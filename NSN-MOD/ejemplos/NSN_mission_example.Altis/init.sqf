/*
---------------------------------------------------------------------------------------------------------------------
	Dejamos este archivo unicamente para activar/desactivar o modificar parametros del mod de nsn
---------------------------------------------------------------------------------------------------------------------

*/

//Limitar inventario para que no puedan agarrar mas de lo que cargan en un principio
missionNamespace Setvariable ["NSN_VAR_INVENTORY_CHECK",true];

//lonewolf
missionNamespace Setvariable ["NSN_VAR_LONEWOLF_ENABLED",true]; //lonewolf activado? 
missionNamespace Setvariable ["NSN_VAR_LONEWOLF_DISTANCE",150]; //maxima distancia de lonewolf

//Client 
missionNamespace Setvariable ["NSN_VAR_VIEWDISTANCE_FOOT",3000];//maxima viewdistance a pie 
missionNamespace Setvariable ["NSN_VAR_VIEWDISTANCE_veh",5000];//Maxima viewdistance a pie 
missionNamespace Setvariable ["allowed_prefixes",[]]; //MODS EXTRA PERMITIDOS

//LIMITE DE RECONEXIONES Y LLEGADAS TARDE 
missionNamespace SetVariable ["NSN_VAR_LIMIT_LATE",true]; //Limitar llegadas tarde? 
missionNamespace SetVariable ["NSN_VAR_LIMIT_RECONECTIONS",true]; // limitar limite de reconexiones
missionNamespace SetVariable ["NSN_VAR_MAX_RECONECTIONS",4]; //maximas reconexiones 
missionNamespace SetVariable ["NSN_VAR_LATE",(60*20)]; 	//Que es "tarde" en segundos desde que arranco la mision 
missionNamespace Setvariable ["NSN_VAR_commandpw","xyz"]; //contrase;a de comandos para poder kickear/banear 

//limite de vidas
missionNamespace Setvariable ["NSN_VAR_LIMITEVIDAS",true]; //Limite de vidas por persona activado 
missionNamespace Setvariable ["NSN_VAR_RESPAWN_VIDAS",2];  //Cantidad de vidas por persona
/*
---------------------------------------------------------------------------------------------------------------------
		Esta parte se encarga de hacer parametros de arranque de la mision NO TOCAR SI NO SABES LO QUE HACE
---------------------------------------------------------------------------------------------------------------------
*/
//Cualquier arranque agregarlo aca 