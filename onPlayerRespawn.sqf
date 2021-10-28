
// falta agregar a los tom

private _uid = getPlayerUID player;


[_uid,
{
  _array_jugadores = array_jugadores;
  private _uid = _this;

  private _idx = _array_jugadores findif {_x select 0 isequalto _uid };
  private _vidas = _array_jugadores select _idx select 1;

  if (_vidas > -1) then {
    [_vidas,{
      cutText [ str (formatText ["<t color='#ff0000' size='2'> Te quedan %1 vidas </t>",_this]), "PLAIN DOWN", -1, true, true];
    }]remoteexec["call",remoteExecutedOwner];

  }else{
    {
      cutText ["<t color='#ff0000' size='2'> No te quedan mas vidas </t>","PLAIN DOWN", -1, true, true];
      hideObject player;
      ["Initialize", [player, [], true ]] call BIS_fnc_EGSpectator;
    }remoteexec["call",remoteExecutedOwner];
  }
}] remoteexec ["call",[0,-2] select isDedicated];
