/*
Name: ShopFunctions.sqf
Author: ScriptingBay.com
Version: 0.1.0 (07/06/2009)
Description: Contains all the shop functions
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/


/*
Opens the shop dialog
	* Parameters: 
		Shop Object <object>

	* Returns:
		A pretty dialog ? :D
*/
SBAY_fShops_OpenShopDialog =
{
	_object = _this select 0;

	if (CreateDialog "TNL_DlgShop") then
	{
		[_object] spawn SBAY_fShops_LoadShop;
	} 
	else
	{
		hint "Error function SBAY_fShops_OpenShopDialog, failed to open dialog!!";
	};

};

SBAY_fShops_LoadShop =
{
	private ["_object"];
	_object = _this select 0;
	
	sleep 0.01;
	
	lbClear 2;
	lbClear 3;

	_shopArray = [_object] call SBAY_fShops_getShopArray;
	_shopName = (_shopArray select 0);
	_shopType = (_shopArray select 1);
	_shopUsesTaxes = (_shopArray select 4);
	_shopBuyStock = (_shopArray select 5);
	_shopSellStock = (_shopArray select 6);
	_usersShopTimes = (_shopArray select 8);
	_GetShopTimes = (_shopArray select 9);
	_GetShopUsers = (_shopArray select 7);
	_OpeningTime = (_GetShopTimes select 0);
	_ClosingTime = (_GetShopTimes select 1);
	_weight = [] call TNL_finv_getPlayerWeight;
		
	TNL_CURRENT_SHOP_OBJECT = _object;
		
	if (not(_GetShopUsers call SBAY_fShops_CanUseShop)) then
	{
		["You cannot use this shop"] call TNL_fextHint_Hint;
		closeDialog 0;
	};

	if (not(dayTime >= _OpeningTime && dayTime <= _ClosingTime)) then
	{
		if (_usersShopTimes) then
		{
			[format["This shop is closed\nOpening time: %1\nClosing time: %2\nPlease come back later", _OpeningTime, _ClosingTime]] call TNL_fextHint_Hint;
			closeDialog 0;
		};
	};
		
	//#### POPULATE PURCHASE WITH STOCK ####
		
	{
		{
				
			_itemClass = (_x select 0);
			_increasedBuyCost = (_x select 1);
			_increasedSellPrice = (_x select 2);
			_requiresLicense = (_x select 3);
			_itemArray = (_itemClass) call TNL_finv_getItemArray;
			_itemName = ((_itemArray select 2) select 0);
			_type = ((_itemArray select 1) select 0);
			_tax = _type call TNL_fs_getTax;
			_itemDesc = ((_itemArray select 2) select 1);
			_itemWeight = (_itemArray select 4);
			_buyPrice = (((_itemArray select 3) select 0) * _increasedBuyCost);
			_origPrice = _buyPrice;
			_buyPrice = ((_buyPrice/100)*_tax);
			_sellPrice = (((_itemArray select 3) select 1) * _increasedSellPrice);
			_itemLicenses = (_itemArray select 6);
			
			_taxRate = (_tax/100);
			_price = _origPrice * (_taxRate);
			_taxPaid = (_taxRate * _price);
			_taxPaid = (_price - _taxPaid);

			_index = lbAdd[2,format["%1 ($%2, $%3, %4kg)", _itemName, _buyPrice, _sellPrice, _itemWeight]];
				lbSetData[2, _index, format["[""%1"",[""%2"",""%3""],[%4,%5], %6, [%7,%8], %9]", _itemClass, _itemName, _itemDesc,_buyPrice,_sellPrice, _itemWeight, _itemLicenses, _requiresLicense, _taxPaid]];
		   
		} foreach _x;
			
	} foreach _shopBuyStock;
		
	((findDisplay 801) displayCtrl 1) ctrlSetStructuredText parseText format ["%1", _shopName];
	ctrlSetText[4, format["Money: $%4 |	Weight: %3/%5kg | Opening Time: %1 | Closing Time: %2 |", _GetShopTimes select 0, _GetShopTimes select 1, _weight select 0, "Money" call TNL_finv_getItemAmount, _weight select 1]];
		
	//#### POPULATE SELL WITH ITEMS ####
	
	{
	_itemClass = (_x select 0);
	_itemAmount = (_x select 1);
	_itemArray = (_itemClass) call TNL_finv_getItemArray;
	_itemName = ((_itemArray select 2) select 0);
	_itemDesc = ((_itemArray select 2) select 1);
	_itemWeight = (_itemArray select 4);
	_itemTotalWeight = (_itemWeight * _itemAmount);
	_itemIncreasedSellCost = [_itemClass, _shopSellStock] call SBAY_fShops_getItemIncreasedSellCost;
	_itemPrice = (((_itemArray select 3) select 1) * _itemIncreasedSellCost);
		
	if ([_itemClass, _shopSellStock] call SBAY_fShops_isSellable) then
	{
		if (_itemAmount > 0) then
		{
			_index = lbAdd[3, format["%1, $%5, %2x, (%3/%4kg)", _itemName, _itemAmount, _itemWeight, _itemTotalWeight, _itemPrice]];
			lbSetData[3, _index, format["[""%1"",[""%2"",""%3""],[0,%5], %6, [], false]", _itemClass, _itemName, _itemDesc, 0, _itemPrice, _itemWeight]];
		};
	};
	
	} foreach Gvar_arr_inv_inventory;
		
	//#### POPULATE SELL WITH WEAPON/MAGAZINES ####
		
	_Weapons = weapons player;
	_Magazine = magazines player;
	_total = _Weapons + _Magazine;
	_foundArray = [ ];

	{
		_weaponClass = (_x);
	
		_found = false;
		_i = 0;
			
		{
			if (count _foundArray > 0) then
			{
				_class = _x select 0;
				_amount = _x select 1;
						
				if (_class == _weaponClass) then
				{
					_found = true;
					_x set[1,(_amount + 1)];
				};
			};

			_i = _i + 1;
		} foreach _foundArray;
			
		if (!_found) then
		{
			_foundArray = _foundArray + [ [_weaponClass, 1] ];
		};
			

	} foreach _total;		
		
	{
		_weaponClass = (_x select 0);
		_itemArray = (_weaponClass) call TNL_finv_getItemArray;
		_weaponName = ((_itemArray select 2) select 0);
		_weaponDesc = ((_itemArray select 2) select 1);
		_weaponIncreasedSellCost = [_weaponClass, _shopSellStock] call SBAY_fShops_getItemIncreasedSellCost;
		_weaponPrice = (((_itemArray select 3) select 1) * _weaponIncreasedSellCost);
			
		if ([_weaponClass, _shopSellStock] call SBAY_fShops_isSellable) then
		{
			_index = lbAdd[3, format["%1, $%3, %2", _weaponName, _weaponPrice, _x select 1]];
			lbSetdata[3, _index, format["[""%1"",[""%2"",""%3""],[0,%5], 0, [], false]", _weaponClass, _weaponName, _weaponDesc, 0, _weaponPrice, 0]];
		};
			
	} foreach _foundArray;
		
	//##### POPULATE SELL WITH VEHICLES #####
	
	{
		_vclClass = (_x select 1);
		_vclObject = (_x select 0);
		_itemArray = (_vclClass) call TNL_finv_getItemArray;
		_name = ((_itemArray select 2) select 0);
		_increasedSellCost = [_vclClass, _shopSellStock] call SBAY_fShops_getItemIncreasedSellCost;
		_cost = (((_itemArray select 3) select 1) * _increasedSellCost);

		if (player distance getpos(_vclObject) < 25) then
		{
			if ([_vclClass, _shopSellStock] call SBAY_fShops_isSellable) then
			{
				_index = lbAdd[3, format["%1 (%2), %3Ц", _name, _vclObject, _cost]];
				lbSetData[3,_index, format["[""%1"",[""%2""], [0,%4], 0, [], false, [""%3"",%4]]", _vclClass, _name, _vclObject, _cost]];
			};
		};
	} foreach Gvar_arr_inv_ownedVehicles;

	lbSetCurSel [3, 0]; 
	lbSetCurSel [2, 0];	
};


