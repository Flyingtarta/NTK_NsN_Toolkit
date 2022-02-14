/*
  Only units with the trait "apoyo" can be driver/pilot of vehicles

  Solamente se puede manejar un vehiclo pasados 10/20 minutos
*/

player addEventHandler ["GetInMan",{
  params ["_unit", "_role", "_vehicle", "_turret"];
  if (_role isequalto "driver") then {
    _respawnTime = _unit getvariable ["RespawnTime",-1];
    if (_respawnTime isnotequalto -1) then {
      _tiempoRestante = round (_respawnTime + 600 - time);
      systemchat str _tiempoRestante;
      if ( _tiempoRestante > 0 ) exitwith {Hint format ["Tenes que esperar %1 minutos para poder manejar un vehiculo", ceil (_tiempoRestante/60)];moveout _unit};
    };

    if !( _unit getvariable ["apoyo",false] || _vehicle getvariable ["NSN_FNC_infCanUse",false] ) then {
      //si se sube de conductor/piloto lo baja
      Hint "Tu rol no te permite manejar este vehiculo" ;moveout _unit;
    };
  };
}];


player addEventHandler ["SeatSwitchedMan", {
 params ["_vehicle", "_unit1", "_unit2"];
 private _unit = player;
 private _role = (assignedVehicleRole _unit)#0;

 if (_role isequalto "driver") then {
   private _respawnTime = player getvariable ["RespawnTime",-1];
   if (_respawnTime isnotequalto -1) then {
     _tiempoRestante = round (_respawnTime + 600 - time);
     systemchat str _tiempoRestante;
     if ( _tiempoRestante > 0 ) exitwith {Hint format ["Tenes que esperar %1 minutos para poder manejar un vehiculo", ceil (_tiempoRestante/60)];moveout _unit};
   };
   if !( _unit getvariable ["apoyo",false] || _vehicle getvariable ["NSN_FNC_infCanUse",false] ) then {
     //si se sube de conductor/piloto lo baja
     Hint "Tu rol no te permite manejar este vehiculo";
     moveout _unit;
     _unit setpos ( (getpos _unit) vectoradd [3,3,0]);
   };
 };
}];

/*v1
player addEventHandler ["GetInMan",{
  params ["_unit", "_role", "_vehicle", "_turret"];
  if !( _unit getvariable ["apoyo",false] || this getvariable ["NSN_FNC_infCanUse",false] ) then {
    //si se sube de conductor/piloto lo baja
    if (_role isequalto "driver" ) exitwith { Hint "Tu rol no te permite manejar este vehiculo" ;moveout _unit};
  };
}];
