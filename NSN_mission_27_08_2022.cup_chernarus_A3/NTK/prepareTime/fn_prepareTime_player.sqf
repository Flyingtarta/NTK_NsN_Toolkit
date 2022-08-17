/*
Locality:
  EXECUTE ON PLAYER

Author:
  [calaveras] FlyingTarta

Description:
  Dont allow players to go further than x raduis during preparation time

Input:
  0: Radio que se puede alejar (default 100 metros)
  1: tiempo de preparacion (defalut = 2minutos)

Output:
  None
*/

params [ ["_Radius",500]]; 


waitUntil {missionNamespace getvariable ["NSN_VAR_EndPrepTime",-1] isnotequalto -1};

private _preparetime = ["Preparacion",10] call BIS_fnc_getParamValue;
_end_preparation_time = missionNamespace getvariable ["NSN_VAR_EndPrepTime", ((["Preparacion", 10] call BIS_fnc_getParamValue) * 60) ];

if (servertime > _end_preparation_time) exitwith {systemchat "praration phase already passed"}; 

sleep 1;
//saves start position
private _beginPos = getpos player;
_time = _end_preparation_time;
//if gets in late, shows same time left
if (time > 1) then {
  _time = _end_preparation_time - servertime;
};

//Timer variable
//Creates a marker arround the player so he can see how futher he can go
private _mk =  createMarkerLocal ["Marker1", _beginPos];
_mk setMarkerSizeLocal [_radius, _radius];
_mk setMarkerShapeLocal "ELLIPSE";
_mk setMarkerBrushLocal "Solid";
_mk setMarkerColorLocal "ColorGreen";
_mk setMarkerAlphaLocal 0.5;

//Delete all ammunition fired while in preparation phase

_eh = player addeventhandler ["Fired",{
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
    if !(player getvariable ["NSN_VAR_PrepTime_exept",false]) then {
      deletevehicle _projectile;
    };
  }];

while {servertime < _end_preparation_time } do { // in preparation phase

  //_time = _time - 1;
  _end_preparation_time = missionnamespace getvariable "NSN_VAR_EndPrepTime";
  _time = _end_preparation_time - servertime;
  hintSilent format["Tiempo de preparacion: \n %1", [((_time)/60)+.01,"HH:MM"] call BIS_fnc_timetostring];
  if (player distance2d _beginPos > _radius) then { //if its too far, its teleported
    if !(player getvariable ["NSN_VAR_PrepTime_exept",false]) then {
      player setpos _beginPos;
    };
  };
  sleep 1;
};
deletemarkerlocal _mk;
player removeEventHandler ["Fired",_eh];
Hint "TIEMPO PREPARACION FINALIZADO";
