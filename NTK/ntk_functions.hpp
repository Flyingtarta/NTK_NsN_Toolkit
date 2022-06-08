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
  class diferenciaBandosEnArea {};
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
  class MCV_init          {};
  class MCV_menuCompraVeh {};
  class MCV_spawnVehicle  {};
};
