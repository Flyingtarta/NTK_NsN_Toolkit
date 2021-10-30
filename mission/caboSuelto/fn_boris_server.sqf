/*





*/

if !(isserver) exitwith {};

hideObjectGlobal intel_opfor;
hideObjectGlobal intel_blufor;

missionNamespace setvariable ["NSN_VAR_PROGRESO",0,true];
missionnamespace setvariable ["NSN_VAR_RadarOwner",sideUnknown,true];
missionNamespace setvariable ["NSN_VAR_EngineRadarOn",false,true];

waituntil { ( missionnamespace getvariable ["NSN_VAR_RadarOwner",sideUnknown]) isnotequalto sideUnknown }; //esperamos que alguien haya activado


while {missionNamespace getvariable ["NSN_VAR_PROGRESO",0] < 100} do {

  _p = missionNamespace getvariable ["NSN_VAR_PROGRESO",0];
  _output = "Transfiriendo: [";
  for "_i" from 0 to 100 do {
   if (_i <= _p) then {
    _output = _output + "|";
   }else{
     _output = _output + " ";
   };
 };
 _output = _output + format["] %1",_p];
 _output = _output + "%";
 missionNamespace setvariable ["NSN_VAR_BORIS_PROGRESO_TXT",_output,true];
 //sleep (selectrandom [7,9,12])
 sleep 0.1;
 missionNamespace setvariable ["NSN_VAR_PROGRESO",_p +1,true];
};

missionNamespace setvariable ["NSN_VAR_BORIS_PROGRESO_TXT","TRANFERENCIA COMPLETA",true];

private _bandoGanador = missionNamespace getvariable ["NSN_VAR_RadarOwner",sideUnknown];
private _intel_var = sideUnknown;
private _color = "colorBlack";

if (_bandoGanador isequalto east) then {//si es opfor
  _intel_var = intel_opfor;
  _color = "colorRed";
}else{//si es bluefor
  _intel_var = intel_blufor;
  _color = "colorBlue";
};

//des-ocuptamos la intel
_intel_var hideObjectGlobal false;

//creamos el marcador para el bando correspondiente
[
  [_intel_var,_color],
  {
    params ["_intel_var","_color"];
    cutText ["<t color='#7ddc1f' size='2'> Tranferencia finalizada <br/> Intel Marcada en el mapa</t>", "PLAIN DOWN", 1, true, true];
    _intel = createmarkerlocal ["INTEL",getpos _intel_var];
    _intel setMarkerColorlocal _color;
    _intel setMarkerAlphalocal 1;
    _intel setmarkershapelocal "ICON";
    _intel setmarkertypelocal "hd_flag";
  }
] remoteexec ["call",_bandoGanador];

//_timeFinal = time + (60*45); // 45 minutos para encontrar la intel y llevarla a base
_timeFinal = time + 60; // 45 minutos para encontrar la intel y llevarla a base
timefinal = _timeFinal;
publicvariable "timefinal";

_bandoPerdio = allplayers select {alive _x &&((side _x) isnotequalto _bandoGanador)};
["",["<t color='#FF0000' size='2'> Tranferencia finalizada <br/> Tienen 45 minutos para evitar que encuentren la intel</t>", "PLAIN DOWN", 1, true, true]] remoteexec ["cutText",_bandoPerdio];

while {_timeFinal > time} do {
  _bluf = {(side _x) isequalto blufor && alive _x } count playableUnits;
  _opf =  {(side _x) isequalto opfor  && alive _x } count playableUnits;

  if (_bluf isequalto 0) exitwith { //gana opfor
    systemchat str "gana opfor";
    ["win1", true] remoteexec ["BIS_fnc_endMission",opfor];
    ["end1", false] remoteexec ["BIS_fnc_endMission",blufor];
  };

  if (_opf isequalto 0) exitwith { //gana bluefor
    systemchat str "gana bluefor";
    ["win1", true] remoteexec ["BIS_fnc_endMission",blufor];
    ["end1", false] remoteexec ["BIS_fnc_endMission",opfor];
  };
  sleep 1;
};


if !(missionNamespace getvariable ["IntelEntregada",false]) then {//gana bando que no entrega
  _win = allplayers select {side _x isnotequalto _bandoGanador};
  ["end1", true] remoteexec ["BIS_fnc_endMission",_win];
  ["end1", false] remoteexec ["BIS_fnc_endMission",_bandoGanador];
};
