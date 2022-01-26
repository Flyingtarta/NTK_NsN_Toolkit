//if !(isServer) exitwith {};


// SERVER SIDE
Zonas = [];
[pene] call NSN_FNC_RAB_drawZones;
publicVariable "Zonas";
[] spawn NSN_FNC_RAB_initPlayer;
[] spawn NSN_FNC_RAB_gamePlay;
