if (isserver) exitwith {
	private _tiempoPreparacion = ["Preparacion",10] call BIS_fnc_getParamValue;
	private _end_preparation_time = servertime + (_tiempoPreparacion*60);
	missionnamespace setvariable ["NSN_VAR_PrepareTime",_end_preparation_time,true];
};
  
[] spawn NSN_fnc_prepareTime_player;