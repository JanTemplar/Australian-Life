/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

//TNL_gAction_inventory = null; //Inventory Action
//TNL_gAction_stats = null; //Stats Action
//TNL_gAction_animations = null; //Animations Action
//TNL_gAction_governorsOffice = null; //Governors actions

TNL_factions_curAddingActions = false;
TNL_gVar_bool_inVehicleActions = false; //In-Vehicle actions been added
TNL_gVar_bool_onFootActions = false; //On-Foot actions been added
TNL_gAction_governorsOffice = false; //Governors Office Actions
TNL_gAction_taxiJobAction = false; //Taxi Actions
TNL_gAction_deliveryJobAction = false; //Delivery actions
TNL_gAction_drugDealer = false; //Drug Dealer Actions
TNL_gAction_exportAction = false;


TNL_gVar_obj_curVehicle = vehicle player; //Current vehicle player is in

[] spawn
{
	TNL_gVar_arr_playerShopActions = [];
	waitUntil {!isNil "TNL_gVar_arr_playerShops"};
	/* Player shop actions */
	{ TNL_gVar_arr_playerShopActions = TNL_gVar_arr_playerShopActions + [0];} forEach TNL_gVar_arr_playerShops; 
};

//Gas stations
TNL_gVar_arr_gasStationActions = [];
{ TNL_gVar_arr_gasStationActions = TNL_gVar_arr_gasStationActions + [0];	} forEach TNL_gas_gasStations;


//Shop Actions
TNL_gVar_arr_shopActions = [];
{ TNL_gVar_arr_shopActions = TNL_gVar_arr_shopActions + [0];} forEach TNL_ShopArray; 

//License Actions
TNL_gVar_arr_licenseActions = [];
{ TNL_gVar_arr_licenseActions = TNL_gVar_arr_licenseActions + [0];} forEach TNL_arr_lic_licensePurchase;

//Player Actions (such as interact)
TNL_gVar_arr_playerActions = [];
{ TNL_gVar_arr_playerActions = TNL_gVar_arr_playerActions + [0];} forEach Gvar_arr_mission_PlayerArray;

//Gather Actions
TNL_gVar_arr_gatherActions = [];
{ TNL_gVar_arr_gatherActions = TNL_gVar_arr_gatherActions + [0];} forEach TNL_gVar_arr_gatherLocations;

//Storage Actions
TNL_gVar_arr_storageActions = [];
{ TNL_gVar_arr_storageActions = TNL_gVar_arr_storageActions + [0];} forEach Gvar_arr_trunk_storages;

//Factory Actions 
TNL_gVar_arr_factoryActions = [];
{ TNL_gVar_arr_factoryActions = TNL_gVar_arr_factoryActions + [0];} forEach TNL_gVar_arr_fact_factorys;

//Ground Actions
TNL_gVar_arr_groundAddedActions = [];
{ TNL_gVar_arr_groundAddedActions = TNL_gVar_arr_groundAddedActions + [0];} forEach TNL_gVar_arr_groundActions;

//Stock Market Actions
TNL_gVar_arr_stockMarketActions = [];
{ TNL_gVar_arr_stockMarketActions = TNL_gVar_arr_stockMarketActions + [0];} forEach TNL_gVar_arr_stockExchanges;

//Bank Actions
TNL_gVar_arr_bankActions = [];
{ TNL_gVar_arr_bankActions = TNL_gVar_arr_bankActions + [0];} forEach TNL_gVar_arr_banks;

{
	(_x select 0) addAction[(_x select 1), "client\useAction.sqf", ["playerShop", (_x select 0)]];
} forEach (playerShops getVariable "playerShops");
