/*
	nsn_fnc_lonewolf_init

	Descripcion:
		Funcion que arranca en el postinit, de forma LOCAL al jugador, encargandose de:
		
		si el jugador se aleja mas de x cantidad ( definida en parametros como  "NSN_VAR_LONEWOLF_DISTANCE" ) defualt:150m
		Le blurrea la pantalla al levantar el arma e intentar apuntar.

*/



if !(hasInterface) exitwith {};// only on players 

if !(missionNamespace getvariable ["NSN_VAR_LONEWOLF_ENABLED",true]) exitwith {}; //disable via 


_blurred = false;
private _pp = 0;
private _base = getpos player;
if (player getvariable ["NSN_VAR_APOYO",false]) exitwith {"APOYO | Lonewolf desactivado para esta unidad"};

//Checks distance between him and other players arround
private _blur = ppEffectCreate ["DynamicBlur",550];
_blur ppEffectEnable false;
_blur ppEffectAdjust [2.5];
_blur ppEffectCommit 5;
missionNamespace setvariable ["NSN_blurEffect",_blur];
private _distancia = missionNamespace getvariable ["NSN_VAR_LONEWOLF_DISTANCE",150];
While {true} do {
  if (alive player && ((side player) isnotequalto civilian) && !(vehicle player iskindof "air") ) then { //if its alive and not civilean
    _aliados = playableUnits select {(side _x isequalto side player) && (alive _x) && (_x isnotequalto player)}; //filter to all alive allies
    _lonewolf = (_aliados findif { _x distance2d player < _distancia }) isequalto -1;
    _inbase = (player distance2d _base) < 500;
    if (_lonewolf && !_inbase) then {
        if !(player getvariable ["NSN_VAR_LONEWOLF",false]) then {
          player setvariable ["NSN_VAR_LONEWOLF",true,true];
        };

        if ( weaponLowered player || !isnull (objectParent player) ) then {
            HintSilent "Estas haciendo lonewolf\nReagrupate con tus compañeros o retirate a base";
            _blur ppEffectEnable false;
        }else{
          HintSilent "Estas haciendo lonewolf\nReagrupate con tus compañeros o retirate a base\n\nBaja el arma para que desaparezca el blur";
          _blur ppEffectEnable true;
        };
      }else{
        if (player getvariable ["NSN_VAR_LONEWOLF",false]) then {
          player setvariable ["NSN_VAR_LONEWOLF",false,true];
        };
        _blur ppEffectEnable false;
      };
  }else{
    _blur ppEffectEnable false;
  };
  sleep 5;
};
