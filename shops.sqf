////////////////////////////////////
////			         //
//      Copyright © TCG         //
//www.tcgaming.enjin.com       //
////////////////////////////////


if(isServer)then

{

INV_itemstocks = 

[
//fs
[-1,15,15,-1,-1,-1,-1,-1],
[-1,15,15,-1,-1,-1,-1,-1],
[-1,15,15,-1,-1,-1,-1,-1],
[-1,15,15,-1,-1,-1,-1,-1],
-1,
//is
[-1,0,0,0,0,0,0,0,0,0,0,5,10,5],
[-1,0,0,0,0,0,0,0,0,0,0,5,10,5],
[-1,0,0,0,0,0,0,0,0,0,0,5,10,5],
[-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1],
//cf
-1,
//pub
-1,
-1,
-1,
-1,
//gs
[8,-1,8,-1,8,-1,8,-1,8,-1,8,-1,8,-1,8,-1,8,-1,8,-1,8,-1,8,-1],
[-1,4,4,4,4,4,4,4,4,4,4,4,4,4],
[8,-1,8,-1,8,-1,8,-1,8,-1,8,-1,8,-1,8,-1,8,8,-1,8,8,-1,8,-1,8,-1,8,-1,8,-1,8,8,-1,8,-1],
-1,
-1,
//es
-1,
-1,
//gc
-1,
//cu
-1,
-1,
//cs
[-1,-1,3,3,3,3,3,3,3,3,3,3,3],
[-1,3,3,3,3,3,3,3,3,3,3,3,3,3,3],
[-1,3,3,3,3,3,3,3,3,3,3,3,3,3],
[-1,-1,3,3,3,3,3,3,3,3,3,3,3],
//sc
-1,
-1,
-1,
-1,
-1,
-1,
//tt
-1,
//ps
[4,4,4,4,4,4,4,5,5,5,5],
[4,4,4,4,4,4,4,5,5,5,5],
//tx
-1,
//mbs
-1,
-1,
-1,
//ts
-1,
//bss
-1,
//as
-1,
-1,
-1,
-1,
-1,
//sb
-1,
//bs
-1,
-1,
-1,
-1,
-1,
//bt
-1,
//Jewelry shop
-1,
//td
-1,
//ms
[15,15,10],
//rs
-1,
//gds
-1,
-1,
-1,
-1,
//os
-1,
//ws
-1,
//ga
-1,
-1,
-1,
-1,
//ds
-1,
-1,
-1,
-1,
-1,
-1,
//ca, cv, cs, cp, cr, cs
-1,
-1,
-1,
-1,
-1,
-1,
-1,
-1,
-1

];

publicvariable "INV_itemstocks";

};

INV_itemmaxstocks = 

[
//fs
[-1,20,20,-1,-1,-1,-1,-1],
[-1,20,20,-1,-1,-1,-1,-1],
[-1,20,20,-1,-1,-1,-1,-1],
[-1,20,20,-1,-1,-1,-1,-1],
-1,
//is
[800,800,800,800,800,800,800,800,800,800,800,10,20],
[800,800,800,800,800,800,800,800,800,800,800,10,20],
[800,800,800,800,800,800,800,800,800,800,800,10,20],
[800,800,800,800,800,800,800,800,800,800,800,10,20],
//cf
-1,
//pub
-1,
-1,
-1,
-1,
//gs
[10,-1,10,-1,10,-1,10,-1,10,-1,10,-1,10,-1,10,-1,10,-1,10,-1,10,-1,10,-1],
[-1,10,10,10,10,10,10,10,10,10,10,10,10,10],
[8,-1,8,-1,8,-1,8,-1,8,-1,8,-1,8,-1,8,-1,8,8,-1,8,8,-1,8,-1,8,-1,8,-1,8,-1,8,8,-1,8,-1],
-1,
-1,
//es
-1,
-1,
//gc
-1,
//cu
-1,
-1,
//cs
[-1,-1,10,10,10,10,10,10,10,10,10,10,10],
[-1,10,10,10,10,10,10,10,10,10,10,10,10,10,10],
[-1,10,10,10,10,10,10,10,10,10,10,10,10,10],
[-1,-1,10,10,10,10,10,10,10,10,10,10,10],
//sc
-1,
-1,
-1,
-1,
-1,
-1,
//tt
-1,
//ps
[6,6,6,6,6,6,6,10,10,10,10],
[6,6,6,6,6,6,6,10,10,10,10],
//tx
-1,
//mbs
-1,
-1,
-1,
//ts
-1,
//bss
-1,
//as
-1,
-1,
-1,
-1,
-1,
//sb
-1,
//bs
-1,
-1,
-1,
-1,
-1,
//bt
-1,
//Jewelry shop
-1,
//td
-1,
//ms
[30,30,20],
//rs
-1,
//gds
-1,
-1,
-1,
-1,
//os
-1,
//ws
-1,
//ga
-1,
-1,
-1,
-1,
//ds
-1,
-1,
-1,
-1,
-1,
-1,
//ca, cv, cs, cp, cr, cs
-1,
-1,
-1,
-1,
-1,
-1,
-1,
-1,
-1

];