/*
Opens the purchase dialog with selected item
	* Parameters: 
		idc of the shop list <int>

	* Returns:
		Nothing
*/
SBAY_fShops_OpenPurchaseDialog =
{
	_idc = _this select 0;
	_index = lbCurSel _idc;
	_data = call compile (lbData[_idc,_index]);
	_money = "Money" call TNL_finv_getItemAmount;	
	TNL_GLOBAL_SHOP_DATA_ARRAY = _data;
	_weight = [] call TNL_finv_getPlayerWeight;
	_itemType = (_data select 0) call TNL_finv_getItemTypes;
	_licenses = ((_data select 4) select 0);
	_requireLicense = ((_data select 4) select 1);

	if (!createDialog "TNL_DlgPurchase") then
	{
		hint "ERROR function SBAY_fShops_OpenPurchaseDialog, failed to open dialog!!";
	};
	
	((findDisplay 802) displayCtrl 6) ctrlSetStructuredText parseText localize "STRS_shop_purchase";
	ctrlSetText[7, format["Amount of %1(s):",_data select 1 select 0]];
	ctrlSetText[10, format["Weight ea: %1kg", _data select 3]];
	ctrlSetText[12, format["Total weight: %1/%2kg", _data select 3, _weight select 1]];
	ctrlSetText[15, format["Money: %1Ц", _money]];
	ctrlSetText[17, format["Weight: %1/%2kg", _weight select 0, _weight select 1]];
	ctrlSetText[11, format["Total price: %1Ц", _data select 2 select 0]];
	ctrlSetText[9,  format["Price ea: %1Ц", _data select 2 select 0]];
	ctrlSetText[16, format["Money after: %1Ц", _money - (_data select 2 select 0)]];
	ctrlSetText[18, format["Weight after: %1/%2kg", ((_data select 3) + (_weight select 0)),_weight select 1]];
				
		
	if (not(_requireLicense)) then
	{
		ctrlSetText[14, "Have required license(s): None Required"];
	}
	else
	{
		if (_licenses call SBAY_fShops_HasRequiredLicense) then
		{
			ctrlSetText[14, "Have required license(s): Yes"];
		}
		else
		{
			ctrlSetText[14, "Have required license(s): No"];
		};
	};
	
	switch (_itemType select 0) do
	{
		case "VEHICLE":
		{
			buttonSetAction[8, format["[%1] call SBAY_fShops_PurchaseVehicle; closeDialog 0;", _data]];
		};
		
		case "ITEM":
		{
			buttonSetAction[8, format["[%1] call SBAY_fShops_PurchaseItem; closeDialog 0;", _data]];
		};
		
		case "WEAPON":
		{
			buttonSetAction[8, format["[%1] call SBAY_fShops_PurchaseWeapon; closeDialog 0;", _data]];	
		};
		
		case "MAGAZINE":
		{
			buttonSetAction[8, format["[%1] call SBAY_fShops_PurchaseMagazine; closeDialog 0;", _data]];
		};
		
		case "ANIMAL":
		{
			buttonSetAction[8, format["[%1] call SBAY_fShops_purchaseAnimal; closeDialog 0;", _data]];
		};
		
	};
	
	TNL_shop_sellPurchase = "purchase";
};

