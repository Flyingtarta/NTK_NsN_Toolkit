/*
	- SERVER SIDE -

	Description:
		Limits the ammount of respawn for each player connected


	Author:
		Tarta
*/

PRIVATE _vidas = ["vidas",2] call BIS_fnc_getParamValue;
array_jugadores = [];
waituntil { time > 0};
{
	_uid = getPlayerUID _x;
	array_jugadores pushback [_uid,_vidas];
} forEach allplayers;
