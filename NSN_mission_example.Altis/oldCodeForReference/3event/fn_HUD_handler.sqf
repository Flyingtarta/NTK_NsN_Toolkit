/*
  Funcion que se encarga de crear el Hud con la info y hacerlo solo visible al ver el reloj o el mapa


*/
/*
{
  missionNamespace setvariable [format ["NSN_VAR_3E_ZONA%1_OWNER",_zona],sideUnknown];
  missionNamespace setvariable [format ["NSN_VAR_3E_ZONA%1_LOCK",_zona] ,false];
  //missionNamespace setvariable [format ["NSN_VAR_3E_ZONA%1_WON",_zona],true];
}foreach [1,2,3];
*/
//call nsn_fnc_sectorInfoHint;

findDisplay 12 displayCtrl 51 ctrlAddEventHandler ["Draw",{
    {

        _imagen ="";
        _zona = _forEachIndex +1;
        _owner  = missionNamespace getvariable [format ["NSN_VAR_3E_ZONA%1_OWNER",_zona],sideUnknown];
        _locked = missionNamespace getvariable [format ["NSN_VAR_3E_ZONA%1_LOCK",_zona],True];
        _won    = missionNamespace getvariable [format ["NSN_VAR_3E_ZONA%1_WON",_zona],False];
        _active = missionnamespace getvariable [format ["NSN_VAR_3E_ZONA%1_ACTIVE",_zona],false];

        if (_active) then {_imagen = "mission\3event\img\Attack.paa"};
        if (_locked) then { _imagen = "mission\3event\img\locked.paa"};
        if (_won) then {_imagen = "mission\3event\img\lockedY.paa"};
        if !(_won || _locked ) then {
            if ( (side player) isequalto _owner ) then {
                _imagen = "mission\3event\img\Defend.paa";
            }else{
                _imagen = "mission\3event\img\Attack.paa";
            };
        };

        _scale = ctrlMapScale (findDisplay 12 displayCtrl 51);
        _alpha = -1+10*_scale;
        (_this#0) drawicon [
            (getMissionPath "") + _imagen,
            [1,1,1,_alpha],
            _x,
            10/_scale,
            10/_scale,
            0
        ];
    }foreach sectores;
}];

while {true} do {
	uisleep 0.1;
  if (visiblemap || visibleWatch) then {
  	1314 cutRsc ["RscTitleDisplayEmpty","PLAIN"];
  	1314 cutRsc ["sectoresStatus","PLAIN"];
  }else{
    1314 cutRsc ["RscTitleDisplayEmpty","PLAIN"];
  };
};