// Shop items

_emptyshop = [];
//Fuel Shop
_fs = ["Fuelline","kanister","reparaturkit","tcgmp","doshd","gdar","bjerk","wulf"];
_fs2 = ["fishingpole","tcgmp","doshd","gdar","bjerk","wulf","Huntingrifle","x_22_LR_17_HMR","MBG_Compound_Bow","MBG_Arrow_N"];
//Item Shop
_is = ["apple","straw","getreide","blowfish","mackerel","herring","perch","trout","walleye","bass","boar","handy","lighter"];
//Copbasefood
_cf = ["wulf","bjerk","tcgmp","doshd"];
//Alcohol shop / Pub
_pub = ["beer","beer2","vodka","smirnoff","wiskey","wine","wine2"];
//Gun Shop
_gs = ["UZI_SD_EP1","Rnd_9x19_UZI_SD","LeeEnfield","x_303","Saiga12K","8Rnd_B_Saiga12_Pellets","FN_FAL","20Rnd_762x51_FNFAL","RH_ar10","RH_20Rnd_762x51_AR10","RH_mac10","RH_9mm_32RND_Mag","RH_pp2000","30Rnd_9x19_MP5","GalilCM","GalilCMRound","GalilCK","GalilCKRound","I44_K98k","I44_5rd_792x57_Tracer_K98","I44_M1Garand","I44_8rd_762x63_Tracer_M1Garand","I44_M1903A3","I44_5rd_762x63_Tracer_M1903"];
_gsa =["20Rnd_762x51_DMR","M14_EP1","RH_m14","RH_m14acog","RH_m14aim","RH_m14eot","RH_sc2","RH_sc2acog","RH_sc2aim","RH_sc2eot","RH_m1s","RH_m1sacog","RH_m1saim","RH_m1seot"];
//Pistol Shop
_gss = ["RH_g19t","RH_17Rnd_9x19_g17","RH_p38","RH_8Rnd_9x19_p38","RH_tt33","RH_8Rnd_762_tt33","RH_browninghp","RH_13Rnd_9x19_bhp","RH_uspm","RH_12Rnd_45cal_usp","RH_usp","RH_15Rnd_9x19_usp","RH_mk2","RH_10Rnd_22LR_mk2","RH_m93r","RH_20Rnd_9x19_M93","RH_m9","RH_m9c","Rnd_9x19_M9","revolver_EP1","revolver_gold_EP1","Rnd_45ACP","RH_anacg","RH_6Rnd_44_Mag","RH_python","RH_6Rnd_357_Mag","RH_deagle","RH_7Rnd_50_AE","RH_g17","RH_19Rnd_9x19_g18","RH_m1911","RH_m1911old","RH_8Rnd_45cal_m1911","RH_bull","RH_6Rnd_44_Mag"];
_ass = ["RH_m9sd","15Rnd_9x19_M9SD","RH_g17sd","RH_17Rnd_9x19_g17SD","RH_m1911sd","RH_8Rnd_45cal_m1911","RH_mk22sd","RH_8Rnd_9x19_Mksd","RH_uzisd","RH_9mm_32RND_SD_Mag"];
_mgs = ["RH_mp5a4","30rnd_9x19_MP5","Binocular","GPS","NVGoggles"];
//Equiptment shop
_es = ["Binocular","GPS","NVGoggles","hideout"];
//gocart
_gc = ["Da_kart"];
//Car Upgrades
_cu = ["nitro","supgrade1","supgrade2","supgrade3"];
//Car Shop
_cs1 = ["Tractor","ALFA_ROMEO_BRERA","Volha_1_TK_CIV_EP1","Lada2_TK_CIV_EP1","S1203_TK_CIV_EP1","Car_hatchback","VWGolf","Car_Sedan","BMW_135I","Skodared","lada1","lada2","CHRYSLER_B_limmo"];
_cs2 = ["Tractor","ALFA_ROMEO_BRERA","Volha_1_TK_CIV_EP1","Lada2_TK_CIV_EP1","S1203_TK_CIV_EP1","Car_hatchback","VWGolf","Car_Sedan","BMW_135I","Skodared","lada1","lada2","CHRYSLER_B_limmo"];
_cs3 = ["Tractor","ALFA_ROMEO_BRERA","Volha_1_TK_CIV_EP1","Lada2_TK_CIV_EP1","S1203_TK_CIV_EP1","Car_hatchback","VWGolf","Car_Sedan","BMW_135I","Skodared","lada1","lada2","CHRYSLER_B_limmo"];
_cs4 = ["Tractor","ALFA_ROMEO_BRERA","Volha_1_TK_CIV_EP1","Lada2_TK_CIV_EP1","S1203_TK_CIV_EP1","Car_hatchback","VWGolf","Car_Sedan","BMW_135I","Skodared","lada1","lada2","CHRYSLER_B_limmo"];
//Sports Car Shop
_sc1 = ["CL_PORSCHE_997","CL_S_COBRA","CL_LAMBORGHINI_GT3","MustangGTRyellow_MLOD","Convertible_MLOD","cl_charger","cl_charger_black","cl_bmwm3b","cl_bmwm3s"];
_sc2 = ["il_charger_blue","il_charger_black","il_charger_red","il_charger_orange","MAZDA_RX_7","MAZDA_RX_71","MAZDA_RX_72","MAZDA_RX_73","MAZDA_RX_75","MAZDA_RX_74","MAZDA_MAZDASPEED_3"];
_sc3 = ["CHRYSLER_300","RENAULT_CLIO_SPORT_V6","SUBARU_IMPREZA_WRX_STI_AWD","SUBARU_IMPREZA_STI_AWD","ALFA_ROMEO_BRERA"];
_sc4 = ["ASTON_MARTIN_DB9","AUDI_FSI_LE_MANS","BUGATTI_VEYRON","Koenigsegg_CCX","KOENIGSEGG_CCX1","KOENIGSEGG_CCX2","KOENIGSEGG_CCX3","LAMBORGHINI_GALLARDO","LAMBORGHINI_MURCIELAGO","LAMBORGHINI_REVENTON","MASERATI_MC12","MCLAREN_F1","PAGANI_ZONDA_F","PORSCHE_911_GT3_RS","PORSCHE_911_TURBO","PORSCHE_997_GT3_RSR","RENAULT_CLIO_SPORT_V6","SUBARU_IMPREZA_STI_AWD","SUBARU_IMPREZA_WRX_STI_AWD"];
_sc5 = ["ALFA_ROMEO_BRERA","MERCEDES_BENZ_CLK_500","BMW_135I","BMW_M3","BMW_M6","BMW_M3_RALLY","JAGUAR_XK","NISSAN_350Z","NISSAN_370Z","NISSAN_GTR_SPECV","NISSAN_GTR_SPECV1","NISSAN_GTR_SPECV2","NISSAN_GTR_SPECV3","NISSAN_SKYLINE_GT_R_Z","NISSAN_SKYLINE_GT_R_Z1","NISSAN_SKYLINE_GT_R_Z2","NISSAN_SKYLINE_GT_R_Z3","NISSAN_SKYLINE_V_SPEC","NISSAN_SKYLINE_V_SPEC1","NISSAN_SKYLINE_V_SPEC2","NISSAN_SKYLINE_V_SPEC3","MAZDA_RX_7","MAZDA_RX_71","MAZDA_RX_72","MAZDA_RX_73","MAZDA_RX_74","MAZDA_RX_75"];
_sc6 = ["CHEVROLET_CAMARO_SS_396","chevrolet_chevelle","CHRYSLER_300","CHRYSLER_B_limmo","CHRYSLER_W_limmo","CORVETTE_C6R","CORVETTE_Z06","DODGE_VIPER_SRT10","FORD_GT","FORD_SHELBY_GT","MERCEDES_BENZ_SL_65_AMG","MERCEDES_BENZ_SLR","PONTIAC_GTO_6","cuda","hemicuda","cd71hm","challenger","barcuda","fury","FORD_MUSTANG_SHELBY_COBRA","FORD_MUSTANG_SHELBY_COBRA1","FORD_MUSTANG_SHELBY_COBRA2","FORD_MUSTANG_SHELBY_COBRA3"];
//Impound Trucks
_tt = ["il_towtruck","kanister","reparaturkit"];
//Pickup Shop - 
_ps = ["Hilux_Hunter","oltruc3","datsun1_civil_1_open","datsun1_civil_2_covered","datsun1_civil_3_open","hilux1_civil_1_open","hilux1_civil_2_covered","il_silverado_black","il_silverado_red","il_silverado_orange","il_silverado_selvo"];
_pt = ["Civcar","Civcarbl","Civcarbu","Civcarge","Civcarre","Civcarsl","Civcarwh"];
//taxi shop
_tx = ["dhi_cvpi_p71_t"];
//motorcycle shop
_mbs = ["tcg_hrly","tcg_hrly_coco","tcg_hrly_demon","tcg_hrly_limited","tcg_hrly_orig1","tcg_hrly_gay","tcg_hrly_metal","tcg_hrly_orig2","tcg_hrly_white","tcg_hrly_blue","tcg_hrly_red","Old_moto_TK_Civ_EP1","MP_MB","TT650_Ins","TT650_Civ","ATV_CZ_EP1"];
_qbs = ["cl_quaddescammo","cl_green","cl_quadred","cl_quadsaftysteel","cl_quadyellow","cl_blue2","cl_quadcarbonlight","cl_chark","cl_dirtyred"];
_qbss = ["tcg_aprilia_blue","tcg_aprilia_yellow","tcg_aprilia_white","tcg_aprilia_green","tcg_aprilia_red","tcg_aprilia_black","tcg_aprilia_black_2","tcg_aprilia_blue_2","tcg_aprilia_blue_4","tcg_aprilia_blue_5","tcg_aprilia_cyan","tcg_aprilia_green_3","tcg_aprilia_orange","tcg_aprilia_red_1","tcg_aprilia_red_2","tcg_aprilia_white_2","tcg_aprilia_yellow_2"];
//Truck Shop
_ts = ["Ural_TK_CIV_EP1", "V3S_Open_TK_CIV_EP1", "V3S_TK_EP1", "V3S_Refuel_TK_GUE_EP1","UralOpen_CDF","KamazOpen","Ural_CDF"];
//Bus Shop
_bss = ["Ikarus_TK_CIV_EP1","Ikarus","schoolbus"];
//Air Shop
_as = ["An2_1_TK_CIV_EP1","An2_2_TK_CIV_EP1","GNT_C185R","GNT_C185C","GNT_C185","GNT_C185F","GNT_C185E"];
_assa = ["AH6X_EP1","KA137_PMC","Mi17_Civilian","adf_as350","ibr_as350_specops","ibr_as350_jungle"];
_asc = ["can_c130","airnz_C130","luf_c130","qantas_C130"];
//Scuba Shop
_sb = ["fishingpole","supgrade1","supgrade2","tcg_wrun","tcg_wave_red","tcg_wave_black","tcg_wave_red2","tcg_wave_sky","tcg_wave_red3","Fishing_boat","PBX","Zodiac","Smallboat_1","Smallboat_2","lcu"];
//Boat Shop
_bs = ["fishingpole","supgrade1","supgrade2","Fishing_boat","PBX","Zodiac","Smallboat_1","Smallboat_2","lcu","big_boat"];
_bsp = ["fishingpole","GNT_C185F","GNT_C185E","PBX","Zodiac","tcg_wrun","tcg_wave_red","tcg_wave_black","tcg_wave_red2","tcg_wave_sky","tcg_wave_red3","big_boat"];
//cop boat shop
_cb = ["fishingpole","Zodiac","RHIB","PBX"];
//Terror Boat Shop
_bt = ["fishingpole","PBX", "Zodiac","Fishing_boat","RHIB","lcu"];
//Jewelry shop
_js = ["Diamond","Diamondring","Diamondnecklace","Diamondbroach","woodchair"];
//Doctor
_td = ["D5W","medikit","firetruck","CL_chargerclEMT","CL_chargerclEMTchief","ArMaT_OH6Aemt","roadcone","roadbarrierlong","roadbarriersmall","reparaturkit","kanister"];
//Mining Shop
_ms = ["Shovel","Pickaxe","JackHammer"];
//Resource Shop
_rs = ["iron","steel","copper","coal","diamond rock","sand","blackpowder","wood"];
//Jackos Cheesburgers
_gds = ["bread","Frozens"];
_gds1 = ["supgrade1","supgrade2","supgrade3","medikit","kanister","reparaturkit"];
_gds2 = ["Binocular","GPS","NVGoggles","wulf","bjerk","tcgmp","doshd"];
_gds3 = ["roadblock","glt_roadsign_octagon","bargate","SearchLight_UN_EP1","roadcone","bunkersmall"];
//Oil Trader/Seller
_os = ["OilBarrel"];
//Whale Sale
_ws = ["Whale"];
//Cocaine Sell
_dsc = ["cocaine","cocaineseed"];
//Marijuana Sell
_dsm = ["marijuana","marijuanaseed"];
//LSD Sell
_dsl = ["lsd"];
//Heroin Sell
_dsh = ["heroin","heroinseed"];
_psc = ["pharm"];
_msc = ["meth"];
//Cop Air Shop
//Littlebird Unarmed, Huey
_ca = ["MH6J_EP1","ArMaT_OH6A","UH1H_TK_GUE_EP1","UH60CG","ibr_as350_civ"];
//Cop Vehicle Shop
_cv = ["MMT_USMC","M1030_US_DES_EP1","ATV_US_EP1","Copcar","CopcarHW","CopcarHW2","CopcarNZ","CopcarAus","CopcarAusgreen","CL_LAMBORGHINIclpd", "cl_f150pd","cl_chargerclpd", "CL_PORSCHEclpd", "cl_chargeretu", "cl_bmwuc1", "cl_bmwclpd", "cl_charger_sheriff", "cl_charger_sheriff1", "jailbus"];
_cv1 = ["il_swatuc","il_bearcat","cop_suv_k9"];
_cv2 = ["MMT_USMC","M1030_US_DES_EP1","ATV_US_EP1","CopcarNZ","CopcarAusgreen"];

