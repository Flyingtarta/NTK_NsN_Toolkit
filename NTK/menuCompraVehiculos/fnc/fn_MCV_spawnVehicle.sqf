/*
  [] CALL NSN_fnc_MCV_spawnVehicle
  Descripcion:
    Crea un vehiculo en la posicion dada y por 10 segundos lo hace invulnerable y lo pega al piso para que no salga volando

  parametros:
    (0): classname del vehiculo
    (1): (opcional) posicion AGL

  return:
    nothing
*/

params ["_classname","_pos"];

if !(canSuspend) exitwith { _this spawn NSN_fnc_MCV_spawnVehicle}; //(APB) Si es asincrono se llama a si misma en modo sincorna
//Borramos animales
{deleteVehicle _X} forEach (_pos nearEntities ["Animal",15]);
//spawneamos el nuevo vehiclo
_shop = compraVehiculos get (side player);
if (isnil "_pos") then { //
  _pos = (screenToWorld (getMousePosition)) vectoradd [0,0,1];
};
//_newveh = _classname createvehicle (
_newveh = createvehicle [_classname,_pos,[],0,"NONE"];
_newveh setdir (getdir _shop);
_newveh allowDamage false;

//invulnerable por 10 segundos, y pegado al piso cada 1 segundo
for "_i" from 0 to 50 do {
  if ( (getpos _newveh) distance2d _pos > 1) then {
    _newveh setpos _pos;
    _newveh setvectorup [0,0,1];
    _newveh setdir (getdir _shop);
  };
  sleep 0.1;
};
_newveh allowDamage true;
