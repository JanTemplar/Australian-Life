TNL_fwp_manageWorkplace = 
{
	private ["_object"];
	_object = (_this select 0);
	_dlg = createDialog "DlgWorkplaceManage";
	
	TNL_gVar_curActiveWorkplace = _object;
};

TNL_fwp_setStocks =
{
	private ["_object"];
	_object = _this;
	
	_Dlg = createDialog "TNL_dlg_genListSelectAmount";
	
	fwp_presult = 3;
	
	
	((findDisplay 1105) displayCtrl 1) ctrlSetStructuredText parseText "Set Stocks";
	
	((findDisplay 1105) displayCtrl 3) ctrlSetText "Set Min";
	((findDisplay 1105) displayCtrl 3) buttonSetAction "fwp_presult = 1;";
	
	((findDisplay 1105) displayCtrl 4) ctrlSetText "Set Max";
	((findDisplay 1105) displayCtrl 4) buttonSetAction "fwp_presult = 2;";
	
	while {!(isNull (findDisplay 1105))} do
	{
		if (fwp_presult == 1) then //Set Min Stock
		{
			_data = call compile (lbData [2, lbCurSel 2]);
			_newStock = parseNumber (ctrlText ((findDisplay 1105) displayCtrl 5));
			_idc = (_data select 3);
			_item = (_data select 0);
			_prices = ((_object) getVariable "price");
			
			((_prices select _idc) set[3,_newStock]);
			
			_object setVariable["price", _prices, true];
			[TNL_gVar_arr_tables_workplaces, [_object], [[_prices, "price"]] ] call TNL_fsav_clientRequestSave;
			
			fwp_presult = 3;
		};
		
		if (fwp_presult == 2) then //Set Max Stock
		{
			_data = call compile (lbData [2, lbCurSel 2]);
			_newStock = parseNumber (ctrlText ((findDisplay 1105) displayCtrl 5));
			_idc = (_data select 3);
			_item = (_data select 0);
			_prices = ((_object) getVariable "price");
			
			((_prices select _idc) set[4,_newStock]);
			
			_object setVariable["price", _prices, true];
			[TNL_gVar_arr_tables_workplaces, [_object], [[_prices, "price"]] ] call TNL_fsav_clientRequestSave;
			
			fwp_presult = 3;
		};
		
		if (fwp_presult == 3) then //Update display
		{
			_i = 0;
			lbClear 2;
			_curSel = lbCurSel 2;
			
			{
				_item = (_x select 0);
				_min = (_x select 3);
				_max = (_x select 4);
				
				_index = lbAdd[2, format["%1, Min: %2x, Max: %3x", _item call TNL_finv_getItemName, _min, _max]];
				lbSetData[2, _index, format["['%1', %2, %3, %4]", (_x select 0), _min, _max, _i]];
				
				_i = _i + 1;
			} forEach ((_object) getVariable "price");
			
			if (_curSel < 0) then
			{
				lbSetCurSel[2,0];
			}
			else
			{
				lbSetCurSel[2,_curSel];
			};
			
			fwp_presult = 0;
		};
		
		sleep 0.01;
	};
};	

