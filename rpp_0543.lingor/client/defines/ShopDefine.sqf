/*
Name: SBAY_ShopDefine.sqf
Auhor: Unforgiven
Version: 0.1.0 (2009/05/28)
Description: Defines all the shops
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

/*
	Shop stock arrays
	* Description: Below here are the arrays of all the shop stocks, these include the items, increased buy cost and other stuff
	* Parameters: 
		(0) Item Class (string)
		(1) Increased buy price this is multiplied by item buy price defined in main items array (integer)
		(2) Increased sell price, this is multiplied by the item sell price defined in the main items array (integer)
		(3) Requires the defined item license to purchase (boolean)
*/
_ExampleShop = 
[
	["test", 1, 1, false],
	["bread", 1, 1, true],
	["pickaxe", 1, 1, true],
	["iron_ore", 1, 1, true],
	["RH_M9", 1, 1, true],
	["15Rnd_9x19_M9", 1, 1, true],
	["AKS_74_U", 1, 1, true],
	["30Rnd_545x39_AK", 1, 1, true],
	["Skoda", 1,1, false],
	["LadaLM", 1, 1, false],
	["MMT_Civ", 7, 1, false],
	["Pastor", 1, 1, false],
	["wood", 1, 1, false],
	["limestone", 1, 1, false],
	["clay", 1, 1, false],
	["Strawberries", 1, 1, false],
	["shovel", 1, 1, false],
	["gloves", 1, 1, false],
	["apple_seed", 1, 1, false],
	["hatchet", 1, 1, false],
	["HandGrenade_Stone", 1, 1, false],
	["pine_seed", 1, 1, false],
	["apple", 1, 1, false],
	["example_shop", 1, 1, false],
	["FORT_CRATE_WOOD", 1, 1, false]
];

_PistolShopBuy =
[
	["RH_M9", 3, 1, true],
	["15Rnd_9x19_M9", 3, 1, true],
	["Colt1911", 3, 1, true],
	["7Rnd_45ACP_1911", 3, 1, true]
];

_BikeShopBuy = 
[
	["MMT_Civ", 1, 1, true],
	["Old_bike_TK_CIV_EP1", 1, 1, true],
	["Old_moto_TK_Civ_EP1", 1, 1, true]
];

_OldCarShopBuy =
[
	["Volha_1_TK_CIV_EP1", 1, 1, true],
	["Volha_2_TK_CIV_EP1", 1, 1, true],
	["Lada1_TK_CIV_EP1", 1, 1, true],
	["Lada2_TK_CIV_EP1", 1, 1, true],
	["V3S_Refuel_TK_GUE_EP1", 1, 1, true],
	["V3S_Salvage_TK_GUE_EP1", 1, 1, true]
];

_ItemShopBuy =
[
	["mobilephone", 1, 1, true],
	["Pickaxe_stone", 1, 1, true],
	["Shovel", 1, 1, true],
	["Hatchet", 1, 1, true]
];

_CopWeaponShopBuy =
[
	["RH_M9", 1, 1, true],
	["15Rnd_9x19_M9", 1, 1, true],
	["M1014", 1, 1, true],
	["8Rnd_B_Beneli_74Slug", 1, 1, true],
	["rh_m1911", 1, 1, true],
	["8Rnd_45cal_m1911", 1, 1, true],
	["RH_g17", 1, 1, true],
	["Makarov", 1, 1, true],
	["8Rnd_9x18_Makarov", 1, 1, true],
	["RH_python", 1, 1, true],
	["6Rnd_357_Mag", 1, 1, true],
	["AK_47_M", 1, 1, true],
	["30rnd_762x39_ak47", 1, 1, true],
	["M4A1", 1, 1, true],
	["30rnd_556x45_stanag", 1, 1, true],
	["RH_MP5A4", 1, 1, true],
	["RH_MP5kpdw", 1, 1, true],
	["30rnd_9x19_mp5", 1, 1, true],
	["RH_MP7aim", 1, 1, true],
	["17Rnd_9x19_glock17", 1, 1, true],
	["RH_46x30mm_40rnd_mag", 1, 1, true]
	
];

