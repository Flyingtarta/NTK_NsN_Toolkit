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

params ["_classname","_pos",["_infCanUSe",false]];

if !(canSuspend) exitwith { _this spawn NSN_fnc_MCV_spawnVehicle}; //(APB) Si es asincrono se llama a si misma en modo sincorna
//Borramos animales
{deleteVehicle _X} forEach (_pos nearEntities ["Animal",sizeof _classname]);
//spawneamos el nuevo vehiclo
_shop = compraVehiculos get (side player);
if (isnil "_pos") then { //
  _pos = (screenToWorld (getMousePosition)) vectoradd [0,0,1];
};

//_newveh = _classname createvehicle (
_newveh = createvehicle [_classname,_pos,[],0,"NONE"];
_newveh setdir (getdir _shop);
_newveh setVectorUp (surfaceNormal _pos);
_newveh allowDamage false;
_newveh disableTIEquipment false;

if (_infCanUSe) then { _newveh setvariable ["NSN_FNC_infCanUse",true,true]};

//invulnerable por 10 segundos, y pegado al piso cada 1 segundo
for "_i" from 0 to 50 do {
  if ( (getpos _newveh) distance2d _pos > 1) then {
    _newveh setpos _pos;
    _newveh setVectorUp (surfaceNormal _pos);
    _newveh setdir (getdir _shop);
  };
  sleep 0.1;
};

if (_newveh iskindof "StaticMortar" || _newveh isKindOf "StaticWeapon") then {
  _newveh allowDamage false;
}else{
  _newveh allowDamage true;
};
