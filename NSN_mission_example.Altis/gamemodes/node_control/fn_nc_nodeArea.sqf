/*
Description:
  Crea una zona para el modo de juego Node Control 
  - uso interno -

  Variables Pendientes:

    - Tamanio de area 
  

  -ESTO VA EN SERVIDOR - 


  FALTA:
    Cambio de quien captura en el medio, produce que al temrinar de capturar se quede el que tenga mayoria
    hay que hacer que al entrar mas de los que estaban capturando originalmente, descapeen primero, antes de volver a capturar 


*/

params ["_node", ["_areaSize",100] , ["_TargetCaptura", 10] ];
IF !(isserver) exitwith {};
private _pos       = getpos _node;  
private _node_data = _node getVariable "data";
private _owner     = _node_data getOrDefault ["owner",sideUnknown];
private _name      = _node_data getOrDefault ["name",""];
private _isbase    = _node_data getOrDefault ["base", false];

//Creamos el marcador con el area 

private _zoneMK = createMarker [_name,_pos];
_zoneMK setmarkercolor ("color" + str(_owner));
_zoneMK setmarkerpos _pos;
_zoneMK setMarkerAlpha 1;
_zoneMK setmarkerSize [_areaSize,_areaSize];
_zoneMK setmarkershape "ELLIPSE";

//ProgressMarker

private _capture_marker = createMarker [_name+"_captureMarker",_pos];
_capture_marker setmarkercolor "ColorCIV";
_capture_marker setmarkerpos _pos;
_capture_marker setMarkerAlpha 1;
_capture_marker setmarkershape "ELLIPSE";
_capture_marker setmarkersize [0,0];


//                Waituntil cease fire ends

private _tiempoDeAltoElFuego = (["AltoElFuego",20] call BIS_fnc_getParamValue) * 60;
waitUntil {missionnamespace getvariable ["NSN_VAR_endTime",-1] isNotEqualTo -1};
waituntil {sleep 1; ((missionnamespace getvariable ["NSN_VAR_EndPrepTime",-1]) + _tiempoDeAltoElFuego )  < servertime };
waitUntil { //waituntils some player are in the area
  sleep 1;
  ({_x inarea _zoneMK } count playableUnits) > 0
};

_bandoD = sideUnknown;

_missionEndTime = missionnamespace getvariable ["NSN_VAR_endTime",-1];
_capture_progress = 0;/*createHashMapFromArray [
  [sideUnknown, 0],
  [blufor,0],
  [opfor,0],
  [independent,0]
];
*/

private _fnc_modificar_capture_area = {
  params ["_capture_marker","_capture_progress","_TargetCaptura","_areaSize"];
  if (_capture_progress >= 0 && _capture_progress <= _TargetCaptura) then {
    _newsize = linearconversion [0,_TargetCaptura,_capture_progress,0,_areaSize];
    _capture_marker setmarkersize [_newsize,_newsize];
  };



};

while { servertime < _missionEndTime } do { //Mientras dure la mision 
  sleep 1; 
  
  if (({_x inarea _zoneMK } count playableUnits) isequalto 0) then {
    //Si estaban capturando y salieron, vuelve a 0
    if (_capture_progress isnotequalto 0 ) then {
      _capture_progress = _capture_progress - 1;
      [_capture_marker,_capture_progress,_TargetCaptura,_areaSize] call _fnc_modificar_capture_area;
    };   
    continue
  };

  _diff = [_pos,0,_zoneMK] call nsn_fnc_diferenciaBandosEnArea;
  _bandoD = _diff select 1;
  _delta = _diff select 0; 
  _node_data = _node getVariable "data";
  _owner     = _node_data getOrDefault ["owner",sideUnknown];
  //_name      = _node_data getOrDefault ["name",""];
  //_isbase    = _node_data getOrDefault ["base", false];

  if (_bandoD isnotEqualTo _owner && _delta > 1.5 ) then { 
      _capture_progress = _capture_progress + 1;
      if (_capture_progress isequalto _TargetCaptura) then {
        
        // termino la captura 
        _capture_progress = 0;
        //cambio de owner 
        _node_data set ["owner",_bandoD];
        //modificar el namespace 
        _node setVariable ["data",_node_data,true];
        //cambiamos el color del marcador
        _zoneMK setmarkercolor ("color" + str(_bandoD));
      };
  } else{
    if (_capture_progress isnotequalto 0 ) then {
      _capture_progress = _capture_progress - 1;
    }; 
  };

  //change capture marker size
  /*if (_capture_progress > 0 && _capture_progress < _TargetCaptura) then {
    _newsize = linearconversion [0,_TargetCaptura,_capture_progress,0,_areaSize];
    _capture_marker setmarkersize [_newsize,_newsize];
  };*/
  [_capture_marker,_capture_progress,_TargetCaptura,_areaSize] call _fnc_modificar_capture_area;

};


