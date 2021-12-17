/*
  Description:
    Mostrar informacion en el mapa del estado de los secotres , marcador y tiempo restante
*/

//disableSerialization;
barrita_captura = createHashMap;
_map = findDisplay 12;
waituntil {!(isNull findDisplay 12)};
_duracion = ["Duracion",165] call BIS_fnc_getParamValue;

{

	_pos = (findDisplay 12 displayCtrl 51) ctrlMapWorldToScreen (getMarkerPos _x);
	_barrita = _map ctrlCreate ["RscProgress", (1314 + _foreachindex)];

	_barrita ctrlSetPosition [1.3125,-0.06 + (0.12*_foreachindex),0.37,0.04];
	_barrita progressSetPosition 1;
	_barrita ctrlSetTextColor [1,1,1,1];
	_barrita ctrlCommit 0;

	_texto = _map ctrlCreate ["RscText", (1414 + _foreachindex)];
	_texto ctrlSetPosition [1.3125,-0.10+ (0.12*_foreachindex) ,0.2625,0.04];
	_texto ctrlSetText (markerText _x);
	_texto ctrlCommit 0;
	barrita_captura set [_x,_barrita];

}foreach (allMapMarkers select {"obj" in _x});

_marcador = _map ctrlCreate ["RscStructuredText",1616];
_marcador ctrlSetPosition [1.2375,0.2,0.45,0.16];

findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw",{
  _map = _this#0;
	_scale = ctrlMapScale _map;
	private _coloresMarcadores = createHashMapFromArray [[blufor,[0,0.3,0.6,0.8]], [opfor,[0.5,0,0,0.8]],[independent,[0,0.5,0,0.8]],[sideUnknown,[0.7,0.6,0,0.8]]];
  {
		_areaState = missionnamespace getvariable _x;
		_owner = _areaState get "owner";
		_tiempoMaximo = _areaState get "TiempoDeCaptura";
		_capturaActual = _areaState get "captura";
		_colorBarra = _coloresMarcadores get _owner;
		_progreso = (_capturaActual get _owner)/_tiempoMaximo;

		_barrita = barrita_captura get _x;
		_barrita ctrlSetTextColor _colorBarra;
		_barrita progressSetPosition _progreso;

		_barrita ctrlCommit 2;
  }foreach (allMapMarkers select {"obj" in _x});
	_duracion = ["Duracion",165] call BIS_fnc_getParamValue;
	_countdown = [(_duracion*60-time)/60+.01,"HH:MM"] call BIS_fnc_timetostring;
	/*
	_marcador = localNamespace getvariable "marcadorUI";
	_structuredText = composeText ["Tiempo Restante: ", _countdown ,lineBreak,image "\A3\ui_f\data\map\markers\flags\nato_ca.paa","  |			",str (marcador get blufor) ,lineBreak,image "\a3\UI_F_Enoch\Data\CfgMarkers\Russia_CA.paa","  |			",str (marcador get opfor)];
	_marcador ctrlSetStructuredText parsetext str _structuredText;
	*/
	hintsilent composeText ["Tiempo Restante: ", _countdown ,lineBreak,image "\A3\ui_f\data\map\markers\flags\nato_ca.paa","  |			",str (marcador get blufor) ,lineBreak,image "\a3\UI_F_Enoch\Data\CfgMarkers\Russia_CA.paa","  |			",str (marcador get opfor)];
}];

/*
controls[]=
{
	RscStructuredText_1100
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Tarta, v1.063, #Zyvoha)
////////////////////////////////////////////////////////

class RscStructuredText_1100: RscStructuredText
{
	idc = 1100;
	x = 1.325;
	y = 0.46;
	w = 0.35;
	h = 0.12;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////
