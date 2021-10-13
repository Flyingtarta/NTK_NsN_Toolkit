/*
Locality:
  EXECUTE ON SERVER

Author:
  [calaveras] FlyingTarta

Description:
  Global markers will be deleted unless is the logged admin

Input:
  None

Output:
  None
*/

waituntil {time > 0};

addmissioneventhandler ["MarkerCreated",{
  params ["_marker", "_channelNumber", "_owner", "_local"];
  private _isAdmin = ((getUserInfo (getPlayerID _owner)) select 8) > 0; //the owner is admin?
  if ( (_channelNumber isequalto 0) && !_isAdmin ) then {
    deletemarker _marker;
  };
}];