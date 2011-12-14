/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

/*
	TNL_gVar_arr_gatherLocations
	* Description: Array of all the locations for gathering
	* Parameters:
		(0) Parameters:
			(0) Marker name (string)
			(1) Name (string)
		(1) Parameters:
			(0) Distance until action shows up (integer)
			(1) Action text (string)
		(2) Parameters:
			(0) Requires vehicle for action to show (boolean)
			(1) Required vehicles you have to be driving for action to show (array of class names)
		(3) Corporation Owned (boolean)
*/
TNL_gVar_arr_gatherLocations = 
[
	[["mine_stone2", "mine_stone1"], [45, "Mine Stone"], [false, []], false],
	[["mine_stone1", "mine_stone1"], [45, "Workplace) Mine Stone"], [false, []], true],
	
	[["mine_coal2", "mine_coal1"], [45, "Mine Coal"], [false, []], false],
	[["mine_coal1", "mine_coal1"], [45, "Workplace) Mine Coal"], [false, []], true],
	
	[["mine_iron2", "mine_iron1"], [45, "Mine Iron"], [false, []], false],
	[["mine_iron1", "mine_iron1"], [45, "Workplace) Mine Iron"], [false, []], true],
	
	[["mine_copper2", "mine_copper1"], [45, "Mine Copper"], [false, []], false],
	[["mine_copper1", "mine_copper1"], [45, "Workplace) Mine Copper"], [false, []], true],
	
	[["gather_petrol2", "gather_petrol1"], [45, "Gather Petroleum"], [false, []], false],
	[["gather_petrol1", "gather_petrol1"], [45, "Workplace) Gather Petroleum"], [false, []], true]
	//[["ExampleIronMine", "mine_iron1"], [45, "Mine Iron"], [false, []], false],
	//[["corp1_ironmine", "mine_iron1"], [45, "Workplace) Mine Iron"], [false, []], true]
];

/*
	Gathering item arrays
	* Description: Arrays of the items for gathering
	* Parameters:
		(0) Item Class (string)
		(1) Parameters:
			(0) Minimum can get (int)
			(1) Maximum can get (int)
		(2) Parameters:
			(0) Is default item if chances for others not hit (boolean)
			(1) Chance of getting the item (int)
		(3) Parameters:
			(0) Skill until max items increased (int)
			(1) Max items increased by (int)
		(4) Parameters:
			(0) Consumes a item (boolean)
			(1) Item consumed (string)
			(2) Consumes more than 1 for each gathered (boolean)
			(3) Amount consumed for each gathered (int)
			(4) Consumed on fail (boolean)
		(5) Parameters:
			(0) Requires additional item (boolean)
			(1) Required item (string)
*/

TNL_gVar_arr_gatherIronItems = 
[ 
	["iron_ore", [1,4], [false, 45], [50,10], [false,"",true,0,true], [false,""]] 
];

TNL_gVar_arr_gatherStoneItems =
[
	["stone", [1,4], [false, 60], [20, 5], [false,"",true,0,true], [false,""]]
];

TNL_gVar_arr_gatherCoalItems =
[
	["coal", [1,4], [false, 45], [30, 10], [false,"",true,0,true], [false,""]]
];

TNL_gVar_arr_gatherCopperItems =
[
	["copper_ore", [1,4], [false, 40], [40, 10], [false,"",true,0,true], [false,""]]
];

TNL_gVar_arr_gatherForageItems = 
[ 
	["ficus_seed", [1,10], [false,15], [25,5], [false,"", true, 0, true], [false, ""]],
	["mari_seed", [1,2], [false,3], [25,2], [false,"",true,0,true], [false, ""]], 
	["Worm", [5,10], [false,40], [25,10], [false,"",true,0,true], [false, ""]], 
	["Nightcrawler", [2,4], [false,25], [25,5], [false,"",true,0,true], [false, ""]], 
	["Money", [1,100], [false,15], [25,50], [false,"",true,0,true], [false, ""]]  
];

TNL_gVar_arr_gatherDiggingItems =
[
	["Sand", [1,10], [false,70], [10,10], [false,"",true,0,true], [false, ""]], 
	["Clay", [1,5], [true,70], [25,15], [false,"",true,0,true], [false, ""]]  
];

TNL_gVar_arr_gatherRockItems =
[
	["Silicon", [1,5], [false,50], [40, 10], [false,"",true,0,true], [false, ""]], 
	["Sulphur", [1,5], [true,50], [40, 10], [false,"",true,0,true], [false, ""]]
];

TNL_gVar_arr_gatherPetrolItems =
[
	["Petroleum", [1,4], [false,50], [10,10], [true,"Barrel",true,1,false], [true,"Barrel"]]
];

