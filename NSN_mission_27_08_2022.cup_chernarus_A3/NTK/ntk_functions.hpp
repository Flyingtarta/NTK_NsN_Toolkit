class variables {
  file = "NTK";
  class NTK_variables { postinit =1};
};

/*
class NsNReglas {
  file = "NTK\Reglas";
  class limiteDeVidas {};
  class LoadoutCheck  {};
  class NoGlobalMarks {};
  class NoLonewolf    {};
  class NoLootBody    {};
  class NoRadioSteal  {};
  class PrepareTime   {};
  class terrainAndViewDistanceMax {postinit = 1}; 
  class vehiclesAllowed {};
};
*/

class Common {
  file = "NTK\common";
  class diferenciaBandosEnArea    {};
  class notificacion_fueraDelArea {};
};

class KOL {
  file = "NTK\KOL";
  class mortarEasyRepack    {};
  class buyAmmoBox          {};
  class changeRolBox        {};
  class easyRepackPlayers   {};
  class easyRepackTurrets   {};
  class heliEasyRepack      {};
  class ammoBoxEasyMove     {};
  class vehicleRepack       {};
};

class MCV {
  file = "NTK\menuCompraVehiculos\fnc";
  class MCV_canSpawn      {};
  class MCV_init          {postinit =1}
  class MCV_menuCompraVeh {};
  class MCV_spawnVehicle  {};
};

class prepTime {
  file = "NTK\prepareTime";
  class prepareTime_init        {postinit = 1};
  class prepareTime_player      {};
};

class Queue {
  file = "NTK\Queue";
  class queue_init {postinit = 1};
};

class scoreboard {
  file = "NTK\scoreboard\fncs";
  class scoreboard_nodos_initplayer {postinit = 1};

};