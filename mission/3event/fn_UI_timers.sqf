params ["_controlData","_zona"];


private _owner     = missionNamespace getvariable [format ["NSN_VAR_3E_ZONA%1_OWNER",_zona],sideUnknown];
private _holdUntil = missionNamespace getvariable [format ["NSN_VAR_3E_ZONA%1_HU",_zona],0];

private _locked    = missionNamespace getvariable [format ["NSN_VAR_3E_ZONA%1_LOCK",_zona],True];
private _won       = missionNamespace getvariable [format ["NSN_VAR_3E_ZONA%1_WON",_zona],False];
private _active    = missionnamespace getvariable [format ["NSN_VAR_3E_ZONA%1_ACTIVE",_zona],false];

if (_active && (_owner isequalto sideUnknown) || _won) exitwith { _controlData#0 ctrlSetText ""};

if (_holdUntil isequalto 0) then {
  _Preparacion = ["Preparacion",10] call BIS_fnc_getParamValue;
  _TiempoEntreZonas = ["tiempoEntreZonas",30] call BIS_fnc_getParamValue;
  _tiempoRestante = ( _preparacion*60 + _TiempoEntreZonas*60*(_zona-1)) - time;
  _time2String = [_tiempoRestante/60+.01,"HH:MM"] call BIS_fnc_timetostring;
  (_controlData#0) ctrlsettext _time2String;
}else{

  _Preparacion = ["Preparacion",10] call BIS_fnc_getParamValue;
  _tiempoRestante = _holdUntil - time;
  _time2String = [_tiempoRestante/60+.01,"HH:MM"] call BIS_fnc_timetostring;
  (_controlData#0) ctrlsettext _time2String;
};
