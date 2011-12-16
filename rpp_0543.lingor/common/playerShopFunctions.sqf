TNL_fps_playerShopAction =
{
	_storageObj = _this select 0;
	_obj = _this select 1;
	
	if (!(_obj getVariable "open")) exitWith
	{
		["The shop is closed at the moment, contact the shop owner."] call TNL_fextHint_Hint;
	};
	
	_Dlg = createDialog "TNL_DlgPlayerShop";
	
	fps_presult = 2;
	
	((findDisplay 1702) displayCtrl 1) ctrlSetStructuredText parseText "Purchase from shop";
	((findDisplay 1702) displayCtrl 25) buttonSetAction "fps_presult = 1;";
	((findDisplay 1702) displayCtrl 2) ctrlSetEventHandler ["LBSelChanged","fps_presult = 5;"];
	((findDisplay 1702) displayCtrl 26) ctrlSetEventHandler ["KeyDown","fps_presult = 6;"];

	[_obj] spawn TNL_fps_playerShopManage;
};

TNL_fps_playerShopCorp =
{
	private ["_object","_dlg"];
	_object = _this;
	_dlg = createDialog "DlgPlayershopManage";
	
	TNL_gVar_curActiveShop = _object;
};

TNL_fps_playerShopRemStock = 
{
	private ["_obj", "_Dlg", "_corp"];
	_obj = _this select 0;
	_corp = (_obj) call TNL_fcorp_getFirmOwner;
	
	if ((([_corp, TNL_db_charName] call RPP_fnc_employee_getAccessLevel) >= 1) or ([_obj, [TNL_db_charName select 0, TNL_db_charName select 1]] call TNL_ffact_isOwner)) then
	{
		_Dlg = createDialog "TNL_DlgPlayerShop";
		
		fps_presult = 2;
		
		((findDisplay 1702) displayCtrl 1) ctrlSetStructuredText parseText "Add/Remove stocks";
		((findDisplay 1702) displayCtrl 4) ctrlSetStructuredText parseText "";
		
		((findDisplay 1702) displayCtrl 25) ctrlSetText "Remove";
		((findDisplay 1702) displayCtrl 25) buttonSetAction "fps_presult = 4;";
		
		((findDisplay 1702) displayCtrl 2) ctrlSetEventHandler ["LBSelChanged","fps_presult = 5;"];
		
		[_obj] spawn TNL_fps_playerShopManage;
	}
	else
	{
		["You are not authorised to do this."] call TNL_fextHint_Hint;
	};
};

TNL_fps_playerShopOpenNameDlg =
{	
	private ["_object"];
	_object = _this;
	
	createDialog "TNL_dlg_genEditInput";
	
	((findDisplay 1103) displayCtrl 10) buttonSetAction format['[ctrlText 13, %1] call TNL_fps_playerShopSetName;', _object];
	((findDisplay 1103) displayCtrl 11) buttonSetAction "closeDialog 0;";
	((findDisplay 1103) displayCtrl 1) ctrlSetStructuredText parseText "Set Shop Name";
	((findDisplay 1103) displayCtrl 2) ctrlSetStructuredText parseText "Select a new name for your shop!";
	((findDisplay 1103) displayCtrl 12) ctrlSetText "Name:";
};

TNL_fps_playerShopSetName = {};
//Disabled due to bug, version 0.535
/*
{
	private ["_name", "_object"];
	_name = _this select 0;
	_object = _this select 1;

	closeDialog 0;
	
	[format["You change the shop name to: %1", _name]] call TNL_fextHint_Hint;
	
	_object setVariable ["name", _name, true];
	[TNL_gVar_arr_tables_shops, [_object], [[(_object getVariable "stock"), "stock"], [_name, "name"]] ] call TNL_fsav_clientRequestSave;
	
	[{ [] call TNL_fps_loadShopMarkers; }, []] call TNL_fnet_execPublic;
};
*/

TNL_fps_loadShopMarkers =
{
	{
		_markerName = format["%1_marker", (_x select 0)];
		_markerName setMarkerTextLocal ((_x select 0) getVariable "name");
	} forEach TNL_gVar_arr_playerShops;
};

