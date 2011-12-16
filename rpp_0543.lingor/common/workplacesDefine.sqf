//Marker name
TNL_gVar_workplaces = 
[
	["mine_stone1", [ ["Stone", 50, 75, 0, 100000] ], StoneMine_Corp, "Workplace: Stone"],
	["mine_coal1", [ ["Coal", 75, 100, 0, 100000] ], CoalMine_Corp, "Workplace: Coal"],
	["mine_iron1", [ ["Iron_ore", 100, 150, 0, 100000] ], IronMine_Corp, "Workplace: Iron"],
	["mine_copper1", [ ["Copper_ore", 75, 100, 0, 100000] ], CopperMine_Corp, "Workplace: Copper"],
	["gather_petrol1", [ ["Petroleum", 100, 200, 0, 100000] ], PetrolMine_Corp, "Workplace: Petroleum"]
];

if (isServer) then //Set Variables
{
	{
		_obj = (_x select 2);
		
		_obj setVariable ["price", (_x select 1), true];
		_obj setVariable ["wpname", (_x select 3), true];
		_obj setVariable ["canBuy", true, true];
		_obj setPos [0,0,0];
	} forEach TNL_gVar_workplaces;

};