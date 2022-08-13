
/*
  Limits viewdistance on foot to 3km and 5km on vehicle
  also it forces to keep the terrain detail at least at very high so cant be exploited

*/

if !(isplayer player) exitwith {};
[] spawn {
  waitUntil {!isnull findDisplay 46}; //waitUntil mission starts
  _viewdistance = viewdistance;
  addmissioneventhandler ["EachFrame",{
    //if on vehicle:
    _vehicle = vehicle player;
    if (_vehicle isequalto player) then {
        if (viewdistance > 3000) then {setviewdistance 3000};
      } else{
        if (viewdistance > 5000) then {setviewdistance 5000};
        //if
    };
    //Terrain Grid
    if (getTerrainGrid > 6.25) then {setterraingrid 6.25};
  },[_viewdistance]];
};
