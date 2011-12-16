/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

/* Ore Smelter */
_oreSmelterRepair = 
[ 
	["Stone", 20], 
	["Clay", 5], 
	["Log", 20] 
];

_oreSmelter = 
[ 
	["Iron_bar", 50, 100, true], 
	["Tin_bar", 50, 100, true], 
	["Copper_bar", 50, 100, true], 
	["Steel_bar", 100,200, true], 
	["lead_bar", 50, 100, true], 
	["gold_bar", 500, 600, true] 
];

_resourceFactRepair =
[
	["Stone", 20],
	["Clay", 5],
	["Log", 20],
	["Coal", 10]
];

_resourceFact = 
[
	["SteelWool", 200,225, true],
	["WoodShaft", 25,50, true],
	["WoodPlank", 25, 50, true],
	["Brick", 25,30, true],
	["Iron_bar", 50, 100, true], 
	["Tin_bar", 50, 100, true], 
	["Coal", 50, 100, true],
	["Copper_bar", 50, 100, true], 
	["Steel_bar", 100,200, true], 
	["lead_bar", 50, 100, true], 
	["gold_bar", 500, 600, true]
];

_carFactoryRepair =
[
	["Steel_bar", 5],
	["ElectronicComponents", 5],
	["WoodShaft", 15],
	["WoodPlank", 15],
	["Brick", 10],
	["Stone", 20]
];

_carFactory =
[
	["Skoda", 500, 600, true],
	["SkodaBlue", 500, 600, true],
	["SkodaRed", 500, 600, true],
	["SkodaGreen", 500, 600, true],
	["civic", 500, 600, true],
	["tractor", 700, 900, true],
	["VWGolf", 1500, 1800, true],
	["car_hatchback", 600, 700, true],
	["car_sedan", 600, 700, true],
	["Lada1", 800, 900, true],
	["Lada2", 800, 900, true],
	["Lada1_TK_CIV_EP1", 800, 900, true],
	["Lada2_TK_CIV_EP1", 800, 900, true],
	["VolhaLimo_TK_CIV_EP1", 10000, 12500, true],
	["M1030", 200, 250, true],
	["TT650_Civ", 200, 250, true],
	["TT650_Gue", 200, 250, true],
	["TT650_TK_CIV_EP1", 200, 250, true],
	["old_moto_tk_civ_ep1", 200, 250, true],
	["ATV_US_EP1", 300, 400, true]
];

_pickupFactoryRepair =
[
	["Steel_bar", 10],
	["ElectronicComponents", 5],
	["WoodShaft", 20],
	["WoodPlank", 20],
	["Brick", 15],
	["Stone", 30]
];	

_pickupFactory =
[
	["datsun1_civil_1_open", 1000, 1200, true],
	["datsun1_civil_2_covered", 1000, 1200, true],
	["datsun1_civil_3_open", 1000, 1200, true],
	["hilux1_civil_1_open", 1300, 1400, true],
	["hilux1_civil_2_covered", 1300, 1400, true],
	["hilux1_civil_3_open", 1300, 1400, true],
	["LandRover_CZ_EP1", 1500, 1600, true],
	["LandRover_TK_CIV_EP1", 1500, 1600, true],
	["S1203_TK_CIV_EP1", 900, 1000, true],
	["S1203_ambulance_EP1", 900, 1000, true],
	["oltruc3", 2000, 2500, true],
	["oldtruck", 2000, 2500, true],
	["cooter", 2000, 2500, true],
	["240GD", 2000, 2500, true],
	["SUV_TK_CIV_EP1", 20000, 30000, true]
];

_truckFactoryRepair =
[
	["Steel_bar", 15],
	["ElectronicComponents", 10],
	["WoodShaft", 30],
	["WoodPlank", 30],
	["Brick", 20],
	["Stone", 35]
];	

_truckFactory =
[
	["Kamaz", 2200, 2500, true],
	["KamazOpen", 2200, 2500, true],
	["KamazRefuel", 2200, 2500, true],
	["oldtruc2", 2000, 2500, true],
	["UralCivil", 3000, 3500, true],
	["UralCivil2", 3000, 3500, true],
	["UralOpen_INS", 3000, 3500, true],
	["MTVR", 4000, 5000, true],
	["MtvrRefuel",4000, 5000, true],
	["Bus", 1500, 2000, true]
];

