

class AttackDefendZone {
  file = "gamemodes\ADZone"
  class ADZ_createSimpleZoneFromTrigger {};
};

class nsn_common_gamemodes {
  file = "gamemodes\common";
  class editScoreBoard      {};
};

class nsn_ResistAndBite {
  file = "gamemodes\RAB";
  class RAB_canCaptureZone    {};
  class RAB_drawZones         {};
  class RAB_gameplay          {};
  class RAB_initPlayer        {};
  class RAB_init              {};//{postinit = 1 };
  class RAB_zonesInSiegeCheck {};

};

class nsn_node_control {
  file = "gamemodes\node_control";
  class NC_canCapture           {};
  class NC_ceaseFirePhase       {};
  class NC_gamemode_loop        {};
  class NC_init                 {postinit = 1};
  class NC_initPlayer           {};
  class NC_nodeArea             {}; 
  class NC_nodeDesconectedCheck {};
};

class nsn_sideMissions {
  file = "gamemodes\sideMissions";
  class createSideMission_destroy {};
  class createSideMission_intel   {};
  class sideMissions_init         {};
};
