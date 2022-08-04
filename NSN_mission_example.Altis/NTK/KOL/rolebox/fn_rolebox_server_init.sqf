/*

initializase the saving loadouts script


*/

Clases = createHashMapFromArray [[opfor,createHashMap],[blufor,createHashMap]];
{
	_rol = roleDescription _x;
	_loadout = getUnitLoadout _x;
	_side = side _x;
	_loadouts_side = clases get _side;
	_loadouts_side set [_rol,_loadout];
} foreach playableunits;

_loadouts_opfor = clases get opfor;
_loadouts_blufor = clases get blufor;


if !(isnil "base_blufor") then {
	{
	 call compile (format ["base_blufor addaction [ %1 ,{(_this select 1) setUnitLoadout %2 }];",str _x,(_loadouts_blufor get _x)]);
	}foreach _loadouts_blufor;
	 systemchat "ERROR EDICION | NO SE DECLARO LA BASE DE BLUFOR PARA CAMBIAR LOADOTS "
};


if !(isnil "base_opfor") then {
	{
	 call compile (format ["%1 addaction [ %2 ,{(_this select 1) setUnitLoadout %3}];",base_opfor,str _x,(_loadouts_opfor get _x)]);
	}foreach _loadouts_opfor;
}else{
	systemchat "ERROR EDICION | NO SE DECLARO LA BASE DE OPFOR PARA CAMBIAR LOADOTS "

}
