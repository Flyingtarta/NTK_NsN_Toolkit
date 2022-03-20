ACE_maxWeightCarry = 60000;
ACE_maxWeightDrag = 80000;
[] call NSN_fnc_LimiteDeVidas; //life limits
[] call NSN_fnc_NoGlobalMarks; //remove global marks

_tiempoPreparacion = ["Preparacion",10] call BIS_fnc_getParamValue;
_end_preparation_time = servertime + (_tiempoPreparacion*60);
missionnamespace setvariable ["NSN_VAR_PrepareTime",_end_preparation_time,true];
//waituntil {_end_preparation_time < servertime };