SBAY_fShops_OpenSellDialog =
{
	_idc = _this select 0;
	_index = lbCurSel _idc;
	_data = call compile (lbData[_idc,_index]);
	_money = "Money" call TNL_finv_getItemAmount;
	_weight = [] call TNL_finv_getPlayerWeight;
	_itemType = (_data select 0) call TNL_finv_getItemTypes;
	
	TNL_GLOBAL_SHOP_DATA_ARRAY = _data;
	
	
	if (!createDialog "TNL_DlgPurchase") then
	{
		hint "ERROR function SBAY_fShops_OpenSellDialog, failed to open dialog!!";
	};
	
	((findDisplay 802) displayCtrl 6) ctrlSetStructuredText parseText localize "STRS_shop_sell";
	ctrlSetText[7,  format["Amount of %1(s):",_data select 1 select 0]];
	ctrlSetText[10, format["Weight ea: %1kg", _data select 3]];
	ctrlSetText[11, format["Total price: %1Ц", _data select 2 select 1]];
	ctrlSetText[12, format["Total weight: %1kg", _data select 3]];
	ctrlSetText[15, format["Money: %1Ц", _money]];
	ctrlSetText[17, format["Weight: %1/%2kg", _weight select 0,_weight select 1]];
	ctrlSetText[9,  format["Price ea: %1Ц", _data select 2 select 1]];
	ctrlSetText[16, format["Money after: %1Ц", _money + (_data select 2 select 1)]];
	ctrlSetText[18, format["Weight after: %1/%2kg", (_weight select 0) - (_data select 3), _weight select 1]];
	ctrlSetText[14, ""];
	
	switch (_itemType select 0) do
	{
		case "VEHICLE":
		{
			buttonSetAction[8, format["[%1] call SBAY_fShops_SellVehicle;", _data]];
		};
		
		case "ITEM":
		{
			buttonSetAction[8, format["[%1] call SBAY_fShops_SellItem; closeDialog 0;", _data]];
		};
		
		case "WEAPON":
		{
			buttonSetAction[8, format["[%1] call SBAY_fShops_SellWeapon; closeDialog 0;", _data]];
		};
		
		case "MAGAZINE":
		{
			buttonSetAction[8, format["[%1] call SBAY_fShops_SellMagazine; closeDialog 0;", _data]];
		};
	};
	
	TNL_shop_sellPurchase = "sell";
};


