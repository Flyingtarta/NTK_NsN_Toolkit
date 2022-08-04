params ["_unit","_delta"];
if !(isplayer _unit) exitwith {systemchat "ERROR DELTAVIDA| UNIDAD NO ES UN JUGADORES";FALSE};
private _uid = (getPlayerUID _unit);
private _vidas = missionNamespace getvariable ["NSN_VAR_RESPAWN_VIDAS",0]; 

if (_uid in nsn_var_jugadores_respawn) then {
	_vidasActuales = nsn_var_jugadores_respawn get _uid;
	if (_vidasActuales > 0) then { 
		nsn_var_jugadores_respawn set [_uid, _vidasActuales + _delta]; 
	} else {
		nsn_var_jugadores_respawn set [_uid,0]; 
	};
	true
}else{
	nsn_var_jugadores_respawn set [_uid,_vidas];
	systemchat "ERROR DELTAVIDA | NO ESTABA EN EL ARRAY";
	true
};



