//Variables needed for MenuCompraVehiclos ( vehicle shop)



/*-------------------------------------------
  FONDOS para la compra de vehiculos
-------------------------------------------*/

//missionnamespace setvariable ["NSN_VAR_FOUNDS",1000];

_fondos = ["puntosDeCompra",1000] call BIS_fnc_getParamValue;

missionnamespace setvariable ["fondos_"+str(opfor) ,_fondos];
missionnamespace setvariable ["fondos_"+str(blufor),_fondos];

/*-------------------------------------------
  Variables de objeto de compra de vehiculos
-------------------------------------------*/


/*------------------------------------------------------------------------------
//VEHICULOS BLUFOR
------------------------------------------------------------------------------*/
private _blueVeh = createHashMapFromArray [
// TRANSPORTE
  ["UK3CB_CW_US_B_EARLY_M151_Jeep_Closed"   , [ 5  ,true ] ],
  ["UK3CB_B_M939_Closed_HIDF"       	      , [ 10  ,true ]],

  // ARMED-APC-IFV
  ["UK3CB_B_M151_Jeep_HMG_HIDF" , [ 20  ,true  ] ],
  ["UK3CB_ANA_B_M113_M2"        , [ 30  ,true  ] ],
  ["UK3CB_ARD_B_BRDM2"     		  , [ 40  ,true  ] ],
  ["UK3CB_ANA_B_BMP1"     		  , [ 100 ,false ] ],

  // TANK
  ["UK3CB_ANA_B_T55"      		  , [ 200  ,false ] ],
  ["UK3CB_CW_US_B_EARLY_M60a1"  , [ 250  ,false ] ],
  ["UK3CB_ANA_B_T72A"     		  , [ 300  ,false ] ],
  ["UK3CB_ARD_B_T72BB"     		  , [ 350  ,false ] ],
  // STATIC
  ["UK3CB_ANA_B_SPG9"     		  , [ 30  ,true ] ],
  ["UK3CB_ADM_O_2b14_82mm" 		  , [ 100 ,true ] ],
  ["UK3CB_AAF_B_M2_MiniTripod"  , [ 10  ,true ] ],
  ["UK3CB_AAF_B_M2_TriPod"     	, [ 10  ,true ] ],
  ["rhs_KORD_VDV"     			    , [ 15  ,true ] ],
  ["UK3CB_UN_I_Kornet"          , [ 100 ,true ] ]
];

/*------------------------------------------------------------------------------
//VEHICULOS OPFOR
------------------------------------------------------------------------------*/

private _opfor =  createHashMapFromArray
  [
    // TRANSPORTE
    ["UK3CB_CW_SOV_O_LATE_VDV_UAZ_Closed"   ,[ 5   ,true ] ],
    ["UK3CB_CW_SOV_O_LATE_VDV_Ural"      	  ,[ 10  ,true ] ],
    // ARMED-APC-IFV
    ["UK3CB_CW_SOV_O_LATE_VDV_UAZ_MG"       ,[ 20   ,true ]],
    ["UK3CB_CW_SOV_O_LATE_BTR40_MG"         ,[ 30   ,true ]],
    ["rhs_btr70_vdv"     		 	              ,[ 40   ,true ]],
    ["rhs_bmd1p"     			                  ,[ 100  ,false]],
    // TANK
    ["UK3CB_KDF_B_T80"		                  ,[ 250  ,false]],
    ["rhs_t80bv"     			                  ,[ 300  ,false]],
    ["rhs_t80u"    				                  ,[ 350  ,false]],
    // STATIC
    ["UK3CB_ANA_B_SPG9"                  	  ,[ 30  ,true ] ],
    ["UK3CB_ADM_O_2b14_82mm"     		        ,[ 100  ,true] ],
    ["rhs_KORD_high_VDV"     		            ,[ 10  ,true ] ],
    ["rhs_KORD_VDV"     			              ,[ 10  ,true ] ],
    ["UK3CB_UN_I_Kornet"          , [ 100 ,true ] ]
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