_copshop = 

[
"copremotewire",
"X26",
"x26_mag",
"M1014",
"8Rnd_B_Beneli_74Slug",
"8Rnd_B_Beneli_Pellets",
"Itembag",
"kanister",
"reparaturkit",
"Donut",
"medikit", 
"handy", 
"Binocular",
"Itembag",
"lockpick",
"spikestrip",
"NVGoggles"

];

_copshop2 = 

[
"copremotewire",
"X26",
"x26_mag",
"M1014",
"8Rnd_B_Beneli_74Slug",
"8Rnd_B_Beneli_Pellets",
"Itembag",
"kanister",
"reparaturkit",
"Donut",
"medikit",
"lockpick", 
"handy", 
"Binocular",
"Itembag",
"supgrade1",
"NVGoggles",
"RH_g17",
"17Rnd_9x19_g17",
"RH_g19t",
"RH_m4macog",
"30Rnd_556x45_Stanag",
"RH_m4eotech",
"RH_m4aim",
"RH_m4",
"RH_mp5kpdw",
"SUV_TK_CIV_EP1",
"30Rnd_9x19_MP5p"
];

_copshop_patrol = 

[
"RH_g17",
"RH_g18",
"RH_p226",
"RH_m9",
"RH_usp",
"RH_g19",
"RH_33Rnd_9x19_g18",
"RH_19Rnd_9x19_g18",
"RH_15Rnd_9x19_usp",
"Rnd_9x19_M9",
"RH_anacg",
"RH_6Rnd_44_Mag",
"roadblock",
"glt_roadsign_octagon",
"bargate",
"SearchLight_UN_EP1",
"roadcone",
"bunkersmall",
"nitro",
"supgrade1",
"supgrade2",
"supgrade3",
"M79_EP1",
"Mk13_EP1",
"6Rnd_Smoke_M203",
"1Rnd_Smoke_M203",
"SmokeShell",
"defuser"

];

