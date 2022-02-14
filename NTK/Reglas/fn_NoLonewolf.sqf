/*
Locality:
  EXECUTE ON PLAYER

Decription:
  Gives you a warning that you are doing lonewolf and show you an icon on the top right, and camera get blurred when aiming down sight.


//wip

*/

//PP effect

_blurred = false;
_pp = 0;
private _base = getpos player;
if (player getvariable ["apoyo",false]) exitwith {"APOYO | Lonewolf desactivado para esta unidad"};
//Checks distance between him and other players arround
_blur = ppEffectCreate ["DynamicBlur",550];
_blur ppEffectEnable false;
_blur ppEffectAdjust [2.5];
_blur ppEffectCommit 5;
missionNamespace setvariable ["NSN_blurEffect",_blur];

While {true} do {
  if (alive player && ((side player) isnotequalto civilian)) then { //!(vehicle player iskindof "air") ) then { //if its alive and not civilean
    _aliados = playableUnits select {(side _x isequalto side player) && (alive _x) && (_x isnotequalto player)}; //filter to all alive allies
    _lonewolf = (_aliados findif { _x distance2d player < 150 }) isequalto -1;
    _inbase = (player distance2d _base) < 300;
    if (_lonewolf && !_inbase) then {
        player setvariable ["NSN_VAR_LONEWOLF",true,true];

        if ( weaponLowered player || !(isnull (objectParent player)) ) then {
            HintSilent "Estas haciendo lonewolf\nReagrupate con tus compañeros o retirate a base";
            _blur ppEffectEnable false;
        }else{
          HintSilent "Estas haciendo lonewolf\nReagrupate con tus compañeros o retirate a base\n\nBaja el arma para que desaparezca el blur";
          _blur ppEffectEnable true;
        };
      }else{
        player setvariable ["NSN_VAR_LONEWOLF",false,true];
        _blur ppEffectEnable false;

      };
  }else{
    _blur ppEffectEnable false;
  };
  sleep 5;
};
