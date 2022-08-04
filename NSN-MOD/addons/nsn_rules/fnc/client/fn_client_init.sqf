
if !(hasInterface) exitwith {}; 

[] call nsn_fnc_client_addons;

[] spawn {
	waitUntil {!isnull findDisplay 46};
	addmissioneventhandler ["EachFrame",{
		[] call nsn_fnc_client_viewDistanceLimit;
	}];
};