SBAY_fShops_UpdatePurchaseTotals = 
{
	_idc = _this select 0;
	_number = 0;
	_text = ctrlText _idc;
	_number = parseNumber _text;
	_data = TNL_GLOBAL_SHOP_DATA_ARRAY;
	_money = "Money" call TNL_finv_getItemAmount;
	_Totalcost = _data select 2 select 0;
	_Totalcost = _Totalcost * _number;
	_Totalweight = _data select 3;
	_Totalweight = _Totalweight * _number;
	_weight = [] call TNL_finv_getPlayerWeight;
	
	ctrlSetText[12, format["Total weight: %1/%2kg", _Totalweight, _weight select 1]];
	
	if (TNL_shop_sellPurchase == "purchase") then
	{
		ctrlSetText[11, format["Total price: %1Ц", _Totalcost]];
	  	ctrlSetText[16, format["Money after: %1Ц", _money - _Totalcost]];
		ctrlSetText[18, format["Weight after: %1/%2kg", (_weight select 0) + (_Totalweight), _weight select 1]];
	}
	else
	{
		if (TNL_shop_sellPurchase == "sell") then
		{
			_Totalcost = ((_data select 2 select 1) * (_number));
			
			ctrlSetText[11, format["Total price: %1Ц", _Totalcost]];
			ctrlSetText[16, format["Money after: %1Ц", _money + _Totalcost]];
			ctrlSetText[18, format["Weight after: %1/%2kg", (_weight select 0) - (_Totalweight), _weight select 1]];
		};
	};
	

};

SBAY_fShops_UpdateDescription = 
{
	_idc = _this select 0;
	_control = _this select 1;
	_index = lbCurSel _idc;
	_data = call compile (lbData[_idc,_index]);

	(findDisplay 801) displayCtrl 6 ctrlSetStructuredText parseText format["%1", _data select 1 select 0];
	(findDisplay 801) displayCtrl 5 ctrlSetStructuredText parseText format["%1", _data select 1 select 1];
};

SBAY_fShops_purchaseAnimal = 
{
	private ["_data"];
	_data = _this select 0;
	_class = (_data select 0);
	
	_class createUnit [position player, group player];
	
	["Purchased a animal"] call TNL_fextHint_Hint;
};


SBAY_fShops_PurchaseItem = 
{
	private ["_itemData"];
	_itemData = _this select 0;
	_itemClass = (_itemData select 0);
	_amount = parseNumber (ctrlText 13);
	_money = "Money" call TNL_finv_getItemAmount;
	_cost = ((_itemData select 2) select 0);
	_totalCost = _cost * _amount;
	_licenses = ((_itemData select 4) select 0);
	_requireLicense = ((_itemdata select 4) select 1);
	_canBuy = true;
	
	if (_licenses call SBAY_fShops_HasRequiredLicense || (not(_requireLicense))) then
	{
		if (_money >= _totalCost) then
		{
			if ([_itemClass,_amount] call TNL_finv_addInventoryItem) then
			{
				['Money', _totalCost] call TNL_finv_takeItemAmount;
				
				[{GovernmentTaxAccount = GovernmentTaxAccount + (_this select 0); publicVariable "GovernmentTaxAccount"; }, [(abs(_itemData select 5) * _amount)]] call TNL_fnet_execPublic;
				[format[localize "STRS_purchase_item", _amount, ((_itemData select 1) select 0), _totalCost, (_money - _totalCost)]] call TNL_fextHint_Hint;

				[player, [player], 15, format["%1 has purchased %2 %3(s)", (name player) call TNL_fplayer_formatName, _amount, ((_itemData select 1) select 0)]] call TNL_fnet_HintToClientsInDistanceOfObject;
			}
			else
			{
				
			};
		}
		else
		{
			[localize "STRS_purchase_cantafford"] call TNL_fextHint_Hint;
		};
	
	}
	else
	{
		[localize "STRS_purchase_requireLicense"] call TNL_fextHint_Hint;
	};
	
	[TNL_CURRENT_SHOP_OBJECT] spawn SBAY_fShops_LoadShop;

};

