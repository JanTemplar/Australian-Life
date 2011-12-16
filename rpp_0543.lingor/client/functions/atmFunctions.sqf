//The New Life (RPG Mission)
//Copyright (C) 2009  Matthew Simms & Petr Klíma

TNL_fatm_open = 
{
	TNL_atm_curDetails = [_this];
	
	if (!createDialog "atmInsertCard") exitWith
	{
		hint "Error in function TNL_fatm_open - Failed to open atmInsertCard dialog!";
	};
	((findDisplay 601) displayCtrl 3) ctrlSetStructuredText parseText localize "STRS_atm_cardsList";
	((findDisplay 601) displayCtrl 2) ctrlSetStructuredText parseText localize "STRS_atm_selectCard";
	{
		if (_x select 0 == "creditCard") then
		{
			_acc = _x select 1;
			_owner = _x select 2;
			
			_name = format [localize format ["STRS_wallet_%1", _x select 0], [_acc, 3] call TNL_fcvar_stringAddDashes];
			_index = lbAdd[1, format["%1", _name]];
			lbSetData[1, _index, format["[""%1"", ""%2""]", _acc, _owner]];
		};
	} foreach TNL_wallet_walletArray;
	
	lbSetCurSel [1, 0];
	
	//TNL_atm_curDetails = [_this]; //Store ATM name
};

TNL_fatm_updateCard =
{
	_data = call compile (lbData[1,_this select 0]);
	((findDisplay 601) displayCtrl 2) ctrlSetStructuredText parseText format [localize "STRS_atm_cardDesc", [_data select 0, 3] call TNL_fcvar_stringAddDashes, _data select 1];
};

TNL_fatm_insertedCard =
{
	private ["_data", "_acc", "_pin", "_ok", "_details"];
	_data = call compile (lbData[1,_this select 0]);
	
	_acc = _data select 0;
	_uid = (_data select 1) call TNL_fdb_nameGetId;
	_pin = [_acc, 1] call TNL_fbank_getDetail;
	_ok = true;
	
	if (!([_acc, _uid] call TNL_fbank_hasAccess)) then
	{
		_ok = false;
	};

	_details = [_acc, _uid, 1] call TNL_fbank_getUserDetails;
	if (typeName _details != "SCALAR") then
	{
		if (!(_details select 0)) then
		{
			_ok = false;
		};
	};
	//hint str _ok;
	if (_ok) then
	{
		if (!createDialog "atmInputPin") exitWith
		{
			hint "Error in function TNL_fatm_insertedCard - Failed to open atmInputPin dialog!";
		};
		
		TNL_atm_curDetails = TNL_atm_curDetails + [_acc, _pin, _uid];
		//hint _pin;

 		((findDisplay 602) displayCtrl 2) ctrlSetStructuredText parseText localize "STRS_atm_enterPIN";
	}
	else
	{
		if (!createDialog "atmExitDlg") exitWith
		{
			hint "Error in function TNL_fatm_insertedCard - Failed to open atmExitDlg dialog!";
		};
		((findDisplay 604) displayCtrl 1) ctrlSetStructuredText parseText localize "STRS_atm_noAccess";
		((findDisplay 604) displayCtrl 10) ctrlSetStructuredText parseText localize "STRS_atm_warning";
	};
};

TNL_fatm_pinFilter =
{
	private "_text";
	_text = ctrlText 1;
	
	_text = [_text, "0123456789"] call TNL_fcvar_stringFilter;
	_text = [_text, 4] call TNL_fcvar_stringShorten;
	
	ctrlSetText [1, _text];
};

TNL_fatm_checkPIN =
{
	private ["_entered", "_acc", "_pin", "_uid", "_try"];
	_entered = _this select 0;
	
	_acc = TNL_atm_curDetails select 1;
	_pin = TNL_atm_curDetails select 2;
	_uid = TNL_atm_curDetails select 3;

	if (_entered == _pin) then
	{
		[] spawn TNL_fatm_openOperations;
	}
	else
	{
		if (_entered != "") then
		{
			_try = [_acc, _uid, 3] call TNL_fbank_getUserDetails;
			
			if (_try == 1) then
			{
				[_acc, _uid call TNL_fdb_idGetName] call TNL_fwallet_removeCreditCard;

				closeDialog 0;
				if (!createDialog "atmExitDlg") exitWith
				{
					hint "Error in function TNL_fatm_operationsProcess - Failed to open atmExitDlg dialog!";
				};

				((findDisplay 604) displayCtrl 1) ctrlSetStructuredText parseText localize "STRS_atm_confiscatedCard";
				((findDisplay 604) displayCtrl 10) ctrlSetStructuredText parseText localize "STRS_atm_warning";
			}
			else
			{
				ctrlEnable [10, false];
				ctrlEnable [1, false];
				((findDisplay 602) displayCtrl 2) ctrlSetStructuredText parseText localize "STRS_atm_loading";

				_try = _try - 1;
				[_acc, _uid, 3, _try] call TNL_fbank_setUserDetails; 
				
				ctrlEnable [10, true];
				ctrlEnable [1, true];
				((findDisplay 602) displayCtrl 2) ctrlSetStructuredText parseText format [localize "STRS_atm_wrongPIN", _try];
				ctrlSetText [1, ""];
			};
		};
	};
};

