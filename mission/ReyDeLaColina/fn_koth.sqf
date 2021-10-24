/*
- Espera 10 minutos hasta que pase fase de preparacion

- Se activa cuando alguien pisa el area

- Espera 10 minutos

- El bando con mayoria dentro de la cota captura la colina

- Gana si la diferencia de gente del bando atacante es de 5 a 1

*/

if !(isserver) exitwith {};
params["_pos","_radio"];

_MK = createmarker ["KOTH",_pos];
_mk setMarkerColor "ColorYellow";
_mk setMarkerSize [_radio,_radio];
_mk setMarkerShape "ELLIPSE";

//espera 10 minutos para activarse
waituntil {time > 600};


//espera a que alguien entre en el area
waituntil {
  _ents = _pos nearEntities ["Man",_radio];
  _activa = _ents findif {alive _x};// && isPlayer _x};
  _activa isNotEqualTo -1
};
["<t color='#ff0000' size='2'> Arranca la pelea por la colina </t>", "PLAIN DOWN",3,true,true] remoteexec ["cutText",0,false];

//Espera otros 10 minutos
sleep 600;

//Contamos cual es el bando que tiene la mayoria
private _bandoDefensor = sideUnknown;
private _bandoAtaca = sideUnknown;
_ents = [];

while {_bandoDefensor isequalto sideUnknown} do { //hasta que se defina un ganador

  _ents = _pos nearEntities ["Man",_radio]; //gente dentro del area
  _ents = _ents select {alive _x}; //&& isPlayer _x};


  if (_ents isnotequalto []) then { //si hay gente dentro del area definimos el atacante y defensor
    _CantidadB = { ( side _x ) isequalto blufor} count _ents;
    _CantidadR = { ( side _X ) isequalto opfor} count _ents;
    if (_CantidadB > _CantidadR) then {
      _bandoDefensor = blufor;
      _bandoAtaca = opfor;
      _MK setMarkerColor "ColorBlue";
    };
    if (_CantidadB < _CantidadR) then {
      _bandoDefensor = opfor;
      _bandoAtaca = blufor;
      _MK setMarkerColor "ColorRed";
    };
    //si hay misma cantidad de ambos bandos, espera
    if (_CantidadB isequalto _CantidadR) then {
      sleep 60;
    };
  }else{ //si no hay gente dentro del area
    sleep 60;//esperamos un minuto
  };
};

//Parte final
private _final = false;
private _ganador = sideUnknown;
private _timeFinal = time;

While { !_final } do { //mientras no termine
  //_playersInArea = allplayers select {_x distance2d _pos < 200};
  _playersInArea = _pos nearEntities ["Man",_radio]; //para pruebas
  _diff = [_pos,_radio] call nsn_fnc_diferenciaBandos;
  //Si hay 5 veces mas atacantes que defensores, Gana atacante
  if ( (_diff #1) isequalto _bandoAtaca ) then {//verificacmos que eso se mantenga por 1 minuto
    if ( (_diff #0) >= 5 ) then {
      _final = true;
      _ganador = _bandoAtaca;
    };
  };

  //Si no quedan del bando defensor vivos, GANA ATACANTE
  if (_playersInArea select {(side _x) isequalto _bandoDefensor} isequalto [] ) then {
    _final = true;
    _ganador = _bandoAtaca;
  };

  //si PASAN 30 MINUTOS Y DEFENSA SOSTUVO , gana defensa
  if (time > _timeFinal + (60)*30) then { //<-------------------------------------- miltiplicar por tiempo
    _final = true;
    _ganador = _bandoDefensor;
    hint str _ganador;
  };

  sleep 30;


};

[(str format ["Gano %1",_ganador ]) ] remoteexec ["hint",allPlayers];

sleep 10;

_victoria = allplayers select {(side _x) isequalto _ganador};
_derrota  = allPlayers select {(side _x) isNotEqualTo _ganador};

["end1", true] remoteexec ["BIS_fnc_endMission",_victoria];
["end1", false] remoteexec ["BIS_fnc_endMission",_derrota];
//Ganador
