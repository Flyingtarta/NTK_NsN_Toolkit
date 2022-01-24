/*

Script engargado del gameplay

SERVERSIDE

*/
systemchat str "RAB | gameplay...ok!";

Marcador = createHashMapFromArray [[opfor,0], [blufor,0]];
publicVariable "Marcador";

// tiempo de alto el fuego y preparacion
private _tiempoDePreparacion = ["Preparacion",10] call BIS_fnc_getParamValue * 60;
private _tiempoDeAltoElFuego = ["AltoElFuego",20] call BIS_fnc_getParamValue * 60;
waituntil { //Espera que pase el tiempo de alto el fuego y de preparacion
  time > (_tiempoDePreparacion + _tiempoDeAltoElFuego)
};

/*
Mensaje de que termino el alto el fuego
*/

_actualizaMarcador = {
  _blufor = { ((missionNamespace getVariable _x) get "bando") isequalto blufor} count _zonas;
  _opfor  = { ((missionNamespace getVariable _x) get "bando") isequalto opfor } count _zonas;
  if (_blufor isnotequalto _opfor) then {

    if (_blufor > _opfor) then {
      _diferencia = _blufor - _opfor;
      _valorAnterior = marcador get blufor;
      Marcador set [blufor,_valorAnterior + _diferencia];
    }else{
      _diferencia =  _opfor - _blufor;
      _valorAnterior = marcador get opfor;
      Marcador set [opfor,_valorAnterior + _diferencia];
    };
  };
  publicVariable "Marcador";
};


_zonas = zonas;

while {sleep 60; true} do {

  {
    _zona = _x;
    _data =missionNamespace getvariable _zona;


    if (!isnil {_data}) then {
    //verifica si se capturo

      _diff = [_data get "pos",0,_zona] call nsn_fnc_diferenciaBandosEnArea;
      _diff params ["_ratio","_bandoDom"];
      _owner = _data get "bando";

      //Si esta sin capturar
      if (_owner isequalto sideUnknown) then {
        if (_bandoDom isequalto sideUnknown) then {
            _zona setmarkercolor ("color" + str(_bandoDom));
            _data set ["bando",_bandoDom];

        }else{
           _zona setmarkercolor ("color" + str(_bandoDom));
           _data set ["bando",_bandoDom];
           _valorAnterior = marcador get _bandoDom;
        };
      }else{
        //Si estan intentando capturar
        if (_owner isnotequalto _bandoDom && _bandoDom isnotequalto sideUnknown) then {
          _vecinoMismoBando = [_zona,_bandoDom] call NSN_FNC_RAB_canCaptureZone;
          if (_ratio >= 1.5 && _vecinoMismoBando ) then {//captura
            /*
            Falta verficiar que pueda captuarr por vecino
            */
            _data set ["bando",_bandoDom];
            _zona setmarkercolor ("color" + str(_bandoDom));
            missionNamespace setvariable [_zona,_data,true];
          };
        };
      };//if (_owner isequalto sideUnknown) then

    };
  }foreach _zonas;

  [] call _actualizaMarcador;
  systemchat str marcador;

  publicVariable "marcador";
};
/*
//Actualiza el marcador
systemchat str [_bandoDom,_valorAnterior +1];
_valorAnterior = Marcador get _bandoDom;
Marcador set [_bandoDom,_valorAnterior +1];
*/