_copshop_response = 

[
"RH_mp5a4",
"RH_mp5kpdw",
"RH_mp7aim",
"RH_ump",
"RH_mp5sd6RFX",
"30rnd_9x19_MP5",
"RH_45ACP_25RND_Mag",
"RH_46x30mm_40RND_Mag",
"20Rnd_556x45_Stanag",
"30Rnd_556x45_Stanag",
"RH_p90",
"RH_57x28mm_50RND_Mag",
"Rnd_B_765x17_Ball"
];

_copshop_sobr = 

[
"RAB_L111A1",
"Land_ladder_half",
"Rnd_9x19_M9",
"SWAT",
"batter",
"RH_M4sdeotech",
"RH_m16a4aim",
"RH_m16a4acog",
"RH_m16a4eotech",
"M14_EP1",
"RH_m4aim",
"RH_m4eotech",
"RH_m4maim",
"RH_m4macog",
"RH_m4meotech",
"JSDF_W_R_M24",
"JSDF_M_R_M24",
"Sa58V_CCO_EP1",
"Sa58V_RCO_EP1",
"M4A3_CCO_EP1",
"RH_Mk48mod1elcan",
"RH_Mk48mod1",
"RH_m1stacog",
"RH_m1staim",
"RH_m1steot",
"100Rnd_762x51_M240",
"RH_m4sbr",
"RH_m4sbraim",
"BAF_L110A1_Aim",
"30Rnd_556x45_G36",
"30Rnd_762x39_SA58",
"20Rnd_762x51_DMR",
"30Rnd_556x45_Stanag",
"1Rnd_Smoke_M203",
"SmokeShell",
"M2StaticMG_US_EP1",
"AA12_PMC",
"20Rnd_B_AA12_Pellets",
"vclammo"

];

