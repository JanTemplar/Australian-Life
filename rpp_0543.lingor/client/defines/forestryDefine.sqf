//Copyright (C) 2009  Matthew Simms & Petr Klíma

/*
	TNL_gVar_arr_forestry_sprouts
	* Description: The array of all the different sprout classes and there values
	* Parameters:
		(0) Sprout class (string)
		(1) Type the sprout is (string)
		(2) Class that the sprout grows into (string)
		(3) Model class that it grows into (string)
		(4) Time it takes to grow (integer)
		(5) Parameters:
			(0) Sprout class that grows on it (string)
			(1) Chance of a sprout to grow on it per growth cycle (integer)
			(2) Item class required to pick sprout (string)
			(3) Sprout picking animation (string)
		(6) Chance of sprout dying on planting (integer)
*/
TNL_gVar_arr_forestry_sprouts = 
[
	["mari_seed", "BUSH", "mari_bush", "AS_p_fiberPlant_EP1", 600, ["mari_seed", 5, "", "normal"], 35, "Marihuana Bush"],
	["ficus_seed", "TREE", "ficus_tree", "AS_t_ficusB2s_EP1", 600, ["ficus_seed", 8, "", "normal"], 20, "Ficus Tree"]
	//["wheat_seed", "BUSH", "wheat_plant", "AS_p_wheat_EP1", 600, ["", 0, "", "normal"], 40, "Wheat"]
	
	//["apple_seed", "BUSH", "apple_tree", "MAP_t_betula1f", 30, ["apple_seed", 12, "sickle", "normal"], 20, "apple tree"],
	//["pine_seed", "TREE", "pine_tree", "MAP_t_picea2s", 30, ["pine_seed", 12, "sickle", "normal"], 20, "pine tree"]
];


/*
	TNL_gVar_arr_forestry_plantableSurfaceTypes
	* Description: An array of all the surface types that can have things planted on them
*/
TNL_gVar_arr_forestry_plantableSurfaceTypes = 
[
	"#IBRlingrassSurface", "#CRGrassW1", "#CRGrassW2", "#CRGrass2", "#CRGrass1", "#Default"
];
 
/* Number of times that the tree/bush will grow */
TNL_gVar_int_forestry_numGrowthCycles = 30;

/* Starting height of the plants underground */	
TNL_gVar_int_forestry_plantStartHeight = -10;

/*
	TNL_gVar_arr_forestry_trees
	* Description: The array of all the tree values for forestry
	* Parameters:
		(0) Tree Class (string)
		(1) Parameters:
			(0) Model class for fallen tree (string)
		(2)  Damage until tree is cut down (integer)
		(3) Parameters:
			(0) Class of item gathered from fallen tree (string)
			(1) Minimum the tree will produce (integer)
			(2) Maximum the tree will produce (integer)
		(4) Parameters:
			(0) Skill class used (string)
			(1) Damage decreased required to cut tree down per 1 skill (integer)
			(2) Normal damage done to tree (integer)
		(5) Parameters:
			(1) Minimum of optimal skill increase range (integer)
			(2) Maximum of optimal skill increase range  (integer)
		(6) Time it takes to chip at the tree (integer)
		(7) Time decrease to chip at tree per 1 skill (integer)
		(8) Item class required to cut it down (string)
		(9) Parameters:
			(0) Cutting animation (string)
			(1) Sawing animation (string)
*/
TNL_gVar_arr_forestry_trees = 
[
	["ficus_tree", ["AS_Misc_trunk_torzo_ep1"], 10, ["log", 2, 6], ["woodcutting", 0.5, 10], [0,20], 7, 0.07, "hatchet", ["AmovPercMstpSnonWnonDnon_sekani2","AmovPercMstpSnonWnonDnon_sekani2"]]
];

/*
	TNL_gVar_arr_forestry_bushes
	* Description: The array of all the bush values for gathering
	* Parameters:
		(0) Bush Class (string)
		(1) Parameters:
			(0) Minimum possibility for gather capacity (integer)
			(1) Maximum possibilty for gather capacity (integer)
			(2) Class of the item gathered from the bush (string)
		(2) Parameters:
			(0) Maximum can be gathered from the bush before it dies (integer)
			(1) Maximum limit that can be gathered increases by (integer)
			(2) Every x skill increases maximum limit that can be gathered (integer)
		(3) Parameters:
			(0) Skill used for gathering (string)
		(4) Parameters:
			(0) Minimum of optimal skill increase range (integer)
			(1) Maximum of optimal skill increase range (integer)
		(5) Time it takes to gather from the bush (integer)
		(6) Time decrease per ever 1 skill (integer)
		(7) Parameters:
			(0) Time until the harvest grows back on it in seconds (integer)
			(1) Minimum that will grow back on it (integer)
			(2) Maximum that will grow back on it (integer)
		(8) Item class required to harvest (string)
		(9) Harvesting animation (string)
*/
TNL_gVar_arr_forestry_bushes = 
[
	["mari_bush", [1,3, "maribuds"], [3,1,5], ["drugharvest"], [0, 20], 20, 0.5, [300, 0,10], "", "AinvPknlMstpSlayWrflDnon_medic"]
	//["apple_tree", [3,12, "apple"], [15, 5, 2], ["gathering"], [0,15], 8, 0.5, [60, 3, 5], "sickle", "AinvPknlMstpSlayWrflDnon_medic"]
];