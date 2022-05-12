

class AttackDefendZone {
  file = "gamemodes\ADZone"
  class ADZ_createSimpleZoneFromTrigger {};
};

class nsn_common_gamemodes {
  file = "gamemodes\common";
  class editScoreBoard      {};
};

class NsN_ResistAndBite {
  file = "gamemodes\RAB";
  class RAB_init           {postinit = 1}; // <------- {posinit = 1} if want to use it
  class RAB_canCaptureZone {};
  class RAB_drawZones      {};
  class RAB_gameplay       {};
  class RAB_initPlayer     {};
  class RAB_subZone        {};
};

class nsn_sideMissions {
  file = "gamemodes\sideMissions";
  class createSideMission_destroy {};
  class createSideMission_intel {};
  class sideMissions_init {postinit = 1};
};
