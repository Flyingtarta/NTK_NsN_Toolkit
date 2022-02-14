/*



*/
[
	_this,											// Object the action is attached to
	"<t color='#008100'>REPACKEAR MORTERO/MONTADA</t>",										// Title of the action
	/*"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",	// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",	// Progress icon shown on screen*/
	"\a3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa",
	"\a3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa",
	"_this distance _target < 10",						// Condition for the action to be shown
	"_caller distance _target < 10",						// Condition for the action to progress
	{},													// Code executed when action starts
	{},													// Code executed on every progress tick
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		private _turret = nearestObjects [_target,["StaticMortar","StaticWeapon"],20];
		if (_turret isequalto []) exitWith { cutText ["<t color='#ff0000' size='3'>No hay montada o morteros cerca cerca (10m)</t>", "PLAIN DOWN", -1, true, true] };
		private _turret = _turret#0;
		if !(count (magazines _turret) < 3) exitwith {cutText ["<t color='#ff0000' size='3'> La montada tiene toda la municion </t>", "PLAIN DOWN", -1, true, true]};
		_turret setvehicleammo 1;
		cutText ["<t color='#008100' size='3'> montada Repackeada </t>", "PLAIN DOWN", -1, true, true];
		deletevehicle _target;
	},				// Code executed on completion
	{},													// Code executed on interrupted
	[],													// Arguments passed to the scripts as _this select 3
	10,													// Action duration [s]
	100,													// Priority
	false,												// Remove on completion
	false												// Show in unconscious state
] call BIS_fnc_holdActionAdd;
