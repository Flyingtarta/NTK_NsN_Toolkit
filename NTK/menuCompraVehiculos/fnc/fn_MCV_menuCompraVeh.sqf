params ["_handler","_params"];

#define background (findDisplay 1314 displayCtrl 1000)
#define listaVeh   (findDisplay 1314 displayCtrl 1500)
#define fondosDisp (findDisplay 1314 displayCtrl 1001)


if (_handler isequalto "lista_onLoad") then {
  {
    _vehicles = (aviableVehicles get (side player));
    _value = (_vehicles get _x) select 0;
    _infCanUSe = (_vehicles get _x) select 1;
    _vehicleName = gettext (configFile >> "CfgVehicles" >> _x >> "displayName");
    _picture = gettext (configFile >> "CfgVehicles" >> _x >> "picture" );
    _pictureRight = gettext (configFile >> "CfgVehicles" >> _x >> "editorPreview");
    (_params#0) lbadd _vehicleName;
    (_params#0) lbSetText [_forEachIndex, _vehicleName];
    (_params#0) lbSetTextRight [_forEachIndex, str _value];
    if !(_infCanUSe) then {
        (_params#0) lbSetTooltip [_forEachIndex,"NO PUEDE SER USADO POR INFANTERIA \n SOLO ESPECIALISTAS"];
    };
    (_params#0) lbSetPicture [_forEachIndex, _picture];
    (_params#0) lbsetPictureColor [_forEachIndex,[1,1,1,1]];
  }foreach ((aviableVehicles get (side player)));

};

if (_handler isequalto "init") then {
  if (localNamespace setvariable ["onEachFrame_MCV",false]) exitwith {};
  addMissionEventHandler ["EachFrame",{    
    _fondos =  format['Fondos: %1',missionnamespace getvariable ["fondos_"+str(side player),0] ];
    (finddisplay 1314 displayctrl 1001) ctrlSetText _fondos;
    localNamespace setvariable ["onEachFrame_MCV",true];
    if (isnull findDisplay 1314) exitwith { localNamespace setvariable ["NSN_VAR_VEHSELECT",objnull] };


    _mousePos = agltoasl (screenToWorld (getMousePosition));

    _control = (findDisplay 1314 displayCtrl 1500);
    _shop = compraVehiculos get (side player);
    _selected = lbCurSel _control;
    if (_selected isequalto -1 )  exitWith {};
    _controlInfoText = (finddisplay 1314 displayctrl 100000);
    _controlInfoText ctrlSetText "Click derecho para poner el vehiculo 								Shift+Click Borrar vehiculo";
    _controlInfoText ctrlSetTextColor [1,1,1,1];

    _vehicles = (aviableVehicles get (side player));
    _vehicle = (keys _vehicles) select _selected;


    _currentVehicle = localNamespace getvariable ["NSN_VAR_VEHSELECT",objNull];
    _canSpawn = [_shop] call NSN_fnc_MCV_canSpawn;
    if !(_canSpawn) exitWith {deleteVehicle _currentVehicle; localNamespace setvariable ["NSN_VAR_VEHSELECT",objNull]};

    if (isnull _currentVehicle && _canSpawn) exitwith {
      _veh = createSimpleObject [_vehicle,_mousePos, true];
      localNamespace setvariable ["NSN_VAR_VEHSELECT",_veh];
      _veh setdir (getdir _shop);
    };

    if ((typeof _currentVehicle) isNotEqualTo _vehicle) then {
      deleteVehicle _currentVehicle;
      _veh = createSimpleObject [_vehicle,_mousePos, true];
      _veh setdir (getdir _shop);
      localNamespace setvariable ["NSN_VAR_VEHSELECT",_veh];
    }else{
      //_veh = localNamespace getvariable "NSN_VAR_VEHSELECT";
      {deleteVehicle _X} forEach (_mousePos nearEntities ["Animal",20]);
      _veh setdir (getdir _shop);
      _currentVehicle setposasl (_mousePos vectoradd [0,0,1.5]);
    };
  }];
};//init
//PARACHUTE_TARGET
//////////////////////// menuCompraVeh_onClick /////////////////////////////////
if (_handler isequalto "menuCompraVeh_onClick") then {
  _params params ["_control", "_button", "_xPos", "_yPos", "_shift", "_ctrl", "_alt"];
  /*
  Pone o borra el vehiculo dependeiendo si
  */
  if (_shift ) then {
    /*
      Si tiene shift apretado y click deerecho borra el vehiculo que se puso
    */
    if (_button isequalto 1) then {
      _mousepos =  (screenToWorld (getMousePosition));
      _entitiesFound = _mousePos nearEntities ["Allvehicles",15];
      _vehicles = (aviableVehicles get (side player));
      if (_entitiesFound isNotEqualTo [] ) then {
        _veh = localNamespace getvariable ["NSN_VAR_VEHSELECT",objNull];
        {
          if (_x isNotEqualTo _veh) then {
            _classname2Delete = typeof _x;
            if (_classname2Delete in (keys _vehicles) ) then{
              _value = (_vehicles get _classname2Delete) select 0;
              deleteVehicle _x;
              _controlInfoText = (finddisplay 1314 displayctrl 100000);
              _controlInfoText ctrlSetText "Se elimino el vehiculo";
              _controlInfoText ctrlSetTextColor [0.8,0,0,1];
              //agregamos de nuevo los fondos

              _fondos = missionnamespace getvariable ["fondos_"+str(side player),0];
              missionNamespace setvariable ["fondos_"+str(side player),_fondos + _value,true];
              _newText =  format['Fondos: %1',missionnamespace getvariable ["fondos_"+str(side player),0] ];
              (finddisplay 1314 displayctrl 1001) ctrlSetText _newText;
            };//
          };
        }foreach _entitiesFound;
      };
    };
  } else{
    if (isnull (localNamespace getvariable ["NSN_VAR_VEHSELECT",objNull]) ) exitwith {};
    //si no tiene el shift apretado lo pone
    if (_button isequalto 1) then {  //rightclick
      //verifica que tenga fondos suficientes
      _mousePos = agltoasl (screenToWorld (getMousePosition));
      _entitiesFound = _mousePos nearEntities ["Allvehicles",10];
      _entitiesFound select {!(_x isKindOf "Animal")};
      if (_entitiesFound isnotequalto [] ) exitwith {};

      _shop = compraVehiculos get (side player);
      _veh = localNamespace getvariable ["NSN_VAR_VEHSELECT",objNull];
      _classname = typeof _veh;
      _vehicles = (aviableVehicles get (side player));
      _value = (_vehicles get _classname) select 0;
      _infCanUSe = (_vehicles get _classname) select 1;
      //_fondos = missionnamespace getvariable ['NSN_VAR_FOUNDS',0];
      _fondos = missionnamespace getvariable ["fondos_"+str(side player),0];



      if ( _value > _fondos) exitwith {hint "No te quedan mas fondos"};
      deletevehicle _veh;
      localNamespace setvariable ["NSN_VAR_VEHSELECT",objNull];


      [_classname,screenToWorld (getMousePosition),_infCanUSe] spawn NSN_fnc_MCV_spawnVehicle;

      missionNamespace setvariable ["fondos_"+str(side player),_fondos - _value,true];
      _newText =  format['Fondos: %1',missionnamespace getvariable ["fondos_"+str(side player),0] ];
      (finddisplay 1314 displayctrl 1001) ctrlSetText _newText ;
      //Pone en rojo los que no se pueden comprar mas
    };
  };

  //Actualizacion de colores de acuerdo si los puede comprar o no
  //disableSerialization;

  _vehicles = (aviableVehicles get (side player));
  {

    _value = (_vehicles get _x) select 0;
    _fondos = missionnamespace getvariable ["fondos_"+str(side player),0];



    if (_fondos < _value) then {
      (findDisplay 1314 displayctrl 1500) lbSetcolor        [_forEachIndex, [0.4, 0.4, 0.4, 1] ];
      (findDisplay 1314 displayctrl 1500) lbSetcolorright   [_forEachIndex, [0.4, 0.4, 0.4, 1] ];
      (findDisplay 1314 displayctrl 1500) lbsetPictureColor [_forEachIndex, [0.4, 0.4, 0.4, 1] ];
    }else{
      (findDisplay 1314 displayctrl 1500) lbSetColor        [_forEachIndex , [1,1,1,1] ];
      (findDisplay 1314 displayctrl 1500) lbSetcolorright   [_forEachIndex , [1,1,1,1] ];
      (findDisplay 1314 displayctrl 1500) lbsetPictureColor [_forEachIndex , [1,1,1,1] ];
    }
  }foreach _vehicles;
};
