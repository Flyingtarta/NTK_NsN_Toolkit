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

		//if !(count (magazines _veh) < 4) exitwith {cutText ["<t color='#ff0000' size='3'> El mortero tiene la municion llena </t>", "PLAIN DOWN", -1, true, true]};
		_veh setvehicleammo 1;
		_veh setfuel 1;
		cutText ["<t color='#008100' size='3'> Vehiculo Repackeado </t>", "PLAIN DOWN", -1, true, true];
		deletevehicle _target;
	},				// Code executed on completion
	{},													// Code executed on interrupted
	[],													// Arguments passed to the scripts as _this select 3
	10,													// Action duration [s]
	100,													// Priority
	true,												// Remove on completion
	false												// Show in unconscious state
] call BIS_fnc_holdActionAdd;
