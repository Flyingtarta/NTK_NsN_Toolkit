
//Limitar inventario para que no puedan agarrar mas de lo que cargan en un principio
missionNamespace setvariable ["NSN_VAR_INVENTORY_CHECK",true];

//lonewolf
missionNamespace setvariable ["NSN_VAR_LONEWOLF_ENABLED",true]
missionNamespace getvariable ["NSN_VAR_LONEWOLF_DISTANCE",150];

//Client 
missionNamespace getvariable ["NSN_VAR_VIEWDISTANCE_FOOT",3000];
missionNamespace getvariable ["NSN_VAR_VIEWDISTANCE_veh",5000];
missionNamespace getvariable ["allowed_prefixes",[]]; //MODS EXTRA PERMITIDOS

//LIMITE DE RECONEXIONES Y LLEGADAS TARDE 
missionNamespace SetVariable ["NSN_VAR_LIMIT_RECONECTIONS",true];
missionNamespace SetVariable ["NSN_VAR_MAX_RECONECTIONS",4];
missionNamespace SetVariable ["NSN_VAR_LIMIT_RECONECTIONS",true];
missionNamespace SetVariable ["NSN_VAR_LATE",(60*20)]; 

//limite de vidas
missionNamespace setvariable ["NSN_VAR_LIMITEVIDAS",true];
missionNamespace setvariable ["NSN_VAR_RESPAWN_VIDAS",2];

//Esto para docs: 
//APLICABLE UNICAMENTE A UNIDADES
// CONDICIONES ESPACIALES: NSN_VAR_APOYO


