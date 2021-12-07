/*


*/
#define RadioSector 200
//#define tiempoEntreSectores 60*20

//if (isserver) exitWith {};
private _tiempoPreparacion = (["Preparacion",10] call BIS_fnc_getParamValue)*60;
private _TiempoEntreZonas = (["tiempoEntreZonas",30] call BIS_fnc_getParamValue)*60;

MARCADOR = createHashMapFromArray [[opfor,0], [blufor,0]];
publicVariable "MARCADOR";

private _sector1 = [12985,10249,0];
private _sector2 = [7853,12411,0];
private _sector3 = [10331,9082,0];

sectores = [_sector1,_sector2,_sector3];
publicVariable "sectores";

{
    _mk = createMarker [str(_x),_x];
    _mk setMarkerColor "ColorBlack";
    _mk setMarkerAlpha 0.8;
    _mk setMarkerSize [RadioSector, RadioSector];
    _mk setMarkerShape "ELLIPSE";

    _zona = _forEachIndex +1;
    missionNamespace setvariable [format ["NSN_VAR_3E_ZONA%1_OWNER",_zona],sideUnknown,true];
    missionNamespace setvariable [format ["NSN_VAR_3E_ZONA%1_LOCK",_zona],True,true];
    missionNamespace setvariable [format ["NSN_VAR_3E_ZONA%1_WON",_zona],False,true];
    missionnamespace setvariable [format ["NSN_VAR_3E_ZONA%1_ACTIVE",_zona],false,true];
} forEach sectores;

{
    //Activamos primer sector
    _zona = _forEachIndex+1;
    //actualizamos el estado del sector de manera global
    missionNamespace setvariable [format ["NSN_VAR_3E_ZONA%1_OWNER",_zona],sideUnknown,true];
    missionNamespace setvariable [format ["NSN_VAR_3E_ZONA%1_LOCK",_zona],False,true];
    missionNamespace setvariable [format ["NSN_VAR_3E_ZONA%1_WON",_zona],False,true];
    missionnamespace setvariable [format ["NSN_VAR_3E_ZONA%1_ACTIVE",_zona],true,true];
    (str _x) setMarkerColor "ColorYellow";
    _x spawn { _this call NSN_fnc_gameplay_Sector};
    waituntil {time > (_TiempoEntreZonas*_zona + _tiempoPreparacion)};
    hint format ["Se activa el objetivo %1",_zona];
}foreach sectores;
