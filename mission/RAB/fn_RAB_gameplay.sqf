/*

Script engargado del gameplay

SERVERSIDE

*/
systemchat str "RAB | gameplay...ok!";

if (!isserver) exitwith {};
//if ( isDedicated || !(isServer) ) exitwith {};

Marcador = createHashMapFromArray [[opfor,0], [blufor,0]];
publicVariable "Marcador";

// tiempo de alto el fuego y preparacion
private _tiempoDePreparacion = (["Preparacion",10] call BIS_fnc_getParamValue) * 60;
private _tiempoDeAltoElFuego = (["AltoElFuego",20] call BIS_fnc_getParamValue) * 60;

settimeMultiplier 0;
waituntil {sleep 1;time > _tiempoDePreparacion};

settimeMultiplier 1;


waituntil { //Espera que pase el tiempo de alto el fuego y de preparacion
  sleep 1;time > _tiempoDeAltoElFuego
};

["","Fin de Alto el Fuego"] remoteexec ["hint",allPlayers];
/*
Mensaje de que termino el alto el fuego
*/

//Funcion de actualizador de marcador
private _actualizaMarcador = {
  _blufor = { ((missionNamespace getVariable _x) get "bando") isequalto blufor} count _zonas;
  _opfor  = { ((missionNamespace getVariable _x) get "bando") isequalto opfor } count _zonas;
  if (_blufor isnotequalto _opfor) then {

    if (_blufor > _opfor) then {
      _diferencia = _blufor - _opfor;
      _valorAnterior = marcador get blufor;
      Marcador set [blufor,_valorAnterior + _diferencia];
      Marcador set ["diffBlufor", _diferencia];
      Marcador set ["diffOpfor", 0];
    }else{
      _diferencia =  _opfor - _blufor;
      _valorAnterior = marcador get opfor;
      Marcador set [opfor,_valorAnterior + _diferencia];
      Marcador set ["diffOpfor", _diferencia];
      Marcador set ["diffBlufor", 0];
    };
  };
  publicVariable "Marcador";
};

publicVariable "zonas";
_zonas = zonas;
_duracionTotalEvento = ((["Duracion",120] call BIS_fnc_getParamValue) * 60);

while {sleep 60; time <= _duracionTotalEvento } do {
  publicVariable "zonas";
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
  publicVariable "Marcador";
};
/*
Declara ganador y perdedor
*/
private _puntosOpfor  = Marcador get opfor;
private _puntosBlufor = Marcador get blufor;

 if (_puntosOpfor isequalto _puntosBlufor) then {//empate
   ["end1", true] remoteexec ["BIS_fnc_endMission",0];
 }else{
   if (_puntosOpfor > _puntosBlufor) then {//gana opfor
     ["end1", true] remoteexec ["BIS_fnc_endMission",opfor];
     ["end1", false] remoteexec ["BIS_fnc_endMission",blufor];
     ["end1", false] remoteexec ["BIS_fnc_endMission",2];
   }else{//gana blufor
     ["end1", true] remoteexec ["BIS_fnc_endMission",blufor];
     ["end1", false] remoteexec ["BIS_fnc_endMission",opfor];
     ["end1", false] remoteexec ["BIS_fnc_endMission",2];
   };
 };
