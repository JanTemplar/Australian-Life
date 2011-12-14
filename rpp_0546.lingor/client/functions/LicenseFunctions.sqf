/*
Name: LicenseFunctions.sqf
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (09/06/2009)
Description: License Functions
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

TNL_flic_openDialog = 
{
	private ["_objectName"];
	
	_objectName = _this select 0;
	
	if (!createDialog "DlgLicenses") exitwith
	{
		hint "ERROR: in function TNL_flic_openDialog failed to open dialog OMGZZZZ!! RUN TO THE HILLS!!";
	};
	
	[_objectName] spawn TNL_flic_loadLicenses;
};
	
TNL_flic_loadLicenses =
{
	private ["_objectName"];
	
	_objectName = _this select 0;

	sleep 0.005;
	
	lbClear 25;
	
	_licenseArray = (_objectName) call TNL_flic_getShopLicenses;
	_licShopName = (_objectName) call TNL_flic_getShopName;
	_money = 'Money' call TNL_finv_getItemAmount;
	_numLicenses = (count Gvar_arr_lic_playerLicenses);
	_availableLicenses = 0;
	
	ctrlSetText[26, format["%1", _licShopName]];
	
	TNL_GLOBAL_VAR_LICENSE_SHOP = _objectName;

	
	
	{
		_licenseName = (_x) call TNL_flic_getLicenseName;
		_licenseDesc = (_x) call TNL_flic_getLicenseDesc;
		_licenseCost = (_x) call TNL_flic_getLicenseCost;
		
		
		if ([player,_x] call TNL_flic_playerCanBuyLicense || (not ((_objectName) call TNL_flic_getShopRequiresType))) then
		{
			_index = lbAdd[25, format["%1, %2Ц", _licenseName, _licenseCost]];
			   	lbSetData[25, _index, format['["%1", ["%2", "%4"], %3]',_x, _licenseName, _licenseCost, _licenseDesc]];
			   
			   _availableLicenses = _availableLicenses + 1;
		};
		
	} foreach _licenseArray;

	ctrlSetText[27, format["Money: %1Ц | # Owned licenses: %2 | Available licenses: %3 |", _money, _numLicenses, _availableLicenses]];
	lbSetCurSel [25, 0]; 
};

TNL_flic_updateDesc = 
{                        
	private ["_control", "_licData"];
	_licData = call compile (_this select 0);
	_licName = _licData select 1 select 0;
	_licDesc = _licData select 1 select 1;
	
	(findDisplay 901) displayCtrl 29 ctrlSetStructuredText parseText format["%1", _licName];
	(findDisplay 901) displayCtrl 28 ctrlSetStructuredText parseText format["%1", _licDesc];	
};

TNL_flic_purchaseLicense = 
{
	private ["_licData"];
	_licData = call compile (_this select 0);
	_licClass = (_licData select 0);
	_money = 'Money' call TNL_finv_getItemAmount;
	_script = (_licClass) call TNL_flic_getLicenseScript;
	
	//(_licClass) call TNL_flic_removeLicense;
	
	if (_money >= _licData select 2) then
	{
		if (not(_licClass call TNL_flic_playerHasLicense)) then
		{
			if (_script == "") then
			{
				['Money',(_licData select 2)] call TNL_finv_takeItemAmount;
				(_licClass) call TNL_flic_addLicense;
				//hint "You bought the license"; //Requires localizing
				[format["You purchased the license for $%1", (_licData select 2)]] call TNL_fextHint_Hint;

			}
			else
			{
				[_licClass] execVM _script;	
			};
		}
		else
		{
			["You already have that license"] call TNL_fextHint_Hint; //Requires localizing
		};
	}
	else
	{
		["Can't afford!"] call TNL_fextHint_Hint; //Requires localizing
	};
	
	[] spawn TNL_flic_refreshLicenses;
};

TNL_flic_refreshLicenses = 
{
	//sleep 0.1;
	//closeDialog 0;
	//[TNL_GLOBAL_VAR_LICENSE_SHOP] spawn TNL_flic_openDialog;
	
	[TNL_GLOBAL_VAR_LICENSE_SHOP] spawn TNL_flic_loadLicenses;
	
};

TNL_flic_getShopName =
{
	private ["_objectName", "_retStr"];
	
	_objectName = _this;
	_retStr = "";
	
	{
		if (_x select 0 == _objectName) then
		{
			_retStr = (_x select 1);
		};
	} foreach TNL_arr_lic_licensePurchase;
	
	_retStr
};

TNL_flic_getShopLicenses = 
{
	private ["_objectName", "_retarray"];
	
	_objectName = _this;
	_retArray = [];
	
	{
		if (_x select 0 == _objectName) then
		{
			_retArray = (_x select 2);	
		};
	} foreach TNL_arr_lic_licensePurchase;
	
	_retArray
};

TNL_flic_getShopRequiresType = 
{
	private ["_objectName", "_retBool"];
	
	_objectName = _this;
	_retBool = false;
	
	{
		if (_x select 0 == _objectName) then
		{
			_retBool = (_x select 3);
		};
	} foreach TNL_arr_lic_licensePurchase;
	
	_retBool
};

TNL_flic_getLicenseName = 
{
	private ["_licClass", "_retStr"];
	_licClass = _this;
	_retStr = "";
	
	{
		if (_x select 0 == _licClass) then
		{
			_retStr = ((_x select 1) select 0);	
		};
	} foreach TNL_arr_lic_licenses;	
	
	_retStr
};


TNL_flic_getLicenseDesc =
{
	private ["_licClass", "_retStr"];
	_licClass = _this;
	_retStr = "";
	
	{
		if (_x select 0 == _licClass) then
		{
			_retStr = ((_x select 1) select 1);
		};
	} foreach TNL_arr_lic_licenses;
	
	_retStr
};

TNL_flic_getLicenseCost = 
{
	private ["_licClass", "_retInt"];
	_licClass = _this;
	_retInt = 0;
	
	{
		if (_x select 0 == _licClass) then
		{
			_retInt = ((_x select 2) select 0);
		};
	} foreach TNL_arr_lic_licenses;
	
	_retInt
};

TNL_flic_getLicenseScript = 
{
	private ["_licClass", "_retStr"];
	_licClass = _this;
	_retStr = "";
	
	{
		if (_x select 0 == _licClass) then
		{
			_retStr = (_x select 4);
		};
	} foreach TNL_arr_lic_licenses;
	
	_retStr
};

TNL_flic_playerCanBuyLicense = 
{
	private ["_player", "_licClass", "_retBool"];
	_player = _this select 0;
	_licClass = _this select 1;
	_retBool = false;
	
	
	{
		if (_x select 0 == _licClass) then
		{
			if (count (_x select 3) <= 0) then
			{
				_retBool = true;
			};
			
			{
				if ([player,_x] call TNL_fmission_playerIsType) then
				{
				   	_retBool = true;	
				};
			} foreach (_x select 3);
		};
	} foreach TNL_arr_lic_licenses;
	
	
	_retBool
};

TNL_flic_playerHasLicense = 
{
	private ["_licClass", "_retBool"];
	_licClass = _this;
	_retBool = false;
	
	
	
	{
		if (_x == _licClass) then
		{
			_retBool = true;
		};
		
	} foreach Gvar_arr_lic_playerLicenses;	
	
	_retBool
};

TNL_flic_addLicense =
{
	private ["_licClass"];
	_licClass = _this;
	
	if (not(_licClass call TNL_flic_playerHasLicense)) then
	{
		Gvar_arr_lic_playerLicenses = Gvar_arr_lic_playerLicenses + [ _licClass ];	
		[TNL_gVar_str_tables_licenses, [TNL_db_charName select 0, TNL_db_charName select 1], Gvar_arr_lic_playerLicenses] call TNL_fsav_clientRequestSave;
	};
};

TNL_flic_removeLicense =
{
	private ["_licClass"];
	_licClass = _this;
	
	if (_licClass call TNL_flic_playerHasLicense) then
	{
		Gvar_arr_lic_playerLicenses = Gvar_arr_lic_playerLicenses - [ _licClass ];
		[TNL_gVar_str_tables_licenses, [TNL_db_charName select 0, TNL_db_charName select 1], Gvar_arr_lic_playerLicenses] call TNL_fsav_clientRequestSave;
	};
};
	
	