TNL_fps_playerShopAddStock =
{
	private ["_object", "_storageObj"];
	_object = _this select 0;
	_storageObj = empty;
	closeDialog 0;
	
	if (!(createDialog "TNL_dlg_genYesNo")) exitWith 
	{
		hint "Dialog Error!";
	};
		
	ynResult = 0;
	((findDisplay 1101) displayCtrl 1) ctrlSetStructuredText parseText "Add Stock";
	((findDisplay 1101) displayCtrl 2) ctrlSetStructuredText parseText "By pressing yes all the storage will be removed from your shop's private storage and added to the shop stocks.";
	((findDisplay 1101) displayCtrl 10) buttonSetAction "ynResult = 1; closeDialog 0;";
	((findDisplay 1101) displayCtrl 11) buttonSetAction "ynResult = 0; closeDialog 0;";
	waitUntil{(isNull(findDisplay 1101))};
		
	if (ynResult == 0) exitWith
	{
		["You change your mind"] call TNL_fextHint_Hint;
	};
		
	{
		if (_x select 0 == _object) exitWith
		{
			_storageObj = (_x select 3);
		};
	} forEach TNL_gVar_arr_playerShops;
		
	_storage = _storageObj getVariable "storage";
	_toAdd = [];
		
	{
		if (_x select 1 > 0) then
		{
			_toAdd set[(count _toAdd), [_x select 0, _x select 1]];
			[_storageObj, _x select 0, -(_x select 1)] call TNL_ftrunk_addStorage;
		};
	} forEach _storage;
		
	_stocks = _object getVariable "stock";
		
	{
		_item = (_x select 0);
		_amount = (_x select 1);
		_found = false;
			
		{
			if (_x select 0 == _item) exitWith
			{
				_x set[2,((_x select 2)+_amount)];
				_found = true;
			};
		} forEach _stocks;
			
		if (!(_found)) then
		{
			_stocks set[count _stocks, [_item,[99999,99999],_amount]];
		};
	} forEach _toAdd;
		
	_object setVariable ["stock", _stocks, true];
	[TNL_gVar_arr_tables_shops, [(_this select 0)], [[_stock, "stock"], [((_this select 0) getVariable "name"), "name"]] ] call TNL_fsav_clientRequestSave;
	["Anything from the shop storage has been removed and added to the shop stocks, dont forget to set the prices"] call TNL_fextHint_Hint;
};

TNL_fps_playerShopSetPrices =
{
	private ["_obj", "_corp", "_dlg"];
	_obj = _this select 0;
	_corp = (_obj) call TNL_fcorp_getFirmOwner;
	

	if (([_obj, [TNL_db_charName select 0, TNL_db_charName select 1]] call TNL_ffact_isOwner) or (([_corp, TNL_db_charName] call RPP_fnc_employee_getAccessLevel) >= 1)) then
	{
		_Dlg = createDialog "TNL_dlg_genListSelectAmount";
	
		fps_presult = 2;
	
		((findDisplay 1105) displayCtrl 1) ctrlSetStructuredText parseText "Set Prices";	
		((findDisplay 1105) displayCtrl 3) ctrlSetText "Set Price";
		((findDisplay 1105) displayCtrl 3) buttonSetAction "fps_presult = 3;";
		((findDisplay 1105) displayCtrl 4) ctrlSetText "Close";
		((findDisplay 1105) displayCtrl 4) buttonSetAction "CloseDialog 0;";
		[_obj, 1105] spawn TNL_fps_playerShopManage;
	}
	else
	{
		["You are not authorised to do this."] call TNL_fextHint_Hint;
	};
	//_obj call TNL_fps_playerShopCorp;
};

TNL_fps_playerShopToggle =
{
	private ["_obj", "_open"];
	_obj = _this select 0;
	
	_open = _obj getVariable "open";
	
	_open = !_open;
	
	_obj setVariable["open", _open, true];
	//[TNL_gVar_arr_tables_shopsLoad, [(_this select 0)], [ [_open, "open"] ] ] call TNL_fsav_clientRequestSave;
	
	if (_open) then
	{
		["The shop has been opened"] call TNL_fextHint_Hint;
	}
	else
	{
		["The shop has been closed"] call TNL_fextHint_Hint;
	};
};



