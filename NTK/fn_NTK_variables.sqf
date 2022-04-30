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
  // CHAD
  [
    // TRANSPORTE
    ["UK3CB_TKA_B_UH1H"                , [ 80   , true ] ],
    ["UK3CB_ADM_B_V3S_Closed"   		   , [ 20   ,true  ] ],
    ["UK3CB_ADM_B_Hilux_Closed"      	 , [ 10   ,true  ] ],
    ["UK3CB_ADM_B_Hilux_Open"     	 	 , [ 10   ,true  ] ],
    // ARMED-APC-IFV
    ["UK3CB_ADM_B_Hilux_Spg9"       	 , [ 40   ,true  ] ],
    ["UK3CB_ADM_B_Hilux_Zu23"    	 	   , [ 80   ,true  ] ],
    ["UK3CB_ADM_B_Hilux_Dshkm"     		 , [ 25   ,true  ] ],
    ["UK3CB_ADM_B_Hilux_Rocket"     	 , [ 100  ,false ] ],
    ["UK3CB_ADM_B_Hilux_Rocket_Arty"   , [ 150  ,false ] ],
    // TANK
    ["UK3CB_ADM_B_T55"      		       , [ 275  ,false ] ],
    // STATIC
    ["UK3CB_ADM_B_D30"     			       , [ 100  ,true ] ],
    ["UK3CB_ADM_B_SPG9"     		       , [ 20   ,true ] ],
    ["UK3CB_ADM_B_2b14_82mm"     		   , [ 50   ,true ] ],
    ["rhs_Kornet_9M133_2_msv"     		 , [ 40   ,true ] ]
  ];
  /*
  // SUPPORT
  ["UK3CB_ADM_B_V3S_Repair"     		  , [ 10  ,false ] ],
  ["UK3CB_ADM_B_V3S_Refuel"      		  , [ 10  ,false ] ],
  ["UK3CB_ADM_B_V3S_Reammo"    		    , [ 10  ,false ] ],
  */

/*------------------------------------------------------------------------------
//VEHICULOS OPFOR
------------------------------------------------------------------------------*/

private _opfor =  createHashMapFromArray
  [
    // TRANSPORTE
    ["UK3CB_ARD_I_UAZ_Closed"  		, [10,true ] ],
    ["rhs_gaz66_msv"  		 	      , [20,true ] ],
    ["UK3CB_CW_SOV_O_LATE_Mi8AMT" , [60,true ] ],
    // ARMED-APC-IFV
    ["rhs_bmp1p_msv"           	  , [80,true]],
    ["rhs_btr70_msv"         		  , [40,true ]],
    ["UK3CB_O_G_MTLB_Zu23"     	  , [100,true ]],
    // TANK
    ["rhs_t72ba_tv"    	 	   	    , [ 325,false ] ],
    ["rhs_t72bb_tv"      			    , [ 400,false ] ],
    ["rhsgref_BRDM2_ATGM_msv"     , [ 250,false ] ],
    ["rhs_2s3_tv"    	  	 	      , [ 300,false ] ],
    // STATIC
    ["rhs_D30_msv"     			      , [ 100,true ] ],
    ["rhs_2b14_82mm_msv"      		, [ 50,true ] ],
    ["rhs_Kornet_9M133_2_msv"   	, [ 40,true ] ],
    ["UK3CB_ADM_B_SPG9"     		  , [ 20,true ] ]
  ];
  // SUPPORT
  /*
  ["rhs_gaz66_ammo_msv"     		  , [ 10  ,false ] ],
  ["UK3CB_ARD_I_Ural_Fuel"      		  , [ 10  ,false ] ],
  ["rhs_gaz66_repair_msv"    		  , [ 10  ,false ] ],
  */

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
