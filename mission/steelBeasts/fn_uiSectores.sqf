/*
  Description:
    Mostrar informacion en el mapa del estado de los secotres , marcador y tiempo restante
*/


barrita_captura = createHashMap;
{
	_map = findDisplay 12;
	_pos = (findDisplay 12 displayCtrl 51) ctrlMapWorldToScreen (getMarkerPos _x);
	_barrita = _map ctrlCreate ["RscProgress", (1314 + _foreachindex)];

	_barrita ctrlSetPosition [1.3125,-0.18 + (0.12*_foreachindex),0.37,0.04];
	_barrita progressSetPosition 1;
	_barrita ctrlSetTextColor [1,1,1,1];
	_barrita ctrlCommit 0;

	_texto = _map ctrlCreate ["RscText", (1414 + _foreachindex)];
	_texto ctrlSetPosition [1.3125,-0.22+ (0.12*_foreachindex) ,0.2625,0.04];
	_texto ctrlSetText (markerText _x);
	_texto ctrlCommit 0;
	barrita_captura set [_x,_barrita];

}foreach (allMapMarkers select {"obj" in _x});



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

}];
