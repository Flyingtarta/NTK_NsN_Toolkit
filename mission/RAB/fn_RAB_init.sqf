//if !(isServer) exitwith {};


// SERVER SIDE
Zonas = [];
[RabArea] call NSN_FNC_RAB_drawZones;
publicVariable "Zonas";
[] spawn NSN_FNC_RAB_initPlayer;
[] spawn NSN_FNC_RAB_gamePlay;
