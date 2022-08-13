/*
	nsn_fnc_drawZones

	Description:
		Este script se encarga de dibujar las zonas del modo ResistAndBite generando una variable global compartida a todos los jugadores llamada "NSN_RAB_AREAS"
		Lista con todas las areas en formato "[valor x , valor y]"

		Subzona hayable por "[valor x , valor y]_subzone"

		infoprmacion de bando y si es de los cuadrados no capturables (base):
			missionNamespace getvariable "marcador": 
				hasmap: 
					"bando": SIDE 
					"base": BOOL
					"subzone": MARCADOR

	Input:
		0: Area (trigger) Trigger de donde saca el tamaño y direccion (siempre rectangular)
		1: Tamaño de la subzona de captura (opcional | default: 0.8) 
		2: Grid, tamaños de cada cuadrado (opcional | defaut: [500,500])
		3: Deadzone en el medio sin capturar ( no es funcional por el momento, dejar defualt: True )
	
	Output:
		NOTHING 
	
*/
if (!isserver) exitWith {};

params ["_area",["_subAreaSize",.8] ,["_grid", [250,250] ] , ["_deadZone", true ] ];


//Sacamos el tama;o del area 
(triggerArea _area) params ["_area_x", "_area_y", "_dir" , ""];
private _centro = getpos _area;

_rab_x_r = floor (_area_x/(_grid select 0)) -1;
_rab_y_r = floor (_area_y/(_grid select 1)) -1; 

if ((_rab_y_r-1) %2 isEqualTo 0 && _deadZone) then {
	//Le agregamos 1 para que sea impar 
	_rab_y_r = _rab_y_r +1;
	//lo movemos para que el centro quede igual 
	_centro = _centro getpos [-(_grid select 1), _dir];
	systemchat str "Se modifico para que entre la deadzone en el medio";   
};

private _posInicial = _centro;
_posInicial = _posInicial getpos [ (_grid select 1) - _area_y  , _dir];
_posInicial = _posInicial getpos [ _area_x - (_grid select 0)  , _dir - 90];

_rab_areas = [];
//Hacemos las subdiviciones correspondientes
for "_cord_y" from 0 to _rab_y_r do {
	_prepos = _posInicial getpos [_cord_y * (_grid select 1)*2, _dir];
	for "_cord_x" from 0 to _rab_x_r do {
		_mkpos = _prepos getpos [_cord_x * (_grid select 0)*2, _dir + 90 ]; 
		_mk = createMarker [str [_cord_x,_cord_y], _mkpos];
		_mk setMarkerDir _dir;
		_mk setMarkerSize _grid;
		_mk setMarkerAlpha 0.6;
		_mk setMarkerShape "RECTANGLE";
		_mk setmarkerbrush "SolidBorder";		 
		
		//Subzona 
		
		_mk2 = createMarker [  _mk + "_sub",_mkpos];
		_mk2 setMarkerDir _dir;
		_mk2 setMarkerSize (_grid apply {_x *_subAreaSize} );
		_mk2 setMarkerAlpha 0.3;
		_mk2 setMarkerShape "RECTANGLE";
		
		
		
		_bando = sideUnknown;
		_data = createHashMap;
		_data set ["subArea", _mk2]; 
		_medio = (floor (_rab_y_r/2)) -1;
		
		if (_cord_y isNotEqualTo floor (_rab_y_r/2) ) then {
		  if (_cord_y > _rab_y_r/2) then {
				_bando = opfor;
		  }else{
			  _bando = blufor;
		  };
		};
			  
		_mk setmarkercolor ("color" + str(_bando));
		_data set ["bando",_bando]; 
		_data set ["base",false];
		
		
		if (_cord_y isequalto 0 or _cord_y isequalto _rab_y_r) then {
			_data set ["base", true];
			_mk2 setMarkerAlpha 0;
		};
		
		missionnamespace setVariable [_mk,_data,true]; 
		_rab_areas pushBack _mk;
		
	}; 
	
}; 

nsn_rab_areas = _rab_areas;
publicVariable "nsn_rab_areas"; 
