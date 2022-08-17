if !(hasInterface) exitwith {};//Only player 
waitUntil {! isNull (findDisplay 12 displayCtrl 51) };
//if !(isnil "eh") then {(findDisplay 12 displayCtrl 51) ctrlRemoveEventHandler ["Draw",eh]};			//DEBUG 



findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw",{
	params ["_map"];
	{
		 _x params["_from","_to"];
		_color = [0.7,0.6,0,1];
		_bando_from = (_from getvariable "data") get "owner";
		_bando_to = (_to getVariable "data") get "owner";
		if ( _bando_from isEqualTo _bando_to) then {
		//Si ambos son del mismo equipo 
				if (_bando_from isEqualTo blufor) then {_color = [0,0.3,0.6,1]};
				if (_bando_from isEqualTo opfor) then {_color =	 [0.5,0,0,1]};	
		};
		_map drawLine [_from,_to,_color ];	
	}foreach nsn_lineas;
}];


[] spawn nsn_fnc_nc_ceaseFirePhase;