class sectoresStatus {
  idd = 1315;
  duration = 3;
  fadeIn = 0;
	fadeOut = 0;

  controlBackground[]={};
  controls[]=
  {
  	zona1,
  	zona2,
  	zona3,
  	zone1_atackDefend,
  	z2_AtackDefend,
  	z3_attackDefend,
  	timer1,
  	timer2,
  	timer3
  };

  class zona1: RscPicture
  {
  	idc = 1200;
  	text = "mission\3event\img\zone_nocap.paa";
    onload = "[_this,1] call NSN_fnc_UI_zonaMarkerColor";
    x = 0.0875;
  	y = -0.38;
  	w = 0.3;
  	h = 0.18;
  };
  class zona2: RscPicture
  {
  	idc = 1201;
  	text = "mission\3event\img\zone_nocap.paa";
    onload = "[_this,2] call NSN_fnc_UI_zonaMarkerColor";
    x = 0.35;
  	y = -0.38;
  	w = 0.3;
  	h = 0.18;
  };
  class zona3: RscPicture
  {
  	idc = 1202;
  	text = "mission\3event\img\zone_nocap.paa";
    onload = "[_this,3] call NSN_fnc_UI_zonaMarkerColor";
    x = 0.6125;
  	y = -0.38;
  	w = 0.3;
  	h = 0.18;
  };
  class zone1_atackDefend: RscPicture
  {
  	idc = 1203;
  	text = "";
    onload = "[_this,1] call NSN_fnc_UI_iconAD";
    x = 0.2125;
  	y = -0.34;
  	w = 0.075;
  	h = 0.1;
  };
  class z2_AtackDefend: RscPicture
  {
  	idc = 1204;
  	text = "";
    onload = "[_this,2] call NSN_fnc_UI_iconAD";
    x = 0.4625;
  	y = -0.34;
  	w = 0.075;
  	h = 0.1;
  };
  class z3_attackDefend: RscPicture
  {
  	idc = 1205;
  	text = "";
    onload = "[_this,3] call NSN_fnc_UI_iconAD";
    x = 0.725;
  	y = -0.34;
  	w = 0.075;
  	h = 0.1;
  };
  class timer1: RscText
  {
  	idc = 1000;
    shadow =2;
  	text = "0"; //--- ToDo: Localize;
    onload = "[_this,1] call NSN_fnc_UI_timers";
    x = 0.2125;
  	y = -0.26;
  	w = 0.075;
  	h = 0.1;
  };
  class timer2: RscText
  {
  	idc = 1001;
    shadow =2;
  	text = "0"; //--- ToDo: Localize;
    onload = "[_this,2] call NSN_fnc_UI_timers";
    x = 0.4625;
  	y = -0.26;
  	w = 0.075;
  	h = 0.1;
  };
  class timer3: RscText
  {
  	idc = 1002;
    shadow =2;
  	text = "0"; //--- ToDo: Localize;
    onload = "[_this,3] call NSN_fnc_UI_timers";
    x = 0.725;
  	y = -0.26;
  	w = 0.075;
  	h = 0.1;
  };
};
