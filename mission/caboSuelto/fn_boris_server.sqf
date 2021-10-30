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
