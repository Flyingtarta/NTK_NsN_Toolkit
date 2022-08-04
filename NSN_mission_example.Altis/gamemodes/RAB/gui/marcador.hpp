
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
			colorBackground[] = {0.08,0.26,0.31,0.7};

			colorFrame[] = {0,0,0,1};
			class Attributes
			{
				align = "center";
			};

		};
	};
};
