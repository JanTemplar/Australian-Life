/*
Name: InventoryFunctions.sqf
Author: ScriptingBay.com
Version: 0.1.0 (07/06/2009)
Description: Contains all the inventory functions and such
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/


/*
Opens the inventory dialog
	* Parameters: 
		None

	* Returns:
		None
*/
TNL_finv_openInventory = 
{
	if (!CreateDialog "DlgInventory") then
	{
		hint "Error in function TNL_finv_openInventory - Failed to open dialog!";
	};
	
	[] call TNL_finv_loadInventory;
};

TNL_finv_isOverWeight =
{
	if (vehicle player == player) then
	{
		if ((speed player > 4) or (speed player < -3)) then
		{
			[{ (_this select 0) switchMove "AinvPknlMstpSnonWrflDnon_medic"; }, [player]] call TNL_fnet_execPublic;
		};
		
		
	}
	else
	{
		player action["Eject", vehicle player];
		["You are over weight and will not fit in the vehicle..could be because you have too much in your inventory, or you are just a fatty... we dont judge."] call TNL_fextHint_Hint;
	};
	

};

TNL_finv_loadInventory = 
{
	_money = "Money" call TNL_finv_getItemAmount;
	_weight = [] call TNL_finv_getPlayerWeight;
	
	lbClear 20;
	
	ctrlSetText[21, format["Money: $%1 | Weight: %2/%3kg", _money, _weight select 0, _weight select 1]];
	
	{
		_itemClass = (_x select 0);
		_itemAmount = (_x select 1);
		_itemArray = (_itemClass) call TNL_finv_getItemArray;
		_itemName = ((_itemArray select 2) select 0);
		_itemDesc = ((_itemArray select 2) select 1);
		_itemWeight = (_itemArray select 4);
		_itemTotalWeight = (_itemWeight * _itemAmount);
		
		if (_itemAmount > 0) then
		{
			_index = lbAdd[20, format["%1, %2x  (%3/%4kg)", _itemName, _itemAmount, _itemWeight, _itemTotalWeight]];
			lbSetData[20, _index, format["[""%1"",[""%2"",""%3""],[%4,%5]]", _itemClass, _itemName, _itemDesc,_itemAmount,_itemWeight]];
		};
	
	} foreach Gvar_arr_inv_inventory;
	
	lbSetCurSel [20, 0];
};
	

/*
Updates the inventory display when selected item changes in list
	* Parameters: 
		idc of the list <int>
		control of the structured text <control>
		
	* Returns:
		None
*/
TNL_finv_updateDisplay = 
{
	private ["_idc", "_control"];
	
	_idc = _this select 0;
	_control = _this select 1;
	_index = lbCurSel _idc;
	_data = call compile (lbData[_idc,_index]);
	_itemName = ((_data select 1) select 0);
	_itemDesc = ((_data select 1) select 1);
	_itemAmount = ((_data select 2) select 0);
	_itemWeight = ((_data select 2) select 1);
	_totalItemWeight = ((_itemWeight) * (_itemAmount));
	_money = "Money" call TNL_finv_getItemAmount;
	_weight = [] call TNL_finv_getPlayerWeight;
	
	ctrlSetText[21, format["Money: $%1 | Weight: %2/%3kg", _money, _weight select 0, _weight select 1]];
	ctrlSetText[22, format["Item name: %1 | Item amount: %2 | Item weight: %3/%4kg", _itemName, _itemAmount, _itemWeight, _totalItemWeight]]; 

	((findDisplay 001) displayCtrl 23) ctrlSetStructuredText parseText format["%1", _itemName];
	((findDisplay 001) displayCtrl 25) ctrlSetStructuredText parseText format ["%1", _itemDesc];
	//_control ctrlSetStructuredText parseText format["%1: %2", _itemName, _itemDesc];	
};


