ACE_maxWeightCarry = 60000;
ACE_maxWeightDrag = 80000;

/*
Tiempo de Fin de mision 
*/
//private _tiempoDeAltoElFuego = (["AltoElFuego",20] call BIS_fnc_getParamValue) * 60;
private _prepareTime =  (["Preparacion",10] call BIS_fnc_getParamValue) * 60;
missionNamespace setvariable ["NSN_VAR_EndPrepTime",servertime + _prepareTime,true];
private _duracion =  (["Duracion",180] call BIS_fnc_getParamValue) * 60;
private _endtime = servertime + _duracion;
missionnamespace setvariable ["NSN_VAR_endTime",_endtime , true];
estimatedTimeLeft (_preparetime + _duracion );





