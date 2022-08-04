/*

*/
if !(isserver) exitwith {};

nsn_var_uid_conectados = []; 
nsn_var_reconneciones = createHashMap;

_tiempoLimiteIngreso = missionnamespace getvariable ["NSN_VAR_LATE",(60*20)];
_tiempoPreparacion = ( ["Preparacion",10] call BIS_fnc_getParamValue) * 60;
tiempoLimiteDeIngreso = servertime + _tiempoLimiteIngreso + _tiempoPreparacion;

_serverCommandPw = missionNamespace getvariable ["nsn_var_commandpw","xyz"];
_serverCommandPw serverCommand "#exec clearbans";
_serverCommandPw serverCommand "#clearbans";

// A los conectados
{
	_uid = getPlayerUID _x;
	nsn_var_uid_conectados pushback _uid;
}foreach allplayers;

// Cada vez que entra alguien lo registra en nsn_var_uid_conectados
addMissionEventHandler ["PlayerConnected", {
	params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
	
	//contrasena 
	_serverCommandPw = missionNamespace getvariable ["nsn_var_commandpw","xyz"];

	//lo agregamos a la lista si no esta 
	if !(_uid in nsn_var_uid_conectados) then {
		nsn_var_uid_conectados pushback _uid;
		nsn_var_reconneciones set [_uid,0];	
	};
	nsn_var_uid_conectados pushbackunique _uid;
	
	//limite de reconexiones
	if ( missionNamespace GetVariable ["NSN_VAR_LIMIT_RECONECTIONS",true] ) then {
		_reconexiones_actuales = nsn_var_reconneciones get _uid;
		format["Recorda que hay limites de reconexiones, te quedan: %1 \nPasado el limite, se te banea por el evento.", (missionNamespace getvariable ["NSN_VAR_MAX_RECONECTIONS",4]) - _reconexiones_actuales ] remoteexec ["hint",_uid];
		if ( _reconexiones_actuales > (missionNamespace getvariable ["NSN_VAR_MAX_RECONECTIONS",4]) ) then {
			_serverCommandPw serverCommand (format ["#ban %1 %2", _uid,"Te reconectaste demaciadas veces"]);
			(format ["exeso de reconexiones | %1 banned",_name]) remoteexec ["systemchat",0];
		}else{
			nsn_var_reconneciones set [_uid, _reconexiones_actuales + 1];
		};
	};

	//tiempo limite 
	if (missionNamespace GetVariable ["NSN_VAR_LIMIT_LATE",true]) then {
		if ( servertime > tiempoLimiteDeIngreso) then {
			if !(_uid in nsn_var_uid_conectados) then {
				//kick 
				_serverCommandPw serverCommand (format ["#kick %1 %2", _uid, "Llegaste demaciado tarde, Lamentablemente no vas a poder ingresar"]);
				(format ["Hora limite exedida | %1 kicked",_name]) remoteexec ["systemchat",0];
			};
		};
	};
}];