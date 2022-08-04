/*
Locality:
  EXECUTE ON PLAYER

Description:
  Prevents player to loot enemy dead body

author:
  Tarta
*/

if !(hasInterface) exitwith{};

if !(missionNamespace getvariable ["NSN_VAR_INVENTORY_CHECK",true]) exitwith {};

player addEventHandler ["InventoryOpened", {
	params ["_unit", "_container"];
	if ((_this #1) iskindof "Man" && (_this#1 getvariable ["BandoOriginal",sideUnknown]) isnotequalto (side player) ) then {
		[] spawn {
			waitUntil {!isnull findDisplay 602};
			(finddisplay 602) closedisplay 1;
			cutText ["No Loot", "PLAIN DOWN",0,true,true];
	  };
	};
}];
