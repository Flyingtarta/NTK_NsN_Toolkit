/*
	Descripcion:
		Agrega addaction e inicializa el menu de compra al que lo puede usar

	return:
		nothing

	author:
		flyingTarta

*/


if !(player getvariable ["CMD",false]) exitwith {}; //Si no es el comandante esto no se le ejecuta
systemchat "CMD MCV INIT..";
_menuDeCompra = player addaction ["MENU DE COMPRA DE VEHICLOS",{
	_shop = compraVehiculos get (side player);
	if (isNil "cam") then {cam = "Land_HandyCam_F" createVehicleLocal (ASLToAGL eyepos player)};
	_relpos = _shop modelToWorld [0, -10, 30];
	cam enableSimulation false;
	cam hideObjectGlobal true;
	cam setpos _relpos;
	_vector = vectordir _shop;
	_vector set [2,-1];
	cam setVectorDirAndUp [_vector,[0,0,1]];
	cam camCommit 0;
	switchCamera cam;
	(findDisplay 46 ) createdisplay "menuCompraVeh";
}];

_fondos = ["puntosDeCompra",1000] call BIS_fnc_getParamValue;
missionnamespace setvariable ['NSN_VAR_FOUNDS',_fondos];

["init"] call NSN_fnc_MCV_menuCompraVeh;

//nose si esto es necesario
findDisplay 46 displayAddEventHandler ["KeyDown", {
  if ( isnull findDisplay 1314) exitWith {};
	if (_this select 1 in actionkeys 'curatorToggleInterface') then {
	(findDisplay 1314 ) closeDisplay 2;
	};
}];
//16.8575

//luego del tiempo de espera, chau menu
_menuDeCompra spawn {
	_menuDeCompra = _this;
	_tiempoPreparacion = ["Preparacion",10] call BIS_fnc_getParamValue;
	waituntil {time > (_tiempoPreparacion*60)};
	player removeAction _menuDeCompra;
	if ( !isnull (findDisplay 1314)) then {
		(findDisplay 1314) closeDisplay 2;
	};
};
