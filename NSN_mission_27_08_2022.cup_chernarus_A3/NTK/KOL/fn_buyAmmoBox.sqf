/*
EXPERIMENTAL WIP

*/

//wip NOT USED

params ["_shop"];
_shop addaction [ "caja mortero/montada", {
  params ["_target", "_caller", "_actionId", "_arguments"];

  private _caja = createVehicle ["rhs_3Ya40_1_single", getpos _caller, [], 0, "NONE"];
  [_caja,nsn_fnc_easyRepackTurrets] remoteexec ["call",allPlayers,_caja];

}];


params ["_shop"];
_shop addaction [ "caja municion jugadores", {
  params ["_target", "_caller", "_actionId", "_arguments"];

  private _caja = createVehicle ["rhs_3Ya40_1_single", getpos _caller, [], 0, "NONE"];
  [_caja,nsn_fnc_easyRepackPlayers] remoteexec ["call",allPlayers,_caja];

}];
