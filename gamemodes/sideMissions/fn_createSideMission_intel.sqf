/*
	
	nsn_fnc_createSideMission_intel
	
	Description:
	Gives task of intel to desired players 
	
	0: target(obj) intel that should be retrived 
	1: whoCanSeeIt  (list of units that should see the task) units <side> selects an entiere side 
	2: askID (string) just a string to identify the task 
	3: title(string) A tittle to show on map 
	4: description  (string) Description on what you should do 
	5: retriveWho   [array] of objects it gives an addAction to this object, to deliver the intel 
	6: reward (number | opcional | default: 100) reward for completing the task 
	
*/
if (!isServer) exitWith {}; // server only 

params ["_target", "_whoCanSeeIt", "_taskID", "_title", "_description", "_retriveToWho", ["_reward", 100]];



// Mision de entregar la intel: 

private _task_retrive = [
	_whoCanSeeIt, // a quien se la da
	_taskID+"retrive",  // id?
	"Entregar los documentos", // descripcion
	_retriveToWho, // target o ubicacion
	true, // estado? creado deberia ser
	2, // prioridad
	true, // notificacion
	"", // clase? deja soempre ""
	false        // que se vea 3d
] call BIS_fnc_taskCreate;

[_task_retrive, ["Entregar los documentos", "Entregar documentos", "documents"]] call BIS_fnc_taskSetDescription;
[_task_retrive, "meet"] call BIS_fnc_taskSetType;

// main mission 
private _task = [
	_whoCanSeeIt, // a quien se la da
	_taskID,  // id?
	_description, // descripcion
	_target, // target o ubicacion
	true, // estado? creado deberia ser
	1, // prioridad
	true, // notificacion
	"", // clase? deja soempre ""
	false        // que se vea 3d
] call BIS_fnc_taskCreate;

[_task, [_description, _title, "documents"]] call BIS_fnc_taskSetDescription;
[_task, "documents"] call BIS_fnc_taskSetType;
[_task, "CREATED"] call BIS_fnc_taskHint;


// dar addAction al que hay que llevarsela que verifique si el tipo de intel esta en el inventario del caller 
missionNamespace setvariable [_task, true, true];

{
	[_x,
		[
			"Entregar intel", {
				params ["_target", "_caller", "_actionId", "_arguments"];
				_arguments params ["_task", "_reward", "_intelType", "_task_retrive"];
				missionNamespace setvariable [_task, false, true];
				if (_intelType in (keys uniqueUnitItems _caller)) then {
					_caller removeAction _actionId; 
					_caller removeItem _intelType;
					if ([_task] call BIS_fnc_taskExists) then {
						[_task, "SUCCEEDED"] call BIS_fnc_taskSetState;
						[_task_retrive, "SUCCEEDED"] call BIS_fnc_taskSetState;
					};
					[createHashMapFromArray [[side _caller, _reward]], nsn_fnc_editScoreBoard] remoteexec ["call", 2];
				} else {
					hint "No tenes la intel";
				};
			},
			[_task, _reward, typeOf _target, _task_retrive], //argumentos
			100, true, true, "",
			"true",
			5
		]
	] remoteexec ["addaction",_whoCanSeeIt];

}foreach _retriveToWho;