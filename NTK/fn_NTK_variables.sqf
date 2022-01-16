
/*-------------------------------------------
  FONDOS para la compra de vehiculos
-------------------------------------------*/

missionnamespace setvariable ["NSN_VAR_FOUNDS",1000];
/*-------------------------------------------
  Variables de objeto de compra de vehiculos
-------------------------------------------*/

//VEHICULOS BLUFOR
_blueVeh = createHashMapFromArray [
  ["B_Plane_CAS_01_dynamicLoadout_F",   50 ],
  ["rhsusf_m1a2sep2d_usarmy"        ,  100 ],
  ["RHS_M2A3_BUSKI"                 ,   50 ],
  ["rhsusf_m113d_usarmy_unarmed"    ,   20 ],
  ["RHS_CH_47F_10_cargo"            ,   40 ],
  ["RHS_UH60M"                      ,   50 ],
  ["RHS_AH1Z"                       ,   80 ],
  ["rhsusf_M1083A1P2_D_fmtv_usarmy" ,  120 ],
  ["rhsusf_M978A4_usarmy_d"         ,  100 ],
  ["rhsusf_M1230a1_usarmy_d"        ,  100 ]
];

//VEHICULOS OPFOR
_opfor =  createHashMap;

//VEHICULOS independent
_indepVeh = createHashMap;

aviableVehicles = createHashMapFromArray [[opfor, _opfor], [blufor, _blueVeh],[independent,_indepVeh]];
/*------------------------------------------------------------------------------
  Variables de objeto de compra de vehiculos
------------------------------------------------------------------------------*/
if (isnil "nsn_compraVehiculos_opfor") then {nsn_compraVehiculos_opfor = objNull};
if (isnil "nsn_compraVehiculos_blufor") then {nsn_compraVehiculos_blufor = objNull};
if (isnil "nsn_compraVehiculos_indep") then {nsn_compraVehiculos_indep = objNull};
compraVehiculos = createHashMapFromArray [
  [opfor       , nsn_compraVehiculos_opfor  ],
  [blufor      , nsn_compraVehiculos_blufor ],
  [independent , nsn_compraVehiculos_indep  ]
];
/*----------------------------------------------------------------------------*/
