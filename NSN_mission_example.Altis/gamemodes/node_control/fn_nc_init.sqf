/*
	Description 
		Script que inicializa el modo de juego "Node Control"
	

*/
//


if !(isnil "eh") then {(findDisplay 12 displayCtrl 51) ctrlRemoveEventHandler ["Draw",eh]};			//DEBUG 

//seleccionamos los nodos 
private _max_line = 3000;
private _nodos_mk = allMapMarkers select {"nodo" in _x};

if (_nodos_mk isequalto []) exitwith {systemChat "ERROR | No se detectaron nodos para el modo Node Control"};
private _nodos = [];
private _bases = _nodos select {"base" in markerText _x}; 

//Creamos logicas 
{
	_nodo = _x; 
	
	_nodo_logic = createVehicle ["Land_HelipadEmpty_F",getMarkerPos _nodo ,[],0,"NONE"];
	_bando = sideUnknown;
	
	if ("WEST" in getMarkerColor _x ) then { _bando = west};
	if ("EAST" in  getMarkerColor _x ) then { _bando = east};
	
	_nodo_logic setvariable ["Data",createHashMapFromArray
		[
			["name", str _x],
			["owner", _bando],
			["base", (_nodo in _bases) ]
		]
	];
	_nodo setMarkerAlpha 0;
	//Falta Crear Zonas de captura 
	_nodos pushBack _nodo_logic;
	[_nodo_logic] spawn nsn_fnc_nc_nodeArea;
}forEach _nodos_mk;

//Conneciones 
_lineas = [];

{
	_nodo = _x;
	_pos = getpos _x;
	{
		if (_x isequalto _nodo) then {continue};
		_posn2 = getpos _x;
		if (_posn2 distance2d _pos > _max_line) then {continue};
		if ([_nodo,_x] in _lineas || [_x,_nodo] in _lineas ) then {continue};
		_lineas pushBackunique [_x,_nodo];
		 
	}forEach _nodos; 
}forEach _nodos;


nsn_nodos = _nodos;
nsn_lineas = _lineas;
// Lo de arriba a servidor 

// Esto va en jugador 
//Los dibujamos 
eh = findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw",{
	params ["_map"];

	{
		 _x params["_from","_to"];
		_color = [0.7,0.6,0,1];
		_bando_from = (_from getvariable "data") get "owner";
		_bando_to = (_to getVariable "data") get "owner";
		if ( _bando_from isEqualTo _bando_to) then {
		//Si ambos son del mismo equipo 
				if (_bando_from isEqualTo blufor) then {_color = [0,0.3,0.6,1]};
				if (_bando_from isEqualTo opfor) then {_color =	 [0.5,0,0,1]};	
		
		};
		
		_map drawLine [_from,_to,_color ];	
	}foreach nsn_lineas;

}];
