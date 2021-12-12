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
//Checks distance between him and other players arround
While {true} do {
  if (alive player && ((side player) isnotequalto civilian)) then { //if its alive and not civilean
    _aliados = playableUnits select {(side _x isequalto side player) && (alive _x) && (_x isnotequalto player)}; //filter to all alive allies
    _lonewolf = (_aliados findif { _x distance2d player < 200 }) isequalto -1;
    _inbase = (player distance2d _base) < 100;
    if (_lonewolf && !_inbase) then {
        HintSilent "Estas haciendo lonewolf\nReagrupate con tus compañeros o retirate a base";
        player setvariable ["NSN_VAR_LONEWOLF",true,true];
        /*
        if (weaponLowered player ) then {
            if (_blurred) then {
              _blurred = false;
              ppEffectDestroy _pp;
            };
          /*}else{
            if !(_blurred) then {
              _pp = ppEffectCreate ["DynamicBlur",420];
              _pp ppEffectCommit 1;
              _pp ppEffectAdjust [1.5];
              _pp ppEffectEnable true;
              _blurred = true;
            };

          };
          HintSilent "Estas haciendo lonewolf";*/
      }else{
        player setvariable ["NSN_VAR_LONEWOLF",false,true];
      }
  };
  sleep 5;
};
