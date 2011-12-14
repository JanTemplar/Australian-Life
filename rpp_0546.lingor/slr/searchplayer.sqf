_type = (_this select 0);
_searchplayer = (_this select 1);

if (_type == "searchCheck") then
{
	["You have sent the request to check the players inventory!"] call TNL_fextHint_Hint;
	[{ 
		if (player == (_this select 0)) then
		{
			["chooseAnswer", (_this select 0), (_this select 1)] execVM "slr\searchplayer.sqf";
		};
	}, [_searchplayer, player]] call TNL_fnet_execPublic;
};

if (_type == "chooseAnswer") then
{
	_searcher = (_this select 2);
	acceptSearch = 0;
	
	if (!(createDialog "TNL_dlg_genYesNo")) exitWith 
	{
		hint "Dialog Error!";
	};
	
	((findDisplay 1101) displayCtrl 1) ctrlSetStructuredText parseText "Search";
	((findDisplay 1101) displayCtrl 2) ctrlSetStructuredText parseText format["%1 wants to search you, do you want to allow him?", _searcher];
	((findDisplay 1101) displayCtrl 10) buttonSetAction "acceptSearch = 1; closeDialog 0;";
	((findDisplay 1101) displayCtrl 11) buttonSetAction "acceptSearch = 0; closeDialog 0;";
	waitUntil{(isNull(findDisplay 1101))};
	
	if (acceptSearch == 1) then
	{
		[{ 
			if (player == (_this select 1)) then
			{
				["returnSearch", (_this select 0), [(_this select 2), (_this select 3)]] execVM "slr\searchplayer.sqf";
			};
		}, [_searchplayer,_searcher,Gvar_arr_inv_inventory,Gvar_arr_lic_playerLicenses]] call TNL_fnet_execPublic;
	}
	else
	{
		[{ 
			if (player == (_this select 0)) then
			{
				[format["%1 refuses to let you search him!", (_this select 1)]] call TNL_fextHint_Hint;
			};
		}, [_searcher, _searchplayer]] call TNL_fnet_execPublic;
	};

};
	
if (_type == "returnSearch") then
{
	if (!(createDialog "TNL_dlg_genListView")) exitWith {hint "Dialog Error!";};
	_array = (_this select 2);
	_licenseArray  = (_array select 1);
	_inventoryArray = (_array select 0);
	_weaponsArray   = weapons   _civobj;
	_magazinesArray  = magazines _civobj;
	((findDisplay 1104) displayCtrl 1) ctrlSetStructuredText parseText "Search Player";
	_line = "---------------------------------------------";
	
	/* Add licenses */
	lbAdd [2, "License(s)"]; 
	if (count _licenseArray > 0) then
	{
		{
			lbAdd [2, format ["%1", (_x call TNL_flic_getLicenseName)]];
		} forEach _licenseArray;
	}
	else
	{
		lbAdd[2, "No licenses"];
	};
	
	lbAdd [2, _line];
	
	/* Add inventory */
	lbAdd [2, "Inventory"];
	if (count _inventoryArray > 0) then
	{
		{
			_itemClass = (_x select 0);
			_itemName = (_itemClass) call TNL_finv_getItemName;
			_amount = (_x select 1);
		
			if (_amount > 0) then 
			{
				lbAdd [2, format ["%1: %2", _itemName, _amount]];
			};
		} forEach _inventoryArray;
	}
	else
	{
		lbAdd[2, "No items"];
	};
	
	lbAdd [2, _line];
	
	/* Add weapons */
	lbAdd [2, "Weapons"];
	if (count _weaponsArray > 0) then
	{
		{
			_weapon = _x;
			_weaponName = _weapon call TNL_finv_getItemName;
			lbAdd [2, format ["%1", _weaponName]];	
		} forEach _weaponsArray;
	}
	else
	{
		lbAdd[2, "No Weapons"];
	};
	
	lbAdd [2, _line];
	
	/* Add magazines */
	_index = lbAdd [2, "Magazines"];
	if (count _magazinesArray > 0) then
	{
		{
				_magazine  = _x;
				_magazineName = _magazine call TNL_finv_getItemName;
				lbAdd [2, format ["%1", _magazineName]];
		} forEach _magazinesArray;
	}
	else
	{
		lbAdd[2, "No Magazines"];
	};
	
	lbAdd [2, _line];	
};