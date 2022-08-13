/*
  NSN_FNC_MCV_canSpawn
  Descripcion:
    Verifica si es posible spawnear un vehiculo en donde esta el mouse posado

  return:
    bool

  author:
    Flyingtarta

*/
params ["_shop"];
private _mousePos = (screenToWorld (getMousePosition));

_entitiesFound = _mousePos nearEntities ["Allvehicles",10];
_entitiesFound select {!(_x isKindOf "Animal")};
_distancia = _mousePos distance2d _shop ;

if (_entitiesFound isnotequalto [] || _distancia > 100) then {
  _controlInfoText = (finddisplay 1314 displayctrl 100000);
  _controlInfoText ctrlSetText "No se puede ubicar el vehiculo en esta posicion";
  _controlInfoText ctrlSetTextColor [0.8,0,0,1];
  false
}else{
  true
};
