/*
Locality:
  EXECUTE ON PLAYER

Description:
  Prevents player to loot enemy dead body

author:
  Tarta
*/


player addEventHandler ["InventoryOpened", {
	params ["_unit", "_container"];
	if ((_this #1) iskindof "Man" && (!alive (_this #1)) ) then {
		[] spawn {
			waitUntil {!isnull findDisplay 602};
			(finddisplay 602) closedisplay 1;
			cutText ["No Loot", "PLAIN DOWN",0,true,true];
	  };
	};
}];
