/*

Descripcion:
  TartaSector v0.1
  - Puede arrancar neutral o capturado
  - Para capturarlo superioridad de 1,5 en area

Ejecucion:
  SERVIDOR

*/
//if !(isDedicated) exitwith {}; //APB

params [
  ["_marcador",""],
  ["_captureTime",60],
  ["_ownerInicial",sideUnknown], // Poder setear si el dueño inical es de un bando o neutral
  ["_condicionEnd",false]
];

private _pos = getMarkerPos _marcador,
//Variables sector
private _areaState = createHashMap;

_areaState set ["owner", _ownerInicial];
_areaState set ["TiempoDeCaptura",_captureTime];

_marcador setmarkercolor (format ["color%1",_ownerInicial]);

_areaState set ["captura",createHashMapFromArray [[blufor, 0],[opfor,0],[independent,0],[sideUnknown,0]]];
(_areaState get "captura") set [_ownerInicial,_captureTime]; //Al bando que arranca siendo propietario le da los puntos

missionnamespace setvariable [_marcador,_areaState,true];

while {!_condicionEnd} do {//loop

  if ( playableUnits findif { _x inarea _marcador} isnotequalto -1 ) then { //si hay alguien dentro del area

    _diff = [_pos,0,_marcador] call nsn_fnc_diferenciaBandosEnArea;
    _diferencia = _diff#0;
    _bandoMayoritario = _diff#1;

    if (_diff#1 isnotequalto (_areaState get "owner") && {_diff#0 >= 1.5} ) then { //si la mayoria no la tiene el bando propietario
      //ARRANCA CAPTURA
      _capturando = true;

      while {_capturando} do{ //Codigo de captura
          _areaState set ["capturando",true];
          //actualizamos la variable
          _marcador setmarkercolor "colorCivilian";//color de disputa
          _diff = [_pos,0,_marcador] call nsn_fnc_diferenciaBandosEnArea;
          _diferencia = _diff#0;
          _bandoMayoritario = _diff#1;
          _capturaActual = _areaState get "captura";
          _puntosActualesCapturando = _capturaActual get _bandoMayoritario;
          //le sacamos 1 a cada uno que no sea, y le damos uno al bando que esta capturando
          {
              if (_x isequalto _bandoMayoritario && {_diferencia >= 1.5 || _diferencia isequalto -1}) then {
                _actual = _capturaActual get _x;
                _capturaActual set [_x,_actual +1];
                if (_actual + 1 isequalto _captureTime) then {
                  _areaState set ["owner",_x]; //si llego al max le da la titularidad del bando
                  _marcador setmarkercolor (format ["color%1",_x]);
                };
              }else{
                _actual = _capturaActual get _x;
                if (_actual > 0) then {
                  _capturaActual set [_x,_actual -1];
                };
              };
          }foreach _capturaActual;

          if (_captureTime in (values _capturaActual)) then { //Si un bando llego al maximo, sale
            _capturando = false;
            _areaState set ["capturando",false];
          };
          systemchat str _areaState;
          missionnamespace setvariable [_marcador,_areaState,true];
          sleep 1;
      };
      //[(_areaState get "owner"),_marcador] call _colorMarkerBySide;
    };

    missionnamespace setvariable [_marcador,_areaState,true];
    //sleep _captureTime;
  }else{//si no hay nadie
    sleep 1;
  };//si hay alguien if
};
