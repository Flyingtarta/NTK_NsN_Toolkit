params ["_display","_zona"];

private _owner  = missionNamespace getvariable [format ["NSN_VAR_3E_ZONA%1_OWNER",_zona],sideUnknown];
private _locked = missionNamespace getvariable [format ["NSN_VAR_3E_ZONA%1_LOCK",_zona],True];
private _won    = missionNamespace getvariable [format ["NSN_VAR_3E_ZONA%1_WON",_zona],False];
private _active = missionnamespace getvariable [format ["NSN_VAR_3E_ZONA%1_ACTIVE",_zona],false];

if (_active) exitWith {_display#0 ctrlSetText ""};

if (_locked) exitWith { _display#0 ctrlSetText "mission\3event\img\locked.paa"};

if (_won) exitwith {_display#0 ctrlSetText "mission\3event\img\lockedY.paa"};

if ( (side player) isequalto _owner && !_locked ) then {
  _display#0 ctrlSetText "mission\3event\img\Defend.paa"
}else{
  _display#0 ctrlSetText "mission\3event\img\Attack.paa"
};