SBAY_fShops_SellItem = 
{
	private ["_itemData"];
	_itemData = _this select 0;
	_itemClass = (_itemData select 0);
	_amount = parseNumber (ctrlText 13);
	_money = "Money" call TNL_finv_getItemAmount;
	_cost = ((_itemData select 2) select 1);
	_totalCost = _cost * _amount;
	

	
	if (_itemClass call TNL_finv_getItemAmount >= _amount) then
	{
		if (['Money', _totalCost] call TNL_finv_addInventoryItem) then
		{
			[_itemClass, _amount] call TNL_finv_takeItemAmount;
			[format[localize "STRS_sell_item",_amount,((_itemData select 1) select 0), _totalCost]] call TNL_fextHint_Hint;
			
			[player, [player], 15, format["%1 has sold %2 %3(s)", (name player) call TNL_fplayer_formatName, _amount, ((_itemData select 1) select 0)]] call TNL_fnet_HintToClientsInDistanceOfObject;
		}
		else
		{
			//Do Nothing
		};

	}
	else
	{
		[format[localize "STRS_sell_notEnough", _itemClass call TNL_finv_getItemName, _amount]] call TNL_fextHint_Hint;
	};
	
	[TNL_CURRENT_SHOP_OBJECT] spawn SBAY_fShops_LoadShop;
	
};

SBAY_fShops_PurchaseVehicle = 
{
	private ["_vclData"];
	_vclData = _this select 0;
	_vclClass = (_vclData select 0);
	_cost = ((_vclData select 2) select 0);
	_money = "Money" call TNL_finv_getItemAmount;
	_licenses = ((_vclData select 4) select 0);
	_requireLicense = ((_vclData select 4) select 1);
	_spawnPoint = (TNL_CURRENT_SHOP_OBJECT) call SBAY_fShops_getVehicleSpawn;

	
	if (_licenses call SBAY_fShops_HasRequiredLicense || (not(_requireLicense))) then
	{
		if (_money >= _cost) then
		{
			[format[localize "STRS_purchase_vehicle", ((_vclData select 1) select 0), _cost, (_money-_cost)]] call TNL_fextHint_Hint;
			['Money', _cost] call TNL_finv_takeItemAmount;
			[{GovernmentTaxAccount = GovernmentTaxAccount + ((_this select 0)); publicVariable "GovernmentTaxAccount"; }, [(abs(_vclData select 5) * 1)]] call TNL_fnet_execPublic;
			
			[player, [player], 15, format["%1 has purchased 1 %2", (name player) call TNL_fplayer_formatName, ((_vclData select 1) select 0)]] call TNL_fnet_HintToClientsInDistanceOfObject;
			
			if (_spawnPoint != empty) then
			{	
				[_vclClass, _spawnPoint] call TNL_fmission_createVehicle; 
			}
			else
			{
				[_vclClass, player] call TNL_fmission_createVehicle;
			};
		}
		else
		{
			[localize "STRS_purchase_cantafford"] call TNL_fextHint_Hint;
		};
	}
	else
	{
		[localize "STRS_purchase_requireLicense"] call TNL_fextHint_Hint;
	};
	
	[TNL_CURRENT_SHOP_OBJECT] spawn SBAY_fShops_LoadShop;
};

