/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

/*
	TNL_factions_actionsLoop
	* Description: Here is the function that adds and removes all the actions in the mission
*/
TNL_factions_actionsLoop = 
{
	TNL_factions_curAddingActions = true;

	/* Add on-foot actions */
	if ((!((player) call TNL_fplayer_inVehicle)) && (!TNL_gVar_bool_onFootActions)) then //if player is not in vehicle and on-foot actions have no been added then add on-foot actions
	{
		TNL_gAction_inventory = player addAction [localize "STRS_ACTION_INVENTORY", "client\useAction.sqf", ["inventory"]]; //add inventory action
		TNL_gAction_stats = player addAction ["Stats", "client\useAction.sqf", ["stats"]]; //add stats menu action
		TNL_gAction_animations = player addAction ["Animations", "client\useAction.sqf", ["anim"]]; //add animation action
		
		TNL_gVar_bool_onFootActions = true; //set added on-foot actions to true
	}; //add on-foot actions
	
	/* Remove on-foot actions */
	if (!alive player) then //if player is dead then remove actions from body
	{
			TNL_gVar_bool_onFootActions = false; //set added on-foot actions to false
			player removeAction TNL_gAction_animations; //remove animation action
			player removeAction TNL_gAction_stats;	//remove stats menu action
			player removeAction TNL_gAction_inventory; //remove inventory action
	}; //remove on-foot actions
	
	/* Add in-vehicle actions */
	if (((player) call TNL_fplayer_inVehicle) && (!TNL_gVar_bool_inVehicleActions)) then //if player is in vehicle and in-vehicle actions have no beed added then add in-vehicle actions
	{
		TNL_gVar_obj_curVehicle = vehicle player; //current vehicle changed to current player
		TNL_gAction_inventory = TNL_gVar_obj_curVehicle addAction [localize "STRS_ACTION_INVENTORY", "client\useAction.sqf", ["inventory"]]; //add inventory action
		TNL_gAction_stats = TNL_gVar_obj_curVehicle addAction ["Stats", "client\useAction.sqf", ["stats"]]; //add stats menu action
		TNL_gVar_bool_inVehicleActions = true; //in-vehicle actions added set to true
	}; //add in-vehicle actions
	
		
	/* Remove in-vehicle actions */
	if ((vehicle player != TNL_gVar_obj_curVehicle) && (TNL_gVar_bool_inVehicleActions) || (!alive player)) then //if player is not in a vehicle and vehicle actions have been added then remove in-vehicle actions
	{
		TNL_gVar_obj_curVehicle removeAction TNL_gAction_inventory; //remove inventory action
		TNL_gVar_obj_curVehicle removeAction TNL_gAction_stats; //remove stats menu action
		TNL_gVar_bool_inVehicleActions = false; //in-vehicle actions added set to false
	}; //remove in-vehicle actions
	
	/* Bank Actions */
	_i = 0;
	{
		_Object = (_x select 0);
		_actionText = (_x select 1);
		_added = (TNL_gVar_arr_bankActions select _i);

		/* Add bank actions */
		if ((player distance _Object <= 5) && (_added == 0)) then
		{
			call compile format['action_bank%3 = player addAction ["%2", "client\useAction.sqf", ["bank", "%2"]];', _Object, _actionText, (_i)];
			
			if ((_object == MainBank) and (phasweapon) and (!isCop)) then
			{
				action_robbank_1 = player addAction ["Rob Bank", "slr\bankrob.sqf", ["rob"]];
			};
			
			if (_object == MainBank) then
			{
				TNL_gAction_paycheckAcc = player addAction["Paycheck Account", "client\useAction.sqf", ["paycheck"]];
				TNL_gAction_corporationRegister = player addAction["Register Corporation", "client\useAction.sqf", ["corporation", "registerDlg"]];
				TNL_gAction_corporationSelect = player addAction["Corporations", "client\useAction.sqf", ["corporation", "selectDlg"]];
			};
			
			TNL_gVar_arr_bankActions set[_i,1];
		};
		
		/* Remove bank actions */
		if ((player distance _Object > 5) && (_added == 1) || (!alive player)) then
		{
			call compile format['player removeAction action_bank%1', (_i)];
			
			if (_object == MainBank) then
			{
				player removeAction action_robbank_1;
				player removeAction TNL_gAction_corporationRegister;
				player removeAction TNL_gAction_corporationSelect;
				player removeAction TNL_gAction_paycheckAcc;
			};
			
			TNL_gVar_arr_bankActions set[_i,0];
		};
		
		//Remove Action if has no weapon
		if (not(phasweapon)) then
		{
			player removeAction action_robbank_1;
		};
		
		_i = _i + 1;
	} forEach TNL_gVar_arr_banks; //for each bank

	/* Shop Actions */
	_i = 0;
	{
		_shopObject = (_x select 0);
		_actionText = (_x select 1);
		_added = (TNL_gVar_arr_shopActions select _i);

		/* Add shop actions */
		if ((player distance _shopObject <= 5) && (_added == 0)) then
		{
			call compile format['action_shop%3 = player addAction ["%2", "client\useAction.sqf", ["shop", %1]];', _shopObject, _actionText, (_i)];
			TNL_gVar_arr_shopActions set[_i,1];
		};
		
		/* Remove shop actions */
		if ((player distance _shopObject > 5) && (_added == 1) || (!alive player)) then
		{
			call compile format['player removeAction action_shop%1', (_i)];
			TNL_gVar_arr_shopActions set[_i,0];
		};
		
		_i = _i + 1;
	} forEach TNL_ShopArray; //for each shop
	
	//Gas Station Actions
	_i = 0;
	{
		_added = (TNL_gVar_arr_gasStationActions select _i);
		
		if ((TNL_gVar_obj_curVehicle distance (_x select 0) <= 10) && (_added == 0)) then
		{
			if (typeOf TNL_gVar_obj_curVehicle in ["V3S_Refuel_TK_GUE_EP1", "MtvrRefuel", "KamazRefuel"]) then
			{
				call compile format['action_gasstation%1 = TNL_gVar_obj_curVehicle addAction["Refuel station", "client\useAction.sqf", ["gasstationrefuel", %2]];', _i, (_x select 0)];
				TNL_gVar_arr_gasStationActions set[_i,1];
			};
		};
		
		if ((TNL_gVar_obj_curVehicle distance (_x select 0) > 10) && (_added == 1) || (!alive TNL_gVar_obj_curVehicle) or (vehicle player != TNL_gVar_obj_curVehicle))  then
		{
			call compile format['TNL_gVar_obj_curVehicle removeAction action_gasstation%1', (_i)];
			TNL_gVar_arr_gasStationActions set[_i,0];
		};
		_i = _i + 1;
	} forEach TNL_gas_gasStations;
	
	/* License shop actions */
	_i = 0;
	{
		_licObject = (_x select 0);
		_actionText = (_x select 1);
		_added = (TNL_gVar_arr_licenseActions select _i);
		
		/* Add license actions */
		if ((player distance _licObject <= 5) && (_added == 0)) then
		{
			call compile format['action_license%1 = player addAction["%2", "client\useAction.sqf", ["license", %3]];', _i, _actionText, _licObject];
			TNL_gVar_arr_licenseActions set[_i,1];
		};
		
		/* Remove license actions */
		if ((player distance _licObject > 5) && (_added == 1) || (!alive player)) then
		{
			call compile format['player removeAction action_license%1', (_i), _licObject];
			TNL_gVar_arr_licenseActions set[_i,0];
		};
		
		_i = _i + 1;	
	} forEach TNL_arr_lic_licensePurchase; //for each license shop
	
	//Player Actions
	_i = 0;
	{
		_object = _x;
		_added = (TNL_gVar_arr_playerActions select _i);

		if ((player distance _object <= 5) && (_added == 0) && (_object != player) && (alive _object)) then
		{
			call compile format['action_interaction%1 = _object addAction["Interact %3", "client\useAction.sqf", ["interaction", _object]];', _i, _object, (name _object) call TNL_fplayer_formatName];
			TNL_gVar_arr_playerActions set[_i,1];
		};
		
		if ((player distance _object > 5) || (not(alive _object)) && (_added == 1)) then
		{
			call compile format['_object removeAction action_interaction%1', (_i), _object];
			TNL_gVar_arr_playerActions set[_i,0];
		};
	
		
		_i = _i + 1;
	} forEach ([] call TNL_cfplayer_activeSlots);
	
	/* Stock Market Actions */
	_i = 0;
	{
		_object = (_x select 0);
		_actionName = (_x select 1);
		_distance = (_x select 2);
		_added = (TNL_gVar_arr_stockMarketActions select _i);
		
		if ((player distance _object <= _distance) && (_added == 0)) then
		{
			call compile format['action_stockmarket%1 = _object addAction["%2", "client\useAction.sqf", ["stockmarket"]];', _i, _actionName];
			TNL_gVar_arr_stockMarketActions set[_i,1];
		};
		
		if ((player distance _object > _distance) && (_added == 1)) then
		{
			call compile format['_object removeAction action_stockmarket%1', _i];
			TNL_gVar_arr_stockMarketActions set[_i,0];
		};
	
		_i = _i + 1;
	} forEach TNL_gVar_arr_stockExchanges;
	
	/* Player shops */
	_i = 0;
	{
		_object = (_x select 0);
		_actionName = (_x select 2);
		//_storage = (_x select 3);
		_added = (TNL_gVar_arr_playerShopActions select _i);
		_corp = (_object) call TNL_fcorp_getFirmOwner;

		if ((player distance _object <= 7) && (_added == 0)) then
		{
			call compile format['action_playershop%1 = player addAction["%2", "client\useAction.sqf", ["playerShop", [%3, %3]]];', _i, _actionName, _object];
			
			if (([_object, [TNL_db_charName select 0, TNL_db_charName select 1]] call TNL_ffact_isOwner) or (([_corp, TNL_db_charName] call RPP_fnc_employee_getAccessLevel) >= 0)) then
			{
				call compile format['action_manageshop%1 = player addAction["(Owner) Manage shop", "client\useAction.sqf", ["playerShopManage", [%3, %3]]];', _i, _actionName, _object];
			};
			
			TNL_gVar_arr_playerShopActions set[_i,1];
		};
		
		if ((player distance _object > 7) && (_added == 1)) then
		{
			call compile format['player removeAction action_playershop%1', _i];
			call compile format['player removeAction action_manageshop%1', _i];
			TNL_gVar_arr_playerShopActions set[_i,0];
		};
	
		_i = _i + 1;
	} forEach TNL_gVar_arr_playerShops;
	
	
	/* Governors Office Actions */
	if ((player distance governorsOffice <= 7) && !(TNL_gAction_governorsOffice)) then
	{
		TNL_gAction_voteMayor = player addAction["Vote Mayor", "client\useAction.sqf", ["mayorVote"]];
		
		if (isMayor) then
		{
			TNL_gAction_setTaxes = player addAction["Set Taxes!", "client\useAction.sqf", ["setTaxes"]];
			TNL_gAction_mayorResign = player addAction["(Mayor) Resign", "client\useAction.sqf", ["MayorResign"]];
			TNL_gAction_setLaws = player addAction["Set Laws", "client\useAction.sqf", ["setLaws"]];
			TNL_gAction_releasePrisoner = player addAction["Wanted/Release", "client\useAction.sqf", ["wantedrelease"]];
		};
			TNL_gAction_governorsOffice = true;
	};
	
	if ((player distance governorsOffice > 7) && (TNL_gAction_governorsOffice)) then
	{
		player removeAction TNL_gAction_voteMayor;
		player removeAction TNL_gAction_setTaxes;
		player removeAction TNL_gAction_mayorResign;
		player removeAction TNL_gAction_setLaws;
		player removeAction TNL_gAction_releasePrisoner;
		TNL_gAction_governorsOffice = false;
	};
	
	//Gathering Actions
	_i = 0;
	{
		_markerName = ((_x select 0) select 0);
		_gatherClass = ((_x select 0) select 1);
		_distance = ((_x select 1) select 0);
		_actionName = ((_x select 1) select 1);
		_requiredInVehicle = ((_x select 2) select 0);
		_requiredVehicles = ((_x select 2) select 1);	
		_corporationOwned = (_x select 3);
		_added = (TNL_gVar_arr_gatherActions select _i);

		if ((player distance (getMarkerPos _markerName) <= _distance) && (_added == 0)) then
		{
			if (_requiredInVehicle) then
			{
				if (((player) call TNL_fplayer_inVehicle) && ([vehicle player, _requiredVehicles] call TNL_fgather_IsInGatherVehicle)) then
				{
					TNL_gVar_arr_gatherActions set[_i,1];

					if (!_corporationOwned) then
					{
						call compile format['action_gather%1 = TNL_gVar_obj_curVehicle addAction["%2", "client\useAction.sqf", ["gather", ["%3", "normal"]]];', _i, _actionName, _gatherClass];
					};

					if (_corporationOwned) then
					{
						call compile format['action_gather%1 = TNL_gVar_obj_curVehicle addAction["%2", "client\useAction.sqf", ["corp_gather", ["%3", "normal", "%4"]]];', _i, _actionName, _gatherClass, _markerName];
						call compile format['action_gatherviewprices%1 = TNL_gVar_obj_curVehicle addAction["Prices", "client\useAction.sqf", ["corp_wp_prices", ["%3", "normal", "%4"]]];', _i, _actionName, _gatherClass, _markerName];
						call compile format['action_gatherpurchasestock%1 = TNL_gVar_obj_curVehicle addAction["Buy Stock", "client\useAction.sqf", ["corp_wp_buystock", ["%3", "normal", "%4"]]];', _i, _actionName, _gatherClass, _markerName];
					};
				};
			}
			else
			{
				if !((player) call TNL_fplayer_inVehicle) then
				{
					if (!_corporationOwned) then
					{
						call compile format['action_gather%1 = player addAction["%2", "client\useAction.sqf", ["gather", ["%3", "normal"]]];', _i, _actionName, _gatherClass];
					};
					
					if (_corporationOwned) then
					{
						call compile format['action_gather%1 = player addAction["%2", "client\useAction.sqf", ["corp_gather", ["%3", "normal", "%4"]]];', _i, _actionName, _gatherClass, _markerName];
						call compile format['action_gatherviewprices%1 = player addAction["Prices", "client\useAction.sqf", ["corp_wp_prices", ["%3", "normal", "%4"]]];', _i, _actionName, _gatherClass, _markerName];
						call compile format['action_gatherpurchasestock%1 = player addAction["Buy Stock", "client\useAction.sqf", ["corp_wp_buystock", ["%3", "normal", "%4"]]];', _i, _actionName, _gatherClass, _markerName];
					};
					
					TNL_gVar_arr_gatherActions set[_i,1];
				};
			};
		};
		
		if ((player distance (getMarkerPos _markerName) > _distance) && (_added == 1) || (!alive player)) then
		{
					call compile format['player removeAction action_gather%1', _i];

				if (_corporationOwned) then
				{
					call compile format['player removeAction action_gatherviewprices%1', _i]; 
					call compile format['player removeAction action_gatherpurchasestock%1', _i]; 
				};
				TNL_gVar_arr_gatherActions set[_i,0];
		};
		
		if ((_requiredInVehicle) && (vehicle player != TNL_gVar_obj_curVehicle) || (!alive player) && (_added == 1)) then
		{
				call compile format['TNL_gVar_obj_curVehicle removeAction action_gather%1', _i];
				
				if (_corporationOwned) then 
				{ 
					call compile format['TNL_gVar_obj_curVehicle removeAction action_gatherviewprices%1', _i]; 
					call compile format['TNL_gVar_obj_curVehicle removeAction action_gatherpurchasestock%1', _i]; 
				};
				
				TNL_gVar_arr_gatherActions set[_i,0];
		};
	
		_i = _i + 1;
	} forEach TNL_gVar_arr_gatherLocations;
	
	
	//Gather
	_i = 0;
	{	
		_terrainType = (_x select 0);
		_actionClass = (_x select 1);
		_requiredItems = (_x select 2);
		_actionText = ((_x select 3) select 0);
		_actionScript = ((_x select 3) select 1);
		_actionParams = ((_x select 3) select 2);
		_haveRequiredItems = (_requiredItems) call TNL_fgather_hasRequiredItems;
		_curTerrain = SurfaceType getpos player;
		_added = (TNL_gVar_arr_groundAddedActions select _i);
		_y = 0;
		_x = 0;
		_isWater = surfaceIsWater [(position player select 0)+_x, (position player select 1)+_y];
		
		if (_isWater) then
		{
			_curTerrain = "#Water";
		};
		
		if ((_haveRequiredItems) && (_curTerrain == _terrainType) && (_added == 0) && (!([player] call TNL_fplayer_inBuilding))) then
		{
			call compile format['action_groundGather%1 = player addAction["%2", "%3", %4];', _actionClass, _actionText, _actionScript, _actionParams];
			TNL_gVar_arr_groundAddedActions set[_i,1];
		};
		
		if (!(_haveRequiredItems) || (_curTerrain != _terrainType) && (_added == 1)) then
		{
			call compile format['player removeAction action_groundGather%1', _actionClass];
			TNL_gVar_arr_groundAddedActions set[_i,0];
		};
	
		_i = _i + 1;
	} forEach TNL_gVar_arr_groundActions;
	
	/* Storage actions */
	_i = 0;
	{
		_object = (_x select 0);
		_actionText = (_x select 1);
		_added = (TNL_gVar_arr_storageActions select _i);
	
		if ((player distance _object <= 7) && (_added == 0) && (!((player) call TNL_fplayer_inVehicle))) then
		{
			TNL_gVar_arr_storageActions set[_i,1];
			call compile format['action_storage%1 = _object addaction["%3", "client\useAction.sqf", ["trunk",_object]];', _i, _object, _actionText];
		};
		
		if ((player distance _object > 7) && (_added == 1) || (!alive player)) then
		{
			call compile format['_object removeAction action_storage%2', _object, _i];
			TNL_gVar_arr_storageActions set[_i,0];
		};
	
		_i = _i + 1;
	} forEach Gvar_arr_trunk_storages;
	
	/* Factory actions */
	_i = 0;
	{
		_object = (_x select 0);
		_actionText = ((_x select 1) select 0);
		_actionDistance = ((_x select 1) select 1);
		_added = (TNL_gVar_arr_factoryActions select _i);
		_repaired = (([_object, "repaired"] call TNL_ffact_getSetting) select 1);
		_selected = (([_object, "selectedType"] call TNL_ffact_getSetting) select 1);

		if ((player distance _object <= _actionDistance) && (_added == 0)) then
		{
			if (_repaired) then
			{
				call compile format['action_factory_complete%1 = player addAction["%2 (Menu)", "client\useAction.sqf", ["factory",["openComplete",%3]]];', _i, _actionText, _object];
			}
			else
			{
				if (_selected) then
				{
					call compile format['action_factory_repair%1 = player addAction["%2 (Menu)", "client\useAction.sqf", ["factory",["openRepair",%3]]];', _i, _actionText, _object];
				}
				else
				{
					if ([_object, [TNL_db_charName select 0, TNL_db_charName select 1]] call TNL_ffact_isOwner) then
					{
						call compile format['action_factory_select%1 = player addAction["%2 (Select type)", "client\useAction.sqf", ["factory",["select",%3]]];', _i, _actionText, _object];
					};
				};
			};
			
			TNL_gVar_arr_factoryActions set[_i,1];
		};
		if ((player distance _object > _actionDistance) && (_added == 1) || (!alive player)) then
		{
			call compile format['player removeAction action_factory_complete%1', _i];
			call compile format['player removeAction action_factory_repair%1', _i];
			call compile format['player removeAction action_factory_select%1', _i];

			TNL_gVar_arr_factoryActions set[_i,0];
		};
		
		if (TNL_gVar_boolean_removeFactSelectAction) then
		{
			call compile format['player removeAction action_factory_complete%1', _i];
			call compile format['player removeAction action_factory_repair%1', _i];
			call compile format['player removeAction action_factory_select%1', _i];

			TNL_gVar_arr_factoryActions set[_i,0];
		};

		_i = _i + 1;
	} forEach TNL_gVar_arr_fact_factorys;
	if (TNL_gVar_boolean_removeFactSelectAction) then { TNL_gVar_boolean_removeFactSelectAction = false; };
	
	
	if (([player, "RIFLE"] call TNL_fplayer_hasWeaponType) or ([player, "PISTOL"] call TNL_fplayer_hasWeaponType)) then 
	{
		phasweapon = true;
	} 
	else 
	{
		phasweapon = false;
	};
	
	// Detect pistol
	{ 
		if (((_x call TNL_finv_getItemTypes) select 1) == "PISTOL") then 
		{
			HandWeapon = true;
		} 
		else 
		{
			HandWeapon = false;
		}; 
		
	} forEach (weapons player);
	
	// Holster
	if ((player == vehicle player) AND (holmenu == 0) AND ((phasweapon) and (HandWeapon) and (!holstervar))) then 
	{
		action_holsterpistol = player addaction ["Holster pistol", "slr\holster.sqf",["holsterPistol"]];
		holmenu = 1;
	};
	
	if (((player != vehicle player) OR ((!phasweapon) OR (!HandWeapon)) OR (holstervar)) AND (holmenu == 1)) then 
	{
		player removeAction action_holsterpistol;
		holmenu = 0;
	};
	
	//Unholster
	if ((player == vehicle player) && (unholmenu == 0) && (unholstervar)) then 
	{
		action_unholsterpistol = player addaction ["Unholster pistol", "slr\holster.sqf",["unholsterPistol"]];
		unholmenu = 1;
	};
	
	if (((player != vehicle player) OR (!unholstervar)) AND (unholmenu == 1)) then 
	{
		player removeAction action_unholsterpistol;
		unholmenu = 0;
	};	
	
	/* Taxi Actions */
	if ((player distance taxijob <= 7) and (!TNL_gAction_taxiJobAction) and (!isCop)) then 
	{
		workplace_gettaxiaction = player addAction ["Taxi job", "slr\taxiJob.sqf", ["getajob_taxi"]]; 
		TNL_gAction_taxiJobAction = true;
	};														

	if (((player distance taxijob > 7) and (TNL_gAction_taxiJobAction))) then 
	{
		player removeAction workplace_gettaxiaction; 
		TNL_gAction_taxiJobAction = false;
	};	
	
	/* Import/Export Actions */
	if ((player distance exportShip <= 7) and (!TNL_gAction_exportAction) and (!isCop)) then 
	{
		exportShip_getAction = player addAction ["Import/Export", "client\useAction.sqf", ["importexport"]]; 
		TNL_gAction_exportAction = true;
	};														

	if (((player distance exportShip > 7) and (TNL_gAction_exportAction))) then 
	{
		player removeAction exportShip_getAction; 
		TNL_gAction_exportAction = false;
	};	

	/* Delivery Actions */
	if ((player distance delivery_job <= 7) and (!TNL_gAction_deliveryJobAction) and (!isCop)) then 
	{
		workplace_getdeliveryaction = player addAction ["Delivery Job", "client\useAction.sqf", ["delivery"]]; 
		TNL_gAction_deliveryJobAction = true;
	};														

	if (((player distance delivery_job > 7) and (TNL_gAction_deliveryJobAction))) then 
	{
		player removeAction workplace_getdeliveryaction; 
		TNL_gAction_deliveryJobAction = false;
	};			
	
	/* Drug Dealer Actions */
	if ((player distance drugvehicle <= 5) and (!TNL_gAction_drugDealer) and ((alive drugvehicle) and (alive drug_einheit))) then 
	{
		if (!(iscop)) then 
		{

			if (isDealer) then 
			{ 
				actioncanceldeal = player addAction["Stop drug dealing", "slr\dealerJob.sqf", ["cancel"]];
			}
			else
			{
				actiondrugdeal = player addAction["(Start Dealing) Get Contact Numbers", "slr\dealerJob.sqf", ["contacts"]];
			};
			actionconvertmoney = player addAction["Illegal Money -> Money", "slr\illegalmoney.sqf", []];
		}
		else
		{
			actionbustdrugdealer = player addaction ["Bust Drug Dealer", "slr\bustdealer.sqf", []];
		};
		TNL_gAction_drugDealer = true;
	};
	
	if ((player distance drugvehicle > 5) and (TNL_gAction_drugDealer) or (!alive drugvehicle) or (!alive drug_einheit)) then 
	{
			player removeaction actiondrugdeal;
			player removeAction actionbustdrugdealer;
			player removeAction actioncanceldeal;
			player removeAction actionconvertmoney;
			TNL_gAction_drugDealer = false;
	};
	
	TNL_factions_curAddingActions = false;
};