
removeGoggles player;
player setVariable ["BIS_enableRandomization", false];

[] call nsn_fnc_NoLootBody;
//
[] call nsn_fnc_LoadoutCheck;
//Preparation time
_tiempoPreparacion = ["Preparacion",10] call BIS_fnc_getParamValue;

[] call nsn_fnc_boris;
//Esto siempre al final
[100,60*_tiempoPreparacion] call nsn_fnc_PrepareTime;

[] call nsn_fnc_NoLonewolf;
