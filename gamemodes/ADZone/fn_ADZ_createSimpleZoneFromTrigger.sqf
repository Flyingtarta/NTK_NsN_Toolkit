/*
Description:
  Creates a simple capturable zone using a trigger as input
  it gives points when captured

how to use :
  on trigger
    (x) only server
    condition:
      true
    on activation:
      [thistrigger] spawn nsn_fnc_ADZ_createSimpleZoneFromTrigger;
*/


params ["_trigger", ["_owner",sideUnknown] ,["_reward",100], ["_TargetCaptura",10] ];


private _pos = getpos _trigger;

private _area = triggerArea _trigger;
private _name = triggerText _trigger;

_area params ["_ladoa","_ladob","_angle","_isrectangle",""];
//Creates marker
private _zoneMK = createMarker [_name,_pos];
_zoneMK setmarkercolor ("color" + str(_owner));
_zoneMK setmarkerdir _angle;
_zoneMK setmarkerpos _pos;
_zoneMK setMarkerAlpha 1;
if (_isrectangle) then {
  _zoneMK setmarkershape "RECTANGLE"
} else {
  _zonaMK setmarkershape "ELLIPSE";
};
_zoneMK setmarkersize [_ladoa,_ladob];


//ProgressMarker

private _capture_marker = createMarker [_name+"_captureMarker",_pos];
_capture_marker setmarkercolor "ColorCIV";
_capture_marker setmarkerdir _angle;
_capture_marker setmarkerpos _pos;
_capture_marker setMarkerAlpha 1;
if (_isrectangle) then {
  _capture_marker setmarkershape "RECTANGLE"
} else {
  _capture_marker setmarkershape "ELLIPSE";
};
_capture_marker setmarkersize [0,0];
private _capture_progress = 0;
/*
  ------------------------------------------------------------------------------
                Waituntil cease fire ends
  ------------------------------------------------------------------------------
*/
private _tiempoDeAltoElFuego = (["AltoElFuego",20] call BIS_fnc_getParamValue) * 60;
waitUntil {missionnamespace getvariable ["NSN_VAR_endTime",-1] isNotEqualTo -1};
waituntil {sleep 1; ((missionnamespace getvariable ["NSN_VAR_EndPrepTime",-1]) + _tiempoDeAltoElFuego )  < servertime };

waitUntil { //waituntils some player are in the area
  sleep 1;
  ({_x inarea _zoneMK } count playableUnits) > 0
};
_bandoD = sideUnknown;
_capturable = true;


while {_capture_progress < _TargetCaptura} do {
  sleep 1;
  if (({_x inarea _zoneMK } count playableUnits) > 0) then {
    _diff = [_pos,0,_zoneMK] call nsn_fnc_diferenciaBandosEnArea;
    _bandoD = _diff select 1;

    if (_bandoD isNotEqualTo _owner) then {
      _capture_progress = _capture_progress + 1;
    } else {
      if (_capture_progress > 0) then {
        _capture_progress = _capture_progress - 1;
      };
    };

  }else{
    if (_capture_progress > 0) then {
      _capture_progress = _capture_progress - 1;
    };
  };

  //change capture marker size
  if (_capture_progress > 0) then {
    _newAsize = linearconversion [0,_TargetCaptura,_capture_progress,0,_ladoA];
    _newBsize = linearconversion [0,_TargetCaptura,_capture_progress,0,_ladoB];
    _capture_marker setmarkersize [_newAsize,_newBsize];
  };
};
//New owner color
deletemarker _capture_marker;
_zoneMK setmarkercolor ("color" + str(_bandoD));

[ createHashMapFromArray [[_bandoD,_reward]] ] call nsn_fnc_editScoreBoard;


//[2,[ ] ] remoteexec ["cutrsc",allplayers,false];
