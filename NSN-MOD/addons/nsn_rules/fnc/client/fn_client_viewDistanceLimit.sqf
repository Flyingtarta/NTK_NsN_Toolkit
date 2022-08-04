/*
	descripcion: 

	Se ejecuta en cada frame, verifica que la viewdistance esta dentro del maximo, varia con vehiculos.
	verifica que el detalle del terreno este en alto como minimo 
*/
if (!isnull findDisplay 46) exitwith {}; 

_distanceOnFoot = missionNamespace getvariable ["NSN_VAR_VIEWDISTANCE_FOOT",3000];
_distanceOnVeh = missionNamespace getvariable ["NSN_VAR_VIEWDISTANCE_veh",5000];
_viewdistance = viewdistance;
_vehicle = vehicle player;

//viewdistance check 
if (_vehicle isequalto player) then {
	if (viewdistance > _distanceOnFoot) then {setviewdistance _distanceOnFoot};
	} else{
	if (viewdistance > _distanceOnVeh) then {setviewdistance _distanceOnVeh};
};

//Terrain Grid
if (getTerrainGrid > 6.25) then {setterraingrid 6.25};


