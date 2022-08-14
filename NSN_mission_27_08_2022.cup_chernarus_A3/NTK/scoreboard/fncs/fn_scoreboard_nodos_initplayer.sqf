/*
//Scoreboard de nodos 

pendiente:
    - adaptable por resolucion 
*/


if !(hasInterface) exitwith {};

addMissionEventHandler ["EachFrame", {
	disableSerialization;
	if !(visibleMap || visibleWatch) exitWith {
		_display = uiNamespace getvariable 'nsn_ui_marcador_nodos';
		if !(isNil {
			_display
		}) then {
			_display closeDisplay 0
		};
	};
	cutRsc ["nsn_marcador_nodos", "PLAIN"];
	_display = uiNamespace getVariable "nsn_ui_marcador_nodos";

	  // _fondo = _display displayCtrl 1000; 
	  // _flagOp =  = _display displayCtrl 1201; 
	  // _flagBlu = _display displayCtrl 1202; 
	  _puntos_op  = _display displayCtrl 1001;// puntos del bando opfor  | rscText  
	  _puntos_blu = _display displayCtrl 1002;// puntos del bando blufor | rscText 
	  _infoText   = _display displayCtrl 1003; // Texto de informacion   | rscText  

	  // tiempo en formato de serverTime de cuando termina la preparacion   
	_tiempoDePreparacion = missionNamespace getvariable ["NSN_VAR_EndPrepTime", ((["Preparacion", 10] call BIS_fnc_getParamValue) * 60) ];
	  // tiempo en formato serverTime de cuando termina el alto el fuego  
	_tiempoDeAltoElFuego = _tiempoDePreparacion + (["AltoElFuego", 20] call BIS_fnc_getParamValue) * 60;
	  // Tiempo en formato serverTime de cuando termina la mision   
	_tiempoFinMision = missionnamespace getvariable ["NSN_VAR_endTime", 0];
	_texto = "";
	if (serverTime < _tiempoDePreparacion) then {
		// en preparacion
		_timer = [((_tiempoDePreparacion - servertime)/60)+.01, "HH:MM"] call BIS_fnc_timeToString;
		_texto = format ["Preparacion restante: %1", _timer];
	};
	if (serverTime < _tiempoDeAltoElFuego && serverTime > _tiempoDePreparacion) then {
		// en alto el fuego 
		_timer = [((_tiempoDeAltoElFuego - servertime)/60)+.01, "HH:MM"] call BIS_fnc_timeToString;
		_texto = format ["Alto el fuego restante: %1", _timer];
	};
	if (serverTime <_tiempoFinMision && serverTime > _tiempoDeAltoElFuego) then {
		// en mision 
		_timer = [((_tiempoFinMision - servertime)/60)+.01, "HH:MM"] call BIS_fnc_timeToString;
		_texto = (_timer);
	};
	//Tiempo restante y estado de la mision 
	_infoText ctrlSetText _texto;

	/*
		Puntaje
	*/
	_nsn_nodos_marcador = nsn_nodos_marcador;
	
	_puntos_blu ctrlSetText str (_nsn_nodos_marcador select 0);
	_puntos_op  ctrlSetText str (_nsn_nodos_marcador select 1);


}];

/*
	addMissionEventHandler ["EachFrame", {
		disableSerialization;
		  if !(visibleMap || visibleWatch) exitWith {
			_display = uiNamespace getvariable 'marcador_RAB';
			    if !(isNil {
				_display
			}) then {
				_display closeDisplay 0
			};
		};
		  cutRsc ["marcador_RAB", "PLAIN"];
		  _display = uiNamespace getVariable "marcador_RAB";
		  _marcador = (allControls _display) select 0;
		  _timer = "";
		  _tiempoDePreparacion = missionNamespace getvariable ["NSN_VAR_EndPrepTime", ((["Preparacion", 10] call BIS_fnc_getParamValue) * 60) ];
		  _tiempoDeAltoElFuego = _tiempoDePreparacion + (["AltoElFuego", 20] call BIS_fnc_getParamValue) * 60;
		
		
		  if (serverTime < _tiempoDeAltoElFuego) then {
			if (serverTime < _tiempoDePreparacion) then {
				_timer = [((_tiempoDePreparacion - servertime)/60)+.01, "HH:MM"] call BIS_fnc_timeToString;
				      _timer =parseText format ["<t color='#BFBF00' > Preparacion:  %1 <t/>", _timer];
			} else {
				_timer = [((_tiempoDeAltoElFuego - serverTime)/60)+.01, "HH:MM"] call BIS_fnc_timeToString;
				      _timer = parseText format ["<t color='#BFBF00'> Alto el fuego:> %1 <t/>", _timer];
			};
		} else {
		// _duracionTotalEvento = ((["Duracion", 10] call BIS_fnc_getParamValue) * 60);
			    _duracionTotalEvento = missionnamespace getvariable ["NSN_VAR_endTime", 0];
			    _timer = [((_duracionTotalEvento - servertime)/60)+.01, "HH:MM"] call BIS_fnc_timeToString;
			    _timer =parseText format ["<t color='#BFBF00'> %1 <t/>", _timer];
		};
		
		
		  _banderaOpfor  = parseText "<img size='2' color='#FF1919' image='\A3\ui_f\data\map\markers\nato\b_unknown.paa'/>";
		  _banderaBLufor = parseText "<img size='2' color='#1A1AFF' image='\A3\ui_f\data\map\markers\nato\b_unknown.paa'/>";
		
		  _diffB = format [" (%1)", Marcador getOrDefault ["diffBlufor", 0]];
		  _diffO = format [" (%1)", Marcador getOrDefault ["diffOpfor", 0]];
		
		
		  _SucturedText = composeText [_timer, lineBreak, _banderaOpfor, "    ", str (marcador get opfor), _diffO, "   |   ", str (marcador get blufor), _diffB, "    ", _banderaBLufor ];
		  _Marcador ctrlSetStructuredText _SucturedText;
		
		  _ancho = ctrlTextWidth _Marcador;
	}];