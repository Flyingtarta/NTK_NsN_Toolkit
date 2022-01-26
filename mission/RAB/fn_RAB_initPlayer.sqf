/*

  - Verifica que no se salga del area
  - Agrega effecto si se sale del area
  - UI

*/
systemchat str "RAB | initPlayer...ok!";
findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw",{

  _zonasCapturables = zonas select {
    _bando = (missionNamespace getVariable _x) get "bando";
    _bando isNotEqualTo (side player)
  };
  {
    _canCapture = [_x,side player] call NSN_FNC_RAB_canCaptureZone;
    if (_canCapture) then {
      _zona = _x;
      _scale = ctrlMapScale (findDisplay 12 displayCtrl 51);
      _alpha = linearconversion [0.1,0.5,_scale,0,1,false];
      systemchat str _zona;
      (_this#0) drawicon [
          "\a3\ui_f\data\igui\cfg\simpletasks\types\attack_ca.paa",
          [1,1,1,_alpha],
          getmarkerpos _zona,
          10/_scale,
          10/_scale,
          markerDir _zona
      ];
    };
  } foreach _zonasCapturables;
}];


addMissionEventHandler ["EachFrame",{
  disableSerialization;
  if !( visibleMap || visibleWatch ) exitWith {
    _display = uiNamespace getvariable 'marcador_RAB';
    if !(isnil {_display}) then {_display closeDisplay 0};
  };
  cutRsc ["marcador_RAB","PLAIN"];
  _display = uiNamespace getVariable "marcador_RAB";
  _marcador = (allControls _display) select 0;

  _duracionTotalEvento = ((["Duracion",10] call BIS_fnc_getParamValue) * 60);
  _timer = [((_duracionTotalEvento - time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring;

  _banderaOpfor  = parseText "<img size='2' color='#FF1919' image='\A3\ui_f\data\map\markers\nato\b_unknown.paa'/>";
  _banderaBLufor = parseText "<img size='2' color='#1A1AFF' image='\A3\ui_f\data\map\markers\nato\b_unknown.paa'/>";

  _diffB = format [" (%1)", Marcador getOrDefault ["diffBlufor",0]];
  _diffO = format [" (%1)", Marcador getOrDefault ["diffOpfor",0]];

  _SucturedText = composeText [_timer,lineBreak,_banderaOpfor,"    ", str (marcador get opfor),_diffO,"   |   ",str (marcador get blufor),_diffB,"    ", _banderaBLufor ];
  _Marcador ctrlSetStructuredText _SucturedText;

  _ancho = ctrlTextWidth _Marcador;
  
  /*
  (allControls _display) params [
    "_Fondo",
    "_slideBlufor",
    "_slideOpfor",
    "_TiempoRestante",
    "_Marcador"
  ];
  //actualizar TiempoRestante
  _duracionTotalEvento = ((["Duracion",10] call BIS_fnc_getParamValue) * 60);
  _timer = [((_duracionTotalEvento - time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring;
  _TiempoRestante ctrlSetText _timer;

  //marcador
  _diffB = Marcador get "diffBlufor";
  _diffO = Marcador get "diffOpfor";

  //(format ["%1 | %2",marcador get opfor, marcador get blufor]);
  //"\A3\ui_f\data\map\markers\nato\b_unknown.paa" //blufor ""
  //"\A3\ui_f\data\map\markers\nato\o_unknown.paa" //opfor

  _banderaOpfor  = parseText "<img size='1.2' color='#FF1919' image='\A3\ui_f\data\map\markers\nato\b_unknown.paa'/>";
  _banderaBLufor = parseText "<img size='1.2' color='#1A1AFF' image='\A3\ui_f\data\map\markers\nato\b_unknown.paa'/>";
  _SucturedText  = composeText [_banderaOpfor, _banderaBlufor,lineBreak, str (marcador get opfor) ,"   |   ",str (marcador get blufor)];
  _Marcador ctrlSetStructuredText _SucturedText;

  //sliders
  _diffB = Marcador get "diffBlufor";
  _diffO = Marcador get "diffOpfor";
  _slideBlufor progressSetPosition _diffB;
  _slideOpfor progressSetPosition _diffO;
  */
}];
