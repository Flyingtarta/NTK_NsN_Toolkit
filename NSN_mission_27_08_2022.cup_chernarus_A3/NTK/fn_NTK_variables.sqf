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
  //croacia 
  [
     // TRANSPORTE
    ["CRO_HeliTransport_UH60M_M134_W"   	 , [ 95  ,true ] ], 
    ["CRO_Heli_Mi171Sh_S8"      		 , [ 135  ,true ] ],
    ["CRO_HMMWV_M1151_W"     	 	 , [ 10  ,true ] ],
    ["CRO_Truck_GOMBR_TAM110"     	 	 , [ 15  ,true ] ],
    ["CRO_Truck_FAP2026_W"     	 	 , [ 20  ,true ] ],
    // VEHICULOS ARMADOS
    ["CRO_HMMWV_M1151_M2_W"       		 , [ 45   ,true ] ], //Ligero
    ["CRO_AMV_GMBR_BOVP127"    	 	 , [ 135  ,true ] ], //APC
    ["CRO_IFV_GOMBR_M80A"     		 , [ 140   ,true ] ], //ifv barato
    ["CRO_IFV_GOMBR_M2A2ODS_W2"     	 , [ 280   ,true ] ], //ifv caro
    ["CRO_MBT_GOMBR_M84A4_Snajper"   	 , [ 250 ,true ] ], //tanque barato
    ["rhs_t80ue1"   			 , [ 450 ,true ] ], //tanque caro
    // STATIC
    ["CRO_Turret_M2_W"     			 , [ 13  ,true ] ],
    ["RHS_TOW_TriPod_USMC_WD"     		 , [ 50  ,true ] ],
    ["rhssaf_army_m252"     		 , [ 30  ,true ] ],
    ["rhsgref_cdf_b_ZU23"     		 , [ 110  ,true ] ],
    ["rhs_D30_vmf"     			 , [ 105  ,true ] ],		
    // SUPPORT
    ["CRO_Truck_GMBR_TAM150_Repair"     		  , [ 10  ,false ] ],
    ["CRO_Truck_GMBR_TAM150_Refuel"      		  , [ 10  ,false ] ],
    ["CRO_Truck_TAM150_Ammo_Open"    		  , [ 10  ,false ] ]
  ];

/*------------------------------------------------------------------------------
//VEHICULOS OPFOR
------------------------------------------------------------------------------*/

private _opfor =  createHashMapFromArray [
    ["rhs_ka60_c"       	 		  , [ 85 ,true ] ],
    ["RHS_Mi8MTV3_vdv"       	 	  , [ 135  ,true ] ],
    ["rhs_gaz66_msv"  			  , [ 15  ,true ] ], 
    ["rhssaf_army_ural"  		 	  , [ 20  ,true ] ], 
    ["rhs_tigr_msv"       	 	 	  , [ 25  ,true ] ],
    // VEHICULOS ARMADOS 
    ["rhs_btr80a_msv"           		  , [ 125  ,true] ], //APC
    ["rhsgref_BRDM2_msv"        		  , [ 75  ,true ] ], //Ligero	
    ["rhs_bmp1k_msv"     	 		  , [ 140  ,true ] ], //IFV barato
    ["rhs_bmp2d_msv9"      			  , [ 280  ,true ] ], //IFV caro
    ["rhs_t72bb_tv"     	 		  , [ 250  ,true ] ], //Tanque barato
    ["rhs_t90saa_tv"      			  , [ 450  ,true ] ], //tanque caro
    // STATIC
    ["rhs_KORD_high_MSV"     		  , [ 15  ,true ] ],
    ["rhs_2b14_82mm_msv"      		  , [ 30  ,true ] ],
    ["rhs_Kornet_9M133_2_msv"   	 	  , [ 50  ,true ] ],
    ["rhssaf_army_d30"   	 		  , [ 105  ,true ] ],
    ["RHS_ZU23_VDV"   	 		  , [ 110  ,true ] ],
    // SUPPORT
    ["RHS_Ural_Repair_MSV_01"     		  , [ 10  ,false ] ],
    ["rhssaf_army_ural_fuel"      		  , [ 10  ,false ] ],
    ["RHS_Ural_Ammo_MSV_01"    		  , [ 10  ,false ] ]
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




