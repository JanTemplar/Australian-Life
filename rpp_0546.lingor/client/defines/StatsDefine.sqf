/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

/*
	TNL_gVar_arr_statsFilter
	* Description: Stat buttons that are in the menu
	* Parameters: 
		(0) Stats text & class (string)
		(1) Stats description (string)
*/
TNL_gVar_arr_statsFilter = 
[
	["Mission", "info about mission"],
	["Player", "Player Stats...here"],
	["Licenses", "Licenses here"],
	["Vehicles", "Your vehicles"],
	["Skills", "Your skills"],
	["Laws", "Stuff about laws"],
	["Taxes and Mayor", "...more stuff"],
	["Wanted List", "Stuff about wanted dudes!"],
	["Drug Prices", "Stuff about drug prices!"],
	["Shops", "Player shops"],
	["Factories", "Factorys"],
	["Workplaces", "Workplaces"],
	["Keys", "Stuff about key presses"]
];

/*
	TNL_gVar_arr_stats
	* Description: 
	* Parameters: 
		(0) Stats class (string)
		(1) Code to be executed when button is hit (code)
*/
TNL_gVar_arr_stats = 
[
	["Mission",
	{
		((findDisplay 4) displayCtrl 4) ctrlSetStructuredText parseText "Mission Info";
		lbAdd[1, ""];
		lbAdd[1, ""];
		lbAdd[1, format["Mission name: %1", localize "STRM_MISSION_NAME"]];
		lbAdd[1, format["Mission version: %1", TNL_version]];
		lbAdd[1, format["Mission Start: %1/%2/%3  %4:%5", missionStart select 1, missionStart select 2, missionStart select 0, missionStart select 3, missionStart select 4]];
		lbAdd[1, format["Time: %1:%2", date select 3, date select 4]];
		lbAdd[1, format["Date: %1/%2/%3", date select 1, date select 2, date select 0]];
		
		
		_players = [] call TNL_cfplayer_activeSlots;
		lbAdd[1, format["Players online: %1", count _players]];
		lbAdd[1, "Players:"];
		{
			lbAdd[1, format ["  > %1", (name _x) call TNL_fplayer_formatName]];
		} forEach _players;
	}],
	
	["Player", 
	{	
		((findDisplay 4) displayCtrl 4) ctrlSetStructuredText parseText "Player Information";
		_weight = [] call TNL_finv_getPlayerWeight;
		_hunger = [] call TNL_fhunger_checkHunger;
		_thirst = [] call TNL_fthirst_checkThirst;
		
		
		lbAdd[1, ""];
		lbAdd[1, ""];
		lbAdd[1, format["First name: %1", TNL_db_charName select 0]];
		lbAdd[1, format["Last name: %1", TNL_db_charName select 1]];
		lbAdd[1, format["Username: %1", name player]];
		lbAdd[1, format["ID: %1", getPlayerUID player]];
		lbAdd[1, format["Temperature: %1c", TNL_gVar_int_Temperature]];
		//lbAdd[1, format["Body Temperature: %1c", TNL_gVar_int_player_bodyTemperature]];
		lbAdd[1, format["Hunger: %1", _hunger]];
		lbAdd[1, format["Thirst: %1", _thirst]];
		lbAdd[1, format["Weight: %1/%2kg", _weight select 0, _weight select 1]];
		lbAdd[1, format["Deaths: %1", TNL_gVar_int_nDeaths]];
		lbAdd[1, format["Kills: %1", TNL_gVar_int_nKills]];
		lbAdd[1, format["Suicides: %1", TNL_gVar_int_nKilledSelf]];
		lbAdd[1, format["Respawn time: %1", TNL_gVar_int_respawnTime]];
		lbAdd[1, ""];
		lbAdd[1, "Weapons/Magazines:"];
		
		_weaponsArr = [] call TNL_fplayer_getWeapons;
		_magazinesArr = [] call TNL_fplayer_getMagazines;
		_foundArray = _weaponsArr + _magazinesArr;

		{
			_weaponClass = (_x select 0);
			_weaponName = ((_weaponClass) call TNL_finv_getItemName);
			_index = lbAdd[1, format["%1, %2", _weaponName, _x select 1]];
		} foreach _foundArray;
		
	}],
	
	["Licenses",
	{
		lbAdd[1, ""];
		lbAdd[1, ""];
		((findDisplay 4) displayCtrl 4) ctrlSetStructuredText parseText "Owned Licenses";
		_i = 0;
		{
			lbAdd[1, format["%1", (_x) call TNL_flic_getLicenseName]];
			_i = _i + 1;
		} forEach Gvar_arr_lic_playerLicenses;
		lbAdd[1, ""];
		
		if (_i != 0) then { lbAdd[1, format["# owned licenses: %1", _i]]; };
	}],
	
	["Vehicles",
	{
		((findDisplay 4) displayCtrl 4) ctrlSetStructuredText parseText "Owned Vehicles";
		lbAdd[1, ""];
		lbAdd[1, ""];
		_i = 0;
		{
			_index = lbAdd[1, format["%1, %2, %3", (_x select 1) call TNL_finv_getItemName, _x select 2, _x select 0]];
			lbSetData[1,_index, format['["%1", %2, "%3"]', (_x select 1), (_x select 2), (_x select 0)]];
			_i = _i + 1;
		} foreach Gvar_arr_inv_ownedVehicles;
		
		lbAdd[1, ""];
		
		if (_i != 0) then { lbAdd[1, format["# vehicles: %1", _i]]; };
	}],
	
	["Skills",
	{
		((findDisplay 4) displayCtrl 4) ctrlSetStructuredText parseText "Your Skills";
		lbAdd[1, ""];
		lbAdd[1, ""];
		{
			lbAdd[1, format["%1, %2", (_x select 1), ((round((_x select 2) * 100))/100)]];
		} forEach TNL_gVar_arr_skills;
	
	}],
	
	["Laws",
	{
		((findDisplay 4) displayCtrl 4) ctrlSetStructuredText parseText "Laws";
		lbAdd[1, ""];
		lbAdd[1, ""];
		_i = 0;
		{
			_i = _i + 1;
		
			lbAdd[1, format["%1: %2", _i, _x]];
		} forEach lawsArray;
	}],
	
	["Taxes and Mayor",
	{
		((findDisplay 4) displayCtrl 4) ctrlSetStructuredText parseText "Taxes and Mayor";
		lbAdd[1, ""];
		lbAdd[1, ""];
		if (currentMayor != "") then
		{
			lbAdd[1, format["Mayor: %1", currentMayor]];
		}
		else
		{
			lbAdd[1, "Mayor: No mayor!"];
		};
		
		lbAdd[1, format["Money on Government Account: £%1", GovernmentTaxAccount]];
		{
			lbAdd[1, format["%1: %2", (_x select 1), (_x select 2)]];
		} forEach INV_ItemTypenArray;
		
		lbAdd[1, format["Bank Transfer tax: %1 Percent", bank_steuer]];
		lbAdd[1, format["Fuel: %1 Percent", GblFuelTaxes]];
		lbAdd[1, format["Income-Tax(0-1000$): %1 Percent", GblIncomeTaxClass1]];
		lbAdd[1, format["Income-Tax(1001-4000$): %1 Percent", GblIncomeTaxClass2 ]];
		lbAdd[1, format["Income-Tax(4001-9999$): %1 Percent", GblIncomeTaxClass3]];
		lbAdd[1, format["Income-Tax(10000-20000$): %1 Percent", GblIncomeTaxClass4]];
		lbAdd[1, format["Income-Tax(>=20001$): %1 Percent", GblIncomeTaxClass5]];
		lbAdd[1, format["Manufacturing-Tax: %1$", GblFactTax]];
		lbAdd[1, format["Wealth-tax : %1 Percent", GblWealthTax]];
		lbAdd[1, format["Welfare Incomelimit: %1$", GblWelfareIncomeLimit]];
		lbAdd[1, format["Welfare Account-Limit: %1$", GblWelfareBankLimit]];
		lbAdd[1, format["Welfare Amount: %1$", add_civmoney]];
		lbAdd[1, format["Mayor Salary: %1$", MayorExtraPay]];
		lbAdd[1, format["Police Chief Salary: %1$", PoliceChiefExtraPay]];
		lbAdd[1, format["Bank Interest: %1 Percent", zinsen_prozent]];
		lbAdd[1, format["Police Basic-Salary: %1$",  add_copmoney]];
	}],
	
	["Wanted List",
	{
		((findDisplay 4) displayCtrl 4) ctrlSetStructuredText parseText "Criminals";
		lbAdd[1, ""];
		lbAdd[1, ""];
		_totalWanted = 0;
		{
			_player = _x;
			_bounty = 0;
			_wanted = 0;	
			
			call compile format ["_bounty = bounty_%1; _wanted = %1_wanted;", _player]; 
			

			if (_wanted > 0) then
			{
				lbAdd[1, format["%2, Bounty: $%1", _bounty, (name _player) call TNL_fplayer_formatName]];
				_totalWanted = _totalWanted + 1;
			};
		
		} forEach ([] call TNL_cfplayer_activeSlots);
		
		if (_totalWanted == 0) then
		{
			lbAdd[1, "There is nobody on the wanted list!"];
		};
	}],
	
	["Drug Prices",
	{
		((findDisplay 4) displayCtrl 4) ctrlSetStructuredText parseText "Drug Prices";
		lbAdd[1,""];
		lbAdd[1,""];
		{
			_name = (_x select 0) call TNL_finv_getItemName;
			_sellPrice = (((_x select 0) call TNL_finv_getItemSellPrice) + (_x select 1));
			lbAdd[1, format["%1: $%2", (_x select 0) call TNL_finv_getItemName, _sellPrice]];
		} forEach drugPriceFlunctuation;
	}],
	
	["Shops",
	{
		((findDisplay 4) displayCtrl 4) ctrlSetStructuredText parseText "Shops";
		lbAdd[1,""];
		lbAdd[1,""];
		
		{
			_stock = (_x select 0) getVariable "stock";
			_open = (_x select 0) getVariable "open";
			_owner = (_x select 0) call TNL_fcorp_getFirmOwner;
			_name = (_x select 0) getVariable "name";
			
			lbAdd[1,format["%1 - %2", _name, _owner]];
			lbAdd[1,format["Open: %1", _open]];
			lbAdd[1,"Stocks:"];
			
			{
				_item = (_x select 0);
				_sellPrice = ((_x select 1) select 1);
				_amount = (_x select 2);
				
				if (_amount > 0) then
				{
					lbAdd[1,format["%1, $%2, %3x", _item call TNL_finv_getItemName, _sellPrice, _amount]];
				};
			} forEach _stock;
			
		
			
			lbAdd[1,""];
		
		} forEach TNL_gVar_arr_playerShops;
	
	}],
	
	["Workplaces",
	{
		((findDisplay 4) displayCtrl 4) ctrlSetStructuredText parseText "Workplaces";
		lbAdd[1,""];
		lbAdd[1,""];
		
		{
			_obj = (_x select 2);
			_owner = _obj call TNL_fcorp_getFirmOwner;
			_stock = (_x select 1);
			_canBuy = _obj getVariable "canBuy";
			_name = _obj getVariable "wpname";
			
			
			if (_owner == "public owners") then
			{
				_stock = _obj getVariable "price";
			};
			
			lbAdd[1,format["%1 - %2", _name, _owner]];
			lbAdd[1,format["Can buy stock: %1", _canBuy]];
			
			lbAdd[1,"Stocks:"];
			{
				_item = _x select 0;
				_buyPrice = _x select 1;
				_sellPrice = _x select 2;
				_minStock = _x select 3;
				_maxStock = _x select 4;
				
				lbAdd[1,format["%1, $%2, $%3, min: %4x, max: %5x", _item call TNL_finv_getItemName, _buyPrice, _sellPrice, _minStock, _maxStock]];
			
			} forEach _stock;
			
		lbAdd[1,""];
		} forEach TNL_gVar_workplaces;
	}],
	
	["Factories",
	{
		((findDisplay 4) displayCtrl 4) ctrlSetStructuredText parseText "Factory Types";
		lbAdd[1,""];
		lbAdd[1,""];
		
		{
			_repaired = (([(_x select 0), "repaired"] call TNL_ffact_getSetting) select 1);
			_name = ((_x select 1) select 0);
			_owner = (_x select 0) call TNL_fcorp_getFirmOwner;
			_factoryType = (([(_x select 0), "factoryType"] call TNL_ffact_getSetting) select 1);
		
			{
				if (_x select 0 == _factoryType) exitWith
				{
					_factoryType = (_x select 1) select 0;
				};
			} forEach TNL_gVar_arr_fact_types;
			
			if (_factoryType == "") then
			{
				_factoryType = "No type";
			};
			
			lbAdd[1,format["%1 - %2", _name, _owner]];
			lbAdd[1,format["Type: %1", _factoryType]];
			lbAdd[1,format["Repaired: %1", _repaired]];
			
			lbAdd[1,""];
			
		} forEach TNL_gVar_arr_fact_factorys;
	
	
	}],
	
	["Keys",
	{
		((findDisplay 4) displayCtrl 4) ctrlSetStructuredText parseText "Key bindings";
		lbAdd[1,""];
		lbAdd[1,""];
		
		lbAdd[1,"Shift-0 = Toggle mining personal or corporation"];
		lbAdd[1,"Spacebar = Toggle siren"];
		lbAdd[1,"Alt-0 = Say text settings"];
		lbAdd[1,"Alt-1 to 4 = Say texts"];
		lbAdd[1,"Alt-I = Inventory"];
		lbAdd[1,"Alt-K = Keychain"];
		lbAdd[1,"F = Start/Stop fishing if in fishing boat"];
	}]
];