TNL_gVar_arr_gatherGroundFishing =
[
	["Minnow", [1,1], [false,40], [0,0], [false,"",true,0,false], [false,""]],
	["Bluegill", [1,1], [false,30], [0,0], [true,"Worm",true,1,false], [true,"Worm"]],
	["Catfish", [1,1], [false,23], [0,0], [true,"Nightcrawler",true,1,false], [true,"Nightcrawler"]],
	["Trout", [1,1], [false,35], [0,0], [true,"Nightcrawler",true,1,false], [true,"Nightcrawler"]],
	["Perch", [1,1], [false,40], [0,0], [true,"Minnow",true,1,false], [true,"Minnow"]],
	["RockBass", [1,1], [false,20], [0,0], [true,"Minnow",true,1,false], [true,"Minnow"]]
];

TNL_gVar_arr_gatherWater =
[
	["ClayPotW", [1,1], [true,100], [0,0], [true,"ClayPot",true,1,true], [true,"ClayPot"]]
];

/* END OF GATHERING ITEM ARRAYS */

/*
	TNL_gVar_arr_gatherDefine
	* Description: Massive array that defines the different gathering types and how they work
	* Parameters:
		(0)  Gathering class (string)
		(1)  Gather locations that use this array (array of gather location classes)
		(2) Parameters:
			(0) Start of action message (string)
			(1) Parameters:
				(0) Success gather message (string) 
				(1) Failure to gather message (string)
				(2) Failure to gather message due to not having items (string)
			(2) Paramters:
				(0) Local message to nearby players when started gathering (string)
				(1) Local success message to nearby players (string)
				(2) Local fail message to nearby players (string)
		(3) Parameters:
			(0) Skill it uses (string)
			(1) Parameters:
				(0) Default time to gather resource (integer)
				(1) Chance to increase skill for both success and fail (integer)
				(2) Time decreased for gathering per 1 skill (interger)
				(3) Increased chance to succeed gathering per 1 skill (integer)
				(4) Parameters:
					(0) Decreases hunger (boolean)
					(1) Amount hunger decreases by (int)
					(2) Decreases thirst (boolean)
					(3) Amount thirst decreases by (int)
				(5) Parameters:
					(0) Minimum skill for optimal skill increase (integer)
					(1) Maximum skill for optimal skill increase (integer)
				(6) Difficulty (integer)
		(4) Animation (string)
		(5) Array of items available from gathering here, the item is selected randomly and array defined as ["Item Class", [Minimum can get, Maximum can get]]  (array)
		(6) Chance to succeed (integer)
		(7) Required Items (array of item classes)
		(8) Max distance player can move until gathering fails and they get nothing (integer)
		(9) Parameters:
			(0) Get skill on success (boolean)
			(1) Get skill on fail (boolean)
		(10) Parameters:
			(0) Need to move to a different spot each action (boolean)
			(1) Message that you have already gathered in that spot (string)
			(2) Time until you can gather there again (integer)
			(3) Distance that you can gather after (integer)
*/
TNL_gVar_arr_gatherDefine = 
[
	["mine_stone1", ["mine_stone1"], ["You start mining the stone", ["You have mined %2 %1(s)", "You chip at the stone but fail to get anything useable", "You failed to mine anything"], ["", "%1 has mined %2 %3(s)", ""]], ["mining", [9, 75, 0.1, 0.2, [false,0, false,2], [0,25], 11]], "AmovPercMstpSnonWnonDnon_sekani2", TNL_gVar_arr_gatherStoneItems, 45, ["Pickaxe_stone"], 5, [true,true], [false, "", 0]],
	["mine_coal1", ["mine_coal1"], ["You start mining the coal", ["You have mined %2 %1(s)", "You failed to mine anything", "You failed to mine anything"], ["", "%1 has mined %2 %3(s)", ""]], ["mining", [9, 60, 0.1, 0.2, [false,0,false,2], [25,40], 20]], "AmovPercMstpSnonWnonDnon_sekani2", TNL_gVar_arr_gatherCoalItems, 40, ["Pickaxe_iron"], 5, [true,true], [false,"", 0]],
	["mine_iron1", ["mine_iron1"], ["You start mining the iron", ["You have mined %2 %1(s)", "You chip at the ore but fail to get any resources", "You fail to mine anything, maybe you are using the wrong type of tool?"], ["", "%1 has mined %2 %3(s)", ""]], ["mining", [9.0, 50, 0.1, 0.2, [false,0,false,2], [40,60], 26]], "AmovPercMstpSnonWnonDnon_sekani2", TNL_gVar_arr_gatherIronItems, 35, ["Pickaxe_iron"], 3, [true,true], [false, "", 0]],
	["mine_copper1", ["mine_copper1"], ["You start mining copper", ["You have mined %2 %1(s)", "You chip at the ore but fail to get any resources", "You fail to mine anything, maybe you are using the wrong type of tool?"], ["", "%1 has mined %2 %3(s)", ""]], ["mining", [9, 70, 0.1, 0.2, [false, 0, false,2], [20,35], 21]], "AmovPercMstpSnonWnonDnon_sekani2", TNL_gVar_arr_gatherCopperItems, 40, ["Pickaxe_iron"], 3, [true,true], [false, "", 0]],
	["gather_petrol1", ["gather_petrol1"], ["You start to gather Petroleum", ["You have got %2 %1(s)", "You dont get anything", "You dont get anything"], ["%1 has started gathering", "%1 has gathered %2 %3(s)", ""]], ["digging", [9, 50, 0.1, 0.2, [false,0,false,2], [20,40], 12]], "AmovPercMstpSnonWnonDnon_sekani2", TNL_gVar_arr_gatherPetrolItems, 35, ["Shovel"], 3, [true,true], [false, "", 0]],
	
	["forage", ["forage"], ["You start to forage in the grass", ["You have found %2 %1(s)", "You have failed to find anything here"], ["%1 has started foraging", "%1 has foraged %2 %3(s)", ""]], ["foraging", [10.0, 100, 0.01, 2.0, [false,0,false,0], [100,0], 2]], "AinvPknlMstpSlayWrflDnon_medic", TNL_gVar_arr_gatherForageItems, 15, [], 3, [true,true], [true, "You have already foraged this spot recently", 7]],
	["gather_sand", ["gather_sand"], ["You start to gather the sand", ["You have dug up %2 %1(s)", "You have failed to collect anything"], ["", "%1 has gathered %2 %3(s)", ""]], ["digging", [10.0, 75, 0.1, 0.2, [false,1,false,1], [0, 20], 2]], "AinvPknlMstpSlayWrflDnon_medic", TNL_gVar_arr_gatherDiggingItems, 20, ["Shovel"], 3, [true,true], [false, "", 0]],
	["gather_rock", ["gather_rock"], ["You start to mine the rock", ["You have mined %2 %1(s)", "You have failed to mine anything"], ["%1 has started mining the rock", "%1 has mined %2 %3(s)", ""]], ["mining", [10, 75, 0.1, 0.2, [false,1, false,2], [20,40], 5]], "AinvPknlMstpSlayWrflDnon_medic", TNL_gVar_arr_gatherRockItems, 25, ["Pickaxe_stone"], 3, [true,true], [false,"",0]],
	["fish_ground", ["fish_ground"], ["You start fishing", ["You have caught %2 %1!", "You dont seem to be getting a bite."], ["%1 has started fishing", "%1 has caught %2 %3!", ""]], ["fishing", [9.5, 35, 0.1, 0.2, [false,0,false,0], [0,40], 5]], "CtsDoktor_Vojak_uder1", TNL_gVar_arr_gatherGroundFishing, 50, ["Fishing_rod"], 5, [true,true], [false,"",0]],
	["water_ground", ["water_ground"], ["", ["You have filled up %2 %1.", ""], ["", "", ""]], ["gathering", [3, 100, 0, 0, [false,0,false,0], [0,40], 0]], "AinvPknlMstpSlayWrflDnon_medic", TNL_gVar_arr_gatherWater, 100, [], 5, [true,true], [false,"",0]]
];


//Gathering Ground Actions
TNL_gVar_arr_groundActions = 
[
	["#IBRlingrassSurface", "grass_w1_forage", [], ["Forage", "client\useAction.sqf", ["gather", ["forage", "ground"]]]],
	["#IBRlinsandSurface", "sand_w1_gather", [], ["Gather Sand", "client\useAction.sqf", ["gather", ["gather_sand", "ground"]]]],
	["#IBRlinrockSurface", "rock_w1_gather", ["pickaxe_stone"], ["Mine", "client\useAction.sqf", ["gather", ["gather_rock", "ground"]]]],
	["#Water", "water_w1_fish", ["Fishing_rod"], ["Fish", "client\useAction.sqf", ["gather", ["fish_ground", "ground"]]]],
	["#Water", "water_w1_water", ["ClayPot"], ["Collect water", "client\useAction.sqf", ["gather", ["water_ground", "ground"]]]]
];

TNL_gVar_int_timeUntilRegather = 3600;

TNL_gVar_arr_gatheredLocations = [];