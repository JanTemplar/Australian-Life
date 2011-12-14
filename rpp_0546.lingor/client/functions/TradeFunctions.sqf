/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

TNL_ftrade_openDialog = 
{
	private ["_unit"];
	_unit = _this select 0;
	
	if (!createDialog "DlgTrade") then
	{
		hint "Error in TradeFunctions.sqf at function TNL_ftrade_openDialog, failed to open Dialog!";
	};
	

	[_unit] spawn TNL_ftrade_loadDialog;
}; 

TNL_ftrade_loadDialog = 
{	
	private ["_unit"];
	_unit = _this select 0;
	[_unit, TNL_finv_getPlayerWeight, []] call TNL_fnet_ValueFromClientFunction;
	waitUntil {TNL_fnet_returnedVar};
	waitUntil {typeName TNL_fnet_returnedRequestedVar == "ARRAY"};
	_returnedWeight = TNL_fnet_returnedRequestedVar;
	_targetWeight = (_returnedWeight select 0);
	_targetMaxWeight = (_returnedWeight select 1);
	
	lbClear 2;
	
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
			_index = lbAdd[2, format["%1, %2  (%3/%4kg)", _itemName, _itemAmount, _itemWeight, _itemTotalWeight]];
			lbSetData[2, _index, format["[""%1"",[""%2"",""%3""],[%4,%5], %6, %7, %8]", _itemClass, _itemName, _itemDesc,_itemAmount,_itemWeight, _unit, _targetWeight, _targetMaxWeight]];
		};
	
	} foreach Gvar_arr_inv_inventory;
	
	lbSetCurSel [2, 0]; 
	
	[(call compile (lbData[2,lbcurSel 2]))] call TNL_ftrade_updateDisplay;
};

TNL_ftrade_updateDisplay = 
{
	private ["_unit"];
	_unit = ((_this select 0) select 3);
	_targetWeight = ((_this select 0) select 4);
	_targetMaxWeight = ((_this select 0) select 5);
	_itemClass = ((_this select 0) select 0);
	_itemArray = (_itemClass) call TNL_finv_getItemArray;
	_itemName = ((_itemArray select 2) select 0);
	_itemAmount = _itemClass call TNL_finv_getItemAmount;
	_itemDesc = ((_itemArray select 2) select 1);
	_itemWeight = (_itemArray select 4);
	_itemTotalWeight = ((_itemWeight) * (_itemAmount));
	_weight = [] call TNL_finv_getPlayerWeight;
	_money = "money" call TNL_finv_getItemAmount;
	_tradeAmount = parseNumber ctrlText 9;
	_tradeTotalWeight = (((_itemWeight) * (_tradeAmount)));

	ctrlSetText[3, format["Money: %1Ц | Weight: %2/%3kg", _money, (_weight select 0), (_weight select 1)]];
	ctrlSetText[4, format["Item name: %1 | Item Amount: %2 | Item Weight: %3/%4kg", _itemName, _itemAmount, _itemWeight, _itemTotalWeight]];
	ctrlSetText[5, format["Trading with: %1", (name _unit) call TNL_fplayer_formatName]];
	ctrlSetText[6, format["Weight: %1/%2kg", _targetWeight, _targetMaxWeight]];
	ctrlSetText[7, format["Weight after: %1/%2kg", (_targetWeight + _tradeTotalWeight), _targetMaxWeight]];
	
	if ((_tradeTotalWeight <= _targetMaxWeight) && (_itemClass call TNL_finv_isDroppable)) then
	{
		ctrlSetText[8, "Able to receive items: Yes"];
	}
	else
	{
		ctrlSetText[8, "Able to receive items: No"];
	};
	
	if (player distance (getpos _unit) > 10) then
	{
		["Too far to trade"] call TNL_fextHint_Hint;
		closeDialog 0;
	};
};

TNL_ftrade_transferItem = 
{
	private ["_unit"];
	_unit = ((_this select 0) select 3);
	_itemClass = ((_this select 0) select 0);
	_itemArray = (_itemClass) call TNL_finv_getItemArray;
	_itemName = ((_itemArray select 2) select 0);
	//_itemDesc = ((_itemArray select 2) select 1);
	_itemAmount = _itemClass call TNL_finv_getItemAmount;
	_itemWeight = (_itemArray select 4);
	_itemTotalWeight = ((_itemWeight) * (_itemAmount));
	_weight = [] call TNL_finv_getPlayerWeight;
	_money = "money" call TNL_finv_getItemAmount;
	_tradeAmount = parseNumber ctrlText 9;
	_tradeTotalWeight = ((_itemWeight) * (_tradeAmount));
	

	
	[_unit, TNL_finv_getPlayerWeight, []] call TNL_fnet_ValueFromClientFunction;
	waitUntil {TNL_fnet_returnedVar};
	waitUntil {typeName TNL_fnet_returnedRequestedVar == "ARRAY"};
	

	_returnedWeight = TNL_fnet_returnedRequestedVar;
	_targetWeight = (_returnedWeight select 0);
	_targetMaxWeight = (_returnedWeight select 1);
	
	if (((TNL_gVar_int_timeSinceLastTrade)+TNL_gVar_int_timeUntilCanTrade) < time) then
	{
		if ((_tradeTotalWeight <= _targetMaxWeight) && (_itemClass call TNL_finv_isDroppable)) then
		{
			if (_itemAmount >= _tradeAmount) then
			{
				TNL_gVar_int_timeSinceLastTrade = time;
				[_unit,_itemClass,_tradeAmount] call TNL_fnet_TransferItemsToClient;
				[_itemClass, _tradeAmount] call TNL_finv_takeItemAmount;
				_code = compile format['["You have been given %1 %2(s) from %3"] call TNL_fextHint_Hint;', _tradeAmount, _itemName, name player call TNL_fplayer_formatName];
				[_unit, _code] call TNL_fnet_ExecuteCodeOnClient;
				[_unit, [_unit, player], 15, format["%1 has given %2 %3(s) to %4", (name player) call TNL_fplayer_formatName, _tradeAmount, _itemName, (name _unit) call TNL_fplayer_formatName]] call TNL_fnet_HintToClientsInDistanceOfObject;
				[format["You have given %1 %2 %3(s)", (name _unit) call TNL_fplayer_formatName, _tradeAmount, _itemName]] call TNL_fextHint_Hint;
			
				//hint "Given items...";
			}
			else
			{
				["You don't have enough"] call TNL_fextHint_Hint;
			};
		}
		else
		{
			["The other player cannot receive this"] call TNL_fextHint_Hint;
		};
	}
	else
	{
		["You are still giving items"] call TNL_fextHint_Hint;
	};

	[_unit] spawn TNL_ftrade_loadDialog;
};