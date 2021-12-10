removeGoggles player;


player setVariable ["BIS_enableRandomization", false];
player setvariable ["BandoOriginal",side player,true];

call nsn_fnc_NoLootBody;
systemchat "NTK | No loot...OK!";
//
call nsn_fnc_LoadoutCheck;
systemchat "NTK | Loadout check...OK!";

//Preparation time
_tiempoPreparacion = ["Preparacion",10] call BIS_fnc_getParamValue;


///////////////////////////Esto siempre al final////////////////////////////////
[1000,60*_tiempoPreparacion] call nsn_fnc_PrepareTime;
systemchat "NTK | PreparationTime...OK!";

[] spawn nsn_fnc_uiSectores;

call nsn_fnc_NoLonewolf;
systemchat "NTK | Lonewolf...OK!";
