
removeGoggles player;

[] call nsn_fnc_NoLootBody;
//
[] call nsn_fnc_LoadoutCheck;
//Preparation time
_tiempoPreparacion = ["Preparacion",10] call BIS_fnc_getParamValue;
[100,60*_tiempoPreparacion] call nsn_fnc_PrepareTime;
//no lonewolf
[] call nsn_fnc_NoLonewolf;
