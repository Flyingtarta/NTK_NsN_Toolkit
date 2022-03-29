/*

  - Chaks that player inside the gamezone
  - if player goes out, a notification pop-up
  - Scoreboard when map/watch opened

*/
systemchat str "RAB | initPlayer...ok!";
//if (isServer) exitwith {};

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


// Scoreboard
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

  _tiempoDePreparacion = missionNamespace getvariable ["NSN_VAR_EndPrepTime", ((["Preparacion",10] call BIS_fnc_getParamValue) * 60) ];
  _tiempoDeAltoElFuego = _tiempoDePreparacion + (["AltoElFuego",20] call BIS_fnc_getParamValue) * 60;


  if (servertime < _tiempoDeAltoElFuego) then {
    if (servertime < _tiempoDePreparacion) then {
      _timer = [((_tiempoDePreparacion - servertime)/60)+.01,"HH:MM"] call BIS_fnc_timetostring;
      _timer =parseText format ["<t color='#BFBF00'> Preparacion: %1 <t/>",_timer];
    }else {
      _timer = [((_tiempoDeAltoElFuego - serverTime)/60)+.01,"HH:MM"] call BIS_fnc_timetostring;
      _timer = parseText format ["<t color='#BFBF00'> Alto el fuego: %1 <t/>",_timer];
    };

  }else{
    //_duracionTotalEvento = ((["Duracion",10] call BIS_fnc_getParamValue) * 60);
    _duracionTotalEvento = missionnamespace getvariable ["NSN_VAR_endTime",0];
    _timer = [((_duracionTotalEvento - servertime)/60)+.01,"HH:MM"] call BIS_fnc_timetostring;
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
  Veryfies that its inside the game area - Probably ill change it in the future
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
  if ((vehicle player) isKindOf "Air") then {
    _advertencia = localnamespace getvariable ["advertencia",0];
    if !(player inarea "RabArea_air") then {
      localnamespace setvariable ["advertencia",(_advertencia+1)];
      [] call NSN_fnc_notificacion_fueraDelArea;
    }else{
      _display = uiNamespace getvariable ['rcsNotificacion_idd',displayNull];
      _display closeDisplay 1;
      if (_advertencia > 0) then {localnamespace setvariable ["advertencia",(_advertencia-1)]};
    };
    if ( _advertencia >= 30 ) then {
      localnamespace setvariable ["advertencia",0];
    };
  } else {

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

    if ( _advertencia >= 30 ) then { //if its keep outside the area, a mortar fall over its head :3
      localnamespace setvariable ["advertencia",0];
      _ammo = createvehicle ["Sh_82mm_AMOS", (getpos player) vectoradd [0,0,100], [], 10,"FLY"];
      _ammo setVelocity [0,0,-30];
    };
  };
};