_CopCarShopBuy =
[
	["speedcam", 1, 1, true],
	["polradio", 1, 1, true],
	["LadaLM", 1, 1, true],
	["sahco", 1, 1, true]
];

_CopBoatBuy =
[
	["RHIB2Turret", 1, 1, true]
];

_CivBoatBuy = 
[
	["Fishing_Boat", 1, 1, true],
	["Smallboat_1", 1, 1, true],
	["Smallboat_2", 1, 1, true],
	["SeaFox", 1, 1, true]
];

_ExportShip = [];
{
	_type = ((_x select 1) select 1);
	_class = (_x select 0);
	
	if ((_type == "RESOURCE") || (_type == "FOOD")) then
	{
		_ExportShip set [(count _ExportShip), [_class, 1, 1, true]]; 
	};
} forEach GoodsArray;

_ImportShip = 
[
	["Pickaxe_stone", 1, 1, true],
	["shovel", 1, 1, true],
	["Fishing_rod", 1, 1, true],
	["ClayPot", 1, 1, true],
	["ButcheringKnife", 1, 1, true]
];


/*
	TNL_ShopArray
	* Description: The main shop array where they are all defined
	* Parameters: 
		(0) Object the action will be added too (object)
		(1) Action name for the shop (string)
		(2) Shop type (string)
		(3) Unused (none)
		(4) Shop uses global taxes (boolean)
		(5) Array of shop purchase stock's (array)
		(6) Array of shop sell stock's (array)
		(7) Array of player types that can use, if its empty then everyone can use (array)
		(8) Unused (none)
		(9) Parameters:
			(0) Opening time (integer)
			(1) Closing time (integer)
		(10) Ammo box where all the purchased weapons will spawn if not required a spawn then use the empty spawn object (object)
		(11) Location where all the purchase vehicles will spawn if not required a spawn then use the empty spawn object (object)
*/
TNL_ShopArray = 
[
	//[ pistolshop1, "Pistol Shop", "item", -1, true, [_PistolShopBuy], [_PistolShopBuy], ["CIV"], true, [7,20], pistolshop1_box, pistolshop1_box],
	//[ itemshop1, "Basic Tool Shop", "item", -1, true, [_ItemShopBuy], [_ItemShopBuy], ["CIV"], false, [0,0], empty, empty],
	//[ carshop1, "Bike Shop", "item", -1, true, [_BikeShopBuy], [_BikeShopBuy], ["CIV"], false, [7,7], carshop1_box, carshop1_box],
	//[ oldcarshop1, "Old Car Shop", "item", -1, true, [_OldCarShopBuy], [_OldCarShopBuy], ["CIV"], true, [7,20], empty, oldcarshop1],
	[ copweapons, "Police Weapons", "item", -1, true, [_CopWeaponShopBuy], [_CopWeaponShopBuy], ["COP"], false, [0,0], copweaponsbox, copweapons],
	[ copvehicles, "Police Vehicles", "item", -1, true, [_CopCarShopBuy], [_CopCarShopBuy], ["COP"], false, [0,0], empty, copvehicles],
	[ boatbuy2, "Police Boats", "item", -1, true, [_CopBoatBuy], [_CopBoatBuy], ["COP"], false, [0,0], empty, boatbuy1_spawn],
	[ exportShip, "Export resources", "item", -1, true, [_ImportShip], [_ExportShip], ["CIV"], false, [0,0], empty, empty]
	//[ boatbuy1, "Civilian Boats", "item", -1, true, [_CivBoatBuy], [_CivBoatBuy], ["CIV"], true, [7,20], empty, boatbuy1_spawn]
];


//Spawn local ammo crates for the player
{
	_crateLogic = (_x select 10);
	_crateName = format["%1_shop_crate", _crateLogic];
	
	call compile format['%1 = "USBasicAmmunitionBox" createVehicleLocal getpos(%2); clearMagazineCargo %1; clearWeaponCargo %1; player reveal %1;', _crateName, _crateLogic];

} foreach TNL_ShopArray;

