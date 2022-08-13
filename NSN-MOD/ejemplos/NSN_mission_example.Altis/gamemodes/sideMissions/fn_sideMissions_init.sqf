/*
	side missions creator

	21:30 | Abre servidor y pueden entrar pero no salir de base
	22:00 | arranca mision 
	22:10 | fin tiempo de prep 
	22.30 | fin Alto el fuego - Se habilitan zonas y antena
	23.00 | primera mision secundaria
	23.30 | segunda mision secundaria
	00:00 | tercera mision secundaria
	00:30 | cuerta mision  secundaria
	01:00 | Fin de la mision 
	
*/

// #define waitTime 30*60
#define waitTime 1800

if (!isServer) exitWith {};

/*
Wait until cese fire ends 
*/

private _tiempoDePreparacion = servertime + (["Preparacion",10] call BIS_fnc_getParamValue) * 60;
private _tiempoDeAltoElFuego = (["AltoElFuego",20] call BIS_fnc_getParamValue) * 60;
missionNamespace setvariable ["NSN_VAR_EndPrepTime",_tiempoDePreparacion,true];
waituntil { //Espera que pase el tiempo de alto el fuego y de preparacion
  servertime > (_tiempoDePreparacion + _tiempoDeAltoElFuego)
}; //script starts after prep time and cease fire


private _mision_de_intel =
{
	[intel_opf_1, opfor , "nsn_intel_opfor_1" , "Documentos", "Buscar Documentos (agarrarlos con menu de ACE) y llevarlos al general en base", [ofi_opf_1],200] call nsn_fnc_createSideMission_intel;
	[intel_blu_1, blufor, "nsn_intel_blufor_1", "Documentos", "Buscar Documentos (agarrarlos con menu de ACE) y llevarlos al general en base", [ofi_blu_1],200] call nsn_fnc_createSideMission_intel;
};

private _mision_de_intel_2 =
{
	[intel_opf_2, opfor , "nsn_intel_opfor_2" , "Documentos", "Buscar Documentos (agarrarlos con menu de ACE) y llevarlos al general en base", [ofi_opf_2],200] call nsn_fnc_createSideMission_intel;
	[intel_blu_2, blufor, "nsn_intel_blufor_2", "Documentos", "Buscar Documentos (agarrarlos con menu de ACE) y llevarlos al general en base", [ofi_blu_2],200] call nsn_fnc_createSideMission_intel;	
};

private _mision_de_destroy =
{
	[destroy_opf_1,opfor  , "nsn_destroy_opf_1", "Cache de armas", "Inteligencia encontro un cache de armas en las montañas" ] call nsn_fnc_createSideMission_destroy;
	[destroy_blu_1,blufor , "nsn_destroy_blu_1", "Cache de armas", "Inteligencia encontro un cache de armas en las montañas" ] call nsn_fnc_createSideMission_destroy;
};

private _mision_de_destroy_2 =
{
	[destroy_opf_2,opfor  , "nsn_destroy_opf_2", "Destruir Antena", "Inteligencia encontro una antena de celulares siendo usada con fines militares" ] call nsn_fnc_createSideMission_destroy;
	[destroy_blu_2,blufor , "nsn_destroy_blu_2", "Destruir Antena", "Inteligencia encontro una antena de celulares siendo usada con fines militares" ] call nsn_fnc_createSideMission_destroy;
};

private _mission_pool = [
	_mision_de_intel,
	_mision_de_intel_2,
	_mision_de_destroy,
	_mision_de_destroy_2	
];

while { _mission_pool isNotEqualTo [] } do {
	sleep waitTime;  // tiempo entre missiones secundarias
	_mission = selectRandom _mission_pool;
	_mission_pool deleteAt (_mission_pool find _mission);
	[] call _mission;// manda la mision elegida
};

//"termino de tirar todas las misiones" remoteexec ["systemchat",0]; 