TNL_fwp_purchaseStocks =
{
	private ["_object"];
	_gatherClass = (_this select 0);
	_gatherType = (_this select 1);
	_workplaceType = (_this select 2);
	_workplaceObj = (_workplaceType) call TNL_fwp_getWorkplaceObject;
	_corpOwner = _workplaceObj call TNL_fcorp_getFirmOwner;
	
	if (!(_workplaceObj getVariable "canBuy")) exitWith
	{
		["Cannot buy anything currently"] call TNL_fextHint_Hint;
	};
	
	_Dlg = createDialog "TNL_dlg_genListSelectAmount";
	
	fwp_presult = 2;
	
	((findDisplay 1105) displayCtrl 1) ctrlSetStructuredText parseText "Purchase";
	
	((findDisplay 1105) displayCtrl 3) ctrlSetText "Purchase";
	((findDisplay 1105) displayCtrl 3) buttonSetAction "fwp_presult = 1;";
	
	((findDisplay 1105) displayCtrl 4) ctrlSetText "Close";
	((findDisplay 1105) displayCtrl 4) buttonSetAction "CloseDialog 0;";
	
	_tick = 0;
	while {!(isNull (findDisplay 1105))} do
	{
		if (fwp_presult == 1) then //Buy
		{
			if ((lbCurSel 2) >= 0) then 
			{
				_data = call compile (lbData [2, lbCurSel 2]);
				_amount = parseNumber (ctrlText ((findDisplay 1105) displayCtrl 5));
				_idc = (_data select 2);
				_inStorage = (_data select 1);
				_item = (_data select 0);
				_minStock = [_workplaceObj, _item] call TNL_fwp_getMinStock;
				_price = 0;
				
				if (_corpOwner == "public owners") then
				{
					_price = ((([_item, _workplaceType] call TNL_fwp_getDefaultJobPrice) select 1) * _amount);
				}
				else
				{
					_price = (([_workplaceObj, _item] call TNL_fwp_getSellPrice) * _amount);
				};
				
				if ((_inStorage - _amount) >= _minStock) then
				{
					if (_amount > 0) then
					{
						if ("money" call TNL_finv_getItemAmount >= _price) then
						{
							_weight = [] call TNL_finv_getPlayerWeight;
							_itemWeight =( (((_item) call TNL_finv_getItemWeight) * _amount) + (_weight select 0));
					
							if (_itemWeight < (_weight select 1)) then
							{
								TNL_GLOBAL_CUR_TRUNK = _object;
								if ([_item,_amount] call TNL_finv_addInventoryItem) then
								{
									//Remove
									[_workplaceObj, _item, -(_amount)] call TNL_ftrunk_addStorage;
							
									//Take Money
									['money', -(_price)] call TNL_finv_addInventoryItem;
							
									//Add money to corporation
									if (_corpOwner != "public owners") then
									{
										[_workplaceObj, _price] call TNL_fcorp_increaseFirmIncome;
										_corpOwner = (_workplaceObj) call TNL_fcorp_getFirmOwner;
										_bankAmount = [_corpOwner] call TNL_fcorp_getBankAmount;
										[_corpOwner, (((_bankAmount) + (_price)))] call TNL_fcorp_setBankAmount;
									};
						
									[format["Purchase %1 %2(s) for $%3", _item call TNL_finv_getItemName, _amount, _price]] call TNL_fextHint_Hint;
								}
								else
								{
									["Cannot do that.."] call TNL_fextHint_Hint;
								};
								closeDialog 0;
							}
							else
							{
								["Will exceed your max weight!"] call TNL_fextHint_Hint;
							};
						}
						else
						{
							["You dont have enough money to purchase the items"] call TNL_fextHint_Hint;
						};
					}
					else
					{
						["You cannot buy 0 items!"] call TNL_fextHint_Hint;
					};	
				}
				else
				{
					[format["The corporation will only allow you to buy %1x of this item", ((_inStorage - _amount) + _minStock)]] call TNL_fextHint_Hint;
				};
			}
			else
			{
				["You cannot do this!"] call TNL_fextHint_Hint;
			};

			fwp_presult = 2;
		};
		
		
		if ((fwp_presult == 2) or (_tick == 4)) then //Update display
		{
			_i = 0;
			lbClear 2;
			_curSel = lbCurSel 2;
			
			{
				_item = (_x select 0);
				_amount = (_x select 1);
				_price = [_workplaceObj, _item] call TNL_fwp_getSellPrice;
				_weight = _item call TNL_finv_getItemWeight;
				_totalWeight = (_weight * _amount);
				
				if (_amount > 0) then
				{
					_index = lbAdd[2, format["%1, $%2, %5x, %3/%4kg", _item call TNL_finv_getItemName, _price, _weight, _totalWeight, _amount]];
					lbSetData[2, _index, format["['%1', %2, %3]", (_x select 0), (_x select 1), _i]];
				};
				
				_i = _i + 1;
			} forEach ((_workplaceObj) getVariable "storage");
			
			if (_curSel < 0) then
			{
				lbSetCurSel[2,0];
			}
			else
			{
				lbSetCurSel[2,_curSel];
			};
			
			fwp_presult = 0;
			_tick = 0;
		};	
		_tick = _tick + 1;
		sleep 0.1;
	};

};

