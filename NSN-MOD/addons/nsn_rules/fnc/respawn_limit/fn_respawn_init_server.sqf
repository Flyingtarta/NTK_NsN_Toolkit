

if !(isserver) exitwith {};//100% serverside

//creamos la variable global 
nsn_var_jugadores_respawn = createHashMap;


private _vidas = missionNamespace getvariable ["NSN_VAR_RESPAWN_VIDAS",2]; 

{	
	_uid = getplayeruid _x; 
	if !( _uid in nsn_var_jugadores_respawn) then {
		nsn_var_jugadores_respawn set [_uid, _vidas]; 
	};
}foreach allplayers; //iteramos en los jugadores conectados y les asignamos en las 2 vidas
publicVariable "nsn_var_jugadores_respawn"; //meh no se si sirve de algo, por ahora lo dejo 

addMissionEventHandler ["PlayerConnected", {
	params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
	if !( _uid in nsn_var_jugadores_respawn) then 
	{ // Si no esta registrado, lo agregamos y les damos las vidas que le corresponden 
		_vidas = missionNamespace getvariable ["NSN_VAR_RESPAWN_VIDAS",0]; 
		nsn_var_jugadores_respawn set [_uid, _vidas]; 
		publicVariable "nsn_var_jugadores_respawn"; //transmitimos la nueva lista a los jugadores
	}; 
}];
/*
addMissionEventHandler ["EntityKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	if !(isPlayer _unit) exitwith {};
	//descontamos una vida a esa persona 
	_uid = getplayeruid _unit;
	_vidasActuales = nsn_var_jugadores_respawn get _uid;
	if (_vidasActuales > 0) then {
		nsn_var_jugadores_respawn set [_uid, _vidasActuales - 1]; 	
	}else{
		nsn_var_jugadores_respawn set [_uid, 0]; 	
	};
	//retrasmitimos la nueva variable
	publicVariable "nsn_var_jugadores_respawn"; //transmitimos la nueva lista a los jugadores
}];
*/
addMissionEventHandler ["EntityRespawned", { 
	params ["_unit", "_oldEntity"]; 
	if !(isPlayer _unit) exitwith {};
	_uid = getplayeruid _unit;
	_vidasRestantes = nsn_var_jugadores_respawn get _uid;

	if (_vidasRestantes isequalto 0) then {
		["<t color='#ff0000' size='2'> No te quedan mas respawn </t>","PLAIN DOWN", -1, true, true] remoteexec ["cutText",_unit]; 
		[ ["Initialize", [_unit, [], true ]],BIS_fnc_EGSpectator] remoteexec ["call",_unit];
		_unit remoteExec ["hideObjectGlobal",0];
	}else{
		["" , [ str (formatText ["<t color='#ff0000' size='2'> Te quedan %1 respawn </t>",_vidasRestantes-1]), "PLAIN DOWN", -1, true, true] ] remoteexec ["cutText",0];
	};
	[_unit,-1] call nsn_Fnc_respawn_deltaVida;
}];