/*
Adds the requested item to the inventory, also handles if the player has too much weight to carry the items
	* Parameters: 
		Item class name <string>
		Amount to be added to inventory <int>
		
	* Returns:
		true/false if the items were successfully added to the inventory <boolean>
*/
TNL_finv_addInventoryItem = 
{
	private ["_className", "_amount", "_return", "_weight", "_itemWeight", "_playerWeight", "_totalWeight"];
	_className = _this select 0;
	_amount = _this select 1;
	_weight = call TNL_finv_getPlayerWeight;
	_itemWeight = _className call TNL_finv_getItemWeight;
	_playerWeight = _weight select 0;
	_totalWeight = _itemWeight * _amount;
	_return = false;


	/*
	if ((_playerWeight + _totalWeight) > (_weight select 1)) then
	{
		[localize "STRS_inv_overWeight"] call TNL_fextHint_Hint;		
		_return = false;
	}
	else
	{
	*/

		if (_className call TNL_finv_haveItem) then
		{
			[_className,_amount] call TNL_finv_addItemAmount;
		}
		else
		{
			Gvar_arr_inv_inventory = Gvar_arr_inv_inventory + [ [_className, _amount] ];
		};
		
		_return = true;
	//};
	
	_return
};



/*
Increases the item amount by the requested amount
	* Parameters: 
		Item class name <string>
		Amount to be increased by <int>
		
	* Returns:
		Nothing
*/
TNL_finv_addItemAmount = 
{
	private ["_itemClass", "_amount"];
	_itemClass = _this select 0;
	_amount = _this select 1;
	
	
	{
		if (_x select 0 == _itemClass) then
		{
			_x set[1,((_x select 1) + (_amount))];	
		};
	} foreach Gvar_arr_inv_inventory;
};

TNL_finv_setItemAmount = 
{
	private ["_itemClass", "_amount"];
	_itemClass = _this select 0;
	_amount = _this select 1;
	
	
	{
		if (_x select 0 == _itemClass) then
		{
			_x set[1,_amount];	
		};
	} foreach Gvar_arr_inv_inventory;
};

/*
Decreases the item amount from inventory by requested amount
	* Parameters: 
		Item class name <string>
		Amount to be decreased by <int>

	* Returns:
		None
*/
TNL_finv_takeItemAmount = 
{
	private ["_itemClass", "_amount"];
	_itemClass = _this select 0;
	_amount = _this select 1;
	
	
	{
		if (_x select 0 == _itemClass) then
		{
			_x set[1,((_x select 1) - (_amount))];	
		};
	} foreach Gvar_arr_inv_inventory;
};


/*
Gets if the player has the requested item in inventory
	* Parameters: 
		Item class name <string>
		
	* Returns:
		true/false if player has item or not <boolean>
*/
TNL_finv_haveItem =
{
	private ["_itemClass", "_return"];
	_itemClass = _this;
	_return = false;
	
	{
		if (_x select 0 == _itemClass) then
		{
			_return = true;
		};
	} foreach Gvar_arr_inv_inventory;
	
	_return
};

/*
Drops the item from inventory 
	* Parameters: 
		Item class name <string>
		Parameters (amount is always in first index) <array>
		
	* Returns:
		Nothing
*/
    TNL_finv_dropItem =
    {
            private ["_className", "_params"];
           
            _className = _this select 0;
            _params = _this select 1;
            _amount = (_params select 0);
            _itemAmount = _className call TNL_finv_getItemAmount;
            _itemName = _className call TNL_finv_getItemName;
           
            if (isNil "TNL_canDropItems") then
            {
                    TNL_canDropItems = true;
            };
           
            if (_amount < 0) exitWith
            {      
                    ["You can not do that!"] call TNL_fextHint_Hint;
            };
           
            if (!TNL_canDropItems) exitWith
            {      
                    ["Cannot drop items yet!"] call TNL_fextHint_Hint;
            };
           
            if (_className call TNL_finv_isDroppable) then
            {
                    if (_itemAmount >= _amount) then
                    {
                            [_className, _amount] call TNL_finv_takeItemAmount;
                            [format[localize "STRS_inv_dropItem", _amount, _itemName]] call TNL_fextHint_Hint;
                           
                            [[_className, _amount]] execVM "slr\dropItem.sqf";
     
                            [player, [player], 15, format["%1 has dropped %2 %3(s)", name player, _amount, _itemName]] call TNL_fnet_HintToClientsInDistanceOfObject;
                    }
                    else
                    {
                            [format[localize "STRS_trunk_notEnoughDrop", _itemName, _amount, _itemAmount]] call TNL_fextHint_Hint;
                    };             
            }
            else
            {
                    hint "You cannot do this";
            };
           
     
            [] call TNL_finv_loadInventory;
    };

	
	
