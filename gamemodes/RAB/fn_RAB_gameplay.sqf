/*
 - SERVERSIDE -

 Server side script of the game mode

*/
systemchat str "RAB | gameplay...ok!";

if (!isserver) exitwith {}; //only on server
//if ( isDedicated || !(isServer) ) exitwith {};

Marcador = createHashMapFromArray [[opfor,0], [blufor,0]]; // score tracker
publicVariable "Marcador";

// tiempo de alto el fuego y preparacion
private _tiempoDePreparacion = servertime + (["Preparacion",10] call BIS_fnc_getParamValue) * 60;
private _tiempoDeAltoElFuego = (["AltoElFuego",20] call BIS_fnc_getParamValue) * 60;
missionNamespace setvariable ["NSN_VAR_EndPrepTime",_tiempoDePreparacion,true];
waituntil { //Espera que pase el tiempo de alto el fuego y de preparacion
  servertime > (_tiempoDePreparacion + _tiempoDeAltoElFuego)
}; //script starts after prep time and cease fire


/*
TODO: add cease-fire notification
*/


[["<t color='#ff0000' size='3' font='PuristaSemibold' shadow=1>- - - FIN ALTO EL FUEGO - - -</t>", "PLAIN DOWN", 1, true, true] ] remoteexec ["cutText",0,false];

estimatedTimeLeft 10800;

//local function to update the scoreboard
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
_zonas = zonas; //zones are each "block"
_duracionTotalEvento = servertime  + ((["Duracion",120] call BIS_fnc_getParamValue) * 60); // Max event duration
missionnamespace setvariable ["NSN_VAR_endTime",_duracionTotalEvento,true];
while {servertime <= _duracionTotalEvento } do {

  _zonasActivas = _zonas select {_zona = _x; {_x inarea _zona} count playableunits > 0};
  systemchat  ("zonas activas: " + str (count _zonasActivas) );

  {
    _zona = _x;
    _data = missionNamespace getvariable _zona;
    if (!isnil {_data}) then {
      //verifica si se capturo - Checks if its captured
      _capturableArea = _data get "subArea";
      _diff = [_data get "pos",0,_capturableArea] call nsn_fnc_diferenciaBandosEnArea;
      _diff params ["_ratio","_bandoDom"];
      _owner = _data get "bando";

      //Si esta sin capturar - if its a uncaptured zone
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
          _vecinoMismoBando = [_zona,_bandoDom] call NSN_FNC_RAB_canCaptureZone; //checks if its capturable (an direct neibor need to be friendly )
          if (_ratio >= 1.5 && _vecinoMismoBando ) then {//captura - you need a ratio of 1:1.5 to be able to capture the zone
            /*
            Falta verficiar que pueda captuarr por vecino
            */
            _data set ["bando",_bandoDom];
            _zona setmarkercolor ("color" + str(_bandoDom));
            missionNamespace setvariable [_zona,_data,true]; //save all data of the zone
          };
        };
      };//if (_owner isequalto sideUnknown) then

    };
  }foreach _zonasActivas;
  [] call _actualizaMarcador; //just updates de scoreboard
  //publicVariable "Marcador"; //Broadcast the new scoreboard value
  sleep 1;// <-----------------------------------------------------------------------------------------------------------------------------------------DEBUG
};
/*
Declara ganador y perdedor - after times up, checks the winner side, for some reason, it didnt work, not sure why
*/

private _puntosOpfor  = Marcador get opfor;
private _puntosBlufor = Marcador get blufor;
 if (_puntosOpfor isequalto _puntosBlufor) then {//empate
   ["end1", true] remoteexec ["BIS_fnc_endMission",allPlayers];
 }else{
   if (_puntosOpfor > _puntosBlufor) then {//gana opfor
     ["end1", true] remoteexec ["BIS_fnc_endMission",opfor];
     ["end1", false] remoteexec ["BIS_fnc_endMission",blufor];
   }else{//gana blufor
     ["end1", true] remoteexec ["BIS_fnc_endMission",blufor];
     ["end1", false] remoteexec ["BIS_fnc_endMission",opfor];
   };
 };
["end1", true] remoteexec ["BIS_fnc_endMission",0]
