/*
NSN_FNC_RAB_draw_zones

Dibuja la zona de combate, basada en un trigger de area cuadrada que nos da el tamaño y centro
*/

//{deleteMarker _x} foreach allMapMarkers;
//if ( isDedicated || !(isServer) ) exitwith {};
if (!isserver) exitwith {};

params ["_area",["_grid",1000],["_deadZone",True]];
_zonas = zonas;
private _gridRadius = _grid/2;
(triggerArea _area) params ["_ejex","_ejey","_dir"];
private _posInicial = getpos _area;
_posInicial = _posInicial getpos [ -_ejey + _gridRadius , _dir];
_posInicial = _posInicial getpos [(_ejex + _gridRadius) , _dir - 90];
private _mk = createMarker ["AO",getpos _area];

_ladox = floor (_ejex/_gridRadius);
_ladoy = floor (_ejey/_gridRadius);
for "_x" from 1 to _ladox do {
	_prepos = _posInicial getpos [_x*_grid, _dir+90];

	for "_y" from 0 to (_ladoy-1) do {

		_markerPos =  _prepos getpos [_y*_grid, _dir];
		_mk = createMarker [str [_x,_y], _markerPos];
		_mk setMarkerDir _dir;
		_mk setMarkerSize [_gridRadius,_gridRadius];
		_mk setMarkerAlpha 0.7;
		_mk setMarkerShape "RECTANGLE";
		_mk setmarkerbrush "SolidBorder";
		_bando = sideUnknown;
		if (_y isNotEqualTo floor (_ladoy/2) ) then {
		  if (_y > _ladoy/2) then {
			  _mk setmarkercolor "colorOpfor";
				_bando = opfor;
		  }else{
			  _mk setmarkercolor "colorBlufor";
				_bando = blufor;
		  };
		};

		_data = createHashMapFromArray [
			["bando", _bando],
			["pos",_markerPos]
		];
		_zonas pushback _mk;
		missionNamespace setvariable [_mk,_data,true];
	};
};
zonas = _zonas;
publicVariable "zonas";
