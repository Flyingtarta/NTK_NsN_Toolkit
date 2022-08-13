/*
Funcion que se encarga de todo
*/
params [ "_nodes"];

private _fnc_modificar_capture_area = {
  params ["_capture_marker","_capture_progress","_TargetCaptura","_areaSize"];
  
  if (_capture_progress >= 0 && _capture_progress <= _TargetCaptura) then {
    _newsize = linearconversion [0,_TargetCaptura,_capture_progress,0,_areaSize];
    _capture_marker setmarkersize [_newsize,_newsize];
  };
};

//ALTO EL FUEGO | CEASE FIRE 
private _tiempoDeAltoElFuego = (["AltoElFuego",20] call BIS_fnc_getParamValue) * 60;
private _missionEndTime = missionnamespace getvariable ["NSN_VAR_endTime",-1];
private _TargetCaptura = missionNamespace getvariable ["NSN_VAR_NC_targetCaptura",10];
private _areaSize =  missionNamespace getvariable ["NSN_VAR_NC_areaSize", 100];

waitUntil {missionnamespace getvariable ["NSN_VAR_endTime",-1] isNotEqualTo -1};
//waituntil {sleep 1; ((missionnamespace getvariable ["NSN_VAR_EndPrepTime",-1]) + _tiempoDeAltoElFuego )  < servertime };


private _capturable_nodes = _nodes select { //solamente checkeamos los que no son "bases"
  !( (_x getvariable "Data") get "base")
};

while {servertime < _missionEndTime} do {
	sleep 1;

	{
		_node = _x;
    //Get node data 
    _nodeData = _node getvariable "Data";
    _node_mk = _nodeData get "referenceMarker"; 
    _node_owner = _nodeData get "owner";
    _node_captureMK = _nodeData get "captureMk";
    _node_captureProgress = _nodeData get "captureProgress";
    //Si no hay enemigos presentes y el progreso de captura es 0, seguimos de largo 
    
    _notOwnerInArea = ({_x inarea _node_mk && side _x isnotequalto _node_owner} count allunits);
    if (_notOwnerInArea isEqualTo 0 && _node_captureProgress isEqualTo 0) then {continue};

    //Si hay Enemigos presentes en el area verificamos captura 
    _diff = [_node, 0 , _node_mk ] call nsn_fnc_diferenciaBandosEnArea;
    
    _diff_ratio = _diff select 0;
    _diff_side = _diff select 1;
    //Si el ratio es mayor a 1.5 y el bando dominante no es el owner sumamos 1 punto de captura 
    if (_diff_ratio > 1.5 && _diff_side isnotequalto _node_owner && [_node, _diff_side] call nsn_fnc_nc_canCapture) then {
      _node_captureProgress = _node_captureProgress + 1;
    }else{
      if (_node_captureProgress > 0) then {
        _node_captureProgress = _node_captureProgress - 1;
      }; 
    };
    //Actualizamos captura
    
    if (_node_captureProgress isequalto _TargetCaptura) then {
      _newOwner = _diff_side; 
      
      //
      //Zona capturada - //Aca podemos meter un eventhandler de captura si es necesario 
      //
      //Cambiamos el color del marcador
      _node_mk setMarkerColor ("color" + str _newOwner);
      //cambiamos la captura a 0
      _node_captureProgress = 0;
      //cambiamos la informacion del nodo y la compartimos 
      _nodeData set ["owner", _newOwner];
      _nodeData set ["captureProgress",0];
      _node setvariable ["Data", _nodeData, True];
      //Verificamos si algun nodo quedo aislado 
      [_capturable_nodes] call nsn_fnc_NC_nodeDesconectedCheck;
    }else{
      _nodeData set ["captureProgress",_node_captureProgress];
      _node setvariable ["Data", _nodeData]; //No compartimos la captura con los jugadores para ahorrar bandwidth 
    }; 
    [_node_captureMK,_node_captureProgress,_TargetCaptura,_areaSize] call _fnc_modificar_capture_area    
	}foreach _capturable_nodes; 
}; 


