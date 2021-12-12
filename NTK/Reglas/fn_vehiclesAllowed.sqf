/*
  Only units with the trait "apoyo" can be driver/pilot of vehicles
*/

player addEventHandler ["GetInMan",{
  params ["_unit", "_role", "_vehicle", "_turret"];
  if !( _unit getvariable ["apoyo",false] || this setvariable ["NSN_FNC_infCanUse",false] ) then {
    //si se sube de conductor/piloto lo baja
    if (_role isequalto "driver" ) exitwith { Hint "Tu rol no te permite manejar este vehiculo" ;moveout _unit};
  };
}];

/*
this addEventHandler ["SeatSwitched", {
	params ["_vehicle", "_unit1", "_unit2"];
}];
