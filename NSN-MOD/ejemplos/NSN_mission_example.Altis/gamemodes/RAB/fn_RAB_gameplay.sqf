/*
	 - SERVERSIDE -
	
	 Server side script of the game mode
	
*/
systemchat str "RAB | gameplay...ok!";

#define MAINLOOP 1
if (!isServer) exitWith {};// only on server

Marcador = createHashMapFromArray [[opfor, 0], [blufor, 0]]; // score tracker
publicVariable "Marcador";

// tiempo de alto el fuego y preparacion
private _tiempoDePreparacion = servertime + (["Preparacion", 10] call BIS_fnc_getParamValue) * 60;
private _tiempoDeAltoElFuego = (["AltoElFuego", 20] call BIS_fnc_getParamValue) * 60;
missionNamespace setvariable ["NSN_VAR_EndPrepTime", _tiempoDePreparacion, true];

// Espera que pase el tiempo de alto el fuego y de preparacion
waitUntil {serverTime > (_tiempoDePreparacion + _tiempoDeAltoElFuego)};

// Notificacion de que termino el alto el fuego
[["<t color='#ff0000' size='3' font='PuristaSemibold' shadow=1>- - - FIN ALTO EL FUEGO - - -</t>", "PLAIN DOWN", 1, true, true] ] remoteexec ["cutText", 0, false];
estimatedTimeLeft 10800;

// local function to update the scoreboard
private _actualizaMarcador = {
	_blufor = {
		((missionNamespace getVariable _x) get "bando") isEqualTo blufor
	} count _zonas;
	_opfor = {
		((missionNamespace getVariable _x) get "bando") isEqualTo opfor
	} count _zonas;
	if (_blufor isNotEqualTo _opfor) then {
		if (_blufor > _opfor) then {
			_diferencia = _blufor - _opfor;
			_valorAnterior = marcador get blufor;
			Marcador set [blufor, _valorAnterior + _diferencia];
			Marcador set ["diffBlufor", _diferencia];
			Marcador set ["diffOpfor", 0];
		} else {
			_diferencia = _opfor - _blufor;
			_valorAnterior = marcador get opfor;
			Marcador set [opfor, _valorAnterior + _diferencia];
			Marcador set ["diffOpfor", _diferencia];
			Marcador set ["diffBlufor", 0];
		};
	};
	publicVariable "Marcador";
};

// import the variable with the zones
private _zonas = nsn_rab_areas;
_zonas = _zonas select {!(missionnamespace getvariable _x get "base")};// sacamos los secotores que son "base" para que ni los revise

// Calculate the duration of the event 
private _duracionTotalEvento = servertime  + ((["Duracion", 120] call BIS_fnc_getParamValue) * 60); // max event duration
missionnamespace setvariable ["NSN_VAR_endTime", _duracionTotalEvento, true];

while { serverTime <= _duracionTotalEvento } do {
	sleep 1;
	{
		_zona = _x;
    
		_data = missionNamespace getVariable _zona;
		
    	if (isnil "_data") then {continue};
    

		// Verifica que el color sea el correcto 
		_check_color = ("color" + str(_data get "bando"));
		if !(markerColor _zona isEqualTo _check_color) then {_zona setMarkerColor _check_color};
    
    	if ( ({_x inarea _zona} count allunits) isequalto 0) then {continue};
		
		// verifica si se capturo - Checks if its captured
		_capturableArea = _data get "subArea";
		_diff = [[] , 0,_capturableArea] call nsn_fnc_diferenciaBandosEnArea;
    
		_diff params ["_ratio", "_bandoDom"];
		_owner = _data get "bando";

		// Si esta sin capturar - if its a uncaptured zone
		if (_owner isEqualTo sideUnknown) then {
			if (_bandoDom isEqualTo sideUnknown) then {
				_zona setmarkercolor ("color" + str(_bandoDom));
				_data set ["bando", _bandoDom];
			} else {
				_zona setmarkercolor ("color" + str(_bandoDom));
				_data set ["bando", _bandoDom];
				_valorAnterior = marcador get _bandoDom;
			};
		} else {
		// Si estan intentando capturar
		if (_owner isNotEqualTo _bandoDom && _bandoDom isNotEqualTo sideUnknown) then {
			// checks if its capturable (an direct neibor need to be friendly)
			_vecinoMismoBando = [_zona, _bandoDom] call NSN_FNC_RAB_canCaptureZone;
			// captura - you need a ratio of 1:1.5 to be able to capture the zone
			if (_ratio >= 1.5 && _vecinoMismoBando) then {
				_data = missionNamespace getvariable _zona;
				_data set ["subArea", _zona + "_sub"];
				_data set ["bando", _bandoDom];
				_zona setmarkercolor ("color" + str(_bandoDom));
				missionNamespace setVariable [_zona, _data, true];// save all data of the zone
			};
		};

		};
	}forEach _zonas;
	//Check if there is some area isolated from the base 
	[] call nsn_fnc_RAB_zonesInSiegeCheck;
	// just updates de scoreboard
	[] call _actualizaMarcador;
	// Broadcast the new scoreboard value
	publicVariable "Marcador";
};
/*
	Declara ganador y perdedor - after times up, checks the winner side, for some reason, it didnt work, not sure why
*/

private _puntosOpfor = Marcador get opfor;
private _puntosBlufor = Marcador get blufor;
if (_puntosOpfor isEqualTo _puntosBlufor) then {// empate
  ["end1", true] remoteexec ["BIS_fnc_endMission", allPlayers];
} else {
  if (_puntosOpfor > _puntosBlufor) then {// gana opfor
    ["end1", true] remoteexec ["BIS_fnc_endMission", opfor];
    ["end1", false] remoteexec ["BIS_fnc_endMission", blufor];
  }else{// gana blufor
    ["end1", true] remoteexec ["BIS_fnc_endMission", blufor];
    ["end1", false] remoteexec ["BIS_fnc_endMission", opfor];
  };
};
["end1", true] remoteexec ["BIS_fnc_endMission", 0]