_pistolFactoryRepair =
[
	["Silicon", 10],
	["Stone", 30],
	["Brick", 15],
	["WoodPlank", 30],
	["steel_bar", 10]
];

_pistolFactory =
[
	["RH_M9", 900, 1000, true],
	["RH_usp", 900, 1000, true],
	["RH_uspm", 900, 1000, true],
	["RH_m1911", 1000, 1200, true],
	["RH_m1911old", 1000, 1200, true],
	["RH_g17", 1000, 1200, true],
	["RH_g19", 1000, 1200, true],
	["RH_ppk", 600, 700, true],
	["Makarov", 500, 600, true],
	["RH_mk22", 900, 1000, true],
	["RH_deagle", 2000, 2500, true],
	["RH_bull", 2000, 2500, true],
	["RH_anac", 2000, 2500, true],
	["RH_python", 2000, 2500, true]
];

_westernWeaponsFactory =
[
	["M1014", 3000, 3500, true],
	["M16A2", 4000, 5000, true],
	["M16A4", 5000, 6000, true],
	["M16A4_ACG", 5500, 6000, true],
	["M4A1", 5000, 6000, true],
	["M4A1_Aim", 6000, 7000, true],
	["LeeEnfield", 1500, 2000, true],
	["Huntingrifle", 3000, 4000, true]
];

_easternWeaponsFactory =
[
	["AKS_74_U", 3000, 3500, true],
	["AK_74", 4000, 4250, true],
	["AKS_74_UN_kobra", 4400, 4700, true],
	["AKS_GOLD", 8000, 9000, true],
	["AK_47_M", 4000, 6000, true],
	["AK_47_S", 4000, 6000, true]
];

_smgFactory =
[
	["RH_vz61", 1200, 1300, true],
	["RH_tec9", 1200, 1300, true],
	["RH_muzi", 1300, 1400, true],
	["RH_uzi", 1300, 1400, true],
	["RH_uzim", 1300, 1400, true],
	["RH_mac10", 1300, 1400, true],
	["RH_MP5A4", 1300, 1400, true],
	["RH_mp5k", 1300, 1400, true],
	["RH_mp5kpdw", 1300, 1400, true],
	["RH_MP5A5", 1300, 1400, true],
	["RH_mp7aim", 1300, 1400, true]
];

_bulletFactory =
[
	["15Rnd_9x19_M9", 25, 50, true],
	["15Rnd_9x19_usp", 25, 50, true],
	["12Rnd_45cal_usp", 25, 50, true],
	["30Rnd_9x19_tec", 25, 50, true],
	["32Rnd_9x19_muzi", 25, 50, true],
	["7rnd_50_AE", 25, 50, true],
	["7rnd_32cal_ppk", 25, 50, true],
	["8rnd_9x19_mk22", 25, 50, true],
	["8Rnd_45cal_m1911", 25, 50, true],
	["17Rnd_9x19_g17", 25, 50, true],
	["8Rnd_9x18_Makarov", 25, 50, true],
	["6Rnd_357_Mag", 25, 50, true],
	["6Rnd_44_Mag", 25, 50, true],
	["8Rnd_B_Beneli_74Slug", 25, 50, true],
	["30Rnd_545x39_AK", 25, 50, true],
	["30Rnd_545x39_AKSD", 25, 50, true],
	["30Rnd_762x39_AK47", 25, 50, true],
	["30Rnd_556x45_Stanag", 25, 50, true],
	["20Rnd_556x45_Stanag", 25, 50, true],
	["10x_303", 25, 50, true],
	["20Rnd_32cal_vz61", 25, 50, true], 
	["RH_9mm_32RND_Mag", 25, 50, true],
	["30Rnd_9x19_MP5", 25, 50, true],
	["RH_46x30mm_40RND_Mag", 25, 50, true],
	["5x_22_LR_17_HMR", 25, 50, true]
];

