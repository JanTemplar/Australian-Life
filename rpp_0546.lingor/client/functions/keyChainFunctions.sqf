/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

TNL_fkeychain_openDialog =
{
	if (!createDialog "DlgKeyChain") then
	{
		hint "ERROR: in keyChainFunctions.sqf, error in function TNL_fkeychain_openDialog";
	};
	
	[] call TNL_fkeychain_loadDialog;
};

TNL_fkeychain_loadDialog = 
{
	lbClear 1;
	lbClear 2;
	
	{
		_index = lbAdd[1, format["Key: %1, %2, %3", (_x select 1) call TNL_finv_getItemName, _x select 2, _x select 0]];
		lbSetData[1,_index, format['["%1", %2, "%3"]', (_x select 1), (_x select 2), (_x select 0)]];
	} foreach Gvar_arr_inv_ownedVehicles;
	
	lbSetCurSel [1,0];
};

TNL_fkeychain_updateDisplay = 
{
	lbClear 2;
	
	if (count Gvar_arr_inv_ownedVehicles > 0) then
	{
		_data = call compile (lbData[1,lbCurSel 1]);
		
		[2, (_data select 2), (_data select 0)] call TNL_fvcl_populateVehicleMenu;
	};
};

TNL_fkeychain_select = 
{
	private ["_ldata","_rdata"];
	_ldata = _this select 0;
	_rdata = _this select 1;
	
	_object = null;
	
	{
		if (_ldata select 2 == format["%1", _x select 0]) then
		{
			if (vehicle player distance (_x select 0) <= 10) then
			{
				[_rdata] call TNL_fvcl_menuSelect;
			}
			else
			{
				["Too far away from the vehicle!"] call TNL_fextHint_Hint;
			};
		};
	
	} foreach Gvar_arr_inv_ownedVehicles;

};

TNL_fkeychain_dropKey = 
{
	private ["_object"];
	_object = _this select 0;
	
	{
		if (format["%1", _x select 0] == _object) then
		{
			_class = (_x select 1);
			_amount = (_x select 2);
			
			if (_amount > 1) then
			{
				(_x) set[2, ((_amount) - (1))];
			}
			else
			{
				_arr = [];
				{
					if (format["%1", _x select 0] != _object) then
					{
						_arr = _arr + [_x];
					};

				} foreach Gvar_arr_inv_ownedVehicles;
				
				Gvar_arr_inv_ownedVehicles = _arr;
			};
		};

	} foreach Gvar_arr_inv_ownedVehicles;

	[] call TNL_fkeychain_loadDialog;
};