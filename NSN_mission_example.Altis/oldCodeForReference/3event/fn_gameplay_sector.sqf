

/*
- Espera 10 minutos hasta que pase fase de preparacion

- Se activa cuando alguien pisa el area

- Espera 10 minutos

- El bando con mayoria dentro de la cota captura la colina

- Gana si la diferencia de gente del bando atacante es de 5 a 1

*/
_posSector = _this;

private _radio = 200;
private _TiempoEntreZonas = (["tiempoEntreZonas",30] call BIS_fnc_getParamValue)*60;
//espera a que alguien entre en el area
waituntil {
  _ents = _posSector nearEntities ["Man",_radio];
  _activa = _ents findif {alive _x};// && isPlayer _x};
  _activa isNotEqualTo -1
};
//["<t color='#ff0000' size='2'> Arranca la pelea por la colina </t>", "PLAIN DOWN",3,true,true] remoteexec ["cutText",0,false];
sleep (_TiempoEntreZonas/3);

//Contamos cual es el bando que tiene la mayoria
private _bandoDefensor = sideUnknown;
private _bandoAtaca = sideUnknown;
private _MK = str(_posSector);
_ents = [];

while {_bandoDefensor isequalto sideUnknown} do { //hasta que se defina un ganador

  _ents = _posSector nearEntities ["Man",_radio]; //gente dentro del area
  _ents = _ents select {alive _x}; //&& isPlayer _x};

  if (_ents isnotequalto []) then { //si hay gente dentro del area definimos el atacante y defensor
    _CantidadB = { ( side _x ) isequalto blufor} count _ents;
    _CantidadR = { ( side _x ) isequalto opfor} count _ents;
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
// Se define el bando que defiende
private _zona = (sectores find _posSector) +1;

private _holdUntil = time + _TiempoEntreZonas;

missionNamespace setvariable [format ["NSN_VAR_3E_ZONA%1_OWNER",_zona]  ,_bandoDefensor,true];
missionNamespace setvariable [format ["NSN_VAR_3E_ZONA%1_LOCK",_zona]   ,false         ,true];          //desbloqueamos el area
missionNamespace setvariable [format ["NSN_VAR_3E_ZONA%1_WON",_zona]    ,false         ,true];            //Aun no gano
missionnamespace setvariable [format ["NSN_VAR_3E_ZONA%1_ACTIVE",_zona] ,false         ,true];         // active se refiere a esta esperando (si le tengo que cambiar el nombre)
missionNamespace setvariable [format ["NSN_VAR_3E_ZONA%1_HU",_zona]     ,_holdUntil    ,true];              //Tiempo limite al que tienen que aguantar

//Parte final
private _final = false;
private _ganador = sideUnknown;


While { !_final } do { //mientras no termine
  //_playersInArea = allplayers select {_x distance2d _pos < 300};
  _playersInArea = _posSector nearEntities ["Man",_radio]; //para pruebas

  _diff = [_posSector,_radio] call nsn_fnc_diferenciaBandosEnArea;
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
  if (time > _holdUntil) then {
    _final = true;
    _ganador = _bandoDefensor;
  };
  sleep 1;
};
//[(str format ["Gano %1",_ganador ]) ] remoteexec ["hint",allPlayers];


if (_ganador isequalto opfor) then {
  _MK setMarkerColor "ColorRed";
}else{
  _MK setMarkerColor "ColorBlue";
};


missionNamespace setvariable [format ["NSN_VAR_3E_ZONA%1_OWNER",_zona]  ,_ganador,true];//Bando que es dueño del area
missionNamespace setvariable [format ["NSN_VAR_3E_ZONA%1_LOCK",_zona]   ,false   ,true];//desbloqueamos el area
missionNamespace setvariable [format ["NSN_VAR_3E_ZONA%1_WON",_zona]    ,true    ,true];//Aun no gano
missionnamespace setvariable [format ["NSN_VAR_3E_ZONA%1_ACTIVE",_zona] ,false   ,true];// active se refiere a esta esperando (si le tengo que cambiar el nombre)
missionNamespace setvariable [format ["NSN_VAR_3E_ZONA%1_HU",_zona]     ,0       ,true];//Tiempo limite al que tienen que aguantar


_actual = MARCADOR get _ganador;
MARCADOR set [_ganador,_actual+1];

_victoria = sideUnknown;
_derrota = sideUnknown;

if ( ( (MARCADOR get opfor) + (MARCADOR get blufor) ) isequalto 3) then {
  if ( (MARCADOR get _ganador) >= 2 ) then {

    _victoria = allplayers select {(side _x) isequalto _ganador};
    _derrota  = allPlayers select {(side _x) isNotEqualTo _ganador};
  }else{
    _derrota = allplayers select {(side _x) isequalto _ganador};
    _victoria  = allPlayers select {(side _x) isNotEqualTo _ganador};
  };
  ["end1", true] remoteexec ["BIS_fnc_endMission",_victoria];
  ["end1", false] remoteexec ["BIS_fnc_endMission",_derrota];
};
