//if !(isServer) exitwith {};


// SERVER SIDE
Zonas = [];
[RabArea] call NSN_FNC_RAB_drawZones; //Draw Zones
[] spawn NSN_FNC_RAB_gamePlay;        //Server init
[] spawn NSN_FNC_RAB_initPlayer;      //player init 
