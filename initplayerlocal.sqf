
removeGoggles player;
player setVariable ["BIS_enableRandomization", false];

[] call nsn_fnc_NoLootBody;
systemchat "NTK | No loot...OK!";
//
[] call nsn_fnc_LoadoutCheck;
systemchat "NTK | Loadout check...OK!";
//Preparation time
_tiempoPreparacion = ["Preparacion",10] call BIS_fnc_getParamValue;
[] call nsn_fnc_boris;
systemchat "NSN | Objetivo anna ...OK!";
[] call nsn_fnc_anna;
systemchat "NSN | Objetivo Boris...OK!";

///////////////////////////Esto siempre al final////////////////////////////////
[100,60*_tiempoPreparacion] call nsn_fnc_PrepareTime;
systemchat "NTK | PreparationTime...OK!";

[] call nsn_fnc_NoLonewolf;
systemchat "NTK | Lonewolf...OK!";