/*
Use the item in inventory by executing the script
	* Parameters: 
		Item class name <string>
		Script parameters usually only the amount <array>
		
	* Returns:
		Nothing
*/
TNL_finv_useItem = 
{
	private ["_className", "_params"];
	_className = _this select 0;
	_params = _this select 1;
	_script = _className call TNL_finv_getItemScript;
	_arr = _className call TNL_finv_getItemArray;
	
	
	if (_script == "") then
	{
		["You cannot use this item"] call TNL_fextHint_Hint; //Requires localization
	}
	else
	{
		[_className, _params, _arr] ExecVM _script;
	};
	
	[] call TNL_finv_loadInventory;
};


	
/*
Gets the players weight and max weight
	* Parameters: 
		Nothing
		
	* Returns:
		Array with the players weight as first index and the max weight as the 2nd <array>
*/
TNL_finv_getPlayerWeight =
{
	private ["_weight", "_pweight"];
	Gvar_int_inv_weight = 0;
	_pweight = 0;
	
	{
		if (_x select 1 > 0) then
		{
			_pweight = _pweight + (((_x select 0) call TNL_finv_getItemWeight) * (_x select 1));
		};
	} foreach Gvar_arr_inv_inventory;

	Gvar_int_inv_weight = _pweight;
	_weight = [_pweight, Gvar_int_inv_maxWeight];
	_weight
};


/*
Gets the item amount in inventory
	* Parameters: 
		Item Class <string>
		
	* Returns:
		The amount the player has of the item in inventory <int>
*/
TNL_finv_getItemAmount = 
{
	private ["_itemClass", "_itemAmount"];
	_itemClass = _this;
	_itemAmount = 0;
	
	{
		if (_x select 0 == _itemClass) exitWith
		{
			_itemAmount = (_x select 1);
		};
	} foreach Gvar_arr_inv_inventory;
	
	_itemAmount
};

TNL_finv_getItemArray = 
{
	private ["_itemClass", "_arr"];
	_itemClass = _this;
	_arr = "";
	
	{
		if (_x select 0 == _itemClass) exitWith
		{
			_arr = (_x);
		};
	} foreach GoodsArray;
	
	_arr
};

/*
Gets the script that the item uses on use
	* Parameters: 
		Item Class <string>
		
	* Returns:
		The script the item uses defined in goodsArray <string>
*/
TNL_finv_getItemScript =
{
	private ["_itemClass", "_scriptName"];
	_itemClass = _this;
	_scriptName = "";
	
	{
		if (_x select 0 == _itemClass) exitWith
		{
			_scriptName = (_x select 5);
		};
	} foreach GoodsArray;
	
	_scriptName
};
	
/*
Gets the items real name from the requested class name
	* Parameters: 
		Item Class <string>
		
	* Returns:
		The items real name <string>
*/
TNL_finv_getItemName = 
{
	private ["_itemClass", "_itemName"];
	_itemClass = _this;
	_itemName = "";

	
	{
		if (_x select 0 == _itemClass) exitWith
		{
			_itemName = ((_x select 2) select 0);
		};
	} foreach GoodsArray;
	
	_itemName	
};
	

/*
Gets the items description from the requested class name
	* Parameters: 
		Item Class <string>
		
	* Returns:
		The items description <string>
*/
TNL_finv_getItemDescription = 
{
	private ["_itemClass", "_itemDesc"];
	_itemClass = _this;
	_itemDesc = "";
	
	{
		if (_x select 0 == _itemClass) exitWith
		{
			_itemDesc = ((_x select 2) select 1);
		};
	} foreach GoodsArray;
	
	_itemDesc
};

/*
Gets the buy price of the requsted item from the goodsArray
	* Parameters: 
		Item class name <string>
		
	* Returns:
		The buy price of the item <int>
*/
TNL_finv_getItemBuyPrice = 
{
	private ["_itemClass", "_buyPrice"];
	_itemClass = _this;
	_buyPrice = 0;
	
	{
		if (_x select 0 == _itemClass) exitWith
		{
			_buyPrice = ((_x select 3) select 0);
		};
	} foreach GoodsArray;
	
	_buyPrice
};

