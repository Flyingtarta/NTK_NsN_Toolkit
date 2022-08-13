/*
	Description:
		Funcion que se encarga de la funcion de embolsar areas 
		DE USO INTERNO DEL MODULO DE RAB
	
	input:
		nada
	
	outpu:
		nada 
	


*/
_rab_areas = nsn_rab_areas;
_rabcoords = _rab_areas apply {call compile _x};  

_y_max = selectMax (_rabcoords apply { _x select 1});  
_x_max = selectMax (_rabcoords apply { _x select 0});  

//_base_b = _rab_areas select {_data = missionNamespace getVariable _x; (_data get "base") && (_data get "bando" isequalto blufor) };  
//_base_o = _rab_areas select {_data = missionNamespace getVariable _x; (_data get "base") && (_data get "bando" isequalto opfor) };  

_base_conn_b = [];
_base_conn_o = [];

_posible_isolated = [];
_embolsados = [];

//_areas_opfor = _rab_areas select { ((missionNamespace getvariable _x) get "bando") isequalto opfor};
//_areas_blufor = _rab_areas select { ((missionNamespace getvariable _x) get "bando") isequalto blufor};

private _fnc_vecinos = {
	params ["_zona"];
	_coords = call compile _zona;
	_vecinos = [[1,0],[0,1],[-1,0],[0,-1]] apply { _x vectorAdd _coords select [0,2]};
	_vecinos select {! isnil{ missionNamespace getvariable (str _x)} };
	_vecinos apply {str _x}
	  
};

for "_eje_y" from 0 to _y_max do {
	for "_eje_x" from 0 to _x_max do {
		_zona = str [_eje_x, _eje_y];
		_Data = missionNamespace getvariable _zona;
		if !(_data get "bando" isequalto blufor) then {continue};
		if (_data get "base") then {_base_conn_b pushBack _zona; continue};
		_capturable = [_zona, blufor] call nsn_fnc_rab_canCaptureZone;
		if !(_capturable) then {_embolsados pushBack _zona; continue};
		_vecinos = [_zona] call _fnc_vecinos;
		
		if (_vecinos findif {_x in _base_conn_b} isnotEqualTo -1) then {
			_base_conn_b pushBack _zona;
		}else {
			_posible_isolated pushBack _zona;
		};	
	};
};

//Segunda pasada
for "_eje_y" from _y_max to 0 step -1 do {
	for "_eje_x" from _x_max to 0 step -1 do {
		_zona = str [_eje_x, _eje_y];
		if !(_zona in _posible_isolated) then {continue};
		_vecinos = [_zona] call _fnc_vecinos;
		if ((_vecinos findif {_x in _base_conn_b}) isnotEqualTo -1) then {
			_base_conn_b pushBack _zona;
		}else {
			_embolsados pushBack _zona;
		}; 
	};
};  

//Verificamos desde opfor
_posible_isolated = [];
for "_eje_y" from _y_max to 0 step -1 do {
 for "_eje_x" from 0 to _x_max do {
  _zona = str [_eje_x, _eje_y];
  _Data = missionNamespace getvariable _zona;
  if !(_data get "bando" isequalto opfor) then {continue};
  if (_data get "base") then {_base_conn_o pushBack _zona; continue};
  
  _capturable = [_zona, opfor] call nsn_fnc_rab_canCaptureZone;
  if !(_capturable) then {_embolsados pushBack _zona; continue};
  
  _vecinos = [_zona] call _fnc_vecinos;

  _vecino_in_connected_idx = _vecinos findif {_x in _base_conn_o};
  
   //systemchat ( _zona + " | " + str _vecino_in_connected_idx);
  if ((_vecinos findif {_x in _base_conn_o}) isnotEqualTo -1) then {
   _base_conn_o pushBack _zona;
  }else {
	_posible_isolated pushBack _zona;
  }; 
 };
};

//Segunda pasada opfor
for "_eje_y" from _y_max to 0 step -1 do {
	for "_eje_x" from _x_max to 0 step -1 do {
		_zona = str [_eje_x, _eje_y];
		if !(_zona in _posible_isolated) then {continue};
			_vecinos = [_zona] call _fnc_vecinos;
		if ((_vecinos findif {_x in _base_conn_o}) isnotEqualTo -1 ) then {
			_base_conn_o pushBack _zona;
		}else {
			_embolsados pushBack _zona;
		};   
	};
};

//embolsados = _embolsados;
{
	_zona = _x;
	_data = missionNamespace getvariable _zona;
	if (_data get "bando" isequalto opfor) then {
		_data set ["bando",blufor];
		_zona setmarkercolor ("color" + str blufor);
	}else{
		_data set ["bando",opfor];
		_zona setmarkercolor ("color" + str opfor);
	};
	_data set ["subArea", _zona + "_sub"];
	missionNamespace setvariable [_zona,_data,true];
} foreach _embolsados;