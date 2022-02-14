/*

  - Verifica que no se salga del area
  - Agrega effecto si se sale del area
  - UI

*/
systemchat str "RAB | initPlayer...ok!";
/*
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
*/

addMissionEventHandler ["EachFrame",{
  disableSerialization;
  if !( visibleMap || visibleWatch ) exitWith {
    _display = uiNamespace getvariable 'marcador_RAB';
    if !(isnil {_display}) then {_display closeDisplay 0};
  };
  cutRsc ["marcador_RAB","PLAIN"];
  _display = uiNamespace getVariable "marcador_RAB";
  _marcador = (allControls _display) select 0;
  _timer = "";

  _tiempoDePreparacion = (["Preparacion",10] call BIS_fnc_getParamValue) * 60;
  _tiempoDeAltoElFuego = (["AltoElFuego",20] call BIS_fnc_getParamValue) * 60;


  if (time < _tiempoDeAltoElFuego) then {
    if (time < _tiempoDePreparacion) then {
      _timer = [((_tiempoDePreparacion - time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring;
      _timer =parseText format ["<t color='#BFBF00'> Preparacion: %1 <t/>",_timer];
    }else {
      _tiempoDeAltoElFuego = (_tiempoDePreparacion + _tiempoDeAltoElFuego);
      _timer = [((_tiempoDeAltoElFuego - time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring;
      _timer = parseText format ["<t color='#BFBF00'> Alto el fuego: %1 <t/>",_timer];
    };

  }else{
    _duracionTotalEvento = ((["Duracion",10] call BIS_fnc_getParamValue) * 60);
    _timer = [((_duracionTotalEvento - time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring;
  };




  _banderaOpfor  = parseText "<img size='2' color='#FF1919' image='\A3\ui_f\data\map\markers\nato\b_unknown.paa'/>";
  _banderaBLufor = parseText "<img size='2' color='#1A1AFF' image='\A3\ui_f\data\map\markers\nato\b_unknown.paa'/>";

  _diffB = format [" (%1)", Marcador getOrDefault ["diffBlufor",0]];
  _diffO = format [" (%1)", Marcador getOrDefault ["diffOpfor",0]];

  _SucturedText = composeText [_timer,lineBreak,_banderaOpfor,"    ", str (marcador get opfor),_diffO,"   |   ",str (marcador get blufor),_diffB,"    ", _banderaBLufor ];
  _Marcador ctrlSetStructuredText _SucturedText;

  _ancho = ctrlTextWidth _Marcador;
}];
/*
  Verifica que este dentro del area y una distancia maxima de 2 km de un sector aliado ( para evitar partizanos)
*/
private _pos2marker = (zonas apply {getMarkerPos _x})  createHashMapFromArray zonas;
_advertencia = 0;
localnamespace setvariable ["advertencia",0];

_blur = ppEffectCreate ["DynamicBlur",500];
_blur ppEffectEnable false;
_blur ppEffectAdjust [0.5];
_blur ppEffectCommit 0;

while { true } do {

  //if ((array_jugadores select {_x#0 == getPlayerUID player} select 0 select 1) > -1) then {break};

  sleep 1;

  if ( !(alive player) ) exitWith {}; //revisa unicamente si esta vivo

  //Verificamos que este dentro del area
  _advertencia = localnamespace getvariable ["advertencia",0];
  if !(player inarea RabArea) then {
    _advertencia = localnamespace getvariable ["advertencia",0];
    localnamespace setvariable ["advertencia",(_advertencia+1)];
    _blur ppEffectEnable true;
    [] call NSN_fnc_notificacion_fueraDelArea;
  }else{
    _blur ppEffectEnable false;

    _display = uiNamespace getvariable ['rcsNotificacion_idd',displayNull];
    _display closeDisplay 1;
    localnamespace setvariable ["advertencia",0];
    /*
    _zonasAliadas = zonas apply {
      if ( ((missionNamespace getvariable _x) get "bando") isequalto (side player) ) then {
        getMarkerPos _x
      }else{
        nil
      };
    };
    _zonasAliadas = _zonasAliadas select {!isnil {_x}};
    _zonaMasCercana = [_zonasAliadas,player] call bis_fnc_nearestposition;
    _zonaMasCercana = _pos2marker get _zonaMasCercana;
    */
  };

  if ( _advertencia >= 30 ) then {
    localnamespace setvariable ["advertencia",0];
    _ammo = createvehicle ["Sh_82mm_AMOS", (getpos player) vectoradd [0,0,100], [], 10,"FLY"];
    _ammo setVelocity [0,0,-30];
  };
};