SBAY_fShops_SellVehicle =
{
	private ["_vclData"];
	_itemData = _this select 0;
	_itemClass = (_itemData select 0);
	_amount = 1;
	_money = "Money" call TNL_finv_getItemAmount;
	_cost = ((_itemData select 2) select 1);
	_totalCost = _cost * _amount;
	_vcl = player;
	closeDialog 0;
	
	{
		_vclClass = (_x select 1);
		_vclObject = (_x select 0);
		
		if (player distance getpos(_vclObject) < 25) then
		{
			if (_itemClass == _vclClass) then
			{
				_vcl = _vclObject;
			};
		};
	} foreach Gvar_arr_inv_ownedVehicles;
	
	if (_vcl == player) exitWith
	{
		hint "Error!";
	};
	
	['Money', _totalCost] call TNL_finv_addInventoryItem;
	[format[localize "STRS_sell_item",_amount,((_itemData select 1) select 0), _totalCost]] call TNL_fextHint_Hint;
	[player, [player], 15, format["%1 has sold %2 %3(s)", (name player) call TNL_fplayer_formatName, _amount, ((_itemData select 1) select 0)]] call TNL_fnet_HintToClientsInDistanceOfObject;
	
	_vcl call TNL_fvcl_removeOwnedVehicle;
	[_vcl,0] call SLR_SafeDeleteVehicle;
	[TNL_CURRENT_SHOP_OBJECT] spawn SBAY_fShops_LoadShop;
};

SBAY_fShops_PurchaseWeapon = 
{
	private ["_data"];
	_data = _this select 0;
	_weaponClass = (_data select 0);
	_cost = ((_data select 2) select 0);
	_money = "Money" call TNL_finv_getItemAmount;
	_amount = parseNumber (ctrlText 13);
	_totalCost = _cost * _amount;
	_licenses = ((_data select 4) select 0);
	_requireLicense = ((_data select 4) select 1);
	_spawnPoint = (TNL_CURRENT_SHOP_OBJECT) call SBAY_fShops_getWeaponCrate;
	_spawnPoint setdamage 0;
	
	
	if (_licenses call SBAY_fShops_HasRequiredLicense || (not(_requireLicense))) then
	{
		if (_money >= _totalCost) then
		{
			if (_spawnPoint != empty) then
			{
				['Money', _totalCost] call TNL_finv_takeItemAmount;
				_spawnPoint addWeaponCargo [_weaponClass,_amount];
				[{GovernmentTaxAccount = GovernmentTaxAccount + (_this select 0); publicVariable "GovernmentTaxAccount"; }, [(abs(_Data select 5)*_amount)]] call TNL_fnet_execPublic;
				[format[localize "STRS_purchase_item", _amount, ((_data select 1) select 0), _totalCost, (_money-_totalcost)]] call TNL_fextHint_Hint;
				
				[player, [player], 15, format["%1 has purchased %2 %3(s)", (name player) call TNL_fplayer_formatName, _amount, ((_data select 1) select 0)]] call TNL_fnet_HintToClientsInDistanceOfObject;
			};
		}
		else
		{
			[localize "STRS_purchase_cantafford"] call TNL_fextHint_Hint;
		};
	}
	else
	{
		[localize "STRS_purchase_requireLicense"] call TNL_fextHint_Hint;
	};
	
	[TNL_CURRENT_SHOP_OBJECT] spawn SBAY_fShops_LoadShop;
};

SBAY_fShops_SellWeapon = 
{
	private ["_data"];
	_data = _this select 0;
	_weaponClass = (_data select 0);
	_cost = ((_data select 2) select 1);
	
	if (['Money', _cost] call TNL_finv_addInventoryItem) then
	{
		player removeWeapon _weaponClass;
		[format[localize "STRS_sell_item",1,((_Data select 1) select 0), _cost]] call TNL_fextHint_Hint;
		
		[player, [player], 15, format["%1 has sold 1 %2(s)", (name player) call TNL_fplayer_formatName, ((_data select 1) select 0)]] call TNL_fnet_HintToClientsInDistanceOfObject;
	}
	else
	{
		//Do nothing
	};
	
	[TNL_CURRENT_SHOP_OBJECT] spawn SBAY_fShops_LoadShop;
	
};

