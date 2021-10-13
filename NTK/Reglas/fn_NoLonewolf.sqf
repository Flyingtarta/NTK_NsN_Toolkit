/*
Locality:
  EXECUTE ON PLAYER

Decription:
  Gives you a warning that you are doing lonewolf and show you an icon on the top right, and camera get blurred when aiming down sight.


//wip

*/

//Checks distance between him and other players arround
While {true} do {
  if (alive player && ((side player) isnotequalto civilian)) then { //if its alive and not civilean
    _aliados = allplayers select {(side _x isequalto side player) && (alive _x) && (_x isnotequalto player)}; //filter to all alive allies
    _lonewolf = _aliados findif { _x distance2d player < 200 };
    if (_lonewolf isequalto -1) then { //if there is no close allies
      //TODO: check if its on vehicle and have a different aproach
      HintSilent "Estas haciendo lonewolf";
    };
  };
  sleep 1;
};
