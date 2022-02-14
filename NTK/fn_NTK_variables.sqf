
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
// TRANSPORTE
  ["UK3CB_CW_US_B_EARLY_M151_Jeep_Closed"   , [ 5  ,true ] ],
  ["UK3CB_B_M939_Closed_HIDF"       	      , [ 10  ,true ]],

  // ARMED-APC-IFV
  ["UK3CB_B_M151_Jeep_HMG_HIDF" , [ 20  ,true  ] ],
  ["UK3CB_ANA_B_M113_M2"        , [ 30  ,true  ] ],
  ["UK3CB_ARD_B_BRDM2"     		  , [ 40  ,true  ] ],
  ["UK3CB_ANA_B_BMP1"     		  , [ 100 ,true ] ],

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
    ["rhs_bmd1p"     			                  ,[ 100  ,true]],
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
private _caja_opfor = [[[],[]],[["RPG7_F","RPG32_HE_F","rhs_10Rnd_762x54mmR_7N14","rhs_30Rnd_762x39mm_bakelite_tracer","rhs_100Rnd_762x54mmR_green","rhs_VOG25","rhs_VG40OP_white","rhs_GRD40_White","rhs_mag_rdg2_white","rhs_mag_rgo"],[4,4,10,30,10,8,8,8,8,5]],[["ACE_fieldDressing","ACE_elasticBandage","ACE_packingBandage","ACE_quikclot","ACE_epinephrine","ACE_salineIV_500"],[20,20,20,20,10,10]],[[],[]]];
private _caja_blufor = [[[],[]],[["UK3CB_G3_20rnd_762x51_GT","rhsusf_100Rnd_762x51_m62_tracer","RPG7_F","RPG32_HE_F","UGL_FlareWhite_F","rhs_mag_an_m8hc","1Rnd_Smoke_Grenade_shell","rhs_mag_M441_HE","rhs_10Rnd_762x54mmR_7N14","rhs_grenade_m1939l_f_mag"],[40,10,4,4,10,10,10,10,10,4]],[["ACE_fieldDressing","ACE_elasticBandage","ACE_packingBandage","ACE_quikclot","ACE_epinephrine","ACE_salineIV_500"],[20,20,20,20,10,10]],[[],[]]];
missionNamespace setvariable ["caja_opfor",_caja_opfor,true];
missionNamespace setvariable ["caja_blufor",_caja_blufor,true];
