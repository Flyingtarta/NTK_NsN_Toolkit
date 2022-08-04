class CfgPatches
{
	class nsn_misc
	{
		name = "nsn_misc";
		author = "FlyingTarta";
		url = "";
		requiredVersion = 1.60;
		requiredAddons[] = { "A3_Functions_F" };
		// List of objects (CfgVehicles classes) contained in the addon. Important also for Zeus content (units and groups) unlocking.
		units[] = {};
		// List of weapons (CfgWeapons classes) contained in the addon.
		weapons[] = {};
	};
};


class CfgMainMenuSpotlight // RscDisplayMain >> Spotlight works but is considered obsolete since SPOTREP #00064
{   
    class JoinServer
	{
		text = "Servidor NSN";
		picture = "nsn_misc\logoNSN.paa";
		action = "connectToServer ['127.0.0.1', 2302, '']";
		actionText = "";
		condition = "true";
	};
    /*
    class AoW_Showcase_AoW : JoinServer {};
    class AoW_Showcase_Future : JoinServer{};
    class ApexProtocol : JoinServer{};
    class Bootcamp : JoinServer{};
    class Contact_Campaign : JoinServer{};
    class EastWind : JoinServer{};
    class OldMan : JoinServer{};
    class Orange_Campaign : JoinServer{}; 
    class Orange_CampaignGerman : JoinServer{};
    class Orange_Showcase_LoW : JoinServer{};
    class SP_FD14 : JoinServer{};
    class Tacops_Campaign_01 : JoinServer{};
    class Tacops_Campaign_02 : JoinServer{};
    class Tacops_Campaign_03 : JoinServer{};
    class Tanks_Campaign_01  : JoinServer{};
    */
};