TNL_fwp_setPrices =
{
	private ["_object"];
	_object = _this;
	
	_Dlg = createDialog "TNL_dlg_genListSelectAmount";
	
	fwp_presult = 3;
	
	
	((findDisplay 1105) displayCtrl 1) ctrlSetStructuredText parseText "Set Prices";
	
	((findDisplay 1105) displayCtrl 3) ctrlSetText "Set Buy";
	((findDisplay 1105) displayCtrl 3) buttonSetAction "fwp_presult = 1;";
	
	((findDisplay 1105) displayCtrl 4) ctrlSetText "Set Sell";
	((findDisplay 1105) displayCtrl 4) buttonSetAction "fwp_presult = 2;";
	
	while {!(isNull (findDisplay 1105))} do
	{
		if (fwp_presult == 1) then //Set buy price
		{
			_data = call compile (lbData [2, lbCurSel 2]);
			_newPrice = parseNumber (ctrlText ((findDisplay 1105) displayCtrl 5));
			_idc = (_data select 3);
			_item = (_data select 0);
			_prices = ((_object) getVariable "price");
			
			((_prices select _idc) set[1,_newPrice]);
			
			_object setVariable["price", _prices, true];
			[TNL_gVar_arr_tables_workplaces, [_object], [[_prices, "price"]]] call TNL_fsav_clientRequestSave;
			
			fwp_presult = 3;
		};
		
		if (fwp_presult == 2) then //Set sell price
		{
			_data = call compile (lbData [2, lbCurSel 2]);
			_newPrice = parseNumber (ctrlText ((findDisplay 1105) displayCtrl 5));
			_idc = (_data select 3);
			_item = (_data select 0);
			_prices = ((_object) getVariable "price");
			
			((_prices select _idc) set[2,_newPrice]);
			
			_object setVariable["price", _prices, true];
			[TNL_gVar_arr_tables_workplaces, [_object], [[_prices, "price"]] ] call TNL_fsav_clientRequestSave;
			
			fwp_presult = 3;
		};
		
		if (fwp_presult == 3) then //Update display
		{
			_i = 0;
			lbClear 2;
			_curSel = lbCurSel 2;
			
			{
				_item = (_x select 0);
				_buyPrice = (_x select 1);
				_sellPrice = (_x select 2);
				
				_index = lbAdd[2, format["%1, $%2, $%3", _item call TNL_finv_getItemName, _buyPrice, _sellPrice]];
				lbSetData[2, _index, format["['%1', %2, %3, %4]", (_x select 0), (_x select 1), (_x select 2), _i]];
				
				_i = _i + 1;
			} forEach ((_object) getVariable "price");
			
			if (_curSel < 0) then
			{
				lbSetCurSel[2,0];
			}
			else
			{
				lbSetCurSel[2,_curSel];
			};
			
			fwp_presult = 0;
		};
		
		sleep 0.01;
	};
};	

