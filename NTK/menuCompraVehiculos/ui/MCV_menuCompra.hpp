////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Tarta, v1.063, #Fagaba)
////////////////////////////////////////////////////////
class menuCompraVeh {
	idd = 1314;

	onMouseButtonDown = "['menuCompraVeh_onClick',_this] call NSN_fnc_MCV_menuCompraVeh";
	onUnload = "_veh = localNamespace getvariable ['NSN_VAR_VEHSELECT',objNull];  deletevehicle _veh; localNamespace setvariable ['NSN_VAR_VEHSELECT',objNull];player camCommit 1;switchCamera player";

	class controls {

		class RscText_1000: RscText
		{
			idc = 1000;
			//style = 160;
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.071 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.913 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};

		class listaVeh: RscListbox
		{
			onLoad = "['lista_onLoad',_this] call NSN_fnc_MCV_menuCompraVeh";
			idc = 1500;
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.082 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.891 * safezoneH;
			colorBackground[] = {0,0,0,0};
		};

		class fondosDisp: RscText
		{
			idc = 1001;
			onload = "_this#0 ctrlSetText ( format['Fondos: %1',missionnamespace getvariable ['NSN_VAR_FOUNDS',0]] )";
			text = "Fondos: 0"; //--- ToDo: Localize;
			style = 2;
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.016 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.044 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};

		class Informacion: RscText
		{
			idc = 100000;
			style = 2;
			text = "Click derecho para poner el vehiculo 								Shift+Click Borrar vehiculo";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.918 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.044 * safezoneH;
			colorBackground[] = {0,0,0,0};
			sizeEx = 1.2 * GUI_GRID_H;
		};
	};//ctrls
};//class
