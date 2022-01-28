/*

	NO FUNCIONA CORRECTAMENTE

*/
/*


[
	_this,											// Object the action is attached to
	"<t color='#008100'>REPACKEAR VEHICULO</t>",										// Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",	// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",	// Progress icon shown on screen
	"_this distance _target < 10 && isnull (objectParent _target)",						// Condition for the action to be shown
	"_caller distance _target < 10",						// Condition for the action to progress
	{},													// Code executed when action starts
	{},													// Code executed on every progress tick
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		private _vehs = nearestObjects [_target,["Tank","Air","Land"],20,true];

		if (_vehs isequalto []) exitWith { cutText ["<t color='#ff0000' size='3'>No hay vehiculos cerca (20m)</t>", "PLAIN DOWN", -1, true, true] };
		_vehs = _vehs select { !(_x isKindOf "Man") };
		private _veh = _vehs#0;
		_veh setvehicleammo 1;
		_veh setfuel 1;
		cutText ["<t color='#008100' size='3'> Vehiculo Repackeado </t>", "PLAIN DOWN", -1, true, true];
		deletevehicle _target;

		if (_veh iskindof "rhs_2s3_tv") then {//artilleria rusa
			_veh removeMagazines  "rhs_mag_WP_2a33" ;
			_veh removeMagazines  "rhs_mag_LASER_2a33";
			for "_" from 1 to 4 do {
			 _veh addMagazineTurret ["rhs_mag_SMOKE_2a33",[0]];
			 _veh addMagazineTurret ["rhs_mag_ILLUM_2a33",[0]];
			};
		};

		if (_veh isKindOf "rhsusf_m109d_usarmy") then { //artilleria rusa
			{
				_veh removeMagazines _x;
			}foreach ["rhs_mag_155mm_m712_2","rhs_mag_155mm_m731_1","rhs_mag_155mm_raams_1","rhs_mag_155mm_m864_3"];

			for "_i" from 0 to 10 do {
				_veh addMagazineTurret ["rhs_mag_155mm_485_2",[0],100];
				_veh addMagazineTurret ["rhs_mag_155mm_m825a1_2",[0],100];
			};
		};
	},				// Code executed on completion
	{},													// Code executed on interrupted
	[],													// Arguments passed to the scripts as _this select 3
	10,													// Action duration [s]
	100,													// Priority
	true,												// Remove on completion
	false												// Show in unconscious state
] call BIS_fnc_holdActionAdd;