_gangshop_buy = 

[

"lockpick",
"lighter",
"Fuelline", 
"kanister",
"medikit",
"Binocular", 
"GPS",
"NVGoggles",
"RH_mk2",
"RH_10Rnd_22LR_mk2",
"RH_M9",
"Rnd_9x19_M9",
"RH_browninghp",
"RH_13Rnd_9x19_bhp",
"RH_vz61",
"RH_20Rnd_32cal_vz61",
"RH_tec9",
"RH_30Rnd_9x19_tec",
"RH_m9c",
"RH_20Rnd_9x19_M93"

];

_gangshop_buy2 = 

[

"lockpick",
"lighter",
"Fuelline", 
"kanister",
"reparaturkit",
"medikit",
"Binocular", 
"GPS",
"NVGoggles",
"RH_mk2",
"RH_10Rnd_22LR_mk2",
"RH_M9", 
"Rnd_9x19_M9",
"RH_muzi",
"RH_32Rnd_9x19_Muzi",
"RH_m9c",
"RH_20Rnd_9x19_M93",
"RH_python",
"RH_6Rnd_357_Mag"

];

_gangshop_buy3 = 

[

"lockpick",
"lighter",
"Fuelline", 
"kanister",
"reparaturkit",
"medikit",
"Binocular", 
"GPS",
"NVGoggles",
"RH_mk2",
"RH_10Rnd_22LR_mk2",
"RH_M9", 
"Rnd_9x19_M9",
"RH_anac",
"RH_6Rnd_44_Mag",
"RH_bull",
"RH_6Rnd_44_Mag",
"RH_mac10",
"RH_9mm_32RND_Mag"

];

