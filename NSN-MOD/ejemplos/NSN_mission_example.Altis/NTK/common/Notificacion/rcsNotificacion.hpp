
class rcsNotificacion {
	idd = 38919;
	duration = 1e+6;
	fadeIn = 0;
	fadeOut = 0;
	onload = "uiNamespace setvariable ['rcsNotificacion_idd',_this select 0]";
	//onUnload = "uiNamespace setvariable ['rcsNotificacion_idd',displayNull]";
	class ControlsBackground {
		class Background: RscText
		{
			idc = 1000;
			x = 0.381405 * safezoneW + safezoneX;
			y = 0.17 * safezoneH + safezoneY;
			w = 0.2475 * safezoneW;
			h = 0.077 * safezoneH;
			colorText[] = {1,1,1,1};
			//colorBackground[] = {0.85,0.4,0,0.3};
			colorBackground[] = {0.08,0.26,0.31,0.5};

		};
	};

	class controls {
		class notificacionText: RscStructuredText
		{
			idc = 1100;
			style = 2;
			text = "";
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.17 * safezoneH + safezoneY;
			w = 0.154687 * safezoneW;
			h = 0.055 * safezoneH;
			//sizeEx = 1.5 * GUI_GRID_H;
			//colorBackground[] = {0.85,0.4,0,0};


		};
		class img_left: RscPicture
		{
			idc = 1200;
			style = 2096;
			text = "#(argb,8,8,3)color(0,0,0,0.7)";
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.175 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.055 * safezoneH;
			//colorBackground[] = {0.85,0.4,0,0.8};
			colorBackground[] = {0.11,0.52,0.69,0.8};
		};
		class img_right: RscPicture
		{
			idc = 1201;
			style = 2096;
			text = "#(argb,8,8,3)color(0,0,0,0.7)";
			x = 0.587656 * safezoneW + safezoneX;
			y = 0.175 * safezoneH + safezoneY;
			w = 0.0360937 * safezoneW;
			h = 0.055 * safezoneH;
			//colorBackground[] = {0.85,0.4,0,0.8};
			colorBackground[] = {0.11,0.52,0.69,0.8};
		};

		class TopText: RscText
		{
			idc = 1001;
			type = 0;
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.148 * safezoneH + safezoneY;
			w = 0.2475 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {1,1,1,1};
			//colorBackground[] = {0.85,0.4,0,0.8};
			colorBackground[] = {0.11,0.52,0.69,0.8};
		};

	};
};


/* #Zohida
$[
	1.063,
	["pene",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1100,"NotificacionText",[1,"''",["0.427812 * safezoneW + safezoneX","0.17 * safezoneH + safezoneY","0.154687 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.7],[-1,-1,-1,-1],"","-1"],[]],
	[1200,"img_left",[1,"#(argb,8,8,3)color(0,0,0,0.7)",["0.386562 * safezoneW + safezoneX","0.17 * safezoneH + safezoneY","0.0360937 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"img_right",[1,"#(argb,8,8,3)color(0,0,0,0.7)",["0.587656 * safezoneW + safezoneX","0.17 * safezoneH + safezoneY","0.0360937 * safezoneW","0.055 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1000,"Background",[1,"",["0.381405 * safezoneW + safezoneX","0.17 * safezoneH + safezoneY","0.2475 * safezoneW","0.077 * safezoneH"],[1,1,1,0.7],[0,0,0,0.7],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"TopText",[1,"",["0.381406 * safezoneW + safezoneX","0.148 * safezoneH + safezoneY","0.2475 * safezoneW","0.022 * safezoneH"],[1,1,1,0.7],[0,0,0,0.7],[-1,-1,-1,-1],"","-1"],[]]
]
*/
