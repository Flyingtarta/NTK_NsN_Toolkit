/*
	Description:
		Framework para menu radial

	input:
		[
			[//Imagenes de cada seleccion
				"",	//0
				"",	//1
				"",	//2
				"",	//3
				"",	//4
				""	//5
			],
				"" //Centro (returnValue -1 )
			,
			[//tooltips
				"",	//0
				"",	//1
				"",	//2
				"",	//3
				"",	//4
				""	//5
			]
		] call NSN_fnc_ui_radialMenu6;

		return:
			Numero de la opcion seleccionada (
			 	-1 si es la del centro
				-100 si se cerro con escape
				)

*/

#define colorBack [0.08,0.26,0.31,0.3]
//#define selectedColor [0.85,0.4,0,0.3]
#define selectedColor [.5,.8,.9,.3]

params ["_images_list",
	["_middleImage" , ""],
 	["_tooltip",	["","","","","","","","",""] ],
  ["_attachtoobject",objNull],
  ["_startOnMousePosition",false]
];

//variable for response
localnamespace setvariable ["NSN_MenuRadial6_selected",-100];

//Creates the display menu
_display = (findDisplay 46) createDisplay "TartaMenu_6";
waituntil {!(isNull _display)};

_images_list pushback _middleImage;

_background = {
  params [ "_display","_idx"];
  _ctrl = _display ctrlcreate ["RscPicture",1315 + _idx];
  _ctrl ctrlSetPosition (ctrlPosition ( _display displayCtrl 1199));
  _ctrl ctrlSetText "rcs\menu_radial\img\back.paa";
  _ctrl ctrlcommit 0;
  _ctrl ctrlSetAngle [60*_idx, .5,.5,false];
  _ctrl ctrlcommit .2;
  _ctrl ctrlSetTextColor colorBack;
};

for "_i" from 0 to 5 do {
  [_display,_i] call _background;
};

_imgs = _display ctrlcreate ["TartaMenu6Options",11314,_display displayCtrl 1199];//,(_display displayCtrl 1199)];

systemchat str (allcontrols _imgs);//systemchat str  ((_display displayCtrl 1199) controlsGroupCtrl 1200);
//"TartaMenu6Options"


{
	_i = _forEachIndex;
	_img = _x;

	_ctrl = _display displayctrl (1200+_i);
	_ctrl ctrlsettext _x;
	_ctrl ctrlSetTextColor [0,0,0,1];
	_ctrl ctrlSetTooltip (_tooltip select _i);
	_ctrl ctrlcommit 0.2;
}foreach _images_list;


(finddisplay 13140) displayAddEventHandler ["MouseMoving" , {
  if not (localNamespace getvariable ["OE_menuRadial",false]) then { localNamespace setvariable ["OE_menuRadial",true];};
  disableSerialization;
  if (isnull (findDisplay 13140)) exitwith {};
  _deg = [] call nsn_fnc_ui_MouseRelativeAngle;
  _selected = floor(_deg/60);
  if (_deg isequalto -1 ) then {

    for "_i" from 0 to 5 do {
      _ctrl = (findDisplay 13140) displayctrl (1315 + _i);
      _ctrl ctrlSetTextColor colorBack;
    };
    _ctrl = findDisplay 13140 displayctrl 1199;
    _ctrl ctrlSetTextColor selectedColor;
  } else{
    _ctrl = findDisplay 13140 displayctrl 1199;
    _ctrl ctrlSetTextColor colorBack;
  };
  if (_deg isNotEqualTo -1) then {
    {
      _ctrl = findDisplay 13140 displayctrl 1199;
      _ctrl ctrlSetTextColor colorBack;
      _ctrl = (findDisplay 13140) displayctrl (_forEachIndex+1315);
      if (_forEachIndex isequalto _selected) then {
       _ctrl ctrlSetTextColor selectedColor;
      }else{
        _ctrl ctrlSetTextColor colorBack;
      };
    }foreach allControls (findDisplay 13140);
  };
}];


(finddisplay 13140) displayaddeventhandler ["MouseButtonDown",{
	params ["_displayOrControl", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
	_deg = [] call nsn_fnc_ui_MouseRelativeAngle;
	_selected = floor(_deg/60);
	_displayOrControl closeDisplay 1;
	localnamespace setvariable ["NSN_MenuRadial6_selected", _selected];
}];

waituntil {localnamespace getvariable ["NSN_MenuRadial6_selected",-100] > -100 || isnull(findDisplay 13140) };
_response = (localnamespace getvariable ["NSN_MenuRadial6_selected",-100]); //return the value selected
localnamespace setvariable ["NSN_MenuRadial6_selected",-100]; //resets the value
_response//Response (number)
