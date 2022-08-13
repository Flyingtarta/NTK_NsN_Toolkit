params ["_controlInfo","_zona"];

_owner = missionNamespace getvariable [format ["NSN_VAR_3E_ZONA%1_OWNER",_zona],sideUnknown];
_active = missionnamespace getvariable [format ["NSN_VAR_3E_ZONA%1_ACTIVE",_zona],false];


if (_active && (_owner isequalto sideUnknown) ) exitwith { (_controlInfo#0) ctrlSetText "mission\3event\img\zone_active.paa"};

if (_owner isequalto opfor) then {
  (_controlInfo#0) ctrlSetText "mission\3event\img\zone_opf.paa";
};

if (_owner isequalto blufor) then {
  (_controlInfo#0) ctrlSetText "mission\3event\img\zone_bluf.paa";
};
