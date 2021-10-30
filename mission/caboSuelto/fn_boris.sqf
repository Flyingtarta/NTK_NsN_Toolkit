/*
  Description:
    [LOCAL]


  Por hacer:
    Contador de 15 minutos para que tire la data
    parte final al activarse
    bajar el sonido al motor para que no se escuche de la loma de la mierda

*/

if !(hasInterface) exitwith {};

private _accion = [
  "Intervenir Radar",//0
  "intervenir Radar",//1
  "",//2
  {//3
    params ["_target", "_caller","_arguments"];

    missionNamespace setvariable ["NSN_VAR_RadarOwner",side _CALLER ,true];
    missionNamespace setvariable ["NSN_VAR_PROGRESO",0,true];

    if !(missionnamespace getvariable ["NSN_VAR_EngineRadarOn",false]) then { // prendemos motor
      createSoundSource ["rhs_Sound_radar1", gen, [], 0];
      missionNamespace setvariable ["NSN_VAR_EngineRadarOn",true,true];
    };

    if (side _target isequalto opfor) then {
      rr animate ["radar_rotation",0.85,0.1];

    }else{
      rr animate ["radar_rotation",0.25,0.1];
    };
  },
  {side (_this #1) isnotequalto (missionnamespace getvariable ["NSN_VAR_RadarOwner",sideUnknown]) }//4
] call ace_interact_menu_fnc_createAction;

[
  interv,
  0,
  [],
  _accion
] call ace_interact_menu_fnc_addActionToObject;


addMissionEventHandler ["draw3D",
{
  _sideRadarOwner = missionNamespace getvariable ["NSN_VAR_RadarOwner",sideUnknown];
	if (player distance interv < 2.5 && (_sideRadarOwner  isnotequalto sideUnknown ) ) then {
    _color = [1,1,1,1];
    if ( (side player) isnotequalto _sideRadarOwner ) then {
      _color = [1,0,0,1];
    };
		_k = 1.5/(player distance interv);
		drawIcon3D
		[
		"",
		_color,
		interv,
		1 * _k,
		1 * _k,
		0,
		missionNamespace getVariable ["NSN_VAR_BORIS_PROGRESO_TXT",""],
		1,
		0.04 * _k,
		"RobotoCondensed",
		"center",
		false,
		0.005 * _k,
		-0.035 * _k
		];
  };
}];

//};
