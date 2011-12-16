#define __thisFile "client\functions\bankFunctions.sqf"

/*
Create a new bank account
	* Parameters: account registrar ID <int>
	* Returns: account ID on succes, -1 on error <int>
*/
TNL_fbank_createAcc =
{
	private ["_owner", "_acc", "_pin", "_accounts"];
	_owner = _this;

	if (typeName _owner != "SCALAR") exitWith
	{
		[__thisFile, format ["Bad input in TNL_fbank_createAcc: param - expected NUMBER, provided %1", typeName _owner]] call TNL_fcore_debug;
	};
	
	_accounts = bank getVariable "TNL_bank_accounts";
	
	_acc = [] call TNL_createAccNum;
	while {_acc in _accounts} do
	{
		_acc = [] call TNL_createAccNum;
	};

	_pin = str (round (random 9999));
	if (parseNumber _pin < 1000) then
	{
		_pin = [_pin, 4] call TNL_fvar_addZeros;
	};
	
	TNL_gVar_paycheckAccNum = _acc;
	
	_accounts = _accounts + [_acc];
	bank setVariable ["TNL_bank_accounts", _accounts, true];
	[TNL_gVar_str_tables_bankAccountRef, [bank], [ [_accounts, "TNL_bank_accounts"] ]] call TNL_fsav_clientRequestSave;
	
	call compile format ['
		bank setVariable ["TNL_bank_acc_%1", [[[_owner, 4],[]], _pin, 0, [], 0]];
		[TNL_gVar_str_tables_bankAccounts, [bank, "TNL_bank_acc_%1"], [[[_owner, 4],[]], _pin, 0, [], 0]] call TNL_fsav_clientRequestSave;
	', _acc];
	[_acc, date, 0, [[] call TNL_fcenv_time, TNL_bank_curBank]] call TNL_fbank_historyAdd;
	
	[_acc, _pin]
};

TNL_createAccNum =
{
	private ["_i", "_acc", "_num"];
	_i = 0;
	_acc = "";
	while {_i < 12} do
	{
		_num = round (random 9);
		while {_i == 0 && _num == 0} do
		{ //don't want the first digit to be 0
			_num = round (random 9);
		};
		
		_acc = format ["%1%2", _acc, _num];
		_i = _i + 1;
	};
	_acc
};
/*
Completely wipes out a specified bank account
	* Parameters: account ID <int>
	* Returns: success/error <bool>
*/
TNL_fbank_deleteAcc =
{
	private ["_acc", "_accounts"];
	_acc = _this select 0;
	
	if (typeName _acc != "STRING") exitWith
	{
		[__thisFile, format ["Bad input in TNL_fbank_deleteAcc: param - expected STRING, provided %1", typeName _acc]] call TNL_fcore_debug;
	};

	_accounts = bank getVariable "TNL_bank_accounts";
	_accounts = _accounts - [_acc];
	bank setVariable ["TNL_bank_accounts", _accounts, true];
	[TNL_gVar_str_tables_bankAccountRef, [bank], [ [_accounts, "TNL_bank_accounts"] ]] call TNL_fsav_clientRequestSave;
		
	call compile format ['
		bank setVariable ["TNL_bank_acc_%1", null, true];
		[TNL_gVar_str_tables_bankAccounts, [bank, "TNL_bank_acc_%1"], null] call TNL_fsav_clientRequestSave;
	', _acc];
};


/*
Check whether the specified account exists
	* Parameters: account ID <int>
	* Returns: true/false <bool>
*/
TNL_fbank_accExists =
{
	private ["_acc", "_accounts"];
	_acc = _this;

	if (typeName _acc != "STRING") exitWith
	{
		[__thisFile, format ["Bad input in TNL_fbank_accExists: param - expected STRING, provided %1", typeName _acc]] call TNL_fcore_debug;
	};
	
	_accounts = bank getVariable "TNL_bank_accounts";
	if (_acc in _accounts) then
	{
		true
	}
	else
	{
		false
	};
};

/*
Retrieve all details of a specified bank account
	* Parameters:
		account ID <string>
	* Returns:
		detials <array>
*/
TNL_fbank_getAll =
{
	private ["_acc", "_return"];
	_acc   = _this;

	if (typeName _acc != "STRING") exitWith
	{
		[__thisFile, format ["Bad input in TNL_fbank_getAll: param - expected STRING, provided %1 (%2)", typeName _index, _index]] call TNL_fcore_debug;
	};
	
	if (! (_acc call TNL_fbank_accExists) ) exitWith
	{
		-1;
		["TNL_fnet_hint", "account not found, cant get all its details!"] call TNL_fnet_execCommand;
	};
		
	call compile format ['
		_return = bank getVariable "TNL_bank_acc_%1";
	', _acc];
		
	_return;
};

TNL_fbank_historyDelete =
{
};

TNL_fbank_historyParse =
{
	private ["_action", "_data", "_params", "_i", "_add", "_sTable", "_text"];
	_action = _this select 0;
	//_time = _this select 1;
	_data = _this select 2;
	//hint str _this;
	_params = "";
	if (count _data > 0) then
	{
		_i = 0;
		while {_i < (count _data)} do
		{
			if (typeName (_data select _i) == "STRING") then
			{
				_add = format ["""%1""", (_data select _i)];
			}
			else
			{
				_add = str (_data select _i);
			};
			_params = format ["%1%2", _params, _add];
			
			if (_i < (count _data) - 1) then
			{
				_params = format ["%1,", _params];
			};
			_i = _i + 1;
		};
	};
	
	//hint _params;
	
	switch (_action) do
	{
		case 0: //account created
		{
			_sTable = "STRS_bank_hist_accCreated";
		};
		case 1: //ATM - withdraw
		{
			_sTable = "STRS_bank_hist_atmWithdraw";
		};
		case 2: //ATM - deposit
		{
			_sTable = "STRS_bank_hist_atmDeposit";
		};
		case 3: //bank - withdraw
		{
			_sTable = "STRS_bank_hist_bankWithdraw";
		};
		case 4: //bank - deposit
		{
			_sTable = "STRS_bank_hist_bankDeposit";
		};
		case 5: //wired transfer - send
		{
			_sTable = "STRS_bank_hist_wireSent";
		};
		case 6: //wired transfer - receive
		{
			_sTable = "STRS_bank_hist_wireReceived";
		};
		case 7: //request a new card
		{
			_sTable = "STRS_bank_hist_requestCard";
		};
		case 8: //add a new user
		{
			_sTable = "STRS_bank_hist_addUser";
		};
		case 9: //remove a user
		{
			_sTable = "STRS_bank_hist_removeUser";
		};
		case 10: //change user's withdraw rights to allowed
		{
			_sTable = "STRS_bank_hist_canWithdrawChangeTrue";
		};
		case 11: //change user's withdraw rights to disallowed
		{
			_sTable = "STRS_bank_hist_canWithdrawChangeFalse";
		};
		case 12: //change user's withdraw limit
		{
			_sTable = "STRS_bank_hist_withdrawLimitChange";
		};
		case 13: //change user's withdraw limit to unlimited
		{
			_sTable = "STRS_bank_hist_withdrawLimitChangeNone";
		};
		case 14: //change user's credit transer rights to allowed
		{
			_sTable = "STRS_bank_hist_canWireChangeTrue";
		};
		case 15: //change user's credit transer rights to disallowed
		{
			_sTable = "STRS_bank_hist_canWireChangeFalse";
		};
		case 16: //change user's credit transfer limit
		{
			_sTable = "STRS_bank_hist_wireLimitChange";
		};
		case 17: //change user's credit transfer limit
		{
			_sTable = "STRS_bank_hist_wireLimitChangeNone";
		};
	};
	
	_text = call compile format ['format [localize "%1", %2]', _sTable, _params];
	_text
};

TNL_fbank_historyAdd =
{
	private ["_acc", "_date", "_action", "_data", "_str", "_i", "_add", "_entry", "_hist", "_index"];
	_acc = _this select 0;
	_date = _this select 1;
	_action = _this select 2;
	_data = _this select 3;
	_str = "";
	
	if (typeName _action == "STRING") then
	{
		switch (toLower _action) do
		{
			case "acccreate":
			{
				_action = 0;
			};
			case "withdrawatm":
			{
				_action = 1;
			};
			case "depositatm":
			{
				_action = 2;
			};
			case "withdrawbank":
			{
				_action = 3;
			};
			case "depositbank":
			{
				_action = 4;
			};
			case "creditsend":
			{
				_action = 5;
			};
			case "creditreceive":
			{
				_action = 6;
			};
			case "requestcard":
			{
				_action = 7;
			};
			case "adduser":
			{
				_action = 8;
			};
			case "removeuser":
			{
				_action = 9;
			};
			case "canwithdrawchangetrue":
			{
				_action = 10;
			};
			case "canwithdrawchangefalse":
			{
				_action = 11;
			};
			case "withdrawlimitchangetrue":
			{
				_action = 12;
			};
			case "withdrawlimitchange":
			{
				_action = 13;
			};
			case "withdrawlimitchangenone":
			{
				_action = 14;
			};
			case "canwirechangetrue":
			{
				_action = 15;
			};
			case "canwirechangefalse":
			{
				_action = 16;
			};
			case "wirelimitchange":
			{
				_action = 17;
			};
			case "wirelimitchangenone":
			{
				_action = 18;
			};
		};
	};
	
	
	/*if (count _data > 0) then
	{
		_i = 0;
		while {_i < (count _data)} do
		{
			_add = _data select _i;
			if (typeName _add == "STRING") then
			{
				_add = format ["""%1""", _add];
			};
			_str = format ["%1%2", _str, _add];
			
			if (_i < (count _data) - 1) then
			{
				_str = format ["%1,", _str];
			};
			_i = _i + 1;
		};
	};*/
	
	
	/*
	_entry = [_action, [_date select 3, _date select 4], _data];
	
	_hist = [_acc, 3] call TNL_fbank_getDetail;	
	
	_date = [_date select 0, _date select 1, _date select 2];
	_index = -1;
	_i = 0;
	{
		if ([_x select _i, _date] call TNL_fcvar_arrayCompare) exitWith
		{
			_index = _i;
		};
		_i = _i + 1;
	} forEach _hist;
	
	if (_index == -1) then
	{
		_index = count _hist;
		_hist set [_index, [_date]];
	};
	
	_day = (_hist select _index);
	_day set [(count _day), _entry];
	
	[_acc, 3, _hist] call TNL_fbank_setDetail;
	*/
};

TNL_fbank_hasAccess =
{
	private ["_acc", "_id", "_return", "_users"];
	_acc = _this select 0;
	_id = _this select 1;
	
	_return = false;
	if (_acc call TNL_fbank_accExists) then
	{	
		_users = [_acc, 0] call TNL_fbank_getDetail;
	
		if (_id == (_users select 0) select 0) then
		{
			_return = true;
		}
		else
		{
			if (count (_users select 1) > 0) then
			{
				{
					if (_id == _x select 0) exitWith
					{
						_return = true;
					};
				} forEach (_users select 1);
			};
		};
	};
	
	_return
};

TNL_fbank_getUserDetails =
{
	private ["_index", "_uid", "_detail", "_users", "_ok", "_return"];
	_acc = _this select 0;
	_uid = _this select 1;
	if (count _this > 2) then
	{
		_detail = _this select 2;
	}
	else
	{
		_detail = -1;
	};
	
	_users = [_acc, 0] call TNL_fbank_getDetail;
	_ok = false;
	_return = [];
	{
		if ((_x select 0) == _uid) exitWith
		{
			_return = _x;
			_ok = true;
		};
	} forEach (_users select 1);
	if (typeName _detail == "STRING") then
	{
		switch (toLower _detail) do
		{
			case "withdrawrights":
			{
				_detail = 1;
			};
			case "wirerights":
			{
				_detail = 2;
			};
			case "tries":
			{
				_detail = 3;
			};
		};
	};
	
	if (_ok) then
	{	
		switch (_detail) do
		{
			case 1:
			{
				_return = _return select 1;
			};
			case 2:
			{
				_return = _return select 2;
			};
			case 3:
			{
				_return = _return select 3;
			};
		};
	}
	else
	{
		if (_detail == 3) then
		{
			_return = (_users select 0) select 1;
		}
		else
		{
			_return = -1;
		};
	};
	
	_return
};

TNL_fbank_setUserDetails =
{
	private ["_acc", "_uid", "_detail", "_data", "_users", "_user", "_index", "_i"];
	_acc = _this select 0;
	_uid = _this select 1;
	if (count _this > 3) then
	{
		_detail = _this select 2;
		_data = _this select 3;
	}
	else
	{
		_detail = -1;
		_data = _this select 2;
	};
	
	if (typeName _detail == "STRING") then
	{
		switch (toLower _detail) do
		{
			case "withdrawrights":
			{
				_detail = 1;
			};
			case "wirerights":
			{
				_detail = 2;
			};
			case "tries":
			{
				_detail = 3;
			};
		};
	};
	
	_users = [_acc, 0] call TNL_fbank_getDetail;
	_index = -1;
	
	_i = 0;
	{
		if (_x select 0 == _uid) exitWith
		{
			_index = _i;
		};
		_i = _i + 1;
	} forEach (_users select 1);
	
	if (_detail == -1) then
	{
		if (_index != -1) then
		{
			_users = (_users select 1) select _index;
			_users set [_detail, _data];
			
			true
		}
		else
		{
			if (_detail == 3) then
			{
				_users = _users select 0;
				_users set [1, _data];
			}
			else
			{
				false
			};
		};
	}
	else
	{
		if (_detail == -1) then
		{
			_user = _users select 1;
			_user set [_index, _data];
		}
		else
		{
			_user = (_users select 1) select _index;
			_user set [_detail, _data];
		};
	};
	
	[_acc, 0, _users] call TNL_fbank_setDetail;
	true
};
//hint str ("654321" call TNL_fbank_getAll)
//["654321", 0, 1, [false, 0, 0]] call TNL_fbank_setUserDetails
TNL_fbank_chooseActionOpen =
{
	TNL_bank_curBank = _this;
	if (!createDialog "TNL_dlg_bankChooseAction") then
	{
		hint "Error in function TNL_fbank_chooseActionOpen - Failed to open TNL_dlg_bankChooseAction dialog!";
	};
	((findDisplay 501) displayCtrl 1) ctrlSetStructuredText parseText TNL_bank_curBank;
};

TNL_fbank_actionCreate =
{
	_stage = _this select 0;
	
	switch (_stage) do
	{
		case 0:
		{
			[
				"ID please",
				"Before you can create a new account you need to show your ID.<br/>Would you like to do that?",			
				'closeDialog 0; ["[1, lbCurSel 1] spawn TNL_fbank_actionCreate;"] call TNL_fbank_selectIdOpen;',
				"closeDialog 0"
			] spawn TNL_fui_createYesNoDlg;
		};
		case 1:
		{
			_name = (call compile (lbData[1,_this select 1])) select 3;
			_id = _name call TNL_fdb_nameGetId;
			
			_new = _id call TNL_fbank_createAcc;
			
			//hint format ["%1 - %2", _new select 0, _new select 1];
			
			["creditCard", _new select 0, _name] call TNL_fwallet_addItem;
			closeDialog 0;
			[
				"Account created!",
				format ["Thank you, your account has been created.<br/><br/><t font='Zeppelin33'>Account #: %1<br/>PIN: %2</t><br/><br/>Would you like to manage your account now?", [(_new select 0), 3] call TNL_fcvar_stringAddDashes, _new select 1],
				format ['closeDialog 0; ["%1", %2] spawn TNL_fbank_manageOpen', _new select 0, _id],
				"closeDialog 0"
			] spawn TNL_fui_createYesNoDlg;
		};
	};
};

TNL_fbank_actionManage =
{
	_stage = _this select 0;

	switch (_stage) do
	{
		case 0:
		{
			//if (!createDialog "TNL_dlg_bankInputAcc") exitWith
			//{
			//	hint "Error in function TNL_fbank_actionManage - Failed to open TNL_dlg_bankInputAcc dialog!";
			//};
			
			[player] call TNL_fatm_open;
			
			((findDisplay 601) displayCtrl 3) ctrlSetStructuredText parseText "Credit cards:";
			((findDisplay 601) displayCtrl 2) ctrlSetStructuredText parseText "Select card";
			((findDisplay 601) displayCtrl 11) ctrlSetStructuredText parseText "Insert card";
			((findDisplay 601) displayCtrl 10) buttonSetAction "closeDialog 0; [2, (call compile lbData[1,(lbCurSel 1)])] call TNL_fbank_actionManage;";
			 
		};
		case 1:
		{
			_text = _this select 1;
			
			_text = [_text, "0123456789"] call TNL_fcvar_stringFilter;
			_text = [_text, 12] call TNL_fcvar_stringShorten;
			
			ctrlSetText [1, _text];
			
			_chars = toArray _text;
			while {count _chars < 12} do
			{
				_chars = _chars + toArray "x";
			};
			_text = toString _chars;
			
			_text = [_text, 3] call TNL_fcvar_stringAddDashes;
			
			((findDisplay 502) displayCtrl 2) ctrlSetStructuredText parseText format ["# %1", _text];
		};
		case 2:
		{
			_acc = ((_this select 1) select 0);
			
			if ([_acc, "0123456789"] call TNL_fcvar_hasForbiddenChars) exitWith {};
			//if (count (toArray _acc) < 12) exitWith {};
			
			if (_acc call TNL_fbank_accExists) then
			{
				closeDialog 0;
				["[3, lbCurSel 1] call TNL_fbank_actionManage;", _acc] call TNL_fbank_selectIdOpen;
			}
			else
			{
				["Invalid account number", "The entered account number does not match any of our registered bank accounts.", "closeDialog 0"] spawn TNL_fui_createNotifyDlg;
			};
		};
		case 3:
		{
			_name = (call compile (lbData[1,_this select 1])) select 3;
			_id = _name call TNL_fdb_nameGetId;
			
			_owners = [TNL_bank_curAccNo, 0] call TNL_fbank_getDetail;

			closeDialog 0;
			if ([TNL_bank_curAccNo, _id] call TNL_fbank_hasAccess) then
			{
				[TNL_bank_curAccNo, _id] spawn TNL_fbank_manageOpen;
			}
			else
			{
				["No access", "Sorry Sir, you do not have the rights to manipulate with this account.", "closeDialog 0;"] spawn TNL_fui_createNotifyDlg;
			};
		};
		case 4:
		{
			private ["_index", "_id", "_displ", "_rights", "_cashRights", "_cashLimit", "_transferRights", "_transferLimit"];
			_index = _this select 1;
			_id = lbValue [12, _index];

			_displ = findDisplay 504;
			if (_id == -1) then
			{	
				{
					ctrlShow [_x, false];
				} forEach [131, 141, 142, 151, 152, 161, 162];
				
				(_displ displayCtrl 132) ctrlSetStructuredText parseText "Account owners can add new users using the Management option.";
			}
			else
			{
				{
					ctrlShow [_x, true];
				} forEach [131, 141, 142, 151, 152, 161, 162];
				_rights = [TNL_bank_curAccDetails select 0, _id, 1] call TNL_fbank_getUserDetails;
				if (_rights select 0) then
				{
					_cashRights = format ["<t color='#22cc00'>%1</t>", localize "STRS_gen_btnYes"];
					if (_rights select 1 == -1) then
					{
						_cashLimit = format ["<t color='#22cc00'>%1</t>", localize "STRS_gen_unlimited"];
					}
					else
					{
						_cashLimit = format ["%1/%2", _rights select 2, _rights select 1];
					};
				}
				else
				{
					_cashRights = format ["<t color='#ff0000'>%1</t>", localize "STRS_gen_btnNo"];
					_cashLimit = format ["<t color='#ff0000'>%1</t>", localize "STRS_gen_forbidden"];
				};
				
				_rights = [TNL_bank_curAccDetails select 0, _id, 2] call TNL_fbank_getUserDetails;
				if (_rights select 0) then
				{
					_transferRights = format ["<t color='#22cc00'>%1</t>", localize "STRS_gen_btnYes"];
					if (_rights select 1 == -1) then
					{
						_transferLimit = format ["<t color='#22cc00'>%1</t>", localize "STRS_gen_unlimited"];
					}
					else
					{
						_transferLimit = format ["%1/%2", _rights select 2, _rights select 1];
					};
				}
				else
				{
					_transferRights = format ["<t color='#ff0000'>%1</t>", localize "STRS_gen_btnNo"];
					_transferLimit = format ["<t color='#ff0000'>%1</t>", localize "STRS_gen_forbidden"];
				};
				
				(_displ displayCtrl 132) ctrlSetStructuredText parseText _cashRights;
				(_displ displayCtrl 142) ctrlSetStructuredText parseText _cashLimit;
				(_displ displayCtrl 152) ctrlSetStructuredText parseText _transferRights;
				(_displ displayCtrl 162) ctrlSetStructuredText parseText _transferLimit;
			};
		};
		case 5:
		{
			_index = lbValue [21, _this select 1];
			
			lbClear 22;
			if (_index != -1) then
			{	
				_hist = ([TNL_bank_curAccDetails select 0, 3] call TNL_fbank_getDetail) select _index;
				
				_i = 1;
				while {_i < count _hist} do
				{
					_entry = (_hist select _i) call TNL_fbank_historyParse;
					//_entry = call compile format ['format [localize "%1", %2]', (_hist select _i) select 0, (_hist select _i) select 1];
					//hint str _hist;
					_index = lbAdd [22, _entry];
					lbSetData [22, _index, _entry];
					_i = _i + 1;
				};
				
				lbSetCurSel [22, 0];
			}
			else
			{
				((findDisplay 504) displayCtrl 23) ctrlSetStructuredText parseText localize "STRS_bank_ereasedHist";
			};
		};
		case 6:
		{
			_text = lbData [22, _this select 1];
			
			((findDisplay 504) displayCtrl 23) ctrlSetStructuredText parseText _text;
		};
		case 7:
		{
			/*private ["_date", "_entry", "_dayHist", "_hist"];
			_date = _this select 1;
			_entry = (_this select 2) + 1;

			_hist = [TNL_bank_curAccDetails select 0, 3] call TNL_fbank_getDetail;
			_hist =+ _hist;
			_dayHist = _hist select _date;
			_dayHist set [_entry, ">REMOVE<"];
			_dayHist = _dayHist - [">REMOVE<"];
			_hist set [_date, _dayHist];
			hint str _hist;
			//[TNL_bank_curAccNo, 4, _hist] call TNL_fbank_setDetail;*/
		};
		case 8:
		{
			//[localize "STRS_bank_histDeleteTitle", localize "STRS_bank_histDeleteMsg", "closeDialog 0; [TNL_bank_curAccDetails select 0, 4, []] call TNL_fbank_setDetail;", "closeDialog 0"] spawn TNL_fui_createYesNoDlg
		};
		case 9:
		{
			_idc = _this select 1;
			_text = _this select 2;
			
			if (ctrlText _idc == "") then
			{
				ctrlShow [_text, true];
			}
			else
			{
				ctrlShow [_text, false];
			};
		};
		case 10:
		{
			disableSerialization;
			
			_data = call compile (lbData [10, _this select 1]);
			_uid = lbValue [10, _this select 1];
			
			//hint str _uid;
			
			_displ = findDisplay 505;
			(_displ displayCtrl 11) ctrlSetStructuredText parseText ((_data select 0) call TNL_fdb_idGetName);
			
			if (_uid == -1) then
			{
				(_displ displayCtrl 110) ctrlSetStructuredText parseText format ["<t color='#666666'>%1</t>", localize "STRS_bank_canWithdraw"];
				ctrlSetText [111, localize "STRS_gen_btnYes"];
				ctrlEnable [111, false];
				(_displ displayCtrl 120) ctrlSetStructuredText parseText format ["<t color='#666666'>%1</t>", localize "STRS_bank_withdrawLimit"];
				ctrlSetText [121, localize "STRS_gen_unlimited"];
				ctrlEnable [121, false];
				
				(_displ displayCtrl 210) ctrlSetStructuredText parseText format ["<t color='#666666'>%1</t>", localize "STRS_bank_canWire"];
				ctrlSetText [211, localize "STRS_gen_btnYes"];
				ctrlEnable [211, false];
				(_displ displayCtrl 220) ctrlSetStructuredText parseText format ["<t color='#666666'>%1</t>", localize "STRS_bank_wireLimit"];
				ctrlSetText [221, localize "STRS_gen_unlimited"];
				ctrlEnable [221, false];
				
				ctrlEnable [40, false];
				ctrlEnable [41, false];
				
				buttonSetAction [42, format ["[18, %1] call TNL_fbank_actionManage", TNL_bank_curAccDetails select 1]];
			}
			else
			{
				buttonSetAction [42, format ["[18, %1] call TNL_fbank_actionManage", _uid]];
				
				{
					ctrlEnable [_x, true];
				} forEach [111, 121, 211, 221, 40, 41];
				
				(_displ displayCtrl 110) ctrlSetStructuredText parseText localize "STRS_bank_canWithdraw";
				(_displ displayCtrl 120) ctrlSetStructuredText parseText localize "STRS_bank_withdrawLimit";
				(_displ displayCtrl 210) ctrlSetStructuredText parseText localize "STRS_bank_canWire";
				(_displ displayCtrl 220) ctrlSetStructuredText parseText localize "STRS_bank_wireLimit";
				
				buttonSetAction [121, format ["[%1, 1] spawn DFS_fbank_accessEditDetails", _uid]];
				buttonSetAction [221, format ["[%1, 2] spawn DFS_fbank_accessEditDetails", _uid]];
				buttonSetAction [41, format ["[14, %1, %2] call TNL_fbank_actionManage", _this select 1, _uid]];
				
				_withdraw = (_data select 1) select 0;
				_transfer = (_data select 2) select 0;
				
				if (!_withdraw) then //Forbidden
				{
					(_displ displayCtrl 120) ctrlSetStructuredText parseText format ["<t color='#666666'>%1</t>", localize "STRS_bank_withdrawLimit"];
					ctrlSetText [111, localize "STRS_gen_btnNo"];
					ctrlSetText [121, localize "STRS_gen_forbidden"];
					ctrlEnable [121, false];
					buttonSetAction [111, format ['[11, 111, false, %1] call TNL_fbank_actionManage', _uid]];
				}
				else
				{
					_withdraw = (_data select 1) select 1;
					
					ctrlSetText [111, localize "STRS_gen_btnYes"];
					buttonSetAction [111, format ['[11, 111, true, %1] call TNL_fbank_actionManage', _uid]];
					if (_withdraw == -1) then //Unimited
					{
						ctrlSetText [121, localize "STRS_gen_unlimited"];
					}
					else
					{
						ctrlSetText [121, format ["%1 UPK", (_withdraw) call TNL_fcvar_addDigitSeparators]];
					};
				};
				
				if (!_transfer) then //Forbidden
				{
					(_displ displayCtrl 220) ctrlSetStructuredText parseText format ["<t color='#666666'>%1</t>", localize "STRS_bank_wireLimit"];
					ctrlSetText [211, localize "STRS_gen_btnNo"];
					ctrlSetText [221, localize "STRS_gen_forbidden"];
					ctrlEnable [221, false];
					buttonSetAction [211, format ['[11, 211, false, %1] call TNL_fbank_actionManage', _uid]];
				}
				else
				{
					_transfer = (_data select 2) select 1;
					
					ctrlSetText [211, localize "STRS_gen_btnYes"];
					buttonSetAction [211, format ['[11, 211, true, %1] call TNL_fbank_actionManage', _uid]];
					if (_transfer == -1) then //Unimited
					{
						ctrlSetText [221, localize "STRS_gen_unlimited"];
					}
					else
					{
						ctrlSetText [221, format ["%1 UPK", (_transfer) call TNL_fcvar_addDigitSeparators]];
					};
				};
			};
		};
		case 11:
		{
			private ["_switch", "_state", "_uid", "_acc", "_rights"];
			_switch = _this select 1;
			_state = _this select 2;
			_uid = _this select 3;
			_acc = TNL_bank_curAccDetails select 0;
			
			if (_switch == 111) then
			{
				_rights = [_acc, _uid, 1] call TNL_fbank_getUserDetails;
				if (_state) then
				{ //toggle off
					_rights set [0, false];
					ctrlSetText [111, localize "STRS_gen_btnNo"];
					buttonSetAction [111, format ['[11, 111, false, %1] call TNL_fbank_actionManage', _uid]];
					
					[_acc, date, 11, [[] call TNL_fcenv_time, (TNL_bank_curAccDetails select 1) call TNL_fdb_idGetName, (_uid call TNL_fdb_idGetName) call TNL_fcvar_makePossessive]] call TNL_fbank_historyAdd;
				}
				else
				{ //toggle on
					_rights set [0, true];
					ctrlSetText [111, localize "STRS_gen_btnYes"];
					buttonSetAction [111, format ['[11, 111, true, %1] call TNL_fbank_actionManage', _uid]];
					
					[_acc, date, 10, [[] call TNL_fcenv_time, (TNL_bank_curAccDetails select 1) call TNL_fdb_idGetName, (_uid call TNL_fdb_idGetName) call TNL_fcvar_makePossessive]] call TNL_fbank_historyAdd;
				};
				[_acc, _uid, _rights, 1] call TNL_fbank_setUserDetails;
			}
			else
			{
				_rights = [_acc, _uid, 2] call TNL_fbank_getUserDetails;
				if (_state) then
				{ //toggle off
					_rights set [0, false];
					ctrlSetText [211, localize "STRS_gen_btnNo"];
					buttonSetAction [211, format ['[11, 211, false, %1] call TNL_fbank_actionManage', _uid]];
					
					[_acc, date, 15, [[] call TNL_fcenv_time, (TNL_bank_curAccDetails select 1) call TNL_fdb_idGetName, (_uid call TNL_fdb_idGetName) call TNL_fcvar_makePossessive]] call TNL_fbank_historyAdd;
				}
				else
				{ //toggle on
					_rights set [0, true];
					ctrlSetText [211, localize "STRS_gen_btnYes"];
					buttonSetAction [211, format ['[11, 211, true, %1] call TNL_fbank_actionManage', _uid]];
					
					[_acc, date, 14, [[] call TNL_fcenv_time, (TNL_bank_curAccDetails select 1) call TNL_fdb_idGetName, (_uid call TNL_fdb_idGetName) call TNL_fcvar_makePossessive]] call TNL_fbank_historyAdd;
				};
				[_acc, _uid, _rights, 2] call TNL_fbank_setUserDetails;
			};
			
			[] spawn
			{
				_sel = lbCurSel 10;
				sleep 0.1;
				lbSetCurSel [10, _sel];
			};
		};
		case 12:
		{
			private ["_text", "_idc"];
			_idc = _this select 1;
			_text = ctrlText _idc;
			_text = [_text, "0123456789."] call TNL_fcvar_stringFilter;
			_text = [_text, 16] call TNL_fcvar_stringShorten;
			
			ctrlSetText [_idc, _text];
		};
		case 13:
		{
			private ["_option", "_value", "_uid", "_name", "_acc", "_rights", "_msg"];
			_option = _this select 1;
			_value = _this select 2;
			_uid = _this select 3;
			_name = (_uid call TNL_fdb_idGetName) call TNL_fcvar_makePossessive;
			_acc = TNL_bank_curAccDetails select 0;
			if ([_value, "0123456789."] call TNL_fcvar_hasForbiddenChars) exitWith {};
			
			_value = parseNumber _value;
			if (_value == 0) then
			{
				_value = -1;
			};
			
			closeDialog 0;
			if (_option == 1) then
			{
				_rights = [_acc, _uid, 1] call TNL_fbank_getUserDetails;
				_rights set [1, _value];

				if (_value == -1) then
				{
					_msg = format [localize "STRS_bank_withdrawLimitDisabled", _name];
					[_acc, date, 13, [[] call TNL_fcenv_time, (TNL_bank_curAccDetails select 1) call TNL_fdb_idGetName, _name call TNL_fcvar_makePossessive]] call TNL_fbank_historyAdd;
				}
				else
				{
					_msg = format [localize "STRS_bank_withdrawLimitUpdated", _name, _value call TNL_fcvar_addDigitSeparators];
					[_acc, date, 12, [[] call TNL_fcenv_time, (TNL_bank_curAccDetails select 1) call TNL_fdb_idGetName, _name call TNL_fcvar_makePossessive, _value call TNL_fcvar_addDigitSeparators]] call TNL_fbank_historyAdd;
				};
				[_acc, _uid, _rights, 1] call TNL_fbank_setUserDetails;
			}
			else
			{
				_rights = [_acc, _uid, 2] call TNL_fbank_getUserDetails;
				_rights set [1, _value];
				
				if (_value == -1) then
				{
					_msg = format [localize "STRS_bank_wireLimitDisabled", _name];
					[_acc, date, 17, [[] call TNL_fcenv_time, (TNL_bank_curAccDetails select 1) call TNL_fdb_idGetName, _name call TNL_fcvar_makePossessive]] call TNL_fbank_historyAdd;
				}
				else
				{
					_msg = format [localize "STRS_bank_wireLimitUpdated", _name, _value call TNL_fcvar_addDigitSeparators];
					[_acc, date, 16, [[] call TNL_fcenv_time, (TNL_bank_curAccDetails select 1) call TNL_fdb_idGetName, _name call TNL_fcvar_makePossessive, _value call TNL_fcvar_addDigitSeparators]] call TNL_fbank_historyAdd;
				};
				[_acc, _uid, _rights, 2] call TNL_fbank_setUserDetails;
			};
			[localize STRS_bank_limitUpdated, _msg, "[] spawn {closeDialog 0; sleep 0.05; _sel = lbCurSel 10; sleep 0.1; lbSetCurSel [10, _sel]};"] spawn TNL_fui_createNotifyDlg
		};
		case 14:
		{
			private ["_index", "_uid", "_acc", "_name", "_action"];
			_index = (_this select 1) - 1;

			_uid = _this select 2;
			_acc = TNL_bank_curAccDetails select 0;
			_name = _uid call TNL_fdb_idGetName;
			
			_action = format ["closeDialog 0; [15, %1, ""%2"", ""%3""] spawn TNL_fbank_actionManage;", _index, _acc, _name];
			[
				format [localize "STRS_bank_accessRemoveHeader", _name],
				format [localize "STRS_bank_accessRemove", _name call TNL_fcvar_makePossessive, [_acc, 3] call TNL_fcvar_stringAddDashes],
				_action,
				"closeDialog 0;"
			] spawn TNL_fui_createYesNoDlg;
		};
		case 15:
		{
			private ["_index", "_acc", "_access", "_users", "_sel"];
			_index = _this select 1;
			_acc = _this select 2;

			_access = [_acc, 0] call TNL_fbank_getDetail;
			_access =+ _access;
			_users = _access select 1;
			
			_users set [_index, ">REMOVE<"];
			_users = _users - [">REMOVE<"];
			
			_sel = count _users;
			
			_access set [1, _users];
			[_acc, 0, _access] call TNL_fbank_setDetail;
			
			[_acc, date, 9, [[] call TNL_fcenv_time, (TNL_bank_curAccDetails select 1) call TNL_fdb_idGetName, _this select 3]] call TNL_fbank_historyAdd;
			
			sleep 0.1;
			lbSetCurSel [10, _sel];
		};
		case 16:
		{
			_idc = _this select 1;
			
			_text = toLower (ctrlText _idc);
			_text = [_text, "abcdefghijklmnopqrstuvwxyz'"] call TNL_fcvar_stringFilter;
			_text = _text call TNL_fcvar_capitalize;
			
			ctrlSetText [_idc, _text];
		};
		case 17:
		{
			private ["_name", "_id", "_acc", "_access", "_users", "_sel"];
			_name = format ["%1 %2", ctrlText 51, ctrlText 52];
			
			_id = _name call TNL_fdb_nameGetId;
			if (_id == -1) then
			{
				[
					format [localize "STRS_bank_userAddNotExistsHeader", _name],
					format [localize "STRS_bank_userAddNotExists", _name],
					"closeDialog 0;"
				] spawn TNL_fui_createNotifyDlg;
			}
			else
			{
				_acc = TNL_bank_curAccDetails select 0;
				_access = [_acc, 0] call TNL_fbank_getDetail;
				_access =+ _access;
				
				if (_id == (_access select 0) select 0) then
				{
					[
						format [localize "STRS_bank_userAddErrorHeader", _name],
						localize "STRS_bank_userAddOwnName",
						"closeDialog 0;"
					] spawn TNL_fui_createNotifyDlg;
				}
				else
				{				
					_users = _access select 1;
					_added = false;
					{
						if (_x select 0 == _id) exitWith
						{
							_added = true;
						};
					} forEach _users;
					
					if (_added) then
					{
						[
							format [localize "STRS_bank_userAddErrorHeader", _name],
							format [localize "STRS_bank_userAddInAlready", _name],
							"closeDialog 0;"
						] spawn TNL_fui_createNotifyDlg;
					}
					else
					{
						_users = _users + [[_id, [false, 1000, 0], [false, 1000, 0], 4]];
						_sel = count _users;
						_access set [1, _users];
						[_acc, 0, _access] call TNL_fbank_setDetail;
						
						[_acc, date, 8, [[] call TNL_fcenv_time, (TNL_bank_curAccDetails select 1) call TNL_fdb_idGetName, _name]] call TNL_fbank_historyAdd;
						
						[
							format [localize "STRS_bank_userAddOkHeader", _name],
							format [localize "STRS_bank_userAddOk", _name],
							format ["[] spawn {closeDialog 0; sleep 0.1; ctrlSetText [51, """"]; ctrlSetText [52, """"]; lbSetCurSel [10, %1]};", _sel]
						] spawn TNL_fui_createNotifyDlg;
					};
				};
			};
		};
		case 18:
		{
			private ["_uid", "_name", "_acc", "_balance"];
			_uid = _this select 1;
			_name = _uid call TNL_fdb_idGetName;
			_acc = TNL_bank_curAccDetails select 0;
			
			_balance = [_acc, "balance"] call TNL_fbank_getDetail;
			if ((_balance - 200) < 0) then
			{
				[
					"Insufficient funds",
					"Sorry Sir, you don't have enough money on your account to pay 200 UPK for the new card.",
					"closeDialog 0"
				] spawn TNL_fui_createNotifyDlg;
			}
			else
			{
				[
					"Make a new credit card?",
					format ["Sir, making a new credit card for %1 will cost you 200 UPK, do you wish to proceed?", _name],
					format ['closeDialog 0; [19, %1, "%2"] call TNL_fbank_actionManage', _uid, _name],
					"closeDialog 0"
				] spawn TNL_fui_createYesNoDlg;
			};
		};
		case 19:
		{
			private ["_uid", "_name", "_acc"];
			_uid = _this select 1;
			_name = _this select 2;
			_acc = TNL_bank_curAccDetails select 0;
			
			[_acc, "balance", ([_acc, "balance"] call TNL_fbank_getDetail) - 100] call TNL_fbank_setDetail;
			["creditCard", _acc, _name] call TNL_fwallet_addItem;
			
			[_acc, date, 7, [[] call TNL_fcenv_time, (TNL_bank_curAccDetails select 1) call TNL_fdb_idGetName, _name]] call TNL_fbank_historyAdd;
			
			[
				"Credit card received",
				"Thank Sir, here's your new card.",
				"closeDialog 0"
			] spawn TNL_fui_createNotifyDlg;
		};
	};
};

TNL_fbank_selectIdOpen =
{
	private ["_action", "_firstname", "_surname", "_fake", "_desc", "_name", "_index"];
	_action = _this select 0;
	
	if (!createDialog "TNL_dlg_bankSelectID") exitWith
	{
		hint "Error in function TNL_fbank_selectIdOpen - Failed to open TNL_dlg_bankSelectID dialog!";
	};
	
	buttonSetAction [4, _action];
	
	if (count _this > 1) then { TNL_bank_curAccNo = _this select 1 };
	
	if (count TNL_wallet_walletArray == 0) exitWith
	{
		["No IDs", "You do not have any identity cards on you.", "closeDialog 0"] spawn TNL_fui_createNotifyDlg;
	};
	
	{
		if (_x select 0 == "idCard") then
		{
			_firstname = _x select 2;
			_surname = _x select 3;
			_fake = _x select 5;
			_desc = _x call TNL_fwallet_idGetDesc;
			
			_name = format [localize "STRS_wallet_idCard", _firstname, _surname];
			_index = lbAdd[1, format["%1", _name]];
			lbSetData[1, _index, format['["%1", "%2", %3, "%4 %5"]', _name, _desc, _fake, _firstname, _surname]];
		};
	} foreach TNL_wallet_walletArray;
	
	lbSetCurSel [1, 0];
};
TNL_fbank_updateId =
{
	private ["_data", "_displ"];
	_data = call compile (lbData[1,_this select 0]);
	
	_displ = findDisplay 503;
	(_displ displayCtrl 2) ctrlSetStructuredText parseText _name;
	(_displ displayCtrl 3) ctrlSetStructuredText parseText (_data select 1);
};

TNL_fbank_manageOpen =
{
	disableSerialization;
	private ["_acc", "_uid", "_displ", "_first", "_accDetails", "_owners", "_mainowner", "_rights", "_index", "_name", "_balance", "_hist"];
	_acc = _this select 0;
	_uid = _this select 1;
	
	TNL_bank_curAccDetails = [_acc, _uid];
	
	if (!createDialog "TNL_dlg_bankManage") exitWith
	{
		hint "Error in function TNL_fbank_manageOpen - Failed to open TNL_dlg_bankManage dialog!";
	};
	
	_displ = findDisplay 504;
	(_displ displayCtrl 1) ctrlSetStructuredText parseText format [localize "STRS_bank_manageHeader", [_acc, 3] call TNL_fcvar_stringAddDashes];
	
	{
		ctrlShow [_x, false];
	} forEach [131, 141, 142, 151, 152, 161, 162];
	
	_first = true;
	while {!isNull (findDisplay 504)} do
	{
		lbClear 12;
		lbClear	21;
		
		(_displ displayCtrl 501) ctrlSetStructuredText parseText localize "STRS_bank_cashOps";
		(_displ displayCtrl 502) ctrlSetStructuredText parseText localize "STRS_bank_creditTransf";
		(_displ displayCtrl 411) ctrlSetStructuredText parseText localize "STRS_bank_amountUpk";
		(_displ displayCtrl 511) ctrlSetStructuredText parseText localize "STRS_bank_amountUpk";
		(_displ displayCtrl 521) ctrlSetStructuredText parseText localize "STRS_bank_destinationAcc";
		
		ctrlShow [17, true];
		{
			ctrlEnable [_x, true];
		} forEach [512, 522, 530, 412, 42, 43];
		
		_accDetails = _acc call TNL_fbank_getAll;
		
		_owners = _accDetails select 0;
		
		_mainowner = ((_owners select 0) select 0) call TNL_fdb_idGetName;
		if (_uid == ((_owners select 0) select 0)) then
		{
			_mainowner = format ["%1 - %2", _mainowner, localize "STRS_gen_you"];
		}
		else
		{
			ctrlShow [17, false];
			
			_rights = [_acc, _uid, 1] call TNL_fbank_getUserDetails;
			if ( !(_rights select 0) ) then
			{
				(_displ displayCtrl 501) ctrlSetStructuredText parseText format ["<t color='#666666'>%1</t>", localize "STRS_bank_cashOps"];
				(_displ displayCtrl 411) ctrlSetStructuredText parseText format ["<t color='#666666'>%1</t>", localize "STRS_gen_forbidden"];
				{
					ctrlEnable [_x, false];
				} forEach [412, 42, 43];
			};
			_rights = [_acc, _uid, 2] call TNL_fbank_getUserDetails;
			if ( !(_rights select 0) ) then
			{
				(_displ displayCtrl 502) ctrlSetStructuredText parseText format ["<t color='#666666'>%1</t>", localize "STRS_bank_creditTransf"];
				(_displ displayCtrl 511) ctrlSetStructuredText parseText format ["<t color='#666666'>%1</t>", localize "STRS_gen_forbidden"];
				(_displ displayCtrl 521) ctrlSetStructuredText parseText format ["<t color='#666666'>%1</t>", localize "STRS_gen_forbidden"];
				{
					ctrlEnable [_x, false];
				} forEach [512, 522, 530];
			};
		};
		
		(_displ displayCtrl 11) ctrlSetStructuredText parseText _mainowner;
		
		_owners = _owners select 1;
		if (count _owners == 0) then
		{
			_index = lbAdd [12, "-"];
			lbSetValue [12, _index, -1];
		}
		else
		{
			{
				_name = (_x select 0) call TNL_fdb_idGetName;
				if (_x select 0 == _uid) then
				{
					_name = format ["%1 - %2", _name, localize "STRS_gen_you"];
				};
				
				_index = lbAdd [12, _name];
				lbSetValue [12, _index, _x select 0];
			} forEach _owners;
		};
		//lbSetCurSel [12, 0];
		
		_balance = _accDetails select 2;
		(_displ displayCtrl 31) ctrlSetStructuredText parseText format ["%1 UPK", _balance call TNL_fcvar_addDigitSeparators];
		(_displ displayCtrl 100) ctrlSetStructuredText parseText format [localize "STRS_bank_cashNow", ("money" call TNL_finv_getItemAmount) call TNL_fcvar_addDigitSeparators];
		
		_hist = _accDetails select 3;
		
		if (count _hist == 0) then
		{
			_index = lbAdd [21, localize "STRS_gen_empty"];
			lbSetValue [21, _index, -1];
		}
		else
		{		
			_i = 0;
			{
				if (count _x < 2) then
				{
					//_hist set [_i, ">REMOVE<"];
				}
				else				
				{
					_date = _x select 0;
					_index = lbAdd [21, format ["%1/%2/%3", _date select 0, _date select 1, _date select 2]];
					lbSetValue [21, _index, _i];
				};
				
				_i = _i + 1;
			} forEach _hist;
			
			//_hist = _hist - ["REMOVE"];
			//[_acc, 4, _hist] call TNL_fbank_setDetail;
		};
		
		if (_first) then
		{
			lbSetCurSel [12, 0];
			lbSetCurSel [21, 0];
			_first = false;
		};
		
		sleep 0.1;
	};
};


    TNL_fbank_operationProccess =
    {
            _params = _this select 1;
            switch (_this select 0) do
            {
                    case 0: //Withdraw
                    {
                            private ["_amount", "_acc", "_uid", "_accDetails", "_owners", "_rights", "_canWithdraw", "_dayLimit", "_curLimit"];
                            _amount = parseNumber _params; //withdraw amount
                           
                            _acc = TNL_bank_curAccDetails select 0; //account #
                            _uid = TNL_bank_curAccDetails select 1; //char ID attached to the identity card that was used
                           
                            _accDetails = _acc call TNL_fbank_getAll;
                            _balance = _accDetails select 2;
                           
                            _owners = _accDetails select 0;
                            if (_uid == (_owners select 0) select 0) then //is player the main owner?
                            {
                                    _canWithdraw = true;
                                    _dayLimit = -1; //unlimited withdraw limit
                                    _curLimit = 0;
                            }
                            else
                            {
                                    _rights = [_acc, _uid, 1] call TNL_fbank_getUserDetails;
                                    _canWithdraw = _rights select 0;
                                    _dayLimit = _rights select 1;
                                    _curLimit = _rights select 2;
                            };
                            if (!_canWithdraw) then
                            { //player has no withdraw rights
                                    hint "Not allowed";
                            }
                            else
                            {
                                    if (((_curLimit + _amount) > _dayLimit) && (_dayLimit != -1)) then
                                    { //player's day limit would be exceeded
                                            ["Limit exceeded", format ["Sorry Sir, you cannot withdraw %1 UPK - that would be %2 over the daily limit of %3.", _amount, (_curLimit + _amount) - _dayLimit, _dayLimit], "closeDialog 0;"] spawn TNL_fui_createNotifyDlg;
                                    }
                                    else
                                    {
                                            if (_balance < _amount) then
                                            { //not enough money on the account
                                                    ["Insuficient funds", format ["Sorr Sir, you cannot withdraw %1 UPK - that would be %2 over the current account balance of %3.", _amount, _amount - _balance, _balance], "closeDialog 0;"] spawn TNL_fui_createNotifyDlg;
                                            }
                                            else
                                            {
                                                    if (["Money", _amount] call TNL_finv_addInventoryItem) then
                                                    { //money could be added to player's inv.
                                                            [_acc, 2, (_balance - _amount)] call TNL_fbank_setDetail;
                                                            [_acc, date, 3, [[] call TNL_fcenv_time, _amount, (TNL_bank_curAccDetails select 1) call TNL_fdb_idGetName, TNL_bank_curBank]] call TNL_fbank_historyAdd;
                                                           
                                                            ctrlSetText [412, ""]; //reset the input field
                                                            ["Transaction succesfull", format ["Thank you Sir, here's yours %1", _amount], "closeDialog 0;"] spawn TNL_fui_createNotifyDlg;
                                                           
                                                            if (_dayLimit != -1) then
                                                            {
                                                                    (_rights select 0) set [1, _curLimit + _amount];
                                                                    [_acc, 0, _owners] call TNL_fbank_setDetail;
                                                            };
                                                    };
                                            };
                                    };
                            };
                    };
                    case 1: //Deposit
                    {
                            private ["_amount", "_balance"];
                            _amount = parseNumber _params; //deposit amount
                            _cash = "money" call TNL_finv_getItemAmount;
                           
                            if (_cash < _amount) then
                            { //player doesn't have enough money in his inv.
                                    ["Not enough cash", format ["I can't deposit %1 when I have %2 with me...", _amount, _amount - _cash], "closeDialog 0;"] spawn TNL_fui_createNotifyDlg;
                            }
                            else
                            {
                                    _acc = TNL_bank_curAccDetails select 0;
                                   
                                    _balance = [_acc, 2] call TNL_fbank_getDetail; //get the current account balance
                                   
                                    [_acc, 2, (_balance + _amount)] call TNL_fbank_setDetail; //add the money to the acc.
                                    ["Money", _amount * -1] call TNL_finv_addInventoryItem; //remove the money from player's inv.
                                   
                                    [_acc, date, 4, [[] call TNL_fcenv_time, _amount, (TNL_bank_curAccDetails select 1) call TNL_fdb_idGetName, TNL_bank_curBank]] call TNL_fbank_historyAdd;
                                   
                                    ctrlSetText [412, ""]; //reset the input field
                                    ["Transaction succesfull", format ["Thank you Sir, %1 deposited to your account.", _amount], "closeDialog 0;"] spawn TNL_fui_createNotifyDlg;
                            };
                    };
                    case 2: //Wired transfer
                    {
                            private ["_amount", "_destAcc", "_sourceAcc", "_sourceAccDetails", "_sourceBalance", "_owners", "_canWire", "_dayLimit", "_curLimit", "_rights", "_destAccDetails"];
                            _amount = parseNumber (_params select 0);
                            _destAcc = _params select 1;
                           
                            _sourceAcc = TNL_bank_curAccDetails select 0;
                            _uid = TNL_bank_curAccDetails select 1;
                            _sourceAccDetails = _sourceAcc call TNL_fbank_getAll;
                            _sourceBalance = _sourceAccDetails select 2;
                           
                           
                            _owners = _sourceAccDetails select 0;
                            if (_uid == (_owners select 0) select 0) then //is player the main owner?
                            {
                                    _canWire = true;
                                    _dayLimit = -1; //unlimited transfer limit
                                    _curLimit = 0;
                            }
                            else
                            {
                                    _rights = [_sourceAcc, _uid, 2] call TNL_fbank_getUserDetails;
                                    _canWire = _rights select 0;
                                    _dayLimit = _rights select 1;
                                    _curLimit = _rights select 2;
                            };
                           
                            if (!_canWire) then
                            {
                                    ["You are not allowed to wire any money at this time!"] call TNL_fextHint_Hint;
                            }
                            else
                            {
                                    if (((_curLimit + _amount) > _dayLimit) && (_dayLimit != -1)) then
                                    { //player's day limit would be exceeded
                                            ["Limit exceeded", format ["Sorry Sir, you cannot transfer £%1 - that would be £%2 over the daily limit of £%3.", _amount, (_curLimit + _amount) - _dayLimit, _dayLimit], "closeDialog 0;"] spawn TNL_fui_createNotifyDlg;
                                    }
                                    else
                                    {
                                            if (_sourceBalance < _amount) then
                                            { //not enough money on source acc
                                                    ["Insuficient funds", format ["Sorry Sir, you cannot transfer £%1 - that would be £%2 over the current account balance of £%3.", _amount, _amount - _sourceBalance, _sourceBalance], "closeDialog 0;"] spawn TNL_fui_createNotifyDlg;
                                            }
                                            else
                                            {
                                                    if (!(_destAcc call TNL_fbank_accExists)) then
                                                    { //destination acc. doesn't exist
                                                            ["Wrong account number", format ["Sorry Sir, there is no account listed under the number of %1.", _destAcc], "closeDialog 0;"] spawn TNL_fui_createNotifyDlg;
                                                    }
                                                    else
                                                    {
                                                            if (_destAcc == _sourceAcc) then
                                                            { //player attemps to send the money to himself
                                                                    ["Wrong account number", format ["Sir, %1 is your own account number.", _sourceAcc], "closeDialog 0;"] spawn TNL_fui_createNotifyDlg;
                                                            }
                                                            else
                                                            {
                                                                    _destAccDetails = _destAcc call TNL_fbank_getAll;
                                                                    if (_destAccDetails select 4 != 0) then
                                                                    { //account is blocked
                                                                            ["Dest. acc blocked"] call TNL_fextHint_Hint;
                                                                    }
                                                                    else
                                                                    {
                                                                            if (_amount < 0) then
                                                                            { //player attempts to wire minus money
                                                                                    ["You can not do that!"] call TNL_fextHint_Hint;
                                                                            }
                                                                            else
                                                                            {
                                                                                    [_sourceAcc, 2, _sourceBalance - _amount] call TNL_fbank_setDetail; //remove money from the source acc.
                                                                                    [_sourceAcc, date, 5, [[] call TNL_fcenv_time, _amount, _destAcc, (TNL_bank_curAccDetails select 1) call TNL_fdb_idGetName, TNL_bank_curBank]] call TNL_fbank_historyAdd;
                                                                           
                                                                                    [_destAcc, 2, (_destAccDetails select 2) + _amount] call TNL_fbank_setDetail; //add money to the destination acc.
                                                                                    [_destAcc, date, 6, [[] call TNL_fcenv_time, _amount, _sourceAcc]] call TNL_fbank_historyAdd;
                                                                           
                                                                                    ctrlSetText [512, ""]; //reset the input fields
                                                                                    ctrlSetText [522, ""];
                                                                           
                                                                                    ["Transaction succesfull", format ["Thank you Sir, £%1 was transfered to account %2.", _amount, _destAcc], "closeDialog 0;"] spawn TNL_fui_createNotifyDlg;
                                                                   
                                                                   
                                                                           
                                                                            };
                                                                    };
                                                            };
                                                    };
                                            };
                                    };
                            };
                    };
            };
    };



TNL_fbank_accessManageOpen =
{
	disableSerialization;
	if (!createDialog "TNL_dlg_bankAccess") exitWith
	{
		hint "Error in function TNL_fbank_accessManageOpen - Failed to open TNL_dlg_bankAccess dialog!";
	};
	private ["_sel", "_acc", "_uid"];
	if (typeName _this == "SCALAR") then
	{
		_sel = _this;
	}
	else
	{
		_sel = 0;
	};
	
	_acc = TNL_bank_curAccDetails select 0;
	_uid = TNL_bank_curAccDetails select 1;
	
	((findDisplay 505) displayCtrl 1) ctrlSetStructuredText parseText format [localize "STRS_bank_manageHeader", [_acc, 3] call TNL_fcvar_stringAddDashes];
	
	[_acc, _uid] spawn
	{
		while {!isNull (findDisplay 505)} do
		{
			lbClear 10;
			
			_acc = _this select 0;
			_uid = _this select 1;
			
			_details = _acc call TNL_fbank_getAll;
			_owners = _details select 0;
			_mainowner = ((_owners select 0) select 0) call TNL_fdb_idGetName;
			
			((findDisplay 505) displayCtrl 100) ctrlSetStructuredText parseText format [localize "STRS_bank_balanceNow", _details select 2];
			
			if (_uid != (_owners select 0) select 0) exitWith
			{
				closeDialog 0;
			};
			_index = lbAdd [10, format ["%1 - %2", _mainowner, localize "STRS_bank_owner"]];
			lbSetValue [10, _index, -1];
			lbSetData [10, _index, format ["[%1]", (_owners select 0) select 0]];
			
			_owners = _owners select 1;
			{
				_name = (_x select 0) call TNL_fdb_idGetName;			
				_index = lbAdd [10, _name];
				lbSetData [10, _index, str _x];
				lbSetValue [10, _index, _x select 0];
			} forEach _owners;
			
			if (ctrlText 51 == "" || ctrlText 52 == "") then
			{
				ctrlEnable [53, false];
			}
			else
			{
				ctrlEnable [53, true];
			};
			
			
			sleep 0.1;
		};
	};
	
	sleep 0.1;
	lbSetCurSel [10, _sel];
	waitUntil {!dialog};
	[_acc, _uid] spawn TNL_fbank_manageOpen;	
};

DFS_fbank_accessEditDetails =
{
	if (!createDialog "TNL_dlg_bankEditRights") exitWith
	{
		hint "Error in function DFS_fbank_accessEditDetails - Failed to open TNL_dlg_bankEditRights dialog!";
	};
	private ["_acc", "_uid", "_option", "_name", "_rights", "_value"];
	_acc = TNL_bank_curAccDetails select 0;
	_uid = _this select 0;
	_option = _this select 1;
	
	_name = _uid call TNL_fdb_idGetName;
	((findDisplay 506) displayCtrl 1) ctrlSetStructuredText parseText localize "STRS_bank_editLimit";
	
	if (_option == 1) then
	{
		_rights = [_acc, _uid, 1] call TNL_fbank_getUserDetails;
		((findDisplay 506) displayCtrl 2) ctrlSetStructuredText parseText localize "STRS_bank_withdrawLimit";
		((findDisplay 506) displayCtrl 3) ctrlSetStructuredText parseText format [localize "STRS_bank_withdrawLimitDesc", _name];
		
		_value = _rights select 1;
		if (_value == -1) then
		{
			_value = 0;
		};
		ctrlSetText [10, str _value];
		
		buttonSetAction [20, format ["[13, 1, ctrlText 10, %1] call TNL_fbank_actionManage", _uid]];
	}
	else
	{
		_rights = [_acc, _uid, 2] call TNL_fbank_getUserDetails;
		((findDisplay 506) displayCtrl 2) ctrlSetStructuredText parseText localize "STRS_bank_wireLimit";
		((findDisplay 506) displayCtrl 3) ctrlSetStructuredText parseText format [localize "STRS_bank_wireLimitDesc", _name];
		
		_value = _rights select 1;
		if (_value == -1) then
		{
			_value = 0;
		};
		
		ctrlSetText [10, str _value];
		
		buttonSetAction [20, format ["[13, 2, ctrlText 10, %1] call TNL_fbank_actionManage", _uid]];
	};
	
	while {true} do
	{
		if (ctrlText 10 == "") then
		{
			ctrlEnable [20, false];
		}
		else
		{
			ctrlEnable [20, true];
		};
		sleep 0.1;
	};
};