TNL_fwp_storage = 
{	
	private ["_object"];
	_object = _this;
	_Dlg = createDialog "TNL_dlg_genListSelectAmount";
	
	fwp_presult = 2;
	
	((findDisplay 1105) displayCtrl 1) ctrlSetStructuredText parseText "Storage";
	
	((findDisplay 1105) displayCtrl 3) ctrlSetText "Take";
	((findDisplay 1105) displayCtrl 3) buttonSetAction "fwp_presult = 1;";
	
	((findDisplay 1105) displayCtrl 4) ctrlSetText "Close";
	((findDisplay 1105) displayCtrl 4) buttonSetAction "CloseDialog 0;";
	
	_tick = 0;
	while {!(isNull (findDisplay 1105))} do
	{
		if (fwp_presult == 1) then //Take
		{
			if ((lbCurSel 2) >= 0) then 
			{
				_data = call compile (lbData [2, lbCurSel 2]);
				_amount = parseNumber (ctrlText ((findDisplay 1105) displayCtrl 5));
				_idc = (_data select 2);
				_inStorage = (_data select 1);
				_item = (_data select 0);
				
				if (_amount > 0) then
				{
					_weight = [] call TNL_finv_getPlayerWeight;
					_itemWeight =( (((_item) call TNL_finv_getItemWeight) * _amount) + (_weight select 0));
					
					if (_itemWeight < (_weight select 1)) then
					{
						TNL_GLOBAL_CUR_TRUNK = _object;
						if ([_item,_amount] call TNL_finv_addInventoryItem) then
						{
							//Add to storage
							[_object, _item, -(_amount)] call TNL_ftrunk_addStorage;
						
							[format["You take %1 %2(s) from the storage", _item call TNL_finv_getItemName, _amount]] call TNL_fextHint_Hint;
						}
						else
						{
							["Cannot do that.."] call TNL_fextHint_Hint;
						};
						closeDialog 0;
					}
					else
					{
						["Will exceed your max weight!"] call TNL_fextHint_Hint;
					};
				}
				else
				{
					["You cannot take 0 items!"] call TNL_fextHint_Hint;
				};	
			}
			else
			{
				["You cannot do this!"] call TNL_fextHint_Hint;
			};

			fwp_presult = 2;
		};
		
		
		if ((fwp_presult == 2) or (_tick == 4)) then //Update display
		{
			_i = 0;
			lbClear 2;
			_curSel = lbCurSel 2;
			
			{
				_item = (_x select 0);
				_amount = (_x select 1);
				_weight = _item call TNL_finv_getItemWeight;
				_totalWeight = (_weight * _amount);
				
				if (_amount > 0) then
				{
					_index = lbAdd[2, format["%1, %2x, %3/%4kg", _item call TNL_finv_getItemName, _amount, _weight, _totalWeight]];
					lbSetData[2, _index, format["['%1', %2, %3]", (_x select 0), (_x select 1), _i]];
				};
				
				_i = _i + 1;
			} forEach ((_object) getVariable "storage");
			
			if (_curSel < 0) then
			{
				lbSetCurSel[2,0];
			}
			else
			{
				lbSetCurSel[2,_curSel];
			};
			
			fwp_presult = 0;
			_tick = 0;
		};	
		_tick = _tick + 1;
		sleep 0.1;
	};
};

TNL_fwp_getSellPrice = 
{
	private ["_object", "_item", "_return"];
	_object = _this select 0;
	_item = _this select 1;
	_return = 0;
	
	{
		if (_x select 0 == _item) exitWith
		{
			_return = (_x select 2);
		};
	
	} forEach (_object getVariable "price");
	
	_return
};

TNL_fwp_getBuyPrice =
{
	private ["_object", "_item", "_return"];
	_object = _this select 0;
	_item = _this select 1;
	_return = 0;
	
	{
		if (_x select 0 == _item) exitWith
		{
			_return = (_x select 1);
		};
	
	} forEach (_object getVariable "price");
	
	_return
};

TNL_fwp_getMinStock = 
{
	private ["_object", "_item", "_return"];
	_object = _this select 0;
	_item = _this select 1;
	_return = 0;
	
	{
		if (_x select 0 == _item) exitWith
		{
			_return = (_x select 3);
		};
	
	} forEach (_object getVariable "price");
	
	_return
};

TNL_fwp_getMaxStock =
{
	private ["_object", "_item", "_return"];
	_object = _this select 0;
	_item = _this select 1;
	_return = 0;
	
	{
		if (_x select 0 == _item) exitWith
		{
			_return = (_x select 4);
		};
	
	} forEach (_object getVariable "price");
	
	_return
};

