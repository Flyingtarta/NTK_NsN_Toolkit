//Variables needed for MenuCompraVehiclos ( vehicle shop)



/*-------------------------------------------
  FONDOS para la compra de vehiculos
-------------------------------------------*/

//missionnamespace setvariable ["NSN_VAR_FOUNDS",1000];

_fondos = ["puntosDeCompra",1500] call BIS_fnc_getParamValue;
private _fondos_opf = missionnamespace getvariable ["fondos_"+str(opfor),_fondos];
private _fondos_blu = missionnamespace getvariable ["fondos_"+str(blufor),_fondos];
missionnamespace setvariable ["fondos_"+str(opfor),_fondos_opf];
missionnamespace setvariable ["fondos_"+str(blufor) ,_fondos_blu];
/*-------------------------------------------
  Variables de objeto de compra de vehiculos
-------------------------------------------*/


/*------------------------------------------------------------------------------
//VEHICULOS BLUFOR
------------------------------------------------------------------------------*/
private _blueVeh = createHashMapFromArray
  // Tactibanes 
  [
    // TRANSPORTE
    ["UK3CB_ANA_B_B_UH60M"   		 , [ 100   ,true ] ], 
    ["UK3CB_ANA_B_Benches_MH9"      	 , [ 100  ,true ] ],
    ["UK3CB_ANA_B_M1030"     	 	 , [ 20  ,true ] ],
    ["UK3CB_ANA_B_Hilux_Open"     	 	 , [ 10  ,true ] ],
    ["UK3CB_ANA_B_M998_2DR"     	 	 , [ 15  ,true ] ],
    ["UK3CB_ANA_B_M1151"     	 	 , [ 45  ,true ] ],
    ["UK3CB_B_M939_Closed_HIDF"     	 , [ 35  ,true ] ],
    // VEHICULOS LIGEROS ARMADOS
    ["UK3CB_ANA_B_Hilux_M2"       		 , [ 55   ,true ] ],
    ["UK3CB_ANA_B_Hilux_Spg9"    	 	 , [ 95  ,true ] ],
    ["UK3CB_MEI_B_Hilux_BMP"     		 , [ 260   ,true ] ],
    ["UK3CB_ANA_B_M1151_OGPK_M2"     	 , [ 135   ,true ] ],
    ["rhsusf_m1245_m2crows_socom_deploy"     , [ 240 ,true ] ],
    // STATIC
    ["UK3CB_CW_US_B_Early_TOW_TriPod"     	 , [ 85  ,true ] ],
    ["UK3CB_ADM_B_SPG9"     		 , [ 50  ,true ] ],
    ["UK3CB_ADM_B_2b14_82mm"     		 , [ 50  ,true ] ],
    ["B_G_HMG_02_high_F"     		 , [ 25  ,true ] ]
    // SUPPORT
    /*["UK3CB_MDF_B_MTVR_Repair"     		  , [ 10  ,false ] ],
    ["UK3CB_MDF_B_MTVR_Reammo"      	  , [ 10  ,false ] ],
    ["UK3CB_MDF_B_MTVR_Refuel"    		  , [ 10  ,false ] ]*/
  ];

/*------------------------------------------------------------------------------
//VEHICULOS OPFOR
------------------------------------------------------------------------------*/

private _opfor =  createHashMapFromArray [
  ["rhs_ka60_grey"       	 		  , [ 100  ,true ] ],
  ["RHS_Mi8mt_vvs"       	 		  , [ 100  ,true ] ],
  ["rhs_uaz_open_vdv"  			  , [ 10  ,true ] ], 
  ["rhs_kamaz5350_msv"  		 	  , [ 20  ,true ] ], 
  ["rhs_tigr_m_3camo_msv"       	 	  , [ 55  ,true ] ],
  ["UK3CB_ARD_B_GAZ_Vodnik"       	  , [ 65  ,true ] ],
  // VEHICULOS ARMADOS  LIGEROS
  ["rhs_btr80a_msv"           		  , [ 240  ,true] ],
  ["UK3CB_ARD_B_GAZ_Vodnik_Cannon"          , [ 215  ,true ] ],
  ["UK3CB_ARD_B_GAZ_Vodnik_PKT"     	  , [ 100  ,true ] ],
  ["UK3CB_CW_SOV_O_LATE_VDV_UAZ_SPG9"       , [ 105  ,true ] ],
  // STATIC
  ["UK3CB_ADP_O_KORD_high"     		  , [ 25  ,true ] ],
  ["rhs_2b14_82mm_msv"      		  , [ 50  ,true ] ],
  ["rhs_Kornet_9M133_2_vmf"   	 	  , [ 85  ,true ] ],
  ["rhs_SPG9M_MSV"   	 		  , [ 50  ,true ] ]
  // SUPPORT
  /*["RHS_Ural_Repair_MSV_01"     		  , [ 10  ,false ] ],
  ["RHS_Ural_Fuel_MSV_01"      		  , [ 10  ,false ] ],
  ["rhs_kamaz5350_ammo_vv"    		  , [ 10  ,false ] ]*/
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




