/*

nsn_fnc_diferenciaBandos

Descripcion:
  cuenta la cantidad de gente por bando y devuelve el bando con mayor presencia y con que porcentaje
  en caso de no haber devuelve -1
input:
      0: ARRAY (posicion) posicion del centro
      1: NUMERO (numero) Radio
      2: AREA (opcional y radio = 0):  (area / marcador / trigger )
Output:
      0:numero ratio de diferencia, va de 1 a 100 donde 1 es total dominancia
      1:Bando con mas gente en el area
*/

params ["_pos","_radio",["_area",""]];

_ent = [];

if (_radio >0) then {
  _ent = _pos nearentities [["man","car","tank","wheeled","tracked"],_radio];
  _ent = _ent select { isTouchingGround _x && alive _x && _x setvariable ["NSN_VAR_LONEWOLF",false] };
}else{
  if (_area isequalto "") exitwith {systemchat "DIFERENCIA BANDOS ERROR | AREA NO DEFINIDA ";[-1,sideUnknown]};
  _ent = allunits select {getpos _x inarea _area && isTouchingGround _x && alive _x && _x setvariable ["NSN_VAR_LONEWOLF",false] };
};

if (_ent isequalto [] ) exitwith { [-1,sideUnknown] };
private _BandoUnidades = [];
{
  if ( (objectParent _x) isequalto "") then {
    _BandoUnidades pushBack (side _x);
  }else{//no es persona
    {
      _BandoUnidades pushBack (side _x);
    }foreach ( (crew _x) select {alive _x && isTouchingGround _x});
  };
}foreach (_ent select {alive _x});

//bandos [_west,_east,_indep]
private _cant_bando = [
  {_x isequalto west} count _BandoUnidades,
  {_x isequalto east} count _BandoUnidades,
  {_x isequalto independent} count _BandoUnidades
];

private _bandoD = sideUnknown;
private _max = selectmax _cant_bando;
private _index = _cant_bando find _max;

if (_index isequalto 0 )then {_bandoD = west };
if (_index isequalto 1 )then {_bandoD = east};
if (_index isequalto 2 )then {_bandoD = independent};

private _sorted = _cant_bando;
_cant_bando sort false;
private _diff = 100;

if (_sorted select 1 > 0) then {
  _diff = (_sorted select 0)/(_sorted select 1);
};

if ( vectorMagnitude _sorted isequalto 0) then {_diff = -1}; //si no hay nadie en el sector desactivamos
[_diff,_bandoD] // [diff,bando]