_itemFactory =
[
	["Pickaxe_stone", 25,50, true],
	["pickaxe_iron", 25, 50, true],
	["pickaxe_steel", 25, 50, true],
	["DrugShed", 100, 200, true],
	["CisternFuelCan", 25, 50, true],
	["shovel", 50,100, true],
	["hatchet", 50,100, true],
	["Fishing_rod", 25,50, true],
	["ClayPot", 5,10,true],
	["mobilephone", 20,30,true],
	["RepairKit", 40, 90, true],
	["Lockpick", 80, 160, true],
	["Crowbar", 80, 160, true],
	["RefuelCan", 40, 90, true],
	["Barrel", 25,50, true],
	["Harpoon", 50, 100, true],
	["Fishing_net", 50, 100, true],
	["ItemGPS", 500, 600, true],
	["ButcheringKnife", 25, 50, true],
	["Spare_Wheel", 100, 120, true],
	["radio", 10, 20, true]
];

_airFactory =
[
	["An2_1_TK_CIV_EP1", 8000, 12000, true],
	["An2_2_TK_CIV_EP1", 8000, 12000, true],
	["An2_TK_EP1", 8000, 12000, true],
	["MH6J_EP1", 8000, 12000, true],
	["USEC_Maule_M7_STD", 8000, 12000, true],
	["Mi17_Civilian", 12000, 12000, true]
];

_boatFactory =
[
	["Fishing_Boat", 4000, 5000, true],
	["Smallboat_1", 1000, 2000, true],
	["Smallboat_2", 1000, 2000, true]
];

TNL_gVar_arr_fact_types = 
[
	//["ore_smelter", ["Ore Smelter", "No description currently"], _oreSmelterRepair, _oreSmelter],
	["res_factory", ["Resource Factory", "No description yet"], _resourceFactRepair, _resourceFact],
	["car_factory", ["Car Factory", "No description yet"], _carFactoryRepair, _carFactory],
	["pickup_factory", ["Pickup Factory", "No description yet"], _pickupFactoryRepair, _pickupFactory],
	["truck_factory", ["Truck Factory", "No description yet"], _truckFactoryRepair, _truckFactory],
	["pistol_factory", ["Pistol Factory", "No description yet"], _pistolFactoryRepair, _pistolFactory],
	["westrifle_factory", ["Western Rifles Factory", "No description yet"], _pistolFactoryRepair, _westernWeaponsFactory],
	["eastrifle_factory", ["Eastern Rifles Factory", "No description yet"], _pistolFactoryRepair, _easternWeaponsFactory],
	["smg_factory", ["SMG Factory", "No description yet"], _pistolFactoryRepair, _smgFactory],
	["bullet_factory", ["Bullet (Magazine) Factory", "No description yet"], _pistolFactoryRepair, _bulletFactory],
	["item_factory", ["Item Factory", "No description yet"], _resourceFactRepair, _itemFactory],
	["air_factory", ["Air vehicles factory", "No description yet"], _pistolFactoryRepair, _airFactory],
	["boat_factory", ["Boat Factory", "No description yet"], _pistolFactoryRepair, _boatFactory]
];

