
/*
Encargado de inicializar el RAB
*/
[RabArea] call NSN_FNC_RAB_drawZones; //Draw Zones 
[] spawn NSN_FNC_RAB_gamePlay;        //Server init
[] spawn NSN_FNC_RAB_initPlayer;      //player init


