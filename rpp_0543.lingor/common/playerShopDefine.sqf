TNL_gVar_arr_playerShops = 
[
	[playerShop1, 
		[ 
			["Barrel", [30, 50], 50],
			["mobilephone", [10,10], 25],
			["shovel", [60,60], 75],
			["hatchet", [60,60], 75],
			["pickaxe_stone", [60,60], 100],
			["pickaxe_iron", [150,150], 50],
			["fishing_rod", [100,100], 15],
			["RepairKit", [125,150], 20],
			["ClayPot", [10,10], 150],
			["DrugShed", [1000,1000], 3],
			["RefuelCan", [125,150], 20],
			["radio", [20,30], 4],
			["Spare_Wheel", [200,250], 40],
			["MMT_Civ", [30,30], 150],
			["Volha_1_TK_CIV_EP1", [1000,1200], 25],
			["Volha_2_TK_CIV_EP1", [1000,1200], 25]
		], "Maruko Central Store", PlayerShop1_Storage],
	[playerShop2, [ ], "Maruko Store (East)", PlayerShop2_Storage],
	[playerShop3, [ ], "Maruko Store (South)", PlayerShop3_Storage],
	[playerShop4, [ ], "Tucos Store", PlayerShop4_Storage],
	[playerShop5, [  ], "Maruko Airport Store", playerShop5_Storage],
	[playerShop6, [ ["Fishing_Boat", [1000,2000], 2] ], "Sanvigado Boat Shop", playerShop6_Storage],
	[playerShop7, [  ], "Manteria Shop", playerShop7_Storage],
	[playerShop8, [  ], "Guayucca Shop", playerShop8_Storage],
	[playerShop9, [  ], "Fernando Shop", playerShop9_Storage],
	[playerShop10, [  ], "Calixo Shop", playerShop10_Storage],
	[playerShop11, [  ], "Aculto Shop", playerShop11_Storage],
	[playerShop12, [  ], "San Isabel Shop", playerShop12_Storage],
	[playerShop13, [ ["MMT_Civ", [100,100], 50] ], "Prison Shop", playerShop13_Storage],
	[playerShop14, [  ], "Corazon Shop", playerShop14_Storage],
	[playerShop15, [  ], "Sanvigado Shop", playerShop15_Storage],
	[playerShop16, [  ], "Prospero Shop", playerShop16_Storage],
	[playerShop17, [  ], "Victorin Shop North", playerShop17_Storage],
	[playerShop18, [  ], "Victorin Shop South", playerShop18_Storage],
	[playerShop19, [  ], "Faunaverde Shop", playerShop19_Storage],
	[playerShop20, [  ], "Marcella Shop", playerShop20_Storage],
	[playerShop21, [  ], "Calapedro Shop", playerShop21_Storage],
	[playerShop22, [  ], "Rosalia Shop", playerShop22_Storage],
	[playerShop23, [  ], "Elcanto Shop", playerShop23_Storage]
];


if (isServer) then
{
	{	
		_obj = (_x select 0);
		_stock = (_x select 1);
		_name = (_x select 2);
		
		if (_obj getVariable ["open","error"] == "error") then
		{
			_obj setVariable["name", _name, true];
			_obj setVariable["open", true, true];
			//_storage setVariable["storage", _stock, true];
			_obj setVariable["stock", _stock, true];
		};
	} forEach TNL_gVar_arr_playerShops;
};

//Needs to be local only
if ((!isServer) or (TNL_debug)) then
{
	{
		_crateLogic = (_x select 0);
		_crateName = format["%1_crate", _crateLogic];
	
		call compile format['%1 = "USBasicAmmunitionBox" createVehicleLocal getpos(%2); clearMagazineCargo %1; clearWeaponCargo %1; player reveal %1;', _crateName, _crateLogic];
	} foreach TNL_gVar_arr_playerShops;
};