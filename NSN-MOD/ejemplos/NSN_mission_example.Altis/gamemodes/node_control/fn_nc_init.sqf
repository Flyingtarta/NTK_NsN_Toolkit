/*
	Description 
		Script que inicializa el modo de juego "Node Control"
	

*/


//Si es jugador, le damos arranque todo lo que dibuja las areas y demas 
if (hasInterface) then { [] spawn nsn_fnc_NC_initPlayer};

if !(isServer) exitwith {};

//seleccionamos los nodos 
private _max_line = 3000;
private _nodos_mk = allMapMarkers select {"nodo" in _x}; 
if (_nodos_mk isequalto []) exitwith {systemChat "ERROR | No se detectaron nodos para el modo Node Control"};
private _nodos = [];


private _areaSize =  missionNamespace getvariable ["NSN_VAR_NC_areaSize", 100];



//Creamos logicas 
{
	_nodo = _x; 
	_isbase = "base" in markerText _nodo;
	_nodo_logic = createVehicle ["Land_HelipadEmpty_F",getMarkerPos _nodo ,[],0,"NONE"];
	
	
	_pos = getpos _nodo_logic;
	_owner = sideUnknown;
	_name = _nodo;
	if ("WEST" in getMarkerColor _x ) then { _owner = west};
	if ("EAST" in  getMarkerColor _x ) then { _owner = east};
	deleteMarker _nodo;

	private _zoneMK = createMarker [_name ,_pos];
	_zoneMK setmarkercolor ("color" + str(_owner));
	_zoneMK setmarkerpos (getpos _nodo_logic);
	_zoneMK setMarkerAlpha 1;
	_zoneMK setmarkerSize [_areaSize,_areaSize];
	_zoneMK setmarkershape "ELLIPSE";
	if (_isbase) then {
		_zoneMK setMarkerBrush "FDiagonal";
	}else{
		_zoneMK setMarkerBrush "SolidBorder";
	};

	private _capture_marker = createMarker [_name+"_captureMarker",_pos];
	_capture_marker setmarkercolor "ColorCIV";
	_capture_marker setmarkerpos _pos;
	_capture_marker setMarkerAlpha 1;
	_capture_marker setmarkershape "ELLIPSE";
	_capture_marker setmarkersize [0,0];

	_nodo_logic setvariable ["Data",createHashMapFromArray
		[
			["name", _name],
			["owner", _owner],
			["base", _isbase ],
			["referenceMarker",_zoneMK ],
			["captureMk", _capture_marker],
			["captureProgress", 0]
		]
	];
	
	//Falta Crear Zonas de captura 
	_nodos pushBack _nodo_logic;
}forEach _nodos_mk;

//Conneciones 
_lineas = [];

{
	_nodo = _x;
	_pos = getpos _x;
	_conectados = [];
	{
		if (_x isequalto _nodo) then {continue};
		_posn2 = getpos _x;
		if (_posn2 distance2d _pos > _max_line) then {continue};
		_conectados pushBackunique _x;
		if ([_nodo,_x] in _lineas || [_x,_nodo] in _lineas ) then {continue};
		_lineas pushBackunique [_x,_nodo];
		
	}forEach _nodos; 
	_nodeData = _nodo getVariable "Data";
	_nodeData set ["connected", _conectados];
	_nodo setvariable ["Data", _nodeData, True]; //Share the var 
}forEach _nodos;

nsn_nodos = _nodos;
publicVariable "nsn_nodos";
nsn_lineas = _lineas;
publicVariable "nsn_lineas";

[_nodos] spawn nsn_fnc_nc_gamemode_loop;
