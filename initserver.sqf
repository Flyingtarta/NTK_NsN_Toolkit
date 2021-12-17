ACE_maxWeightCarry = 60000;
ACE_maxWeightDrag = 80000;
[] call NSN_fnc_LimiteDeVidas;
[] call NSN_fnc_NoGlobalMarks;
_tiempoPreparacion = ["Preparacion",10] call BIS_fnc_getParamValue;
waituntil {_tiempoPreparacion*60 < time};
systemchat "paso tiempo de espera de preparacion";

[] spawn NSN_fnc_SB_gameplay_initServer;

systemchat str "SectoresInit";
