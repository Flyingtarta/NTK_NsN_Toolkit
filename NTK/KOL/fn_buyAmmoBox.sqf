/*
EXPERIMENTAL WIP

*/

params ["_shop"];
_shop addaction [ "caja mortero/montada", {
  params ["_target", "_caller", "_actionId", "_arguments"];

  private _caja = createVehicle ["rhs_3Ya40_1_single", getpos _caller, [], 0, "NONE"];
  [_caja,nsn_fnc_easyRepackTurrets] remoteexec ["call",allPlayers,_caja];

}];

/*
params ["_shop"];
_shop addaction [ "Caja municion jugadores", {
  params ["_target", "_caller", "_actionId", "_arguments"];

  private _caja = createVehicle ["rhs_7ya37_1_single", getpos _caller, [], 0, "NONE"];

  clearItemCargoGlobal _caja;
  clearWeaponCargoglobal _caja;
  clearMagazineCargoGlobal _caja;
  clearItemCargoGlobal _caja;
  clearBackpackCargoGlobal _caja;

  //[_caja,nsn_fnc_easyRepackPlayers] remoteexec ["call",allPlayers,_caja];
  private _side = side _caller;
  private _cargo = [];

  if ( _side isequalto opfor) then {
    _cargo = missionNamespace getvariable ["caja_opfor" ,[]];
  }else{
    _cargo = missionNamespace getvariable ["caja_blufor",[]];
  };
  _cargo params ["_weapons","_magazines","_items","_backpacks"];
  if (_weapons isnotequalto [[],[]] ) then {   { _caja addWeaponCargoglobal [_x,_weapons select _forEachIndex] } foreach _weapons#0        };
  if (_magazines isnotequalto [[],[]] ) then { { _caja addmagazineCargoglobal [_x,_magazines select _forEachIndex] } foreach _magazines#0; };
  if (_items isnotequalto [[],[]] ) then {     { _caja additemCargoglobal [_x,_items select _forEachIndex] } foreach _items#0              };
  if (_backpacks isnotequalto [[],[]] ) then { { _caja addbackpackCargoglobal [_x,_backpacks select _forEachIndex] } foreach _backpacks#0  };
/*
  { _caja addmagazineCargoglobal [_x,_magazines select _forEachIndex] } foreach _magazines#0;
  { _caja additemCargoglobal [_x,_items select _forEachIndex] } foreach _items#0;
  { _caja addbackpackCargoglobal [_x,_backpacks select _forEachIndex] } foreach _backpacks#0;
*/

  /*
  _caja addWeaponCargoglobal   (_cargo select 0);
  _caja addMagazineCargoGlobal (_cargo select 1);
  _caja addItemCargoGlobal     (_cargo select 2);
  _caja addBackpackCargoGlobal (_cargo select 3);
  */
//}];
