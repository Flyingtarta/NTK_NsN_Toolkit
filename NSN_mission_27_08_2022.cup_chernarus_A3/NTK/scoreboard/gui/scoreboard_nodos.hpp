/* #Fidocu
$[
	1.063,
	["marcador_nodos",[[0,0,1,1],0.025,0.04,"GUI_GRID"],0,0,0],
	[1000,"fondo",[1,"",["0.422656 * safezoneW + safezoneX","0.06 * safezoneH + safezoneY","0.139219 * safezoneW","0.088 * safezoneH"],[-1,-1,-1,-1],[0,0,0,0.5],[-1,-1,-1,-1],"","-1"],[]],
	[1200,"b_opfor",[1,"#(argb,8,8,3)color(0.5,0,0,0.8)",["0.525781 * safezoneW + safezoneX","0.071 * safezoneH + safezoneY","0.0309375 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1201,"b_blufor",[1,"#(argb,8,8,3)color(0,0.3,0.6,0.8)",["0.427812 * safezoneW + safezoneX","0.071 * safezoneH + safezoneY","0.0309375 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1001,"puntos_o",[1,"0000",["0.494844 * safezoneW + safezoneX","0.071 * safezoneH + safezoneY","0.0257812 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1002,"puntos_b",[1,"0000",["0.463906 * safezoneW + safezoneX","0.071 * safezoneH + safezoneY","0.0257812 * safezoneW","0.033 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]],
	[1003,"texto_info",[1,"tiempo preparacion: 00:00",["0.427812 * safezoneW + safezoneX","0.115 * safezoneH + safezoneY","0.128906 * safezoneW","0.022 * safezoneH"],[-1,-1,-1,-1],[-1,-1,-1,-1],[-1,-1,-1,-1],"","-1"],[]]
]
*/

class nsn_marcador_nodos { 
	idd= 13140;
	duration = 1e+6;
	fadeIn = 0;
	fadeOut = 0;
	onload = "uiNamespace setvariable ['nsn_ui_marcador_nodos',_this select 0]";
	
	
	class controls {
		class fondo: RscText
		{
			idc = 1000;
			x = 0.422656 * safezoneW + safezoneX;
			y = 0.06 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.088 * safezoneH;
			colorBackground[] = {0.08,0.26,0.31,0.8};
		};
		class b_opfor: RscPicture
		{
			idc = 1200;
			text = "#(argb,8,8,3)color(0.5,0,0,0.8)";
			x = 0.525781 * safezoneW + safezoneX;
			y = 0.071 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class b_blufor: RscPicture
		{
			idc = 1201;
			text = "#(argb,8,8,3)color(0,0.3,0.6,0.8)";
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.071 * safezoneH + safezoneY;
			w = 0.0309375 * safezoneW;
			h = 0.033 * safezoneH;
		};
		class puntos_o: RscText
		{
			idc = 1001;
			text = "-"; //--- ToDo: Localize;
			x = 0.494844 * safezoneW + safezoneX;
			y = 0.071 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.033 * safezoneH;
			style  = ST_CENTER;
		};
		class puntos_b: RscText
		{
			idc = 1002;
			text = "-"; //--- ToDo: Localize;
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.071 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.033 * safezoneH;
			style  = ST_CENTER;
		};
		class texto_info: RscText
		{
			idc = 1003;
			sizeEx = 0.035;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.115 * safezoneH + safezoneY;
			w = 0.128906 * safezoneW;
			h = 0.022 * safezoneH;
			style  = ST_CENTER;
			
		};
	};
};





