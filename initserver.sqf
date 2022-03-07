ACE_maxWeightCarry = 60000;
ACE_maxWeightDrag = 80000;
[] call NSN_fnc_LimiteDeVidas; //life limits
[] call NSN_fnc_NoGlobalMarks; //remove global marks

_tiempoPreparacion = ["Preparacion",10] call BIS_fnc_getParamValue;
waituntil {_tiempoPreparacion*60 < time};
systemchat "paso tiempo de espera de preparacion"; 
