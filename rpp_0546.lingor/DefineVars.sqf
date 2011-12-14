/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

//Integers
Gvar_int_inv_weight = 0;
Gvar_int_inv_maxWeight = 45;
TNL_atm_dayLimit = 4000;
TNL_env_dayLength = 3600;

Gvar_int_player_hungerLoopTime = 60;
Gvar_int_player_hungerDecrease = 3.15;
Gvar_int_player_hunger = 100;
Gvar_int_player_maxHunger = 100;

TNL_gVar_miningYourself = true;

RPP_gVar_boolean_leadingAnimal = false;
RPP_gVar_obj_leadAnimal = empty;

RPP_var_curRadioChan = 0;

gatherResult = [];

TNL_gVar_arr_copied = [];

Gvar_int_player_thirstLoopTime = 60;
Gvar_int_player_thirstDecrease = 2.75;
Gvar_int_player_thirst = 100;
Gvar_int_player_maxThirst = 100;

TNL_gVar_int_timeSinceLastTrade = time;
TNL_gVar_int_timeUntilCanTrade = 3;

TNL_gVar_int_timeSinceLastUsedTrunk = time;
TNL_gVar_int_timeUntilCanUseTrunk = 2;

TNL_gVar_int_player_bodyTemperature = 0;

//Arrays
Gvar_arr_inv_inventory = [ ];
Gvar_arr_lic_playerLicenses = [ ];
Gvar_arr_inv_ownedVehicles = [ ];
Gvar_arr_extHint_extendedHints = [ ["", 0] ];
TNL_gVar_arr_forestry_serverBushes = [];
TNL_gVar_arr_credits_names = 
[ 
	"SCRIPTING & DIALOGS",
	"Unforgiven",
	"Deadfast",
	"END",
	
	"CONFIGS",
	"Jason",
	"END",
	
	"SOUNDS",
	"Somebloke",
	"END",
	
	"TEXTURES",
	"X-Ray",
	"Cyrax",
	"END",
	
	"MODELS",
	"Alternus", 
	"END", "", "", "", "", "", "", ""
];


//Booleans
Gvar_bool_player_hungerEffectEnabled = false;
Gvar_bool_player_thirstEffectEnabled = false;
Gvar_bool_player_ableToUseAnimation = true;
TNL_gVar_bool_gatheringItems = false;
TNL_gVar_bool_cuttingTree = false;
