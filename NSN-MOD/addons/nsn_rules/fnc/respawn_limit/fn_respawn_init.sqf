[] spawn {
    
    waituntil {time > 0};
    if !(missionNamespace getvariable ["NSN_VAR_LIMITEVIDAS",true]) exitwith {}; 
    [] spawn nsn_fnc_respawn_init_player;
    [] spawn nsn_fnc_respawn_init_server;

};