/*
Gets the sell price of the requsted item from the goodsArray
	* Parameters: 
		Item class name <string>
		
	* Returns:
		The sell price of the item <int>
*/
TNL_finv_getItemSellPrice = 
{
	private ["_itemClass", "_sellPrice"];
	_itemClass = _this;
	_sellPrice = 0;
	
	{
		if (_x select 0 == _itemClass) exitWith
		{
			_sellPrice = ((_x select 3) select 1);
		};
	} foreach GoodsArray;
	
	_sellPrice
};

/*
Gets the requested items weight from the goodsArray
	* Parameters: 
		Item class name <string>
		
	* Returns:
		Weight of the item <int>
*/
TNL_finv_getItemWeight =
{
	private ["_itemClass", "_weight"];
	_itemClass = _this;
	_weight = 0;
	
	{
		if (_x select 0 == _itemClass) exitWith
		{
			_weight = (_x select 4);
		};
	} foreach GoodsArray;
	
	_weight
};

/*
Gets the requested items required licenses from the goodsArray
	* Parameters: 
		Item class name <string>
		
	* Returns:
		required licenses <array>
*/
TNL_finv_getItemLicenses = 
{
	private ["_itemClass", "_licenses"];
	_itemClass = _this;
	_licenses = [];
	
	{
		if (_x select 0 == _itemClass) exitWith
		{
			_licenses = (_x select 6);
		};
	} foreach GoodsArray;
	
	_licenses
};

/*
Gets the requested items types, such as ["ITEM", "FOOD"]
	* Parameters: 
		Item class name <string>
		
	* Returns:
		item types <array>
*/
TNL_finv_getItemTypes =
{
	private ["_itemClass", "_types"];
	_itemClass = _this;
	_types = [];
	
	{
		if (_x select 0 == _itemClass) exitWith
		{
			_types = (_x select 1);
		};
	} foreach GoodsArray;
	
	_types
};



TNL_finv_getOtherValues = 
{
	private ["_itemClass", "_return"];
	_itemClass = _this;
	_return = [];
	
	{
		if (_x select 0 == _itemClass) exitWith
		{
			_return = (_x select 7);
		};
	} foreach GoodsArray;
	
	_return
};

/*
Gets if the requested item is droppable from inventory
	* Parameters: 
		Item Class <string>
		
	* Returns:
		true/false <boolean>
*/
TNL_finv_isDroppable = 
{
	private ["_itemClass", "_return"];
	_itemClass = _this;
	_return = false;
	
	{
		if (_x select 0 == _itemClass) exitWith
		{
			_return = (_x select 9);
		};
	} foreach GoodsArray;
	
	_return
};


TNL_finv_isDroppedOnDeath = 
{
	private ["_itemClass", "_return"];
	_itemClass = _this;
	_return = false;
	
	{
		if (_x select 0 == _itemClass) exitWith
		{
			_return = (_x select 10);
		};
	} foreach GoodsArray;
	
	_return
};

TNL_finv_getItemRequiredMaterials =
{
	private ["_itemClass", "_return"];
	_itemClass = _this;
	_return = [];
	
	{
		if (_x select 0 == _itemClass) exitWith
		{
			_return = (_x select 11);
		};
	} foreach GoodsArray;
	
	_return
};

TNL_finv_removeIllegalItems =
{
	{
		_itemArray = (_x select 0) call TNL_finv_getItemArray;
		_itemAmount = (_x select 1);
		_isIllegal = (_itemArray select 8);
		
		if (_isIllegal) then
		{
			[(_x select 0), -(_x select 1)] call TNL_finv_addInventoryItem;
		};
	} forEach Gvar_arr_inv_inventory;

};

TNL_finv_isIllegal =
{
	private ["_itemArray", "_isIllegal"];
	_itemArray = _x call TNL_finv_getItemArray;
	_isIllegal = (_itemArray select 8);
	
	_isIllegal
};
