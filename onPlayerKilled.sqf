/*
  Used on respawn limit per player 

*/


private _uid = getPlayerUID player;

_vidas = ["vidas",2] call BIS_fnc_getParamValue;

if (_vidas isequalto (-100)) exitwith {systemchat " No hay limite de respawn "};

[_uid,
{
  private _array_jugadores = array_jugadores;

  private _idx = _array_jugadores findif {_x select 0 isequalto _this };
  private _vidas = ["vidas",2] call BIS_fnc_getParamValue;

  if (_idx isEqualTo -1) then {//soluciona JIP
    _array_jugadores pushBackUnique [_this,_vidas - 1];
  }else{
    private _vidas = ((_array_jugadores select _idx) select 1) - 1;
    _array_jugadores set [_idx,[_this,_vidas]];
  };
}]remoteexec ["call",2];
