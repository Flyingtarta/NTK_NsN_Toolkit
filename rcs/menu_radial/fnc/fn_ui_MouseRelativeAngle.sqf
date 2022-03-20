/*

	Description:
		Relative angle from middle of screen

	input:
		Center threshhold

	Retrun:
		Relative angle from middle of screen
		-1 if in center in threshhold (default 0.15)

*/
params [["_centerThreshold",0.15]];
_vec = getMousePosition vectordiff [0.5,0.5];
if ( (vectorMagnitude _vec) < _centerThreshold) exitwith {-1};

_vec params ["_x","_y"];
if (_y isequalto 0) then {_y = 0.001};

_deg = atan(_x/_y);
if (_x > 0) then {
	if ( _y > 0 ) then {
		180 - abs(_deg)
	}else{
	  abs(_Deg)
	};
}else{
	if ( _y > 0 ) then {
		(180 - _deg)
	}else{
		(360 - _deg)
	};
};
