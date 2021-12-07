[] call NSN_fnc_LimiteDeVidas;
[] call NSN_fnc_NoGlobalMarks;
_tiempoPreparacion = ["Preparacion",10] call BIS_fnc_getParamValue;
waituntil {_tiempoPreparacion*60 < time};
systemchat "paso tiempo de espera de preparacion";
[] call nsn_fnc_gameplay_init;
