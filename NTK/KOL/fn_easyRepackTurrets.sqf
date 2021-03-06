/*

	Recharge ammo on turrets and mortars, dont work propperly on mortars

*/

[
	_this,											// Object the action is attached to
	"<t color='#008100'>REPACKEAR MORTERO/MONTADA</t>",										// Title of the action
	"\a3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa",
	"\a3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa",
	"_this distance _target < 10",						// Condition for the action to be shown
	"_caller distance _target < 10",						// Condition for the action to progress
	{
		private _turret = nearestObjects [_target,["StaticMortar","StaticWeapon"],20];
		if (_turret isequalto []) exitWith { cutText ["<t color='#ff0000' size='3'>No hay montada o morteros cerca cerca (10m)</t>", "PLAIN DOWN", -1, true, true] };
		if ( (crew (_turret#0)) isNotEqualTo []) exitwith {cutText ["<t color='#ff0000' size='3'>No tiene que tener gente dentro</t>", "PLAIN DOWN", -1, true, true] };

	},													// Code executed when action starts
	{},													// Code executed on every progress tick
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		private _turret = nearestObjects [_target,["StaticMortar","StaticWeapon"],20];
		if (_turret isequalto []) exitWith { cutText ["<t color='#ff0000' size='3'>No hay montada o morteros cerca cerca (10m)</t>", "PLAIN DOWN", -1, true, true] };
		private _turret = _turret#0;
		if ((crew _turret) isNotEqualTo []) exitwith {cutText ["<t color='#ff0000' size='3'>No tiene que tener gente dentro</t>", "PLAIN DOWN", -1, true, true] };
		if !(count (magazines _turret) < 3) exitwith {cutText ["<t color='#ff0000' size='3'> La montada tiene toda la municion </t>", "PLAIN DOWN", -1, true, true]};
		//_turret setVehicleAmmoDef 1;
		[_turret, 1] remoteExecCall ["setVehicleAmmoDef",owner _turret, false];

		cutText ["<t color='#008100' size='3'> montada Repackeada </t>", "PLAIN DOWN", -1, true, true];
		deletevehicle _target;
	},				// Code executed on completion
	{},													// Code executed on interrupted
	[],													// Arguments passed to the scripts as _this select 3
	10,													// Action duration [s]
	100,												// Priority
	false,											// Remove on completion
	false												// Show in unconscious state
] call BIS_fnc_holdActionAdd;
