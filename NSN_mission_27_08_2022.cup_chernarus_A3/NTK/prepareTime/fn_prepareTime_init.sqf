if (isserver) then {
	private _preparetime = ["Preparacion",10] call BIS_fnc_getParamValue;
	private _end_preparation_time = servertime + (_preparetime*60);
	missionnamespace setvariable ["NSN_VAR_EndPrepTime",_end_preparation_time,true];
	private _duracion =  (["Duracion",180] call BIS_fnc_getParamValue) * 60;
	private _endtime = servertime + _duracion;
	missionnamespace setvariable ["NSN_VAR_endTime",_endtime , true];
	estimatedTimeLeft (_preparetime + _duracion );
};


[] spawn NSN_fnc_prepareTime_player;
