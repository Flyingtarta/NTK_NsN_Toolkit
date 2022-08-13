/*
	nsn_fnc_createSideMission_destroy

	Description:
		Gives task of intel to desired players 

	0: target		(obj) intel that should be retrived 
	1: whoCanSeeIt  (list of units that should see the task) units <side> selects an entiere side 
	2: askID	 	(string) just a string to identify the task 
	3: title		(string) A tittle to show on map 
	4: description  (string) Description on what you should do 
	5: reward 		(number | default: 100 ) reward for completing the task 

	output:
		none
*/

if (!isserver) exitwith {};

params ["_target","_whoCanSeeIt","_taskID","_title","_description",["_reward",100]];
//creates the task

private _task = [
	_whoCanSeeIt,//a quien se la da
	_taskID, //id?
	_description, //descripcion
	_target, //target o ubicacion
	true, //estado? creado deberia ser
	1, //prioridad
	true, //notificacion
	"", //clase? deja soempre ""
	false //que se vea 3d
] call BIS_fnc_taskCreate;

[_task,[_description,_title,"destroy"]] call BIS_fnc_taskSetDescription;
[_task,"destroy"] call BIS_fnc_taskSetType;
[_task,"CREATED"] call bis_fnc_taskHint;

//add action to destroy the target
private _radius =  5 + ((boundingbox _target) select 2) * 1.5 ;


[
	_target,


	["Poner explosivos",
		{
			params ["_target", "_caller", "_actionId", "_arguments"];
			_arguments params ["_task","_whocanseeit","_reward"]; 
			"Explosivos Plantados\nDespejar la zona (30s)" remoteexec ["Hint", allplayers select {_x distance2d _target < 300}];
			_caller removeaction _actionid; 
			[_task,_target,side _caller,_reward] spawn 
			{
				params ["_task","_obj","_side","_reward"];
				uisleep 10;
				_pos = getpos _obj;
				deletevehicle _obj;
				createvehicle ["HelicopterExploBig",_pos, [], 0, "CAN_COLLIDE"];
				if ([_task] call BIS_fnc_taskExists) then 
				{
					[_task,"SUCCEEDED"] call BIS_fnc_taskSetState;
					
				};
				[createHashMapFromArray [[_side, _reward]],nsn_fnc_editScoreBoard]  remoteexec ["call",2]; 
			};
		},
		[_task,_whocanseeit,_reward],//params
		100,//priority
		true,//showwindow
		true,//hideonuse
		"",
		"true",//condition
		_radius
	]

] remoteexec ["addaction",_whoCanSeeIt,_target];

