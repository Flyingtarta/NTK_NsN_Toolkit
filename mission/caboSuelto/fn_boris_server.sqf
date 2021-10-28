/*





*/
missionNamespace setvariable ["NSN_VAR_PROGRESO",0,true];
missionnamespace setvariable ["NSN_VAR_RadarOwner",sideUnknown,true];
missionNamespace setvariable ["NSN_VAR_EngineRadarOn",false,true];

waituntil { ( missionnamespace getvariable ["NSN_VAR_RadarOwner",sideUnknown]) isnotequalto sideUnknown }; //esperamos que alguien haya activado

_output = "Transfiriendo: [";
while {missionNamespace getvariable ["NSN_VAR_PROGRESO",0] < 100} do {

  _p = missionNamespace getvariable ["NSN_VAR_PROGRESO",0];
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
 sleep (selectrandom [7,9,12]);
};



/*



for "_p" from 0 to 100 do {
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
 sleep (selectrandom [1,2,3]);
};
*/
