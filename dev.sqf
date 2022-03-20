sleep 1;

_weap = allunits apply {
	_weapon = weapons _x;
	_secondary = SecondaryWeapon _x;

	//_idx = _weapons findif {(configFile >> "CfgWeapons" >> _x >> "cursor") isnotequalto "arifle"};

	if (_secondary isequalto "") then {
		gettext (configFile >> "CfgWeapons" >> ( (weapons _x) #0) >> "picture" )
	}else {
		gettext (configFile >> "CfgWeapons" >> _secondary >> "picture" )
	};
};

[
	   _weap
	,
		""	//Centro (returnValue -1 )
] execvm  "rcs\menu_radial\fnc\fn_ui_radialMenu6.sqf" //NSN_fnc_ui_radialMenu6;


/*
sleep 1;

_weap = allunits apply {
	_weapons = (weapons _x);
	if ( count _weapons > 2) then {
		gettext (configFile >> "CfgWeapons" >> ( _weapons select ((count _weapons )-1) ) >> "UiPicture" )
	} else {
		gettext (configFile >> "CfgWeapons" >> ( (weapons _x) #0) >> "UiPicture" )

	};

};
//>> "cursor" == "rocket"
[
	   _weap
	,
		""	//Centro (returnValue -1 )
] call NSN_fnc_ui_radialMenu6;
