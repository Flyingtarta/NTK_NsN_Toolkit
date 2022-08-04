class CfgFunctions {
    class NsN {
    tag = "nsn";

    class client {
        file = "nsn_rules\fnc\client";
        class client_addons {};
        class client_init {postinit = 1};
        class client_viewDistanceLimit {}; 
    };

    class inventory {
        file = "nsn_rules\fnc\inventory";
        class inventory_init {postinit = 1}; 
        class inventory_noLootBody {};
        class inventory_noRadioSteal {}; 
    };

    class lonewolf {
        file = "nsn_rules\fnc\lonewolf";
        class lonewolf_init{postinit = 1}; 
    };

    class respawn_limit {
        file= "nsn_rules\fnc\respawn_limit";
        class respawn_deltaVida		   {};
		class respawn_init_player 	   {};
		class respawn_init_server 	   {};
		class respawn_init {postinit = 1};
    };

    class slotControl {
        file = "nsn_rules\fnc\slotControl";
        class slotControl_init_server {postinit = 1}; 
    };
    };
};