_gangshop_buy4 = 

[

"lockpick",
"lighter",
"Fuelline", 
"kanister",
"reparaturkit",
"medikit",
"Binocular", 
"GPS",
"NVGoggles",
"RH_mk2",
"RH_10Rnd_22LR_mk2",
"RH_M9", 
"Rnd_9x19_M9",
"RH_tec9",
"RH_30Rnd_9x19_tec",
"RH_mac10",
"RH_9mm_32RND_Mag",
"RH_muzi",
"RH_32Rnd_9x19_Muzi",
"RH_m9c",
"RH_20Rnd_9x19_M93",
"RH_python",
"RH_6Rnd_357_Mag"

];

INV_ItemShops = [

[fuelshop1,"Fuel-station Shop",dummyobj,dummyobj,_fs,_fs,true],
[fuelshop2,"Fuel-station Shop",dummyobj,dummyobj,_fs,_fs,true],
[fuelshop3,"Fuel-station Shop",dummyobj,dummyobj,_fs,_fs,true],
[fuelshop4,"Fuel-station Shop",dummyobj,dummyobj,_fs,_fs,true],
[Vending2,"Outdoor Shop",vending2,horsespawn,_fs2,_fs2,true],
[shop1,"Food Shop",dummyobj,dummyobj,_is,_is,true],
[shop2,"Food Shop",dummyobj,dummyobj,_is,_is,true],
[shop3,"Food Shop",dummyobj,dummyobj,_is,_is,true],
[shop4,"Jonzie Food",dummyobj,dummyobj,_is,_is,true],
[pdfood,"Food and Gun Locker",dummyobj,dummyobj,_cf,_cf,true],
[pub1,"Pub",dummyobj,dummyobj,_pub,_pub,true],
[pub2,"Pub",dummyobj,dummyobj,_pub,_pub,true],
[pub3,"Pub",dummyobj,dummyobj,_pub,_pub,true],
[pub4,"Pub",dummyobj,dummyobj,_pub,_pub,true],
[gunbox1,"Rifle/SMG Shop",gunbox1,dummyobj,_gs,_gs,true],
[gunbox3,"M14/Socom Shop",gunbox3,dummyobj,_gsa,_gsa,true],
[gunbox2,"Pistol Shop",gunbox2,dummyobj,_gss,_gss,true],
[assassinshop,"Assassin Shop",assassinshop,dummyobj,_ass,_ass,true],
[mayorguns,"Government Equip Shop",mayorguns,mayorguns,_mgs,_mgs,true],
[equipbox,"Equipment Shop",equipbox,dummyobj,_es,_es,true],
[equipbox1,"Equipment Shop",equipbox1,dummyobj,_es,_es,true],
[gocartshop,"Texas Go-Carts Shop",dummyobj,gocartspawn,_gc,_gc,true],
[tuning1,"Car Upgrades",dummyobj,dummyobj,_cu,_cu,true],
[tuning2,"Car Upgrades",dummyobj,dummyobj,_cu,_cu,true],
[carshop1,"Used Cars",dummyobj,carspawn1,_cs1,_cs1,true],
[carshop2,"Used Cars",dummyobj,carspawn2,_cs2,_cs2,true],
[carshop3,"Liter O Car Shop",dummyobj,carspawn3,_cs3,_cs3,true],
[carshop4,"Used Cars",dummyobj,carspawn4,_cs4,_cs4,true],
[scarshop,"Race Cars",dummyobj,scarspawn1,_sc1,_sc1,true],
[scarshop2,"Charger and Mazda",dummyobj,scarspawn2,_sc2,_sc2,true],
[scarshop3,"Every Day Cars",dummyobj,scarspawn3,_sc3,_sc3,true],
[scarshop4,"Super Sports Cars",dummyobj,scarspawn4,_sc4,_sc4,true],
[scarshop5,"Sports Car",dummyobj,scarspawn5,_sc5,_sc5,true],
[scarshop6,"Muscle Car Shop",dummyobj,scarspawn6,_sc6,_sc6,true],
[towshop,"Tow Truck Company",dummyobj,towspawn,_tt,_tt,true],
[pickupshop1,"Pickup Shop",dummyobj,pickupspawn1,_ps,_ps,true],
[pickupshop2,"Holden Dealers",dummyobj,pickupspawn2,_pt,_pt,true],
[taxishop,"Taxi Shop",dummyobj,taxispawn1,_tx,_tx,true],
[bikeshop,"Mikes Bike Shop",dummyobj,bikespawn,_mbs,_mbs,true], 
[bikeshop1,"Quad Bike Shop",dummyobj,bikespawn1,_qbs,_qbs,true],
[bikeshop2,"Sports Bike Shop",dummyobj,bikespawn1,_qbss,_qbss,true],
[truckshop,"Truck Shop",dummyobj,truckspawn,_ts,_ts,true],
[busshop,"Tour Bus Shop",dummyobj,busspawn,_bss,_bss,true],
[airshop,"Airplane Shop",dummyobj,asairspawn,_as,_as,true],
[airshop2,"Chopper and Jet Shop",dummyobj,asairspawn2,_assa,_assa,true],
[airshop1,"Cuban Airplane Shop",dummyobj,asairspawn1,_as,_as,true],
[airshop3,"Commercial Air Shop",dummyobj,asairspawn3,_asc,_asc,true],
[airshop4,"Chopper and Jet Shop",dummyobj,asairspawn1,_assa,_assa,true],
[scubashop, "Jetski Shop",dummyobj,boatspawn5,_sb,_sb,true],	
[boatshop1, "Boat Shop",dummyobj,boatspawn1,_bs,_bs,true],										
[boatshop2, "Boat Shop",dummyobj,boatspawn2,_bs,_bs,true],
[boatshop3, "Boat Shop",dummyobj,boatspawn3,_bs,_bs,false],
[boatshop4, "Sea Plane Shop",dummyobj,boatspawn4,_bsp,_bsp,false],
[copboatshop, "Coast Guard Shop",dummyobj,copboatspawn,_cb,_cb,true],
[tboatshop1,"Boat Shop",dummyobj,tboatspawn1,_bt,_bt,true],
[Diamond_1,"Bryces Pretty Jewelry Shop",dummyobj,dummyobj,_js,_js,true],
[tdoc,"Emergency Equipment",dummyobj,tdocspawn,_td,_td,true],
[Oil_1,"Mining equipment",dummyobj,dummyobj,_ms,_ms,true],
[resourcesell,"Sell Resources",dummyobj,dummyobj,_rs,_rs,true],
[cheeseburger,"Jackos Cheeseburgers",dummyobj,dummyobj,_gds,_gds,true],
[workplace_getjobflag_4,"Aussie Imporium",dummyobj,dummyobj,_gds1,_gds1,true],
[workplace_getjobflag_5,"XMart",dummyobj,dummyobj,_gds2,_gds2,true],
[workplace_getjobflag_6,"Wigworths",dummyobj,dummyobj,_gds3,_gds3,true],
[OilSell1,"Oil Dealer", dummyobj,dummyobj, _emptyshop,_os,true],
[whalesell,"Sell Whale",dummyobj,dummyobj,_emptyshop,_ws,true],	
[gangarea1,"Gang Shop",gangbox1,dummyobj,_gangshop_buy,_gangshop_buy,false],
[gangarea2,"Gang Shop",gangbox2,dummyobj,_gangshop_buy2,_gangshop_buy2,false],
[gangarea3,"Gang Shop",gangbox3,dummyobj,_gangshop_buy3,_gangshop_buy3,false],																	
[gangarea4,"Gang Shop",gangbox4,dummyobj,_gangshop_buy4,_gangshop_buy4,false],											
[cdrugsell,"Sell Cocaine",dummyobj,dummyobj,_dsc,_dsc,true],
[mdrugsell,"Sell marijuana",dummyobj,dummyobj,_dsm,_dsm,true],
[ldrugsell,"Sell LSD",dummyobj,dummyobj,_emptyshop,_dsl,true],
[hdrugsell,"Sell Heroin",dummyobj,dummyobj,_dsh,_dsh,true],
[methsell,"Sell Meth",dummyobj,dummyobj,_msc,_msc,true],
[pharmacy,"Pharmacy",dummyobj,dummyobj,_psc,_emptyshop,false],
[copair,"Police Air-Vehicle Shop",dummyobj, cairspawn,_ca,_ca,true],
[copcar,"Police vehicle Shop",dummyobj, ccarspawn,_cv,_cv,true],
[copcar1,"STAR Vehicle Shop",dummyobj, ccarspawn1,_cv1,_cv1,true],
[copcar3,"Police vehicle Shop",dummyobj, ccarspawn3,_cv2,_cv2,true],
[copbasic,"Generic Police Shop",copbasic,dummyobj, _copshop,_copshop,false],
[coppatrol,"Patrol-Officer",coppatrol,dummyobj,_copshop_patrol,_copshop_patrol,true],
[copcriminal,"Criminal Response-Officer",copcriminal,dummyobj,_copshop_response,_copshop_response,true],
[copswat,"STAR Guns",copswat,dummyobj,_copshop_sobr,_copshop_sobr,true],
[copbasic2,"AFP Police Shop",copbasic2,ccarspawn2, _copshop2,_copshop2,true]

];
