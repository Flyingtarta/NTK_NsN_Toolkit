removeGoggles player;
enableEngineArtillery false;
ACE_maxWeightCarry = 60000;
ACE_maxWeightDrag = 80000;

player setVariable ["BIS_enableRandomization", false];
player setvariable ["BandoOriginal",side player,true]; //used for no loot script

//Preparation time
/*
_tiempoPreparacion = ["Preparacion",10] call BIS_fnc_getParamValue;
[] spawn nsn_fnc_MCV_init; // Vehicle Shop
*/

[parseText (format["<img shadow=0 image='NTK\img\LogoNSN.paa' size='4' /img> <t shadow=1 font='PuristaLight' size='1.2'> | %1 </t>  <br/><t font='PuristaLight'></t>",missionName]), true, nil, 7, 0.7, 0] spawn BIS_fnc_textTiles;
/*
[1000] call nsn_fnc_PrepareTime;
systemchat "NTK | PreparationTime...OK!";
*/