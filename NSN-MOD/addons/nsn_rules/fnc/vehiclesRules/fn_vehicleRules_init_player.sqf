/*
  Description:
	Al respawnear no podes subirte a un vehiculo por x tiempo ( definido en variable NSN_VAR_VEHICULE_BAN_TIME | DEFUALT 600 SEGUNDOS)


	NSN_FNC_VAR_LIMITE_VEHICULOS
	NSN_VAR_VEHICLE_BAN_TIME 600
*/

if !(hasInterface) exitwith {};

IF !(missionNamespace getvariable ["NSN_FNC_VAR_LIMITE_VEHICULOS",TRUE]) exitwith {};


player addeventhandler ["Respawn", {
	params ["_unit", "_corpse"];
	player setvariable ["RespawnTime", serverTime];
}];

player addEventHandler ["GetInMan",{
	params ["_unit", "_role", "_vehicle", "_turret"];
	if (_role isequalto "driver") then {
	  _respawnTime = _unit getvariable ["RespawnTime",-1];
	  if (_respawnTime isnotequalto -1) then {
		_ban = missionNamespace getvariable ["NSN_VAR_VEHICLE_BAN_TIME",600];
		_tiempoRestante = round (_respawnTime + _ban - servertime);
		if ( _tiempoRestante > 0 ) exitwith {Hint format ["Tenes que esperar %1 minutos para poder manejar un vehiculo", ceil (_tiempoRestante/60)];moveout _unit};
	  };

	  //if !( _unit getvariable ["apoyo",false] || _vehicle getvariable ["NSN_FNC_infCanUse",false] ) then {
		//si se sube de conductor/piloto lo baja
	  //    Hint "Tu rol no te permite manejar este vehiculo" ;moveout _unit;
	  //};
	};
  }];


  player addEventHandler ["SeatSwitchedMan", {
	params ["_vehicle", "_unit1", "_unit2"];
	private _unit = player;
	private _role = (assignedVehicleRole _unit)#0;

	if (_role isequalto "driver") then {
	  private _respawnTime = player getvariable ["RespawnTime",-1];
	  if (_respawnTime isnotequalto -1) then {
		_ban = missionNamespace getvariable ["NSN_VAR_VEHICLE_BAN_TIME",600];
		_tiempoRestante = round (_respawnTime + _ban - servertime);
		if ( _tiempoRestante > 0 ) exitwith {Hint format ["Tenes que esperar %1 minutos para poder manejar un vehiculo", ceil (_tiempoRestante/60)];moveout _unit};
	  };
	  /*if !( _unit getvariable ["apoyo",false] || _vehicle getvariable ["NSN_FNC_infCanUse",false] ) then {
	  //si se sube de conductor/piloto lo baja
	  Hint "Tu rol no te permite manejar este vehiculo";
	  moveout _unit;
	  _unit setpos ( (getpos _unit) vectoradd [3,3,0]);
	  };
	  */
	};
  }];
