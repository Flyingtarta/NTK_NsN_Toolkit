/*
  Descripcion:
    Cada caja equivale a un repack completo del mortero, busca en un radio de 10 metros un mortero y le llena la municion, luego borra la caja
		Older version, only for mortarts, it works since it loads the magazines
  input:
    Caja (objeto): caja que queremos que haga de repack

  output:
    Nada

  author:
    [calaveras] FlyingTarta

*/





[
	_this,											// Object the action is attached to
	"<t color='#008100'>REPACKEAR MORTERO</t>",										// Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",	// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",	// Progress icon shown on screen
	"_this distance _target < 10",						// Condition for the action to be shown
	"_caller distance _target < 10",						// Condition for the action to progress
	{},													// Code executed when action starts
	{},													// Code executed on every progress tick
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		private _mortars = nearestObjects [_target,["StaticMortar"],10];
		if (_mortars isequalto []) exitWith { cutText ["<t color='#ff0000' size='3'>No hay morteros cerca (10m)</t>", "PLAIN DOWN", -1, true, true] };
		private _mortar = _mortars#0;
		if !(count (magazines _mortar) < 4) exitwith {cutText ["<t color='#ff0000' size='3'> El mortero tiene la municion llena </t>", "PLAIN DOWN", -1, true, true]};
		_mortar setvehicleammo 1;
		cutText ["<t color='#008100' size='3'> Mortero Repackeado </t>", "PLAIN DOWN", -1, true, true];
		deletevehicle _target;
	},				// Code executed on completion
	{},													// Code executed on interrupted
	[],													// Arguments passed to the scripts as _this select 3
	10,													// Action duration [s]
	100,													// Priority
	true,												// Remove on completion
	false												// Show in unconscious state
] call BIS_fnc_holdActionAdd;



//Old CODE just for reference 
/*
_this addAction
[
	"<t color='#008100'>REPACK MORTERO</t>",
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		private _mortars = nearestObjects [_target,["StaticMortar"],10];
		if (_mortars isequalto []) exitWith { cutText ["<t color='#ff0000' size='3'>No hay morteros cerca (10m)</t>", "PLAIN DOWN", -1, true, true] };
		private _mortar = _mortars#0;
		if !(count (magazines _mortar) < 4) exitwith {cutText ["<t color='#ff0000' size='3'> El mortero tiene la municion llena </t>", "PLAIN DOWN", -1, true, true]};
		_mortar setvehicleammo 1;
		cutText ["<t color='#008100' size='3'> Mortero Repackeado </t>", "PLAIN DOWN", -1, true, true];
		deletevehicle _target;
	},
	nil,
	100,
	False,
	true,
	"",
	"true",
	10,
	false,
	"",
	""
];
*/
