/*
  Used on respawn limit per player

*/
private _uid = getPlayerUID player;
player setvariable ["BandoOriginal",side player,true];
player setvariable ["RespawnTime",time,true];

[[_uid,player],
{
  _array_jugadores = array_jugadores;
  private _uid = _this#0;
  private _unit = _this#1;
  private _idx = _array_jugadores findif {_x select 0 isequalto _uid };
  private _vidas = _array_jugadores select _idx select 1;

  if (_vidas > -1) then {
    [_vidas,{
      cutText [ str (formatText ["<t color='#ff0000' size='2'> Te quedan %1 respawn </t>",_this]), "PLAIN DOWN", -1, true, true];
    }]remoteexec["call",remoteExecutedOwner];
  }else{
    {
      cutText ["<t color='#ff0000' size='2'> No te quedan mas respawn </t>","PLAIN DOWN", -1, true, true];
      hideObjectGlobal _unit;
      ["Initialize", [_unit, [], true ]] call BIS_fnc_EGSpectator;
    }remoteexec["call",remoteExecutedOwner];
  }
}] remoteexec ["call",[0,-2] select isDedicated];