SBAY_fShops_PurchaseMagazine = 
{
	private ["_data"];
	_data = _this select 0;
	_magClass = (_data select 0);
	_cost = ((_data select 2) select 0);
	_money = "Money" call TNL_finv_getItemAmount;
	_amount = parseNumber (ctrlText 13);
	_totalCost = _cost * _amount;
	_licenses = ((_data select 4) select 0);
	_requireLicense = ((_data select 4) select 1);
	_spawnPoint = (TNL_CURRENT_SHOP_OBJECT) call SBAY_fShops_getWeaponCrate;
	_spawnPoint setdamage 0;
	
	if (_licenses call SBAY_fShops_HasRequiredLicense || (not(_requireLicense))) then
	{
		if (_money >= _totalCost) then
		{
			if (_spawnPoint != empty) then
			{
				['Money', _totalCost] call TNL_finv_takeItemAmount;
				[{GovernmentTaxAccount = GovernmentTaxAccount + (_this select 0); publicVariable "GovernmentTaxAccount"; }, [(abs(_Data select 5)*_amount)]] call TNL_fnet_execPublic;
				_spawnPoint addMagazineCargo [_magClass,_amount];
				[format[localize "STRS_purchase_item", _amount, ((_data select 1) select 0), _totalCost, (_money-_totalcost)]] call TNL_fextHint_Hint;
				
				[player, [player], 15, format["%1 has purchased %2 %3(s)", (name player) call TNL_fplayer_formatName, _amount, ((_data select 1) select 0)]] call TNL_fnet_HintToClientsInDistanceOfObject;
			};
		}
		else
		{
			[localize "STRS_purchase_cantafford"] call TNL_fextHint_Hint;
		};
	}
	else
	{
		[localize "STRS_purchase_requireLicense"] call TNL_fextHint_Hint;
	};
	
	
	[TNL_CURRENT_SHOP_OBJECT] spawn SBAY_fShops_LoadShop;
};

SBAY_fShops_SellMagazine = 
{
	private ["_data"];
	_data = _this select 0;
	_magClass = (_data select 0);
	_cost = ((_data select 2) select 1);
	_amount = parseNumber (ctrlText 13);
	_totalCost = _cost * _amount;
	_mags = magazines player;
	_numMags = 0;
	
	{
		if (_x == _magClass) then
		{
			_numMags = _numMags + 1;
		};
		
	} foreach _mags;
	
	if (_numMags >= _amount) then
	{
		if (['Money', _totalCost] call TNL_finv_addInventoryItem) then
		{
			_i = 0;
			
			while {_i < _amount} do
			{
				player removeMagazine _magClass;
				
				_i = _i + 1;
			};
			
			[format[localize "STRS_sell_item", _amount, ((_data select 1) select 0), _totalCost]] call TNL_fextHint_Hint;
			[player, [player], 15, format["%1 has sold %2 %3(s)", (name player) call TNL_fplayer_formatName, _amount, ((_data select 1) select 0)]] call TNL_fnet_HintToClientsInDistanceOfObject;
		}
		else
		{
			//Do nothing
		};
	}
	else
	{
		[format[localize "STRS_sell_notEnough", ((_data select 1) select 0), _amount]] call TNL_fextHint_Hint;
	}; 
	
	[TNL_CURRENT_SHOP_OBJECT] spawn SBAY_fShops_LoadShop;
};

SBAY_fShops_getShopArray = 
{
	private ["_object", "_returnArray"];
	_Object = _this select 0;
	_ReturnArray = [];
	
	{
		if (_Object == _x select 0) then
		{
			_ReturnArray = (_x);
		};
	} foreach TNL_ShopArray;
	
	_ReturnArray

};


//SBAY_fShops_GetShopOpeningTimes [ ObjectName ] returns array of shop opening time and closing time
SBAY_fShops_GetShopOpeningTimes = 
{
	_Object = _this select 0;
	_ReturnArray = [];
	
	{
		if (_Object == _x select 0) then
		{
			_ReturnArray = _x select 9;
		};
		
	} foreach TNL_ShopArray;
	
	_ReturnArray
};

//SBAY_fShops_GetShopName [ ObjectName ] returns ShopName
SBAY_fShops_GetShopName = 
{
	_Object = _this select 0;
	_ReturnName = "";


	{
		if (_Object == _x select 0) then
		{
			_ReturnName = _x select 1;
		};
	
	} foreach TNL_ShopArray;

_ReturnName
};