TNL_gVar_arr_fact_factorys = 
[
	[factory_1, ["Maruko Factory North", 15], [factory_1_pstorage, factory_1_lstorage], factory1_vclSpawn, factory1_weaponSpawn],
	[factory_2, ["Maruko Factory Stone Mine", 15], [factory_2_pstorage, factory_2_lstorage], factory2_vclSpawn, factory2_weaponSpawn],
	[factory_3, ["Tucos Bridge Factory", 15], [factory_3_pstorage, factory_3_lstorage], factory3_vclSpawn, factory3_weaponSpawn],
	[factory_4, ["Tucos Factory West", 15], [factory_4_pstorage, factory_4_lstorage], factory4_vclSpawn, factory4_weaponSpawn],
	[factory_5, ["Tucos Factory Central", 15], [factory_5_pstorage, factory_5_lstorage], factory5_vclSpawn, factory5_weaponSpawn],
	[factory_6, ["Tucos Factory East", 15], [factory_6_pstorage, factory_6_lstorage], factory6_vclSpawn, factory6_weaponSpawn],
	[factory_7, ["San Isabel Factory East", 15], [factory_7_pstorage, factory_7_lstorage], factory7_vclSpawn, factory7_weaponSpawn],
	[factory_8, ["San Isabel Factory West", 15], [factory_8_pstorage, factory_8_lstorage], factory8_vclSpawn, factory8_weaponSpawn],
	[factory_9, ["Haciendos Factory", 15], [factory_9_pstorage, factory_9_lstorage], factory9_vclSpawn, factory9_weaponSpawn],
	[factory_10, ["Maruko Factory South", 15], [factory_10_pstorage, factory_10_lstorage], factory10_vclSpawn, factory10_weaponSpawn],
	[factory_11, ["Manteria Factory", 15], [factory_11_pstorage, factory_11_lstorage], factory11_vclSpawn, factory11_weaponSpawn],
	[factory_12, ["Calapedro Factory", 15], [factory_12_pstorage, factory_12_lstorage], factory12_vclSpawn, factory12_weaponSpawn],
	[factory_13, ["Calapedro Factory West", 15], [factory_13_pstorage, factory_13_lstorage], factory13_vclSpawn, factory13_weaponSpawn],
	[factory_14, ["Calapedro Factory South", 15], [factory_14_pstorage, factory_14_lstorage], factory14_vclSpawn, factory14_weaponSpawn],
	[factory_15, ["Victorin Factory North", 15], [factory_15_pstorage, factory_15_lstorage], factory15_vclSpawn, factory15_weaponSpawn],
	[factory_16, ["Victorin Factory South", 15], [factory_16_pstorage, factory_16_lstorage], factory16_vclSpawn, factory16_weaponSpawn],
	[factory_17, ["Sanvigado Factory East", 15], [factory_17_pstorage, factory_17_lstorage], factory17_vclSpawn, factory17_weaponSpawn],
	[factory_18, ["Prospero Factory", 15], [factory_18_pstorage, factory_18_lstorage], factory18_vclSpawn, factory18_weaponSpawn],
	[factory_19, ["Marcella Factory", 15], [factory_19_pstorage, factory_19_lstorage], factory19_vclSpawn, factory19_weaponSpawn],
	[factory_20, ["Corazon Factory West", 15], [factory_20_pstorage, factory_20_lstorage], factory20_vclSpawn, factory20_weaponSpawn],
	[factory_21, ["Maruko Airport Factory", 15], [factory_21_pstorage, factory_21_lstorage], factory21_vclSpawn, factory21_weaponSpawn]
];

/* Please dont mess with these */
TNL_gVar_arr_fact_actions = 
[
	["Management", "managefactory", "openComplete", "owner"],
	["Manufacture", "manufacture", "openComplete", "public"],
	["Repair", "repair", "openRepair", "owner"],
	["Private storage", "localstorage", "", "public"],
	["Factory storage", "publicstorage", "", "public"]
];

TNL_gVar_arr_fact_repairUserActions =
[
	["Add User", "adduser"],
	["Remove User", "remuser"],
	["Lock/unlock storage", "lockstorage"],
	["Toggle required to be on list", "listenable"]
];

TNL_gVar_arr_fact_managementActions =
[
	["Toggle users can manufacture item", "toggleItemCanMake"],
	["Set Item Price", "setprice"],
	["Change factory type", "changefactorytype"],
	["Add user", "adduser"],
	["Remove user", "remuser"],
	["Lock/unlock storage", "lockstorage"],
	["Lock/unlock factory", "lockfactory"],
	["Toggle required to be on list", "listenable"]
];

TNL_gVar_arr_fact_owners = [ ];

{
	_crateLogic = (_x select 4);
	_crateName = format["%1_factory_crate", _crateLogic];
	((_x select 2) select 0) setpos[0,0,0];
	((_x select 2) select 1) setPos[0,0,0];
	
	call compile format['%1 = "USBasicAmmunitionBox" createVehicleLocal getpos(%2); clearMagazineCargo %1; clearWeaponCargo %1; player reveal %1;', _crateName, _crateLogic];

} foreach TNL_gVar_arr_fact_factorys;


if (isServer) then
{
	{	
		_factory = (_x select 0);
		_factory setVariable ["factory_settings", 
		[ 
			["repaired", false], 
			["selectedType", false],
			["factoryType", ""],
			["permissionsPublicStorage", [false, true, false, [ ]]],
			["factoryMaterialsRepair", []],
			["itemsCanMake", []],
			["factoryFunds", 0],
			["factoryLocked", false]
		], true];
		
	} forEach TNL_gVar_arr_fact_factorys;
};