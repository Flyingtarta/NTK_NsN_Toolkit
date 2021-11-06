/*
  Description:
    Setea como maximo en el loadout, lo que se tiene al principio

*/

//WIP
if (!hasInterface) exitwith {};
waituntil {time > 0};

loadoutInicial = uniqueUnitItems player;//hashmap de cosas en inventario
loadoutInicialCompleto = getUnitLoadout player; //guardamos para re-pack
_cargadoresCompatibles = [primaryWeapon player] call CBA_fnc_compatibleMagazines;
cargadoresIniciales = { _x in _cargadoresCompatibles  } count (magazines player); //cantidad de cargadores iniciales en el arma principal

player addEventHandler ["Take", {
  params ["_unit", "_container", "_item"];
  _cargadoresCompatibles = [primaryWeapon player] call CBA_fnc_compatibleMagazines;
  if (_item in loadoutInicial || _item in _cargadoresCompatibles) then {

    _itemsActuales = (uniqueUnitItems player);
    if (_item in _cargadoresCompatibles) then { //si es cargador del arma
      _cargadoresActuales = { _x in _cargadoresCompatibles } count (magazines player);
      if (_cargadoresActuales > cargadoresIniciales) then {
        player removeItem _item;
        _container addItemCargoGlobal [_item,1];
        //(finddisplay 602) closedisplay 1;
        cutText ["<t color='#ff0000' size='2'>No carges mas cargadores que los que tenias al iniciar </t>", "PLAIN DOWN",0,true,true];
      };

    }else{//si es otro item

      _cantidadActual = _itemsActuales get _item;
      _cantidadInicial = loadoutInicial get _item;
      if (_cantidadActual > _cantidadInicial) then {
        player removeItem _item;
        _container addItemCargoGlobal [_item,1];
        //(finddisplay 602) closedisplay 1;
        cutText ["<t color='#ff0000' size='2'>No carges mas cosas de las que tenias al principio </t>", "PLAIN DOWN",0,true,true];
      };
    };
  };
}];