//SBAY_fShops_GetShopType [ ObjectName ] returns ShopType
SBAY_fShops_GetShopType = 
{
	_Object = _this select 0;
	_ReturnType = "";


	{
		if (_Object == _x select 0) then
		{
			_ReturnType = _x select 2;
		};
	
	} foreach TNL_ShopArray;

_ReturnType
};

//SBAY_fShops_GetShopUsesTaxes [ ObjectName ] returns if shop uses taxes true/false
SBAY_fShops_GetShopUsesTaxes =
{
	_Object = _this select 0;
	_returnType = false;
	
	{
		if (_Object == _x select 0) then
		{
			if (_x select 4) then
			{
				_returnType = true;
			};
		};
	} foreach TNL_ShopArray;
	
	_returnType
};

//SBAY_fShops_GetShopBuyStock [ ObjectName ] returns array of the shops buy stock
SBAY_fShops_GetShopBuyStock = 
{
	_Object = _this select 0;
	_returnArray = [];
	
	{
		if (_Object == _x select 0) then
		{
			_returnArray = _x select 5;
		};
	} foreach TNL_ShopArray;
	
	_returnArray
};

SBAY_fShops_GetShopSellStock = 
{
	_Object = _this select 0;
	_returnArray = [];
	
	{
		if (_Object == _x select 0) then
		{
			_returnArray = _x select 6;
		};
	} foreach TNL_ShopArray;
	
	_returnArray
};

SBAY_fShops_isSellable = 
{
	private ["_itemName", "_result", "_arr"];
	_itemName = _this select 0;
	_arr = _this select 1;
	_result = false;

	{
		{
			if (_itemName == _x select 0) then
			{
				_result = true;
			};
		} foreach _x;
	} foreach _arr;
	
	
	
	_result
};

SBAY_fShops_getItemIncreasedSellCost = 
{
	private ["_itemClass", "_shopSellStock", "_amount"];
	_itemClass = _this select 0;
	_shopSellStock = _this select 1;
	_amount = 0;
	
	{
		{
			if (_x select 0 == _itemClass) then
			{
				_amount = (_x select 2);
			};
		} foreach _x;
	} foreach _shopSellStock;
	
	_amount
};


SBAY_fShops_CanUseShop = 
{
	private ["_Types", "_result"];
	_Types = _this;
	_result = false;
	
	if (count _Types == 0) then
	{
		_result = true;
	};
	
	{
		if ([player, _x] call TNL_fmission_playerIsType) then
		{
			_result = true;	
		};
		
	} foreach _Types;

	
	_result
};

SBAY_fShops_GetWhoCanUseShop = 
{
	private ["_object", "_returnArray"];
	_object = _this select 0;
	_returnArray = [];
	
	{
		if (_Object == _x select 0) then
		{
			_returnArray = _x select 7;
		};
	} foreach TNL_ShopArray;
	
	_returnArray
};

SBAY_fShops_HasRequiredLicense =
{
	private ["_licenses", "_retBool"];
	_licenses = _this;
	_retBool = true;
	
	{
		if ([player, _x select 0] call TNL_fmission_playerIsType) then
		{
			if (_x select 1 call TNL_flic_playerHasLicense) then
			{
				_retBool = true;
			}
			else
			{
				_retBool = false;
			};	
		};
		
		
	} foreach _licenses;
	
	_retBool
};

SBAY_fShops_getWeaponCrate = 
{
	private ["_object", "_returnObject"];
	_object = _this;
	_returnObject = empty;
	
	{
		if (_object == _x select 0) then
		{
			_returnObject = call compile format["%1_shop_crate", (_x select 10)];
		};
	} foreach TNL_ShopArray;
	
	_returnObject
};

SBAY_fShops_getVehicleSpawn = 
{
	private ["_object", "_returnObject"];
	_object = _this;
	_returnObject = empty;
	
	{
		if (_object == _x select 0) then
		{
			_returnObject = (_x select 11);
		};
	} foreach TNL_ShopArray;
	
	_returnObject
};

SBAY_fShops_reOpenShop =
{
	sleep 0.005;
	closeDialog 1;
	[TNL_CURRENT_SHOP_OBJECT] spawn SBAY_fShops_OpenShopDialog;
};


	