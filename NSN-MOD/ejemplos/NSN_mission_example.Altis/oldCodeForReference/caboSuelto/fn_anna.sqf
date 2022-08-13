/*
	description:
		Da informacion al recibir intel - especifico de mision
		[Local] en todos los jugadoes

	author: tarta

*/

{
//Addaction
	_x disableai "PATH";
	_X allowDamage false;

	_x addAction
	[
		"<t color='#06CE00'>Entregar Intel </t> ",
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			_caller removemagazine "acex_intelitems_photo";
			_lose = allplayers select {(side _x) isnotequalto (side _caller)};
			missionNamespace getvariable ["IntelEntregada",true,true];
			["win1", true] remoteexec ["BIS_fnc_endMission",side _caller];
			["end1", false] remoteexec ["BIS_fnc_endMission",_lose];
		},
		nil,
		1.5,
		true,
		true,
		"",
		"'acex_intelitems_photo' in (magazines _this)",
		5,
		false,
		"",
		""
	];

	_x addAction
	[
		"<t color='#06CE00'>Entregar Caja Negra</t> ",
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			_caller removeItem "rhs_item_flightrecorder";
			[ "", ["<t color='#0892d0' size='2'> Caja negra entregada <br/> Intel nueva en el mapa </t>", "PLAIN DOWN",3,true,true] ] remoteexec ["cutText",side _caller,false];
			missionNamespace getvariable ["IntelEntregada",true,true];
			[[],{
				_posW = (getpos intel_opfor) getpos [random [0,143,360], random [0,50,140] ];
				_posE = (getpos intel_blufor) getpos [random [0,143,360], random [0,50,140] ];
				//crear marcadores
				_MK1 = createmarkerlocal ["INTEL_WEST",_posW];
				_mk1 setMarkerColorlocal "ColorRed";
				_mk1 setMarkerSizelocal [500,500];
				_mk1 setMarkerShape "ELLIPSE";

				_MK2 = createmarkerlocal ["INTEL_EAST",_posE];
				_mk2 setMarkerColorlocal "ColorBlue";
				_mk2 setMarkerSizelocal [500,500];
				_mk2 setMarkerShapelocal "ELLIPSE";
			}] REMOTEEXEC [ "call",side _caller,true];

		},
		nil,
		1.5,
		true,
		true,
		"",
		"'rhs_item_flightrecorder' in (items _this)", // _target, _this, _originalTarget
		5,
		false,
		"",
		""
	];

} foreach [hq_east,hq_west];
