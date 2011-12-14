/*
Name: GoodsArray.sqf
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (07/06/2009)
Description: Contains the entire items array
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/


/*
	GoodsArray
	*Description: The array of all the items in the mission
	* Parameters:
		(0) Item class name (string)
		(1) Parameters: 
			(0) Item buy type (string)
			(1) Item misc type (string)
		(2) Parameters:
			(0) Item name (string)
			(1) Item description (string)
		(3) Parameters:
			(0) Purchase price (number)
			(1) Sell price (number)
		(4) Weight (number)
		(5) Script name it executes on use (string)
		(6) Parameters: (Array of required licenses)
			(0) Player type such as "civ" etc (string)
			(1) License class (string)
		(7) Parameters: (other values)
			(0) If is vehicle then its trunk weight (number)
			(1) If vehicle then its a special action for vehicle menu (array)
			(2) If vehicle then its gas tank capacity (number)
			(3) If vehicle then the fuel type it runs on (integer)
			(4) If vehicle than siren values:
				(0) Has siren by default (bool)
				(1) Siren type name (string)
				(2) Siren parameters:
					(0) Light effects (array)
					(1) Sound effects (array)
		(8) Is Illegal (boolean)
		(9) Is Droppable (boolean)
		(10) Drops on death (boolean)
		(11) Parameters: (Array of required materials to manufacture)
			(0) Item Class (string) 
			(1) Item Amount (integer)
*/
GoodsArray = 
[
	/* Items */
	["TEST", ["ITEM", "FOOD"], [localize "STRS_ITEM_TEST", localize "STRS_ITEM_DESC_TEST"], [6,2], 0.1, "client\ItemUses\TestObject.sqf", [], [], false, false, true, []],
	["Money", ["ITEM", "SPECIAL"], [localize "STRS_ITEM_MONEY", localize "STRS_ITEM_DESC_MONEY"], [1,1], 0, "", [], [], false, true, true, []],
	["Wallet", ["ITEM", "SPECIAL"], [localize "STRS_ITEM_WALLET", localize "STRS_ITEM_DESC_WALLET"], [0, 0], 0, "client\ItemUses\wallet.sqf",  [], [], false, false, false, []],
	["keychain", ["ITEM", "SPECIAL"], [localize "STRS_ITEM_KEYCHAIN", localize "STRS_ITEM_DESC_KEYCHAIN"], [0,0], 0, "client\ItemUses\keyChain.sqf", [], [], false, false, false, []],
	["IllegalMoney", ["ITEM", "RESOURCE"], ["Illegal Money", localize "STRS_item_desc_noDesc"], [1,1], 0, "", [], [], true, true, true, []],	
	["pistol", ["ITEM", "SPECIAL"], ["Pistol", localize "STRS_item_desc_noDesc"], [0, 0], 0, "slr\holster.sqf", [], [0.1, []], false, false, false, []],
	["mobilephone", ["ITEM", "MOBILE"], ["Mobile Phone", localize "STRS_item_desc_noDesc"], [0,0], 1.5, "client\ItemUses\useItem.sqf", [], [], false, true, true, [["iron_bar", 1]]],
	["radio", ["ITEM", "TOOL"], ["Radio", localize "STRS_item_desc_noDesc"], [0,0], 1.0, "client\ItemUses\radio.sqf", [], [], false, true, true, [ ["iron_bar", 1] ]],
	
	/* Tools */
	["shovel", ["ITEM", "TOOL"], ["Shovel", localize "STRS_item_desc_noDesc"], [50,10], 2.0, "", [], [], false, true, true, [ ["iron_bar", 1], ["woodShaft", 1] ]],
	["hatchet",  ["ITEM", "TOOL"], ["Hatchet", localize "STRS_item_desc_noDesc"], [50,10], 2.0, "", [], [], false, true, true, [ ["iron_bar", 1], ["woodShaft", 1] ]],
	["Pickaxe_stone", ["ITEM", "TOOL"], ["Pickaxe (Stone)", localize "STRS_item_desc_noDesc"], [50,10], 2.0, "", [], [], false, true, true, [ ["Stone", 1], ["woodShaft", 1] ]],
	["Pickaxe_iron", ["ITEM", "TOOL"], ["Pickaxe (Iron)", localize "STRS_item_desc_noDesc"], [50,10], 2.0, "", [], [], false, true, true, [ ["iron_bar", 1], ["woodShaft", 1] ]],
	["Pickaxe_steel", ["ITEM", "TOOL"], ["Pickaxe (Steel)", localize "STRS_item_desc_noDesc"], [50,10], 2.0, "", [], [], false, true, true, [ ["steel_bar", 1], ["woodShaft", 1]]],
	["Barrel", ["ITEM", "TOOL"], ["Barrel", localize "STRS_item_desc_noDesc"], [0,0], 7, "client\ItemUses\useItem.sqf", [], [], false, true, true, [ ["iron_bar", 1] ]], 
	["Fishing_rod", ["ITEM", "TOOL"], ["Fishing rod", localize "STRS_item_desc_noDesc"], [50,0], 2, "", [], [], false, true, true, [ ["woodShaft", 1] ]], 
	["ClayPot", ["ITEM", "TOOL"], ["Clay Pot", localize "STRS_item_desc_noDesc"], [50,0], 1, "", [], [], false, true, true, [ ["clay", 1] ]], 
	["CisternFuelCan", ["ITEM", "TOOL"], ["Cistern Fuel Barrel", localize "STRS_item_desc_noDesc"], [0,0], 7, "client\ItemUses\CisternFuel.sqf", [], [], false, true, true, [ ["Petroleum", 10] ]], 
	["RepairKit", ["ITEM", "TOOL"], ["Repair Kit", localize "STRS_item_desc_noDesc"], [0,0], 5, "client\ItemUses\repairKit.sqf", [], [], false, true, true, [ ["iron_bar", 1], ["glass", 1], ["Copper_bar", 1] ]], 
	["Spare_Wheel", ["ITEM", "TOOL"], ["Spare Wheel", localize "STRS_item_desc_noDesc"], [0,0], 12, "client\ItemUses\spareWheel.sqf", [], [], false, true, true, [ ["Copper_bar", 3] ]], 	
	["RefuelCan", ["ITEM", "TOOL"], ["Refuel Can", localize "STRS_item_desc_noDesc"], [0,0], 5, "client\ItemUses\refuelCan.sqf", [], [], false, true, true, [ ["iron_bar", 1], ["Petroleum", 6] ]], 
	["Lockpick", ["ITEM", "TOOL"], ["Lockpick", localize "STRS_item_desc_noDesc"], [0,0], 1, "client\ItemUses\lockpick.sqf", [], [], false, true, true, [ ["steel_bar", 2] ]], 
	["Crowbar", ["ITEM", "TOOL"], ["Crowbar", localize "STRS_item_desc_noDesc"], [0,0], 1, "client\ItemUses\crowbar.sqf", [], [], false, true, true, [ ["steel_bar", 2] ]], 
	["ButcheringKnife", ["ITEM", "TOOL"], ["Butchering Knife", localize "STRS_item_desc_noDesc"], [50,25], 1, "", [], [], false, true, true, [ ["iron_bar", 1] ]], 

	["Fishing_net", ["ITEM", "TOOL"], ["Trawler net", localize "STRS_item_desc_noDesc"], [0,0], 4, "", [], [], false, true, true, [ ["log", 2], ["iron_bar", 2]  ]], 
	["Harpoon", ["ITEM", "TOOL"], ["Harpoon", localize "STRS_item_desc_noDesc"], [0,0], 4, "", [], [], false, true, true, [ ["steel_bar", 2] ]], 
	
	/* Butchery */
	["Raw_Beef", ["ITEM", "RESOURCE"], ["Raw Beef", localize "STRS_item_desc_noDesc"], [0,100], 1, "", [], [], false, true, true, []],
	["Raw_Goat", ["ITEM", "RESOURCE"], ["Raw Goat Meat", localize "STRS_item_desc_noDesc"], [0,50], 1, "", [], [], false, true, true, []],
	["Raw_Boar", ["ITEM", "RESOURCE"], ["Raw Boar Meat", localize "STRS_item_desc_noDesc"], [0,175], 1, "", [], [], false, true, true, []],	
	
	/* Water */
	["ClayPotW", ["ITEM", "TOOL"], ["Clay Pot (Water)", localize "STRS_item_desc_noDesc"], [0,0], 1, "client\ItemUses\drink.sqf", [], [], false, true, true, [ [ ]]], 
	["ClayPotM", ["ITEM", "TOOL"], ["Clay Pot (Milk)", localize "STRS_item_desc_noDesc"], [0,0], 1, "client\ItemUses\drink.sqf", [], [], false, true, true, [ [ ]]], 
	
	/* Baits */
	
	//Bluegill
	["Worm", ["ITEM", "TOOL"], ["Worm", localize "STRS_item_desc_noDesc"], [0,0], 0.1, "", [], [], false, true, true, [ ]], 
	
	//Catfish, Trout
	["Nightcrawler", ["ITEM", "TOOL"], ["Night crawler", localize "STRS_item_desc_noDesc"], [0,0], 0.1, "", [], [], false, true, true, [ ]], 
	
	//Perch, Rockbass
	["Minnow", ["ITEM", "TOOL"], ["Minnow", localize "STRS_item_desc_noDesc"], [0,0], 0.25, "client\ItemUses\eat.sqf", [], [], false, true, true, [ ]], 
	
	/* Fish */
	["Bluegill", ["ITEM", "FOOD"], ["Bluegill", localize "STRS_item_desc_noDesc"], [0,25], 1, "client\ItemUses\eat.sqf", [], [], false, true, true, [ ]], 
	["Catfish", ["ITEM", "FOOD"], ["Catfish", localize "STRS_item_desc_noDesc"], [0,40], 5, "client\ItemUses\eat.sqf", [], [], false, true, true, [ ]], 
	["Perch", ["ITEM", "FOOD"], ["Perch", localize "STRS_item_desc_noDesc"], [0,25], 3, "client\ItemUses\eat.sqf", [], [], false, true, true, [ ]], 
	["Trout", ["ITEM", "FOOD"], ["Trout", localize "STRS_item_desc_noDesc"], [0,30], 4, "client\ItemUses\eat.sqf", [], [], false, true, true, [ ]], 
	["RockBass", ["ITEM", "FOOD"], ["Rock Bass", localize "STRS_item_desc_noDesc"], [0,35], 7, "client\ItemUses\eat.sqf", [], [], false, true, true, [ ]], 
	
	/* Sea Fish */
	
	/* Fishing Net */
	["Sardine", ["ITEM", "FOOD"], ["Sardine", localize "STRS_item_desc_noDesc"], [0,5], 0.1, "client\ItemUses\eat.sqf", [], [], false, true, true, [ ]], 
	["Monkfish", ["ITEM", "FOOD"], ["Monkfish", localize "STRS_item_desc_noDesc"], [0,15], 10, "client\ItemUses\eat.sqf", [], [], false, true, true, [ ]], 
	["Salmon", ["ITEM", "FOOD"], ["Salmon", localize "STRS_item_desc_noDesc"], [0,50], 2, "client\ItemUses\eat.sqf", [], [], false, true, true, [ ]], 
	
	/* Harpoon */
	["Shark", ["ITEM", "FOOD"], ["Shark", localize "STRS_item_desc_noDesc"], [0,150], 60, "client\ItemUses\eat.sqf", [], [], false, true, true, [ ]], 
	["Tuna", ["ITEM", "FOOD"], ["Tuna", localize "STRS_item_desc_noDesc"], [0,165], 3, "client\ItemUses\eat.sqf", [], [], false, true, true, [ ]], 
	["Whale", ["ITEM", "FOOD"], ["Whale", localize "STRS_item_desc_noDesc"], [0,350], 200, "client\ItemUses\eat.sqf", [], [], false, true, true, [ ]], 
	["Swordfish", ["ITEM", "FOOD"], ["Swordfish", localize "STRS_item_desc_noDesc"], [0,300], 7, "client\ItemUses\eat.sqf", [], [], false, true, true, [ ]], 
	
	/* Natural Resources */
	["Stone", ["ITEM", "RESOURCE"], ["Stone", localize "STRS_item_desc_noDesc"], [6,45], 3, "", [], [], false, true, true, []],
	["Sand", ["ITEM", "RESOURCE"], ["Sand", localize "STRS_item_desc_noDesc"], [6,25], 1, "", [], [], false, true, true, []],
	["Clay", ["ITEM", "RESOURCE"], ["Clay", localize "STRS_item_desc_noDesc"], [6,50], 1, "", [], [], false, true, true, []],
	["Log", ["ITEM", "RESOURCE"], ["Log", localize "STRS_item_desc_noDesc"], [6,50], 5, "", [], [], false, true, true, []],
	["Coal", ["ITEM", "RESOURCE"], ["Coal", localize "STRS_item_desc_noDesc"], [6,50], 2, "", [], [], false, true, true, [ ["log", 1] ]],
	["Rubber", ["ITEM", "RESOURCE"], ["Rubber", localize "STRS_item_desc_noDesc"], [6,100], 2, "", [], [], false, true, true, []],
	["Iron_ore", ["ITEM", "RESOURCE"], ["Iron Ore", localize "STRS_item_desc_noDesc"], [6,80], 4, "", [], [], false, true, true, []],
	["Copper_ore", ["ITEM", "RESOURCE"], ["Copper Ore", localize "STRS_item_desc_noDesc"], [6,55], 4, "", [], [], false, true, true, []],
	["Tin_ore", ["ITEM", "RESOURCE"], ["Tin Lump", localize "STRS_item_desc_noDesc"], [6,65], 4, "", [], [], false, true, true, []],
	["Lead_ore", ["ITEM", "RESOURCE"], ["Lead Lump", localize "STRS_item_desc_noDesc"], [6,65], 4, "", [], [], false, true, true, []],
	["Gold_ore", ["ITEM", "RESOURCE"], ["Gold Ore", localize "STRS_item_desc_noDesc"], [6,150], 4, "", [], [], false, true, true, []],
	["Silicon", ["ITEM", "RESOURCE"], ["Silicon", localize "STRS_item_desc_noDesc"], [6,45], 3, "", [], [], false, true, true, []],
	["Sulphur", ["ITEM", "RESOURCE"], ["Sulphur", localize "STRS_item_desc_noDesc"], [6,45], 3, "", [], [], false, true, true, []],
	["Petroleum", ["ITEM", "RESOURCE"], ["Petroleum", localize "STRS_item_desc_noDesc"], [6,100], 5, "", [], [], false, true, true, []],
	
	/* Manufactured Resources */
	["Iron_bar", ["ITEM", "RESOURCE"], ["Iron Bar", localize "STRS_item_desc_noDesc"], [6,150], 6, "", [], [], false, true, true, [ ["iron_ore", 2] ]],
	["Copper_bar", ["ITEM", "RESOURCE"], ["Copper Bar", localize "STRS_item_desc_noDesc"], [6,85], 6, "", [], [], false, true, true, [ ["copper_ore", 2] ]],
	["Tin_bar", ["ITEM", "RESOURCE"], ["Tin Bar", localize "STRS_item_desc_noDesc"], [6,100], 6, "", [], [], false, true, true, [ ["tin_ore", 2] ]],
	["Lead_bar", ["ITEM", "RESOURCE"], ["Lead Bar", localize "STRS_item_desc_noDesc"], [6,125], 6, "", [], [], false, true, true, [ ["lead_ore", 2] ]],
	["Gold_bar", ["ITEM", "RESOURCE"], ["Gold Bar", localize "STRS_item_desc_noDesc"], [6,500], 6, "", [], [], false, true, true, [ ["gold_ore", 2] ]],
	["Steel_bar", ["ITEM", "RESOURCE"], ["Steel Bar", localize "STRS_item_desc_noDesc"], [6,450], 6, "", [], [], false, true, true, [ ["iron_ore", 2], ["coal", 2] ]],
	["Glass", ["ITEM", "RESOURCE"], ["Glass", localize "STRS_item_desc_noDesc"], [6,95], 5, "", [], [], false, true, true, [ ["Sand",5] ]],
	["Brick", ["ITEM", "RESOURCE"], ["Brick", localize "STRS_item_desc_noDesc"], [6,50], 3, "", [], [], false, true, true, [  ["Clay",3] ]],
	["ElectronicComponents", ["ITEM", "RESOURCE"], ["Electronic Components", localize "STRS_item_desc_noDesc"], [6,100], 3, "", [], [], false, true, true, [  ["silicon", 1], ["copper_bar", 1] ]],
	["Plastic", ["ITEM", "RESOURCE"], ["Copper_bar", localize "STRS_item_desc_noDesc"], [6,150], 3, "", [], [], false, true, true, [  ["log", 1], ["sand", 1] ]],
	["BlackPowder", ["ITEM", "RESOURCE"], ["Black Powder", localize "STRS_item_desc_noDesc"], [6,100], 3, "", [], [], false, true, true, [ ["coal", 1], ["Sulphur", 1]]],
	["SteelWool", ["ITEM", "RESOURCE"], ["Steel Wool", localize "STRS_item_desc_noDesc"], [6,125], 3, "", [], [], false, true, true, [ ["steel_bar", 1] ]],
	["WoodShaft", ["ITEM", "RESOURCE"], ["Wooden Shaft", localize "STRS_item_desc_noDesc"], [6,75], 3, "", [], [], false, true, true, [ ["log", 1] ]],
	["WoodPlank", ["ITEM", "RESOURCE"], ["Wooden Plank", localize "STRS_item_desc_noDesc"], [6,95], 3, "", [], [], false, true, true, [  ["log", 2] ]],
	["MineralOil", ["ITEM", "RESOURCE"], ["Mineral Oil", localize "STRS_item_desc_noDesc"], [6,100], 2, "", [], [], false, true, true, [  ["Log",2] ]],
	
	/* Seeds */
	["mari_seed", ["ITEM", "SPROUT"], ["Marihuana Seed", localize "STRS_item_desc_noDesc"], [0,0], 0.1, "client\ItemUses\useItem.sqf", [], [], true, true, true, []],
	["ficus_seed", ["ITEM", "SPROUT"], ["Ficus Sapling", localize "STRS_item_desc_noDesc"], [0,0], 0.1, "client\ItemUses\useItem.sqf", [], [], false, true, true, []],
	
	/* Containers */
	["FORT_CRATE_WOOD", ["VEHICLE", "CONTAINER"], ["Crate", localize "STRS_item_desc_noDesc"], [280, 110], 10.0, "", [], [60, [], 36, false], false, true, true, [ ["WoodPlank", 5] ]],
	["Suitcase", ["VEHICLE", "STORAGE"], ["Items", localize "STRS_item_desc_noDesc"], [280, 110], 10.0, "", [], [60, [], 36, false], false, true, true, [  ]],
	
	/* Drugs */
	["mari", ["ITEM", "DRUG"], ["Marihuana", localize "STRS_item_desc_noDesc"], [500,250], 0.1, "", [], [60, [], 36, false], true, true, true, [ ["maribuds", 1] ]],
	["maribuds", ["ITEM", "RESOURCE"], ["MariBud", localize "STRS_item_desc_noDesc"], [500,0], 0.1, "", [], [60, [], 36, false], true, true, true, [  ]],
	["DrugShed", ["ITEM", "DRUGSHED"], ["Drug Lab", localize "STRS_item_desc_noDesc"], [500,250], 1.0, "client\ItemUses\useItem.sqf", [], [60, [], 36, false], true, true, true, [ ["WoodPlank", 25], ["silicon", 5] ]],
	
	/* Speed Camera */
	["speedcam", ["ITEM", "SPEEDCAM"], ["Speed Camera", localize "STRS_item_desc_noDesc"], [0,0], 1.0, "client\ItemUses\useItem.sqf", [], [], true, true, true, []],
	
	/* Police Radio: Gives access to police chat when in inventory and police menu when using */
	["polradio", ["ITEM", "TOOL"], ["Police Radio", localize "STRS_item_desc_noDesc"], [0,0], 1.0, "client\ItemUses\policeRadio.sqf", [], [], true, true, true, []],

	/* Objects */
	["Obj_StopLight", ["ITEM", "OBJECT"], ["Stop light", localize "STRS_item_desc_noDesc"], [0,0], 2, "client\ItemUses\useItem.sqf", [], [], false, true, true, []],
	["Obj_StoneWall", ["ITEM", "OBJECT"], ["Stone Wall",  localize "STRS_item_desc_noDesc"], [0,0], 2, "client\ItemUses\useItem.sqf", [], [], false, true, true, []],
	
	/* Vehicles */
	["Skoda", ["VEHICLE", "CAR"], ["Skoda (White)", localize "STRS_item_desc_noDesc"], [400, 190], 60, "", [ ["CIV", "b_drivers"] ], [60, [], 36, false], false, true, true, [ ["steel_bar", 3], ["silicon", 1], ["log", 1]   ]], //Skoda
	["SkodaBlue", ["VEHICLE", "CAR"], ["Skoda (Blue)", localize "STRS_item_desc_noDesc"], [400, 190], 60, "", [ ["CIV", "b_drivers"] ], [60, [], 36, false], false, true, true, [ ["steel_bar", 3], ["silicon", 1], ["log", 1] ]], //Skoda Blue
	["SkodaRed", ["VEHICLE", "CAR"], ["Skoda (Red)", localize "STRS_item_desc_noDesc"], [400, 190], 60, "", [ ["CIV", "b_drivers"] ], [60, [], 36, false], false, true, true, [  ["steel_bar", 3], ["silicon", 1], ["log", 1]]], //Skoda Red
	["SkodaGreen", ["VEHICLE", "CAR"], ["Skoda (Green)", localize "STRS_item_desc_noDesc"], [400, 190], 60, "", [ ["CIV", "b_drivers"] ], [60, [], 36, false], false, true, true, [ ["steel_bar", 3], ["silicon", 1], ["log", 1] ]], //Skoda Green
	
	["tractor", ["VEHICLE", "CAR"], ["Tractor", localize "STRS_item_desc_noDesc"], [200, 100], 60, "", [ ["CIV", "b_drivers"] ], [60, [], 36, false], false, true, true, [ ["steel_bar", 5], ["silicon", 1], ["log", 1]]], //Tractor
	["Kamaz", ["VEHICLE", "TRUCK"], ["Kamaz", localize "STRS_item_desc_noDesc"], [6800, 2000], 500, "", [ ["CIV", "c_drivers"] ], [1200, [], 36, false], false, true, true, [ ["steel_bar", 18],["WoodPlank", 10],["silicon", 5],["Sand", 5],["log", 5]]], //Kamaz
	["KamazOpen", ["VEHICLE", "TRUCK"], ["Kamaz (Open)", localize "STRS_item_desc_noDesc"], [6800, 2000], 500, "", [ ["CIV", "c_drivers"] ], [1200, [], 36, false], false, true, true, [ ["steel_bar", 18],["WoodPlank", 10],["silicon", 5],["Sand", 5],["log", 5]]], //Kamaz Open
	["KamazRefuel", ["VEHICLE", "TRUCK"], ["Kamaz (Refuel)", localize "STRS_item_desc_noDesc"], [12800, 2000], 500, "", [ ["CIV", "c_drivers"] ], [10, [], 36, false], false, true, true, [ ["steel_bar", 18],["WoodPlank", 10],["silicon", 5],["Sand", 5],["log", 5]]], //Kamaz Refuel
	
	["UralCivil", ["VEHICLE", "TRUCK"], ["Ural Civil", localize "STRS_item_desc_noDesc"], [6800, 2000], 1000, "", [ ["CIV", "c_drivers"] ], [2000, [], 36, false], false, true, true, [ ["steel_bar", 25],["WoodPlank", 15],["silicon", 10],["Sand", 5],["log", 7]  ]], //Ural Civil
	["UralCivil2", ["VEHICLE", "TRUCK"], ["Ural Civil 2", localize "STRS_item_desc_noDesc"], [6800, 2000], 1000, "", [ ["CIV", "c_drivers"] ], [2000, [], 36, false], false, true, true, [ ["steel_bar", 25],["WoodPlank", 15],["silicon", 10],["Sand", 5],["log", 7] ]], //Ural Civil 2
	["UralOpen_INS", ["VEHICLE", "TRUCK"], ["Ural Camo", localize "STRS_item_desc_noDesc"], [6800, 2000], 1000, "", [ ["CIV", "c_drivers"] ], [2000, [], 36, false], false, true, true, [ ["steel_bar", 25],["WoodPlank", 15],["silicon", 10],["Sand", 5],["log", 7] ]], //Ural Open
	
	["oldtruc2", ["VEHICLE", "TRUCK"], ["Vintage Truck", localize "STRS_item_desc_noDesc"], [6800, 2000], 1000, "", [ ["CIV", "c_drivers"] ], [700, [], 36, false], false, true, true, [ ["steel_bar", 12],["WoodPlank", 10],["silicon", 5],["Sand", 5],["log", 5]  ]], //Ural Civil
	["oldtruck", ["VEHICLE", "CAR"], ["1965 GMC Fleetside", localize "STRS_item_desc_noDesc"], [6800, 2000], 1000, "", [ ["CIV", "b_drivers"] ], [300, [], 36, false], false, true, true, [ ["steel_bar", 12],["WoodPlank", 10],["silicon", 5],["Sand", 5],["log", 5]  ]], //Ural Civil
	["oltruc3", ["VEHICLE", "CAR"], ["1977 Ford F250", localize "STRS_item_desc_noDesc"], [6800, 2000], 1000, "", [ ["CIV", "b_drivers"] ], [350, [], 36, false], false, true, true, [ ["steel_bar", 13],["WoodPlank", 10],["silicon", 5],["Sand", 5],["log", 5]  ]], //Ural Civil
	["240GD", ["VEHICLE", "CAR"], ["Mercedes 240GD", localize "STRS_item_desc_noDesc"], [6800, 2000], 1000, "", [ ["CIV", "b_drivers"] ], [120, [], 36, false], false, true, true, [ ["steel_bar", 8],["silicon", 5],["Sand", 3],["log", 5]  ]], //Ural Civil
	["civic", ["VEHICLE", "CAR"], ["1989 Honda Civic", localize "STRS_item_desc_noDesc"], [800, 240], 60, "", [ ["CIV", "b_drivers"] ], [40, [], 36, false], false, true, true, [ ["steel_bar", 3], ["silicon", 1], ["log", 1] ]], //Honda Civic
	["cooter", ["VEHICLE", "CAR"], ["Tow Truck", localize "STRS_item_desc_noDesc"], [6800, 2000], 1000, "", [ ["CIV", "b_drivers"] ], [50, [], 36, false], false, true, true, [ ["steel_bar", 15],["WoodPlank", 10],["Sand", 5],["log", 3]  ]], //Tow truck

	["MTVR", ["VEHICLE", "TRUCK"], ["MTVR", localize "STRS_item_desc_noDesc"], [6800, 2000], 250, "", [ ["CIV", "c_drivers"] ], [850, [], 36, false], false, true, true, [ ["steel_bar", 18],["WoodPlank", 30],["silicon", 6],["Sand", 5],["log", 5] ]], //MTVR
	["MtvrRefuel", ["VEHICLE", "TRUCK"], ["MTVR Refuel", localize "STRS_item_desc_noDesc"], [6800, 2000], 250, "", [ ["CIV", "c_drivers"] ], [10, [], 36, false], false, true, true, [ ["steel_bar", 18],["WoodPlank", 30],["silicon", 6],["Sand", 5],["log", 5] ]], //MTVR Refuel
	
	["V3S_Refuel_TK_GUE_EP1", ["VEHICLE", "TRUCK"], ["V3S (Refuel)", localize "STRS_item_desc_noDesc"], [2500, 1000], 500, "", [ ["CIV", "c_drivers"] ], [100, [], 36, false], false, true, true, [ ]], //V3S Refuel
	["V3S_Salvage_TK_GUE_EP1", ["VEHICLE", "TRUCK"], ["V3S", localize "STRS_item_desc_noDesc"], [2500, 1000], 500, "", [ ["CIV", "c_drivers"] ], [100, [], 36, false], false, true, true, [ ]], //V3S
	
	["datsun1_civil_1_open", ["VEHICLE", "CAR"], ["Datsun Open (Blue)", localize "STRS_item_desc_noDesc"], [800, 190], 80, "", [ ["CIV", "b_drivers"] ], [120, [], 36, false], false, true, true, [ ["steel_bar", 7],["silicon", 5],["log", 1] ]], //Datsun Civil 1
	["datsun1_civil_2_covered", ["VEHICLE", "CAR"], ["Datsun Covered", localize "STRS_item_desc_noDesc"], [800, 190], 80, "", [ ["CIV", "b_drivers"] ], [120, [], 36, false], false, true, true, [  ["steel_bar", 7],["silicon", 5],["log", 1] ]], //Datsun Civil 2
	["datsun1_civil_3_open", ["VEHICLE", "CAR"], ["Datsun Tubeframe", localize "STRS_item_desc_noDesc"], [800, 190], 80, "", [ ["CIV", "b_drivers"] ], [120, [], 36, false], false, true, true, [ ["steel_bar", 7],["silicon", 5],["log", 1] ]], //Datsun Civil 3
	
	["hilux1_civil_1_open", ["VEHICLE", "CAR"], ["Hilux Open (Gold)", localize "STRS_item_desc_noDesc"], [800, 190], 80, "", [ ["CIV", "b_drivers"] ], [150, [], 36, false], false, true, true, [  ["steel_bar", 11],["silicon", 7],["log", 2]]], //Hilux Gold
	["hilux1_civil_2_covered", ["VEHICLE", "CAR"], ["Hilux Covered (Red)", localize "STRS_item_desc_noDesc"], [800, 190], 80, "", [ ["CIV", "b_drivers"] ], [150, [], 36, false], false, true, true, [ ["steel_bar", 11],["silicon", 7],["log", 2]]], //Hilux Red
	["hilux1_civil_3_open", ["VEHICLE", "CAR"], ["Hilux Open (White)", localize "STRS_item_desc_noDesc"], [800, 190], 80, "", [ ["CIV", "b_drivers"] ], [150, [], 36, false], false, true, true, [ ["steel_bar", 11],["silicon", 7],["log", 2]]], //Hilux White
	
	["LandRover_CZ_EP1", ["VEHICLE", "CAR"], ["Landrover", localize "STRS_item_desc_noDesc"], [800, 190], 150, "", [ ["CIV", "b_drivers"] ], [220, [], 36, false], false, true, true, [ ["steel_bar", 10],["silicon", 7],["Sand", 3],["log", 3] ]], //Landrover
	["LandRover_TK_CIV_EP1", ["VEHICLE", "CAR"], ["Landrover (Red)", localize "STRS_item_desc_noDesc"], [800, 190], 150, "", [ ["CIV", "b_drivers"] ], [220, [], 36, false], false, true, true, [["steel_bar", 10],["silicon", 7],["Sand", 3],["log", 3] ]], //Landrover Red
	
	["S1203_TK_CIV_EP1", ["VEHICLE", "CAR"], ["Skoda 1203", localize "STRS_item_desc_noDesc"], [800, 190], 150, "", [ ["CIV", "b_drivers"] ], [170, [], 36, false], false, true, true, [ ["steel_bar", 4],["silicon", 3],["log", 3] ]], //Skoda 1203
	["S1203_ambulance_EP1", ["VEHICLE", "CAR"], ["Skoda 1203 (Ambulance)", localize "STRS_item_desc_noDesc"], [800, 190], 150, "", [ ["CIV", "b_drivers"] ], [170, [], 36, false], false, true, true, [ ["steel_bar", 4],["silicon", 3],["log", 3] ]], //Skoda 1203
	["SUV_TK_CIV_EP1", ["VEHICLE", "CAR"], ["SUV (Black)", localize "STRS_item_desc_noDesc"], [800, 190], 150, "", [ ["CIV", "b_drivers"] ], [150, [], 36, false], false, true, true, [ ["steel_bar", 20],["silicon", 7],["Sand", 15],["log", 10] ]], //SUV Black
	
	["VWGolf", ["VEHICLE", "CAR"], ["VW Golf", localize "STRS_item_desc_noDesc"], [1200, 600], 60, "", [ ["CIV", "b_drivers"] ], [60, [], 36, false], false, true, true, [ ["steel_bar", 6],["silicon", 15],["Sand", 10],["log", 10] ]], //VW Golf
	
	["car_hatchback", ["VEHICLE", "CAR"], ["Hatchback", localize "STRS_item_desc_noDesc"], [600, 124], 60, "", [ ["CIV", "b_drivers"] ], [60, [], 36, false], false, true, true, [ ["steel_bar", 3], ["silicon", 1], ["log", 1]  ]], //Hatchback
	["car_sedan", ["VEHICLE", "CAR"], ["Sedan", localize "STRS_item_desc_noDesc"], [500, 200], 60, "", [ ["CIV", "b_drivers"] ], [60, [], 36, false], false, true, true, [ ["steel_bar", 3], ["silicon", 1], ["log", 1]  ]], //Sedan
	
	["LadaLM", ["VEHICLE", "CAR"], [localize "STRS_vcl_vazPolice", localize "STRS_item_desc_noDesc"], [800, 240], 60, "", [ ["CIV", "b_drivers"] ], [60, [], 39, 0, [true, "singleBlue", [[[0, 0.1, 0.3], [0, 0, 1], 0.04], [] ]]], false, true, true, [ ["steel_bar", 3], ["silicon", 1], ["log", 1] ]], //Lada Police
	["Lada1", ["VEHICLE", "CAR"], ["Lada (White)", localize "STRS_item_desc_noDesc"], [800, 240], 60, "", [ ["CIV", "b_drivers"] ], [60, [], 36, false], false, true, true, [ ["steel_bar", 3], ["silicon", 1], ["log", 1] ]], //Lada white
	["Lada2", ["VEHICLE", "CAR"], ["Lada (Red)", localize "STRS_item_desc_noDesc"], [800, 240], 60, "", [ ["CIV", "b_drivers"] ], [60, [], 36, false], false, true, true, [ ["steel_bar", 3], ["silicon", 1], ["log", 1] ]], //Lada red
	["Lada1_TK_CIV_EP1", ["VEHICLE", "CAR"], ["Old Lada (Green)", localize "STRS_item_desc_noDesc"], [300, 240], 60, "", [ ["CIV", "b_drivers"] ], [35, [], 36, false], false, true, true, [ ["steel_bar", 3], ["silicon", 1], ["log", 1] ]], //Old Lada Green
	["Lada2_TK_CIV_EP1", ["VEHICLE", "CAR"], ["Old Lada (Decorated)", localize "STRS_item_desc_noDesc"], [300, 240], 60, "", [ ["CIV", "b_drivers"] ], [35, [], 36, false], false, true, true, [ ["steel_bar", 3], ["silicon", 1], ["log", 1] ]], //Old Gypsy Green
	
	["Volha_1_TK_CIV_EP1", ["VEHICLE", "CAR"], ["Old Car (Blue)", localize "STRS_item_desc_noDesc"], [300, 240], 40, "", [ ["CIV", "b_drivers"] ], [35, [], 36, false], false, true, true, [["steel_bar", 3], ["silicon", 1], ["log", 1] ]], //Old Car Blue
	["Volha_2_TK_CIV_EP1", ["VEHICLE", "CAR"], ["Old Car (White)", localize "STRS_item_desc_noDesc"], [300, 240], 40, "", [ ["CIV", "b_drivers"] ], [35, [], 36, false], false, true, true, [ ["steel_bar", 3], ["silicon", 1], ["log", 1]]], //Old Car White
	["VolhaLimo_TK_CIV_EP1", ["VEHICLE", "CAR"], ["Limo (Black)", localize "STRS_item_desc_noDesc"], [300, 240], 40, "", [ ["CIV", "b_drivers"] ], [35, [], 36, false], false, true, true, [ ["steel_bar", 3], ["silicon", 1], ["log", 1]]], //Old Car Black
	
	["Bus", ["VEHICLE", "CAR"], ["Bus", localize "STRS_item_desc_noDesc"], [1400, 450], 120, "", [ ["CIV", "d_drivers"] ], [75,[],36,false], false, true, true, [ ["steel_bar", 20],["WoodPlank", 15],["silicon", 3],["Sand", 5],["log", 2] ]], //Bus
	
	["MMT_Civ", ["VEHICLE", "BIKE"], ["Mountain bike", localize "STRS_item_desc_noDesc"], [50, 10], 5, "", [ ], [5, []], false, true, true, []], //Mountain Bike
	["Old_bike_TK_CIV_EP1", ["VEHICLE", "BIKE"], ["Old bike", localize "STRS_item_desc_noDesc"], [0, 0], 5, "", [ ], [5, []], false, true, true, []], //Crappy Bike
	["Old_moto_TK_Civ_EP1", ["VEHICLE", "BIKE"], ["Old motorbike", localize "STRS_item_desc_noDesc"], [150, 75], 10, "", [ ["CIV", "a_drivers"] ], [10, []], false, true, true, [["steel_bar", 3], ["silicon", 1]]], //Crappy MotorBike
	
	["M1030", ["VEHICLE", "BIKE"], ["M1030", localize "STRS_item_desc_noDesc"], [150, 30], 10, "", [ ["CIV", "a_drivers"] ], [10,[],36,false], false, true, true, [  ["steel_bar", 3], ["silicon", 1]]], //M1030
	["TT650_Civ", ["VEHICLE", "BIKE"], ["TT650", localize "STRS_item_desc_noDesc"], [150, 30], 10, "", [ ["CIV", "a_drivers"] ], [10,[],36,false], false, true, true, [ ["steel_bar", 3], ["silicon", 1]]], //TT650
	["TT650_Gue", ["VEHICLE", "BIKE"], ["TT650 (Pattern)", localize "STRS_item_desc_noDesc"], [150, 30], 10, "", [ ["CIV", "a_drivers"] ], [10,[],36,false], false, true, true, [["steel_bar", 3], ["silicon", 1]]], //TT650 Flame
	["TT650_TK_CIV_EP1", ["VEHICLE", "BIKE"], ["TT650 (Rusty)", localize "STRS_item_desc_noDesc"], [150, 30], 10, "", [ ["CIV", "a_drivers"] ], [10,[],36,false], false, true, true, [["steel_bar", 3], ["silicon", 1]]], //TT650 Rusty
	["ATV_US_EP1", ["VEHICLE", "BIKE"], ["ATV", localize "STRS_item_desc_noDesc"], [150, 30], 30, "", [ ["CIV", "a_drivers"] ], [10,[],36,false], false, true, true, [["steel_bar", 3], ["silicon", 1]]], //ATV

	["sahco", ["VEHICLE", "CAR"], ["Police Cruiser", localize "STRS_item_desc_noDesc"], [8000, 2400], 100, "", [ ["CIV", "b_drivers"] ], [60, [], 39, 0, [true, "singleBlue", [[[0, 0.1, 0.3], [0, 0, 1], 0.04], [] ]]], false, true, true, [ ["steel_bar", 8], ["silicon", 4], ["log", 3] ]], //Sahco

	/* Boats */
	["Fishing_Boat", ["VEHICLE", "CAR"], ["Fishing Boat", localize "STRS_item_desc_noDesc"], [3000, 900], 650, "", [ ["CIV", "fishing_license"], ["CIV", "boat_license"] ], [650,[],36,false], false, true, true, [["steel_bar", 10],["WoodPlank", 15],["silicon", 3],["Sand", 5],["log", 2]]], //Fishing Boat
	["Smallboat_1", ["VEHICLE", "CAR"], ["Small boat 1", localize "STRS_item_desc_noDesc"], [1500, 900], 125, "", [ ["CIV", "boat_license"] ], [125,[],36,false], false, true, true, [["steel_bar", 10],["WoodPlank", 15],["silicon", 3],["Sand", 5],["log", 2]]], //Small boat 1
	["Smallboat_2", ["VEHICLE", "CAR"], ["Small boat 2", localize "STRS_item_desc_noDesc"], [1500, 900], 125, "", [ ["CIV", "boat_license"] ], [125,[],36,false], false, true, true, [["steel_bar", 10],["WoodPlank", 15],["silicon", 3],["Sand", 5],["log", 2]]], //Small boat 2
	["RHIB2Turret", ["VEHICLE", "CAR"], ["RHIB2 Turret", localize "STRS_item_desc_noDesc"], [3000, 900], 350, "", [  ], [350,[],36,false], false, true, true, [["steel_bar", 5],["silicon", 3],["Sand", 5],["log", 2]]], //RHIB2 
	["SeaFox", ["VEHICLE", "CAR"], ["Storage Boat", localize "STRS_item_desc_noDesc"], [3000, 900], 800, "", [ ["CIV", "boat_license"] ], [800,[],36,false], false, true, true, [["steel_bar", 15],["WoodPlank", 30],["silicon", 12],["Sand", 15],["log", 8]]], //SeaFox
	
	/* Air vehicles */
	["An2_1_TK_CIV_EP1", ["VEHICLE", "AIR"], ["Antonov An-2 (Red)", localize "STRS_item_desc_noDesc"], [300, 240], 500, "", [ ["CIV", "plane_private_license"] ], [100, [], 36, false], false, true, true, [ ["steel_bar", 50], ["iron_bar", 50], ["silicon", 25], ["Sand", 25], ["Copper_bar", 50], ["log", 50]]], //Antonov An-2 (Red)
	["An2_2_TK_CIV_EP1", ["VEHICLE", "AIR"], ["Antonov An-2 (Green)", localize "STRS_item_desc_noDesc"], [300, 240], 500, "", [ ["CIV", "plane_private_license"] ], [100, [], 36, false], false, true, true, [ ["steel_bar", 50], ["iron_bar", 50], ["silicon", 25], ["Sand", 25], ["Copper_bar", 50], ["log", 50]]], //Antonov An-2 (Green)
	["An2_TK_EP1", ["VEHICLE", "AIR"], ["Antonov An-2 (Green 2)", localize "STRS_item_desc_noDesc"], [300, 240], 500, "", [ ["CIV", "plane_private_license"] ], [100, [], 36, false], false, true, true, [ ["steel_bar", 50], ["iron_bar", 50], ["silicon", 50], ["Sand", 25], ["Copper_bar", 50], ["log", 50]]], //Antonov An-2 (Green 2)
	["USEC_Maule_M7_STD", ["VEHICLE", "AIR"], ["Maule M7", localize "STRS_item_desc_noDesc"], [300, 240], 100, "", [ ["CIV", "plane_private_license"] ], [100, [], 36, false], false, true, true, [ ["steel_bar", 25], ["silicon", 10], ["Sand", 20], ["Copper_bar", 20], ["log", 15]]], //Antonov An-2 (Green 2)
	["C130J_US_EP1", ["VEHICLE", "AIR"], ["C-130J", localize "STRS_item_desc_noDesc"], [300, 240], 2000, "", [ ["CIV", "plane_comm_license"] ], [33000, [], 36, false], false, true, true, [ ["steel_bar", 300], ["iron_bar", 300], ["silicon", 150], ["Sand", 75], ["Copper_bar", 150], ["log", 150]]], //C130J
	["MV22", ["VEHICLE", "AIR"], ["MV22", localize "STRS_item_desc_noDesc"], [300, 240], 2000, "", [ ["CIV", "plane_comm_license"] ], [7000, [], 36, false], false, true, true, [ ["steel_bar", 300], ["iron_bar", 300], ["silicon", 150], ["Sand", 75], ["Copper_bar", 150], ["log", 300]]], //MV22
	["UH60M_MEV_EP1", ["VEHICLE", "AIR"], ["UH-60M", localize "STRS_item_desc_noDesc"], [300, 240], 1500, "", [ ["CIV", "plane_private_license"] ], [200, [], 36, false], false, true, true, [ ["steel_bar", 100], ["iron_bar", 100], ["silicon", 50], ["Sand", 25], ["Copper_bar", 50], ["log", 100]]], //UH60
	["MH6J_EP1", ["VEHICLE", "AIR"], ["MH6J", localize "STRS_item_desc_noDesc"], [300, 240], 200, "", [ ["CIV", "plane_private_license"] ], [100, [], 36, false], false, true, true, [ ["steel_bar", 40], ["iron_bar", 40], ["silicon", 25], ["Sand", 15], ["Copper_bar", 25], ["log", 25]]], //MH6
	["AH6X_EP1", ["VEHICLE", "AIR"], ["AH6X", localize "STRS_item_desc_noDesc"], [300, 240], 200, "", [ ["CIV", "plane_private_license"] ], [100, [], 36, false], false, true, true, [ ["steel_bar", 75], ["iron_bar", 75], ["silicon", 25], ["Sand", 15], ["Copper_bar", 25], ["log", 30]]], //AH6
	["Mi17_Civilian", ["VEHICLE", "AIR"], ["Mi17", localize "STRS_item_desc_noDesc"], [300, 240], 1500, "", [ ["CIV", "plane_private_license"] ], [750, [], 36, false], false, true, true, [ ["steel_bar", 50], ["iron_bar", 50], ["silicon", 50], ["Sand", 15], ["Copper_bar", 40], ["log", 30]]], //Mi17
	["Pchela1T", ["VEHICLE", "AIR"], ["Pchela-1T", localize "STRS_item_desc_noDesc"], [300, 240], 100, "", [ ["CIV", "plane_private_license"] ], [5, [], 36, false], false, true, true, [ ["steel_bar", 25], ["iron_bar", 25], ["silicon", 15], ["Sand", 2], ["Copper_bar", 15], ["log", 25]]], //Pchela-1T

	/* Weapons */
	
	/* Pistols */ 
	
	/* M9 */ //15Rnd_9x19_M9
	["RH_M9", ["WEAPON", "PISTOL"], ["Beretta 92 FS 9mm", localize "STRS_item_desc_noDesc"], [700, 600], 1, "", [ ["CIV", "PISTOL"] ], [], true, true, true, [ ["steel_bar", 2], ["Copper_bar", 1] ]],
	["15Rnd_9x19_M9", ["MAGAZINE", "PISTOL"], ["15Rnd 9mm M9/92FS Mag", localize "STRS_item_desc_noDesc"], [120, 50], 0.1, "", [], [], true, true, true, [ ["copper_bar", 2], ["Sulphur", 1] ]],
	
	/* Colt1911 */ //7Rnd_45ACP_1911
	["RH_m1911", ["WEAPON", "PISTOL"], ["Colt M1911", localize "STRS_item_desc_noDesc"], [800,500], 1, "",  [ ["CIV", "PISTOL"]], [], true, true, true, [ ["steel_bar", 2], ["Copper_bar", 1] ]],
	["RH_m1911old", ["WEAPON", "PISTOL"], ["Colt M1911 old", localize "STRS_item_desc_noDesc"], [800,500], 1, "",  [ ["CIV", "PISTOL"]], [], true, true, true, [ ["steel_bar", 2], ["Copper_bar", 1] ]],
	["8Rnd_45cal_m1911",["MAGAZINE", "PISTOL"],["8Rnd M1911 .45 ACP Mag", localize "STRS_item_desc_noDesc"], [140, 20], 0.1, "", [], [], true, true, true, [ ["copper_bar", 2], ["Sulphur", 1] ]],
	
	/* Glock */ //17Rnd_9x19_glock17
	["RH_g17", ["WEAPON", "PISTOL"], ["Glock17", localize "STRS_item_desc_noDesc"], [1000,500], 1, "",  [ ["CIV", "PISTOL"]], [], true, true, true, [ ["steel_bar", 2], ["Copper_bar", 1] ]],
	["RH_g18", ["WEAPON", "PISTOL"], ["Glock18", localize "STRS_item_desc_noDesc"], [1000,500], 1, "",  [ ["CIV", "PISTOL"]], [], true, true, true, [ ["steel_bar", 2], ["Copper_bar", 1] ]],	
	["RH_g19", ["WEAPON", "PISTOL"], ["Glock19", localize "STRS_item_desc_noDesc"], [1000,500], 1, "",  [ ["CIV", "PISTOL"]], [], true, true, true, [ ["steel_bar", 2], ["Copper_bar", 1] ]],
	["17Rnd_9x19_glock17", ["MAGAZINE", "PISTOL"], ["17Rnd Glock17 Mag", localize "STRS_item_desc_noDesc"], [140, 20], 0.1, "", [], [], true, true, true, [ ["copper_bar", 2], ["Sulphur", 1] ]],
	["33Rnd_9x19_g18", ["MAGAZINE", "PISTOL"], ["33rnd Glock18 Mag", localize "STRS_item_desc_noDesc"], [140, 20], 0.1, "", [], [], true, true, true, [ ["copper_bar", 2], ["Sulphur", 1] ]],

	/* Makarov */ //8Rnd_9x18_Makarov
	["Makarov", ["WEAPON", "PISTOL"], ["Makarov (Stun gun)", localize "STRS_item_desc_noDesc"], [500,350], 1, "",  [ ["CIV", "PISTOL"]], [], true, true, true, [ ["steel_bar", 2], ["Copper_bar", 1] ]],
	["8Rnd_9x18_Makarov", ["MAGAZINE", "PISTOL"], ["8Rnd Makarov Mag (Stun ammo)", localize "STRS_item_desc_noDesc"], [140, 20], 0.1, "", [], [], true, true, true, [ ["copper_bar", 2], ["Sulphur", 1] ]],
	
	/* Revolver */ //6Rnd_45ACP
	["RH_python", ["WEAPON", "PISTOL"], ["Colt Python", localize "STRS_item_desc_noDesc"], [1500,500], 3, "",  [ ["CIV", "PISTOL"]], [], true, true, true, [ ["steel_bar", 2], ["Copper_bar", 1] ]],
	["RH_bull", ["WEAPON", "PISTOL"], ["Taurus Raging Bull", localize "STRS_item_desc_noDesc"], [1500,500], 3, "",  [ ["CIV", "PISTOL"]], [], true, true, true, [ ["steel_bar", 2], ["Copper_bar", 1] ]],
	["RH_anac", ["WEAPON", "PISTOL"], ["Colt Anaconda", localize "STRS_item_desc_noDesc"], [1500,500], 3, "",  [ ["CIV", "PISTOL"]], [], true, true, true, [ ["steel_bar", 2], ["Copper_bar", 1] ]],
	["6Rnd_357_Mag", ["MAGAZINE", "PISTOL"], ["6Rnd 357 Mag", localize "STRS_item_desc_noDesc"], [100, 0], 0.1, "", [], [], true, true, true, [ ["copper_bar", 2], ["Sulphur", 1] ]],
	["6Rnd_44_Mag", ["MAGAZINE", "PISTOL"], ["6Rnd 44 Mag", localize "STRS_item_desc_noDesc"], [100, 0], 0.1, "", [], [], true, true, true, [ ["copper_bar", 2], ["Sulphur", 1] ]],

	/* desert eagle */	
	["RH_deagle", ["WEAPON", "PISTOL"], ["Desert Eagle", localize "STRS_item_desc_noDesc"], [500,350], 1, "",  [ ["CIV", "PISTOL"]], [], true, true, true, [ ["steel_bar", 2], ["Copper_bar", 1] ]],
	["7rnd_50_AE", ["MAGAZINE", "PISTOL"], ["7rnd 50AE Mag", localize "STRS_item_desc_noDesc"], [140, 20], 0.1, "", [], [], true, true, true, [ ["copper_bar", 2], ["Sulphur", 1] ]],

	/* Mk22 */	
	["RH_mk22", ["WEAPON", "PISTOL"], ["Mk22", localize "STRS_item_desc_noDesc"], [500,350], 1, "",  [ ["CIV", "PISTOL"]], [], true, true, true, [ ["steel_bar", 2], ["Copper_bar", 1] ]],
	["8rnd_9x19_mk", ["MAGAZINE", "PISTOL"], ["8rnd Mk22 Mag", localize "STRS_item_desc_noDesc"], [50, 0], 0.1, "", [], [], true, true, true, [ ["copper_bar", 2], ["Sulphur", 1] ]],

	/* PPK */		
	["RH_ppk", ["WEAPON", "PISTOL"], ["PPK", localize "STRS_item_desc_noDesc"], [500,350], 1, "",  [ ["CIV", "PISTOL"]], [], true, true, true, [ ["steel_bar", 2], ["Copper_bar", 1] ]],
	["7rnd_32cal_ppk", ["MAGAZINE", "PISTOL"], ["7rnd PPK Mag", localize "STRS_item_desc_noDesc"], [50, 0], 0.1, "", [], [], true, true, true, [ ["copper_bar", 2], ["Sulphur", 1] ]],

	/* USP */	
	["RH_usp", ["WEAPON", "PISTOL"], ["USP", localize "STRS_item_desc_noDesc"], [500,350], 1, "",  [ ["CIV", "PISTOL"]], [], true, true, true, [ ["steel_bar", 2], ["Copper_bar", 1] ]],
	["15Rnd_9x19_usp", ["MAGAZINE", "PISTOL"], ["15Rnd USP Mag", localize "STRS_item_desc_noDesc"], [120, 50], 0.1, "", [], [], true, true, true, [ ["copper_bar", 2], ["Sulphur", 1] ]],
	["RH_uspm", ["WEAPON", "PISTOL"], ["USP Match", localize "STRS_item_desc_noDesc"], [500,350], 1, "",  [ ["CIV", "PISTOL"]], [], true, true, true, [ ["steel_bar", 2], ["Copper_bar", 1] ]],
	["12Rnd_45cal_usp", ["MAGAZINE", "PISTOL"], ["12Rnd USP Match Mag", localize "STRS_item_desc_noDesc"], [120, 50], 0.1, "", [], [], true, true, true, [ ["copper_bar", 2], ["Sulphur", 1] ]],

	/* Rifles */
	
	/* M1014 */ //8Rnd_B_Beneli_74Slug
	["M1014", ["WEAPON", "RIFLE"], ["M1014", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["steel_bar", 6], ["Copper_bar", 2]]],
	["8Rnd_B_Beneli_74Slug", ["MAGAZINE", "RIFLE"], ["8Rnd 74Slug", localize "STRS_item_desc_noDesc"], [120, 50], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["copper_bar", 2], ["Sulphur", 1]]],
	
	/* AKS74 */ //30Rnd_545x39_AK
	["AKS_74_U", ["WEAPON", "RIFLE"], ["AKS74", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [ ["steel_bar", 10], ["woodPlank", 5] ]],
	["30Rnd_545x39_AK", ["MAGAZINE", "RIFLE"], ["30Rnd AK Mag", localize "STRS_item_desc_noDesc"], [120, 50], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["copper_bar", 2], ["Sulphur", 1]]],
	
	/* AK74 */ //30Rnd_545x39_AK
	["AK_74", ["WEAPON", "RIFLE"], ["AK74", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["steel_bar", 10], ["woodPlank", 5]]],
	
	/* AKS74 Kobra */ //30Rnd_545x39_AKSD
	["AKS_74_UN_kobra", ["WEAPON", "RIFLE"], ["AKS74 Kobra", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["steel_bar", 10], ["woodPlank", 5]]],
	["30Rnd_545x39_AKSD", ["MAGAZINE", "RIFLE"], ["30Rnd AK-SD Mag", localize "STRS_item_desc_noDesc"], [120, 50], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["copper_bar", 2], ["Sulphur", 1]]],
	
	/* AKS Gold */ //30Rnd_762x39_AK47
	["AKS_GOLD", ["WEAPON", "RIFLE"], ["AKS Gold", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["steel_bar", 20], ["woodPlank", 5]]],
	
	/* AK47 */ //30Rnd_762x39_AK47
	["AK_47_M", ["WEAPON", "RIFLE"], ["AK47", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["steel_bar", 10], ["woodPlank", 5]]],
	["30Rnd_762x39_AK47", ["MAGAZINE", "RIFLE"], ["30Rnd AK47 Mag", localize "STRS_item_desc_noDesc"], [120, 50], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["copper_bar", 2], ["Sulphur", 1]]],
	
	/* AKS47 */ //30Rnd_762x39_AK47
	["AK_47_S", ["WEAPON", "RIFLE"], ["AKS47", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["steel_bar", 10], ["woodPlank", 5]]],

	/* M16A2 */ //30Rnd_556x45_Stanag, 20Rnd_556x45_Stanag
	["M16A2", ["WEAPON", "RIFLE"], ["M16A2", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["steel_bar", 10]]],
	["30Rnd_556x45_Stanag", ["MAGAZINE", "RIFLE"], ["30Rng 556x45 Stanag", localize "STRS_item_desc_noDesc"], [120, 50], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["copper_bar", 2], ["Sulphur", 1]]],
	["20Rnd_556x45_Stanag", ["MAGAZINE", "RIFLE"], ["20Rnd 556x45 Stanag", localize "STRS_item_desc_noDesc"], [120, 50], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["copper_bar", 2], ["Sulphur", 1]]],
	
	/* M16A4 */ //30Rnd_556x45_Stanag, 20Rnd_556x45_Stanag
	["M16A4", ["WEAPON", "RIFLE"], ["M16A4 (Reddot Sight)", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["steel_bar", 10]]],
	
	/* M16A4 Acog */ //30Rnd_556x45_Stanag, 20Rnd_556x45_Stanag
	["M16A4_ACG", ["WEAPON", "RIFLE"], ["M16A4 (ACOG Sight)", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["steel_bar", 10]]],
	
	/* M4A1 */ //30Rnd_556x45_Stanag, 20Rnd_556x45_Stanag
	["M4A1", ["WEAPON", "RIFLE"], ["M4A1", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["steel_bar", 10]]],
	["RH_HK53aim", ["WEAPON", "RIFLE"], ["HK53", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["steel_bar", 10]]],

	/* M4A1 Aim */ //30Rnd_556x45_Stanag, 20Rnd_556x45_Stanag
	["M4A1_Aim", ["WEAPON", "RIFLE"], ["M4A1 (Reddot Sight)", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["steel_bar", 10]]],
	
	/* LeeEnfield */ //10x_303
	["LeeEnfield", ["WEAPON", "RIFLE"], ["Lee Enfield", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["steel_bar", 4]]],
	["10x_303", ["MAGAZINE", "RIFLE"], ["303 Caliber Ammo", localize "STRS_item_desc_noDesc"], [120, 50], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["copper_bar", 2], ["Sulphur", 1]]],
	
	/* SMGs */

	/* TEC9 */
	["RH_tec9", ["WEAPON", "PISTOL"], ["Tec9", localize "STRS_item_desc_noDesc"], [500,350], 1, "",  [ ["CIV", "PISTOL"]], [], true, true, true, [ ["steel_bar", 4], ["Copper_bar", 4] ]],
	["30rnd_9x19_tec", ["MAGAZINE", "PISTOL"], ["30rnd Tec9 Mag", localize "STRS_item_desc_noDesc"], [120, 50], 0.1, "", [], [], true, true, true, [ ["copper_bar", 2], ["Sulphur", 1] ]],

	/* Muzi */	
	["RH_muzi", ["WEAPON", "PISTOL"], ["Micro Uzi", localize "STRS_item_desc_noDesc"], [500,350], 1, "",  [ ["CIV", "PISTOL"]], [], true, true, true, [ ["steel_bar", 4], ["Copper_bar", 4] ]],
	["32rnd_9x19_muzi", ["MAGAZINE", "PISTOL"], ["32rnd Micro Uzi Mag", localize "STRS_item_desc_noDesc"], [120, 50], 0.1, "", [], [], true, true, true, [ ["copper_bar", 2], ["Sulphur", 1] ]],
	
	/*Sa61 */ //20Rnd_B_765x17_Ball, 10Rnd_B_765x17_Ball
	["RH_vz61", ["WEAPON", "PISTOL"], ["VZ-61", localize "STRS_item_desc_noDesc"], [500,350], 1, "",  [ ["CIV", "SMG"]], [], true, true, true, [["steel_bar", 5]]],
	["20Rnd_32cal_vz61", ["MAGAZINE", "PISTOL"], ["20Rnd 765x17", localize "STRS_item_desc_noDesc"], [120, 50], 1, "", [ ["CIV", "SMG"] ], [], true, true, true, [["copper_bar", 2], ["Sulphur", 1]]],
		
	/* UZI */ //30Rnd_9x19_UZI
	["RH_uzi", ["WEAPON", "RIFLE"], ["Uzi", localize "STRS_item_desc_noDesc"], [500,350], 1, "",  [ ["CIV", "SMG"]], [], true, true, true, [["steel_bar", 5], ["Copper_bar", 3]]],
	["RH_uzim", ["WEAPON", "RIFLE"], ["Mini Uzi", localize "STRS_item_desc_noDesc"], [500,350], 1, "",  [ ["CIV", "SMG"]], [], true, true, true, [["steel_bar", 8], ["Copper_bar", 5]]],
	["RH_mac10", ["WEAPON", "RIFLE"], ["Mac10", localize "STRS_item_desc_noDesc"], [500,350], 1, "",  [ ["CIV", "SMG"]], [], true, true, true, [["steel_bar", 8], ["Copper_bar", 5]]],	
	["RH_9mm_32RND_Mag", ["MAGAZINE", "RIFLE"], ["32Rnd 9x19 Uzi Mac10", localize "STRS_item_desc_noDesc"], [120, 50], 1, "", [ ["CIV", "SMG"] ], [], true, true, true, [["copper_bar", 2], ["Sulphur", 1]]],
	
	/* MP5A5 */ //30Rnd_9x19_MP5
	["RH_MP5A5", ["WEAPON", "RIFLE"], ["MP5A5", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "SMG"] ], [], true, true, true, [["steel_bar", 7], ["Copper_bar", 4]]],
	["RH_MP5k", ["WEAPON", "RIFLE"], ["MP5k", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "SMG"] ], [], true, true, true, [["steel_bar", 6], ["Copper_bar", 3]]],
	["RH_MP5kpdw", ["WEAPON", "RIFLE"], ["MP5k PDW", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "SMG"] ], [], true, true, true, [["steel_bar", 6], ["Copper_bar", 4]]],
	["RH_MP5A4", ["WEAPON", "RIFLE"], ["MP5A4", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "SMG"] ], [], true, true, true, [["steel_bar", 7], ["Copper_bar", 4]]],
	["RH_mp5a5risRFX", ["WEAPON", "RIFLE"], ["MP5A5 RFX", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "SMG"] ], [], true, true, true, [["steel_bar", 7], ["Copper_bar", 4]]],
	["30Rnd_9x19_MP5", ["MAGAZINE", "RIFLE"], ["30Rnd 9x19 MP5", localize "STRS_item_desc_noDesc"], [120, 50], 1, "", [ ["CIV", "SMG"] ], [], true, true, true, [["copper_bar", 2], ["Sulphur", 1]]],
	["RH_mp7aim", ["WEAPON", "RIFLE"], ["MP7", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "SMG"] ], [], true, true, true, [["steel_bar", 4], ["Copper_bar", 7]]],
	["RH_46x30mm_40RND_Mag", ["MAGAZINE", "RIFLE"], ["40Rnd 46x30 MP7", localize "STRS_item_desc_noDesc"], [120, 50], 1, "", [ ["CIV", "SMG"] ], [], true, true, true, [["copper_bar", 2], ["Sulphur", 1]]],

	/* P90 */
	["RH_P90eot", ["WEAPON", "RIFLE"], ["P90 Eotech", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "SMG"] ], [], true, true, true, [["steel_bar", 7], ["Copper_bar", 4]]],
	["RH_57x28mm_50RND_Mag", ["MAGAZINE", "RIFLE"], ["57rnd P90 Mag", localize "STRS_item_desc_noDesc"], [120, 50], 1, "", [ ["CIV", "SMG"] ], [], true, true, true, [["copper_bar", 2], ["Sulphur", 1]]],

	/* UMP */
	["RH_umpeot", ["WEAPON", "RIFLE"], ["UMP Eotech", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "SMG"] ], [], true, true, true, [["steel_bar", 7], ["Copper_bar", 4]]],
	["RH_45ACP_25RND_Mag", ["MAGAZINE", "RIFLE"], ["25rnd UMP Mag", localize "STRS_item_desc_noDesc"], [120, 50], 1, "", [ ["CIV", "SMG"] ], [], true, true, true, [["copper_bar", 2], ["Sulphur", 1]]],

	/* Sniper Rifles */ //5x_22_LR_17_HMR
	["Huntingrifle", ["WEAPON", "RIFLE"], ["Hunting Rifle", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["steel_bar", 13], ["Copper_bar", 3]]],
	["5x_22_LR_17_HMR", ["MAGAZINE", "RIFLE"], ["9.3x61mm", localize "STRS_item_desc_noDesc"], [120, 50], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["copper_bar", 2], ["Sulphur", 1]]],
	["M24", ["WEAPON", "RIFLE"], ["M24", localize "STRS_item_desc_noDesc"], [1200, 600], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["steel_bar", 10]]],
	["5Rnd_762x51_M24", ["MAGAZINE", "RIFLE"], ["M24 Mag", localize "STRS_item_desc_noDesc"], [120, 50], 1, "", [ ["CIV", "RIFLE"] ], [], true, true, true, [["copper_bar", 2], ["Sulphur", 1]]],	

	/* Equipment */
	["ItemMap", ["WEAPON", "ITEM"], ["Map", localize "STRS_item_desc_noDesc"], [0,0], 0, "", [], [], false, false, true, []],
	["ItemCompass", ["WEAPON", "ITEM"], ["Compass", localize "STRS_item_desc_noDesc"], [0,0], 0, "", [], [], false, false, true, []],
	["ItemWatch", ["WEAPON", "ITEM"], ["Watch", localize "STRS_item_desc_noDesc"], [0,0], 0, "", [], [], false, false, true, []],
	["ItemRadio", ["WEAPON", "ITEM"], ["Radio", localize "STRS_item_desc_noDesc"], [0,0], 0, "", [], [], false, false, true, []],
	["ItemGPS", ["WEAPON", "ITEM"], ["GPS", localize "STRS_item_desc_noDesc"], [0,0], 0, "", [], [], false, true, true, [["silicon",2]]],

	
	/* Magazines */
	//Note the second item type must be where the magazine shows in gear!
	["HandGrenade_Stone", ["MAGAZINE", "RIFLE"], ["Stone", localize "STRS_item_desc_noDesc"], [0,0], 0, "", [], [], true, true, true, []],
	
	/* Animals */
	["Pastor", ["ANIMAL", "DOG"], ["Alsatian", localize "STRS_item_desc_noDesc"], [200,0], 0, "", [], [], false, true, true, []],
	["Cow01", ["ANIMAL", "COW"], ["Cow", localize "STRS_item_desc_noDesc"], [200,0], 0, "", [], [], false, true, true, []],
	["Cow02", ["ANIMAL", "COW"], ["Cow", localize "STRS_item_desc_noDesc"], [200,0], 0, "", [], [], false, true, true, []],
	["Cow03", ["ANIMAL", "COW"], ["Cow", localize "STRS_item_desc_noDesc"], [200,0], 0, "", [], [], false, true, true, []],
	["Cow04", ["ANIMAL", "COW"], ["Cow", localize "STRS_item_desc_noDesc"], [200,0], 0, "", [], [], false, true, true, []],
	["Goat", ["ANIMAL", "GOAT"], ["Goat", localize "STRS_item_desc_noDesc"], [200,0], 0, "", [], [], false, true, true, []],
	["Goat01_EP1", ["ANIMAL", "GOAT"], ["Goat", localize "STRS_item_desc_noDesc"], [200,0], 0, "", [], [], false, true, true, []],
	["Goat02_EP1", ["ANIMAL", "GOAT"], ["Goat", localize "STRS_item_desc_noDesc"], [200,0], 0, "", [], [], false, true, true, []],
	["WildBoar", ["ANIMAL", "BOAR"], ["Boar", localize "STRS_item_desc_noDesc"], [200,0], 0, "", [], [], false, true, true, []]
];

