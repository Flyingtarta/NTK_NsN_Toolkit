
class marcador_RAB {
	idd= 13140;
	duration = 1e+6;
	fadeIn = 0;
	fadeOut = 0;
	onload = "uiNamespace setvariable ['marcador_RAB',_this select 0]";
	class controls {
		class Marcador: RscStructuredText
		{
			idc = 1100;
			style = 2;
			x = (0.355625 + 0.075) * safezoneW + safezoneX;
			y = 0.038 * safezoneH + safezoneY;
			//w = 0.299062 * safezoneW;
			w = 0.15 * safezoneW;
			h = 0.066 * safezoneH;
			colorBackground[] = {0,0,0,0.7};
			colorFrame[] = {0,0,0,0};
			class Attributes
			{
				align = "center";
			};

		};
	};
};


/*
class marcador_RAB {
	idd= 13140;
	duration = 1e+6;
	fadeIn = 0;
	fadeOut = 0;
	onload = "uiNamespace setvariable ['marcador_RAB',_this select 0]";
	class ControlsBackground {
		class FONDO: RscText
		{
			idc = 1002;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.038 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.066 * safezoneH;
			colorBackground[] = {0,0,0,0.7};
			colorFrame[] = {0,0,0,0};
		};
	};

	class controls {
		class slideBlufor: RscSlider
		{
			idc = 1201;
			color[] = {1,1,1,0.6};
			colorActive[] = {1,1,1,1};
			colorBar[] = {1,1,1,1};
			progress = 0.5;

			x = 0.530937 * safezoneW + safezoneX;
			y = 0.038 * safezoneH + safezoneY;
			w = 0.175313 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0.1,0.1,0.7,0.7};
			texture = "#(argb,8,8,3)color(1,1,1,1)";
			type = CT_PROGRESS;
			fade = 0;
			access = 0;
			colorFrame[] = {0,0,0,0};

		};
		class slideOpfor: RscSlider
		{
			idc = 1202;
			color[] = {1,1,1,0.6};
			//colorActive[] = {0.7,0.1,0.1,0.7};
			colorBar[] = {0.7,0.1,0.1,0.7};
			progress = 0.5;
			colorBackground[] = {0.7,0.1,0.1,0.7};

			angle = 180;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.038 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.022 * safezoneH;
			texture = "#(argb,8,8,3)color(1,1,1,1)";
			type = CT_PROGRESS;
			colorFrame[] = {0,0,0,1};
			fade = 0;
			access = 0;
		};
		class TiempoRestante: RscText
		{
			idc = 1000;
			style = 2;
			text = "85:45:25"; //--- ToDo: Localize;
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.038 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.022 * safezoneH;
		};

		class Marcador: RscStructuredText
		{
			idc = 1001;
			style = 2;
			text = "5000 | 5000"; //--- ToDo: Localize;
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.06 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.044 * safezoneH;
		};

	};
};
*/
