//if !(isServer) exitwith {};


// SERVER SIDE
Zonas = [];
[RabArea] call NSN_FNC_RAB_drawZones;
[] spawn NSN_FNC_RAB_gamePlay;
[] spawn NSN_FNC_RAB_initPlayer;
