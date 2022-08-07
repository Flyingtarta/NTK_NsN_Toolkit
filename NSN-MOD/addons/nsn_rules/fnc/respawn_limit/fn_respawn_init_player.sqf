if !(hasInterface) exitwith {};

waitUntil {!isnil "nsn_var_jugadores_respawn"};
private _uid = getPlayerUID player;

if (_uid in nsn_var_jugadores_respawn) then {
	_vidas = nsn_var_jugadores_respawn get _uid;
	systemchat str _vidas;
	if (_vidas isequalto 0) then {
		cutText ["<t color='#ff0000' size='2'> No te quedan mas respawn </t>","PLAIN DOWN", -1, true, true];
	  	player remoteexec ["hideObjectGlobal",0];
      	["Initialize", [player, [], true ]] call BIS_fnc_EGSpectator;
	};
};