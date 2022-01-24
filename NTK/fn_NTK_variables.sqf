
/*-------------------------------------------
  FONDOS para la compra de vehiculos
-------------------------------------------*/

missionnamespace setvariable ["NSN_VAR_FOUNDS",1000];
/*-------------------------------------------
  Variables de objeto de compra de vehiculos
-------------------------------------------*/


/*------------------------------------------------------------------------------
//VEHICULOS BLUFOR
------------------------------------------------------------------------------*/
private _blueVeh = createHashMapFromArray [
  ["UK3CB_ANA_B_M240_Low"        , 5   ],
  ["UK3CB_ANA_B_M113_M240"       , 5   ],
  ["UK3CB_ANA_B_KORD"            , 5   ],
  ["UK3CB_ANA_B_SPG9"            , 20  ],
  ["UK3CB_ANA_B_Kornet"          , 50  ],
  ["UK3CB_ANA_B_2b14_82mm"       , 100 ],
  ["UK3CB_ANA_B_M113_unarmed"    , 10  ],
  ["UK3CB_ANA_B_Ural_Open"       , 10  ],
  ["UK3CB_ANA_B_NSV"             , 20  ],
  ["UK3CB_ANA_B_M113_M2"         , 30  ],
  ["UK3CB_ANA_B_Hilux_Spg9"      , 75  ],
  ["UK3CB_ANA_B_BMP2"            , 150 ],
  ["UK3CB_ANA_B_T55"             , 150 ],
  ["UK3CB_ANA_B_T72B"            , 200 ],
  ["UK3CB_ANA_B_T72BM"           , 250 ]
];

/*------------------------------------------------------------------------------
//VEHICULOS OPFOR
------------------------------------------------------------------------------*/

private _opfor =  createHashMapFromArray
  [
    ["UK3CB_CW_SOV_O_LATE_BTR70" ,                    40  ],
    ["UK3CB_CW_SOV_O_LATE_BTR40_MG" ,                 50  ],
    ["UK3CB_CW_SOV_O_Late_VDV_SPG9" ,                 20  ],
    ["UK3CB_CW_SOV_O_Late_VDV_DSHKM" ,                5   ],
    ["UK3CB_CW_SOV_O_Late_VDV_DSHkM_Mini_TriPod",     5   ],
    ["UK3CB_CW_SOV_O_Late_VDV_NSV" ,                  1000],
    ["UK3CB_CW_SOV_O_Late_2b14_82mm" ,                100 ],
    ["UK3CB_CW_SOV_O_LATE_UAZ_SPG9" ,                 75  ],
    ["UK3CB_CW_SOV_O_LATE_BMP2" ,                     150 ],
    ["UK3CB_CW_SOV_O_LATE_BRM1K" ,                    100 ],
    ["UK3CB_CW_SOV_O_LATE_T80U" ,                     300 ],
    ["UK3CB_CW_SOV_O_LATE_T80BVK" ,                   250 ],
    ["UK3CB_CW_SOV_O_LATE_T80B" ,                     200 ],
    ["UK3CB_CW_SOV_O_LATE_Gaz66_Covered" ,            10  ]
  ];

/*------------------------------------------------------------------------------
//VEHICULOS independent
------------------------------------------------------------------------------*/
private _indepVeh = createHashMapFromArray [];

aviableVehicles = createHashMapFromArray [[opfor, _opfor], [blufor, _blueVeh],[independent,_indepVeh]];
/*------------------------------------------------------------------------------
  Variables de objeto de compra de vehiculos
------------------------------------------------------------------------------*/
if ( isnil "nsn_compraVehiculos_opfor" ) then {nsn_compraVehiculos_opfor  = objNull };
if ( isnil "nsn_compraVehiculos_blufor") then {nsn_compraVehiculos_blufor = objNull };
if ( isnil "nsn_compraVehiculos_indep" ) then {nsn_compraVehiculos_indep  = objNull };
compraVehiculos = createHashMapFromArray [
  [opfor       , nsn_compraVehiculos_opfor  ],
  [blufor      , nsn_compraVehiculos_blufor ],
  [independent , nsn_compraVehiculos_indep  ]
];
/*----------------------------------------------------------------------------*/