TNL_fwp_getCurrentStock =
{
	private ["_object", "_item", "_return"];
	_object = _this select 0;
	_item = _this select 1;
	_return = 0;
	
	{
		if (_x select 0 == _item) exitWith
		{
			_return = (_x select 1);
		};
	} forEach (_object getVariable "storage");
	
	_return
};

TNL_fwp_openPrices =
{
	private ["_gatherClass", "_gatherType", "_gatherArray", "_workplaceType", "_workplaceObj", "_corpOwner"];
	_gatherClass = (_this select 0);
	_gatherType = (_this select 1);
	_workplaceType = (_this select 2);
	_workplaceObj = (_workplaceType) call TNL_fwp_getWorkplaceObject;
	_corpOwner = _workplaceObj call TNL_fcorp_getFirmOwner;
	_itemsArray = [];
	
	if (!(createDialog "TNL_dlg_genListView")) exitWith {hint "Dialog Error!";};
	((findDisplay 1104) displayCtrl 1) ctrlSetStructuredText parseText "Prices";
	
	if (_corpOwner == "public owners") then
	{
		_itemsArray = _workplaceType call TNL_fwp_getDefaultWPItems;
	}
	else
	{
		_itemsArray = _workplaceObj call TNL_fwp_getWPItems;
	};
	
	{
		lbAdd[2, format["%1: $%2, $%3", (_x select 0) call TNL_finv_getItemName, (_x select 1), (_x select 2)]];
	} forEach _itemsArray;
};

TNL_fwp_togglecanbuy = 
{
	private ["_object", "_toggle"];
	_obj = _this;
	
	_toggle = _obj getVariable "canBuy";
	
	_obj setVariable ["canBuy", !_toggle, true];
	//[TNL_gVar_arr_tables_workplacesLoad, [_object], [ [!_toggle, "canBuy"] ] ] call TNL_fsav_clientRequestSave;
	
	if (_toggle) then
	{
		["Users can no longer purchase items from the workplace"] call TNL_fextHint_Hint;
	}
	else
	{
		["Users can now purchase items from the workplace"] call TNL_fextHint_Hint;
	};
};

TNL_fwp_handleAction =
{
	private ["_gatherClass", "_gatherType", "_gatherArray", "_amount"];
	_gatherClass = (_this select 0);
	_gatherType = (_this select 1);
	_workplaceType = (_this select 2);
	_gatherArray = (_gatherClass) call TNL_fgather_getGatherArray;
	_workplaceObj = (_workplaceType) call TNL_fwp_getWorkplaceObject;
	_corpOwner = _workplaceObj call TNL_fcorp_getFirmOwner;
	_publicOwner = false;

	
	//[corp1_ironmine] call TNL_fwp_manageWorkplace;
	
	if (TNL_gVar_bool_gatheringItems) exitWith {};
	
	
	gatherResult = [];
	
	if ((count _gatherArray) > 0) then
	{
		[_gatherArray, _gatherType] spawn TNL_fgather_StartGathering;
		
		
		waitUntil {count gatherResult > 0};
		_ok = (gatherResult select 0);
		_gotItem = (gatherResult select 1);
		_amount = (gatherResult select 2);
		
		if (_ok) then
		{
			_curStock = [_workplaceObj, _gotItem] call TNL_fwp_getCurrentStock;
			_maxStock = [_workplaceObj, _gotItem] call TNL_fwp_getMaxStock;
			
			if ((_curStock + _amount) > _maxStock) exitWith
			{
				["The corporation is currently at max stock and is not buying anymore items of this type"] call TNL_fextHint_Hint;
			};
		
			if ([_workplaceObj, [TNL_db_charName select 0, TNL_db_charName select 1]] call TNL_fwp_isOwner) then 
			{
				["You are the owner, you dont get any money!"] call TNL_fextHint_Hint;
			}
			else
			{
				_price = 0;
				_bankAmount = 0;
				if (_corpOwner == "public owners") then
				{
					_price = ((([_gotItem, _workplaceType] call TNL_fwp_getDefaultJobPrice) select 0) * _amount);
					_bankAmount = _price;
					_publicOwner = true;
				}
				else
				{
					_price = ((([_gotItem, _workplaceType] call TNL_fwp_getJobPrice) select 0) * _amount);
					_bankAmount = [_corpOwner] call TNL_fcorp_getBankAmount;
				};
				
				if ((_bankAmount - _price) >= 0) then
				{
					//Add Money to paycheck
					WorkplaceReward = WorkplaceReward + _price;
				
					//Remove money from corporation
					
					if (!_publicOwner) then
					{
						[_workplaceObj, _price] call TNL_fcorp_increaseFirmExpenses;
						_corpOwner = (_workplaceObj) call TNL_fcorp_getFirmOwner;
						_bankAmount = [_corpOwner] call TNL_fcorp_getBankAmount;
						[_corpOwner, (((_bankAmount) - (_price)))] call TNL_fcorp_setBankAmount;
					};
					
					[format["You get paid $%1 for %2 %3(s)", _price, _amount, _gotItem call TNL_finv_getItemName]] call TNL_fextHint_Hint;
				}
				else
				{
					["The corporation doesnt have enough money!"] call TNL_fextHint_Hint;
				};
			};
			
			//Remove what he got!
			[_gotItem,-(_amount)] call TNL_finv_addInventoryItem;
			
			//Add to storage
			[_workPlaceObj, _gotItem, _amount] call TNL_ftrunk_addStorage;
		
		};	
	};
};