TNL_fatm_openOperations =
{
	private ["_acc", "_uid", "_balance", "_details", "_limitDay", "_limitNow"];
	_acc = TNL_atm_curDetails select 1;
	_uid = TNL_atm_curDetails select 3;
	closeDialog 0;
	if (!createDialog "atmOperations") then
	{
		hint "Error in function TNL_fatm_checkPIN - Failed to open atmOperations dialog!";
	};
	
	TNL_atm_manageLoop = true;
	while {TNL_atm_manageLoop} do
	{
		((findDisplay 603) displayCtrl 1) ctrlSetStructuredText parseText format ["%1", _acc];
		
		_balance = [_acc, 2] call TNL_fbank_getDetail;
		if (_balance <= 0) then
		{
			((findDisplay 603) displayCtrl 2) ctrlSetStructuredText parseText format ["<t color='#ff0000'>%1 Ц</t>", _balance];
		}
		else
		{
			((findDisplay 603) displayCtrl 2) ctrlSetStructuredText parseText format ["%1 Ц", _balance];
		};

		_details = [_acc, _uid, 1] call TNL_fbank_getUserDetails;
		if (typeName _details == "SCALAR") then
		{
			_limitDay = -1;
			_limitNow = -1;
			((findDisplay 603) displayCtrl 3) ctrlSetStructuredText parseText localize "STRS_gen_unlimited";
		}
		else
		{
			_limitDay = _details select 1;
			_limitNow = _details select 2;
			
			if (_limitDay == -1) then
			{
				((findDisplay 603) displayCtrl 3) ctrlSetStructuredText parseText localize "STRS_gen_unlimited";
			}
			else
			{
				if (_limitNow >= _limitDay) then
				{
					((findDisplay 603) displayCtrl 3) ctrlSetStructuredText parseText format ["<t color='#ff0000'>%1/%2 Ц</t>", _limitNow , _limitDay];
				}
				else
				{
					((findDisplay 603) displayCtrl 3) ctrlSetStructuredText parseText format ["%1/%2 Ц", _limitNow, _limitDay];
				};
			};
		};
		((findDisplay 603) displayCtrl 100) ctrlSetStructuredText parseText format [localize "STRS_bank_cashNow", "money" call TNL_finv_getItemAmount];
		
		TNL_atm_curDetails = TNL_atm_curDetails + [_balance, _limitDay, _limitNow];
		sleep 0.1;
	};
};

TNL_fatm_updateEntered =
{
	private ["_idc", "_text", "_amount", "_show", "_balance", "_limitDay", "_limitNow"];
	_idc = _this select 0;
	
	_text = ctrlText _idc;
	
	_text = [_text, "0123456789."] call TNL_fcvar_stringFilter;
	_text = [_text, 4] call TNL_fcvar_stringShorten;
	
	ctrlSetText [_idc, _text];

	_amount = parseNumber (ctrlText _idc);
	_show = _amount call TNL_fcvar_addDigitSeparators;
	_balance = TNL_atm_curDetails select 4;
	_limitDay = TNL_atm_curDetails select 5;
	_limitNow = TNL_atm_curDetails select 6;
	
		if (_amount == 0) then
		{
			((findDisplay 603) displayCtrl 5) ctrlSetStructuredText parseText localize "STRS_atm_enterAmount";
		}
		else
		{
			if (_amount > _balance) then
			{
				((findDisplay 603) displayCtrl 5) ctrlSetStructuredText parseText format [localize "STRS_atm_toWithdrawNoCash", _show];
			}
			else
			{
				if ((_amount + _limitNow > _limitDay) && (_limitDay != -1)) then
				{
					((findDisplay 603) displayCtrl 5) ctrlSetStructuredText parseText format [localize "STRS_atm_toWithdrawMaxLimit", _show];
				}
				else
				{
					((findDisplay 603) displayCtrl 5) ctrlSetStructuredText parseText format [localize "STRS_atm_toWithdrawOK", _show];
				};
			};
		};
};

TNL_fatm_operationsProcess =
{
	private ["_entered", "_balance", "_limitDay", "_limitNow", "_balance", "_limitDay", "_limitNow", "_acc", "_data"];
	_entered = (round ((_this select 0) * 10)) / 10;
	
	_balance = TNL_atm_curDetails select 4;
	_limitDay = TNL_atm_curDetails select 5;
	_limitNow = TNL_atm_curDetails select 6;

	//hint format ["_entered: %1\n_balance: %2\n_limitDay: %3\n_limitNow %4", _entered, _balance, _limitDay, _limitNow];
	if (_entered <= _balance && (((_entered + _limitNow) <= _limitDay) || _limitDay == -1) && _entered != 0) then
	{
		if (["Money", _entered] call TNL_finv_addInventoryItem) then
		{
			_acc = TNL_atm_curDetails select 1;
			TNL_atm_manageLoop = false;
			{
				ctrlEnable [_x, false];
			} forEach [4, 10];
			
			[_acc, 2, (_balance - _entered)] call TNL_fbank_setDetail;
			
			if (_limitDay != -1) then
			{
				_data = [true, _limitDay, _limitNow + _entered];
				[_acc, TNL_atm_curDetails select 3, 1, _data] call TNL_fbank_setUserDetails;
			};

			closeDialog 0;
			if (!createDialog "atmExitDlg") exitWith
			{
				hint "Error in function TNL_fatm_operationsProcess - Failed to open atmExitDlg dialog!";
			};
			
			[_acc, date, 1, [[] call TNL_fcenv_time, _entered, (TNL_atm_curDetails select 3) call TNL_fdb_idGetName, TNL_atm_curDetails select 0]] call TNL_fbank_historyAdd;
			((findDisplay 604) displayCtrl 1) ctrlSetStructuredText parseText format [localize "STRS_atm_operationSuccess", _entered];
		};
	};
};