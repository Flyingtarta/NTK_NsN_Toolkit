removeGoggles player;
enableEngineArtillery false;
ACE_maxWeightCarry = 60000;
ACE_maxWeightDrag = 80000;

player setVariable ["BIS_enableRandomization", false];
player setvariable ["BandoOriginal",side player,true]; //used for no loot script

[] call nsn_fnc_vehiclesAllowed; // you cant drive a vehicle until 20 minutes later you respawn


call nsn_fnc_NoLootBody; //no loot enemies dead bodies
systemchat "NTK | No loot...OK!";
//
call nsn_fnc_LoadoutCheck; //Checks loadout, dont allow you to carry more mags that you have at start
systemchat "NTK | Loadout check...OK!";

//Preparation time
_tiempoPreparacion = ["Preparacion",10] call BIS_fnc_getParamValue;
[] spawn nsn_fnc_MCV_init; // Vehicle Shop

///////////////////////////Esto siempre al final////////////////////////////////

[parseText " <img shadow=0 image='NTK\img\LogoNSN.paa' size='4' /img> <t shadow=1 font='PuristaLight' size='1.2'> | Afganistan 2025 </t>  <br/><t font='PuristaLight'></t>", true, nil, 7, 0.7, 0] spawn BIS_fnc_textTiles;

[1000] call nsn_fnc_PrepareTime;
systemchat "NTK | PreparationTime...OK!";
sleep 3;
call nsn_fnc_NoLonewolf; //Lonewolf script
systemchat "NTK | Lonewolf...OK!";