TNL_fwp_isOwner =
{
	private ["_object", "_firstName", "_lastName", "_return"];
	_object = (_this select 0);
	_firstName = ((_this select 1) select 0);
	_lastName = ((_this select 1) select 1);
	_return = false;
	
	{
		_obj = (_x select 0);
		_ownerFName = ((_x select 2) select 0);
		_ownerSName = ((_x select 2) select 1);
		if ((_obj == _object) && (_ownerFName == _firstName) && (_ownerSName == _lastName)) then
		{
			_return = true;
		};
	} forEach (corporations getVariable "firms");

	_return
};

TNL_fwp_getWorkplaceArray =
{
	private ["_name", "_array"];
	_name = _this;
	_array = [];
	{
		if (_x select 0 == _name) exitWith
		{
			_array = _x;
		};
	} forEach TNL_gVar_workplaces;

	_array
};

TNL_fwp_getWorkPlaceName = 
{
	_this getVariable "name"
};

//Use this if you are using the marker name to get the workplace name
TNL_fwp_getWorkPlaceNameMarker =
{
	(((_this) call TNL_fwp_getWorkplaceArray) select 3) 
};

TNL_fwp_getWorkplaceObject = 
{
	(((_this) call TNL_fwp_getWorkplaceArray) select 2) 
};

TNL_fwp_getDefaultWPItems =
{
	(((_this) call TNL_fwp_getWorkplaceArray) select 1) 
};

TNL_fwp_getWPItems =
{
	_this getVariable "price";
};

TNL_fwp_getJobPrice = 
{ 
	private ["_item", "_items", "_wp", "_prices"];
	_wp = (_this select 1);
	_item = (_this select 0);
	_items = ((_wp call TNL_fwp_getWorkplaceObject) getVariable "price");
	_prices = [0,0];
	
	{
		if ((_x select 0) == _item) then
		{
			_prices = [(_x select 1), (_x select 2)];
		};
	} forEach _items;
	
	_prices
};

TNL_fwp_getDefaultJobPrice = 
{ 
	private ["_item", "_items", "_wp", "_prices"];
	_wp = (_this select 1);
	_item = (_this select 0);
	_items = ((_wp call TNL_fwp_getWorkplaceArray) select 1);
	_prices = [0,0];
	
	{
		if ((_x select 0) == _item) then
		{
			_prices = [(_x select 1), (_x select 2)];
		};
	} forEach _items;
	
	_prices
};
