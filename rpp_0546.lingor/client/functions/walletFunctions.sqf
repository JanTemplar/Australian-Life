//The New Life (RPG Mission)
//Copyright (C) 2009  Matthew Simms & Petr Klíma

//Initialize wallet array:
if (isNil "TNL_wallet_walletArray") then
{
	TNL_wallet_walletArray = [];
};
//TNL_wallet_walletArray = [["creditCard", "654321", "John Doe"], ["creditCard", "123456", "John Doe"], ["idCard", 15415, "John", "Doe", "Maruko", [true, 90]]];

TNL_fwallet_addItem =
{
	switch (toLower(_this select 0)) do
	{
		case "creditcard":
		{
			TNL_wallet_walletArray = TNL_wallet_walletArray + [["creditCard", _this select 1, _this select 2]];
		};
		
		case "idcard":
		{
			TNL_wallet_walletArray = TNL_wallet_walletArray + [["idCard", _this select 1, _this select 2, _this select 3, "Maruko", [_this select 4, _this select 5]]];
		};
	};
	
	[TNL_gVar_str_tables_wallet, [TNL_db_charName select 0, TNL_db_charName select 1], TNL_wallet_walletArray] call TNL_fsav_clientRequestSave;
};

/*
Opens the wallet dialog
	* Parameters: 
		None

	* Returns:
		None
*/
TNL_fwallet_open = 
{
	if (!CreateDialog "DlgWallet") exitWith
	{
		hint "Error in function TNL_finv_openInventory - Failed to open dialog!";
	};
	((findDisplay 701) displayCtrl 3) ctrlSetStructuredText parseText localize "STRS_wallet_selectCard";
	
	{
		switch (_x select 0) do
		{
			case "creditCard":
			{
				_acc = _x select 1;
				_owner = _x select 2;
				
				_name = format [localize "STRS_wallet_creditCard", [_acc, 3] call TNL_fcvar_stringAddDashes];
				_desc = format [localize "STRS_wallet_desc_creditcard", [_acc, 3] call TNL_fcvar_stringAddDashes, _owner];
				_index = lbAdd[1, format["%1", _name]];
				lbSetData[1, _index, format["[""%1"", ""%2"", ""%3"", ""%4"", [""type"", ""creditCard""]]", _name, _desc, _acc, _owner]];
			};
			case "idCard":
			{
				_name = format [localize "STRS_wallet_idCard", _x select 2, _x select 3];
				
				_desc = localize "STRS_wallet_desc_idCard" + (_x call TNL_fwallet_idGetDesc);
				
				_index = lbAdd[1, format["%1", _name]];
				lbSetData[1, _index, format["[""%1"", ""%2"", [""type"", ""idCard""]]", _name, _desc]];
			};
		};
	} foreach TNL_wallet_walletArray;
	lbSetCurSel [1, 0];
};

TNL_fwallet_giveItem =
{

};

TNL_fwallet_viewItem = 
{
	{
		if (typeName _x == "ARRAY") then
		{
			if (_x select 0 == "type") then
			{
				_type = (_x select 1);
				
				if (_type == "idCard") then
				{
				
				}
				else
				{
					if (_type == "creditCard") then
					{
						_acc = ((_this select 0) select 2);
						copyToClipboard _acc;
						_pin = [_acc, 1] call TNL_fbank_getDetail;
						TNL_gVar_arr_copied = [_acc, _pin];
						[format["Account: %1 (ALT-0) \nPin: %2 (ALT-1)\nCopied to clipboard!", _acc, _pin]] call TNL_fextHint_Hint;
					};
				};
			};
		};
	} forEach (_this select 0);
};

TNL_fwallet_idGetDesc =
{
	_id = _this select 1;
	_firstname = _this select 2;
	_surname = _this select 3;
	_address = _this select 4;
	_fake = _this select 5;

	_desc = format [localize "STRS_wallet_desc_idCardDetails", _id, _firstname, _surname, _address];
	if (_fake select 0) then
	{
		_desc = _desc + "<br/><br/>Forged";
		_quality = _fake select 1;
		if (_quality < 20) then
		{
			_desc = _desc + ", Quality: Terrible<br/>A really botched quality. Anyone with at least 1 eye can tell this is a forgery.";
		}
		else
		{
			if (_quality < 40) then
			{
				_desc = _desc + ", Quality: Bad<br/>A job well done...for a 10 year old.";
			}
			else
			{
				if (_quality < 60) then
				{
					_desc = _desc + ", Quality: Decent<br/>Might fool the regular Joe Cop, but you'd have to be really lucky to try elsewhere.";
				}
				else
				{
					if (_quality < 80) then
					{
						_desc = _desc + ", Quality: Good<br/>A good piece of work. Without a UV lamp you won't see the difference from original.";
					}
					else
					{
						if (_quality == 100) then
						{
							_desc = _desc + ", Quality: Genuine<br/>This is your legit ID, do not lose this!.";
						}
						else
						{
							_desc = _desc + ", Quality: Perfect<br/>Brilliant piece of art. The only way to tell this from a genuine counterpart is a detailed examination under microscope.";
						};
					};
				};
			};
		};
	}
	else
	{
		_desc = _desc + "<br/><br/>Genuine";
	};
	
	_desc;
};

TNL_fwallet_updateDisplay = 
{
	private ["_idc"];

	_idc = _this select 0;
	_index = lbCurSel _idc;
	_ctrl1 = _this select 1;
	
	_data = call compile (lbData[_idc,_index]);
	_itemName = (_data select 0);
	
	((findDisplay 701) displayCtrl 2) ctrlSetStructuredText parseText format["%1", _itemName];
	((findDisplay 701) displayCtrl 3) ctrlSetStructuredText parseText format["%1", _data select 1];
};

TNL_fwallet_removeCreditCard =
{
	private ["_acc", "_remove"];
	_acc = _this select 0;
	_name = _this select 1;
	
	_i = 0;
	{
		if ((_x select 0) == "creditCard") then
		{
			if ((_acc == _x select 1) && (_name == _x select 2)) exitWith
			{
				TNL_wallet_walletArray set [_i, ">REMOVE<"];
			};
		};
		_i = _i + 1;
	} forEach TNL_wallet_walletArray;
	
	TNL_wallet_walletArray = TNL_wallet_walletArray - [">REMOVE<"];
	[TNL_gVar_str_tables_wallet, [TNL_db_charName select 0, TNL_db_charName select 1], TNL_wallet_walletArray] call TNL_fsav_clientRequestSave;
};