TNL_fps_playerShopManage =
{
	private ["_tick", "_display"];
	_tick = 0;
	_display = 1702;
	
	if (count _this >= 2) then
	{
		_display = (_this select 1);
	};
	
	while {!(isNull (findDisplay _display))} do
	{
		if (fps_presult == 1) then //Buy
		{
			if ((lbCurSel 2) >= 0) then 
			{
				_data = call compile (lbData [2, lbCurSel 2]);
				_amount = parseNumber (ctrlText ((findDisplay 1702) displayCtrl 26));
				_id = (_data select 1);
				_item = (_data select 0);
				
				//Check if amount is in stock
				_inStock = ((((_this select 0) getVariable "stock") select _id) select 2);
				_price = ((((((_this select 0) getVariable "stock") select _id) select 1) select 1) * _amount);
				
				if (_amount > 0) then
				{
					if (_inStock >= _amount) then
					{
						_corpOwner = (_this select 0) call TNL_fcorp_getFirmOwner;
						_money = "Money" call TNL_finv_getItemAmount;
						
						if (_money >= _price) then
						{
							_weight = [] call TNL_finv_getPlayerWeight;
							_itemWeight =((((_item) call TNL_finv_getItemWeight) * _amount) + (_weight select 0));
							_types = (_item) call TNL_finv_getItemTypes;
							
							if (_types select 0 in ["VEHICLE","WEAPON","MAGAZINE"]) then
							{
								_itemWeight = 0;
							};
						
							if (_itemWeight < (_weight select 1)) then
							{
								_result = false;
								_crate = call compile format['%1_crate',(_this select 0)];
								_crate setDamage 0;
								
								switch (_types select 0) do
								{
									case "VEHICLE":
									{
										//vehicle
										_z = 0;
										while {_z < _amount} do
										{
											[_item, (_this select 0)] call TNL_fmission_createVehicle;
											_z = _z + 1;
										};
										
										_result = true;
									};
									
									case "ITEM":
									{
										//Add Item
										[_item,+(_amount)] call TNL_finv_addInventoryItem;
								
										_result = true;
									};
									
									case "WEAPON":
									{
										//Add weapon
										_crate addWeaponCargo [_item,_amount];
										
										_result = true;
									};
									
									case "MAGAZINE":
									{
										//Add magazine
										_crate addMagazineCargo[_item,_amount];
										
										_result = true;
									};
									
									default
									{
										//Cannot buy this type
									};
								};	
								
								if (_result) then
								{
									//Add money to corp
									if (_corpOwner != "public owners") then
									{
										[(_this select 0), _price] call TNL_fcorp_increaseFirmIncome;
										_corpOwner = (_this select 0) call TNL_fcorp_getFirmOwner;
										_bankAmount = [_corpOwner] call TNL_fcorp_getBankAmount;
										[_corpOwner, (((_bankAmount) + (_price)))] call TNL_fcorp_setBankAmount;	
									};
									
									_stock = (_this select 0) getVariable "stock";
									{
										if (_x select 0 == _item) then
										{
											_x set[2,((_x select 2)-_amount)];
										};
									
									} forEach _stock;
									
									(_this select 0) setVariable ["stock",_stock,true];
									[TNL_gVar_str_tables_shops, [(_this select 0)], [[_stock, "stock"], [((_this select 0) getVariable "name"), "name"]] ] call TNL_fsav_clientRequestSave;
									
									//Take Money
									['money', -(_price)] call TNL_finv_addInventoryItem;	
									
									closeDialog 0;
									
									//Message you bought item
									[format["You have purchased %2 %1(s) for $%3", _item call TNL_finv_getItemName, _amount, _price]] call TNL_fextHint_Hint;
									
									
									lbClear 2;
								};
							}
							else
							{
								//Needs hint, over weight
								["You would be overweight if you did this"] call TNL_fextHint_Hint;
							};
						}
						else
						{
							//Needs hint, not enough money
							["You dont have enough money available"] call TNL_fextHint_Hint;
						};
						
					} 
					else
					{
						//Needs hint, not enough in stock
						["There is not enough of the item in stock"] call TNL_fextHint_Hint;
					};
				}
				else
				{
					//Needs hint, cant buy 1
					["You cannot do this"] call TNL_fextHint_Hint;
				};
				
			}
			else
			{
				["You cannot do this"] call TNL_fextHint_Hint;
			};
		
			fps_presult = 2;
		};
		
		if (fps_presult == 3) then //Set price
		{
			_data = call compile (lbData [2, lbCurSel 2]);
			_amount = parseNumber (ctrlText ((findDisplay _display) displayCtrl 5));
			_id = (_data select 1);
			_item = (_data select 0);
			_stock = (_this select 0) getVariable "stock";
			
			(_stock select _id) set[1,[0,_amount]];
			
			(_this select 0) setVariable["stock", _stock, true];
			[TNL_gVar_arr_tables_shops, [(_this select 0)], [[_stock, "stock"], [((_this select 0) getVariable "name"), "name"]] ] call TNL_fsav_clientRequestSave;
			
			fps_presult = 2;
		};
		
		if (fps_presult == 4) then //Remove stock
		{
			_data = call compile (lbData [2, lbCurSel 2]);
			_amount = parseNumber (ctrlText ((findDisplay _display) displayCtrl 26));
			_id = (_data select 1);
			_item = (_data select 0);
			_stock = (_this select 0) getVariable "stock";
			_storageObj = empty;
			
			_types = (_item) call TNL_finv_getItemTypes;
							
			if (_types select 0 in ["VEHICLE","WEAPON","MAGAZINE"]) then
			{
				_amount = 1;
			};
			
			{
				if (_x select 0 == (_this select 0)) exitWith
				{
					_storageObj = (_x select 3);
				};
			} forEach TNL_gVar_arr_playerShops;
	
			if (_amount > 0) then
			{	
				_inStock = ((((_this select 0) getVariable "stock") select _id) select 2);	
				
				if (_inStock >= _amount) then
				{
					if ([_storageObj, _item, +(_amount)] call TNL_ftrunk_addStorage) then
					{
						(_stock select _id) set[2,(((_stock select _id) select 2)-_amount)];
						//Hint removed
						[format["You have taken %2 %1(s) from the shop, they will be in the shop storage", _item call TNL_finv_getItemName, _amount]] call TNL_fextHint_Hint;
						
						(_this select 0) setVariable["stock", _stock, true];
						[TNL_gVar_str_tables_shops, [(_this select 0)], [[_stock, "stock"], [((_this select 0) getVariable "name"), "name"]]] call TNL_fsav_clientRequestSave;
				
					}
					else
					{
						//Hint cannot do this 
						["There is an issue at the moment"] call TNL_fextHint_Hint;
					};
				};
			};
			fps_presult = 2;
		};
		
		if (fps_presult == 5) then //Update desc & item
		{
			_data = call compile (lbData [2, lbCurSel 2]);
			_item = (_data select 0);
			
			((findDisplay _display) displayCtrl 6) ctrlSetStructuredText parseText format["Item: %1", _item call TNL_finv_getItemName];
			((findDisplay _display) displayCtrl 5) ctrlSetStructuredText parseText format["Desc: %1", _item call TNL_finv_getItemDescription];	
		
			fps_presult = 6;
		};
		
		if (fps_presult == 6) then //Update Status
		{
			_data = call compile (lbData [2, lbCurSel 2]);
			_item = (_data select 0);
			_amount = parseNumber (ctrlText ((findDisplay 1702) displayCtrl 26));
			_id = (_data select 1);
			
			//Check if amount is in stock
			_inStock = ((((_this select 0) getVariable "stock") select _id) select 2);
			_price = (((((_this select 0) getVariable "stock") select _id) select 1) select 1);
				
			((findDisplay 1702) displayCtrl 3) ctrlSetStructuredText parseText format["Item: %1<br></br>Amount: %5x<br></br>Price each: $%2<br></br>Total price: $%3<br></br>In stock: %4x<br></br>",_item call TNL_finv_getItemName, _price, (_price * _amount),_inStock,_amount];
		};
		
		if (fps_presult == 7) then //Add Stock
		{
			
		
		};
		
		if ((fps_presult == 2) or (_tick == 30))  then //Refresh buy
		{
			_i = 0;
			lbClear 2;
			_curSel = lbCurSel 2;
			
			if (_curSel <= 0) then
			{
				lbSetCurSel [2,0];
			};
			
			{
				_item = (_x select 0);
				_buyPrice = ((_x select 1) select 0);
				_sellPrice = ((_x select 1) select 1);
				_amount = (_x select 2);
				
				if (_amount > 0) then
				{
					_index = lbAdd[2, format["%1, $%2, %3x", _item call TNL_finv_getItemName, _sellPrice, _amount]];
					lbSetData[2,_index, format["['%1',%2]", _item, _i]];
				};
			
				_i = _i + 1;
			} forEach ((_this select 0) getVariable "stock");
			
			fps_presult = 0;
			
		};
		
		
		_tick = _tick + 1;
		sleep 0.1;
	};
};