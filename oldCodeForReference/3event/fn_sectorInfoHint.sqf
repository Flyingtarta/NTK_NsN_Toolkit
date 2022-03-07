findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw",{
  _position = _map posScreenToWorld getMousePosition;

  _zona = ( sectores findif { _x distance2d _position < 100} ) + 1;
  if (_zona isnotequalto 0) then {

    _owner  = missionNamespace getvariable [format ["NSN_VAR_3E_ZONA%1_OWNER",_zona],sideUnknown];
    _locked = missionNamespace getvariable [format ["NSN_VAR_3E_ZONA%1_LOCK",_zona],True];
    _won    = missionNamespace getvariable [format ["NSN_VAR_3E_ZONA%1_WON",_zona],False];
    _active = missionnamespace getvariable [format ["NSN_VAR_3E_ZONA%1_ACTIVE",_zona],false];

  };

}]
