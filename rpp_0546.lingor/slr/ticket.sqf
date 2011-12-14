_type = (_this select 0);

if (_type == "createDlg") then
{
	createDialog "TNL_dlg_genEditInput";
	_unitObj = (_this select 1);
	UnitInteractWi = _unitObj;
	

	sliderSetPosition[13, 5];
	sliderSetRange[13, 1, 45];
	
	((findDisplay 1103) displayCtrl 1) ctrlSetStructuredText parseText "Ticket Menu";
	((findDisplay 1103) displayCtrl 2) ctrlSetStructuredText parseText "Set the amount you want to ticket this errm civilian dude for";
	((findDisplay 1103) displayCtrl 10) buttonSetAction "[""ticket"", (parseNumber (ctrlText 13)),UnitInteractWi] execVM ""slr\ticket.sqf""; closeDialog 0;";
	while {!(isNull(findDisplay 1103))} do
	{
		_amount = parseNumber (ctrlText 13);
		((findDisplay 1103) displayCtrl 12) ctrlSetText format["Amount: $%1", (_amount call TNL_fcvar_addDigitSeparators)];
		sleep 0.2;
		
		if (player distance (getpos _unitObj) >= 10) exitWith
		{
			closeDialog 0;
		};
	};
	
	UnitInteractWi = null;
};

if (_type == "ticket") then
{
	_civ = (_this select 2);
	_amount = (_this select 1);
	[{
		if (player == (_this select 0)) then 
		{
			["clientTicket", (_this select 0), (_this select 1), (_this select 2)] execVM "slr\ticket.sqf";
		};
		[format["%1 has been ticketed for $%2", name (_this select 0) call TNL_fplayer_formatName, (_this select 1)]] call TNL_fextHint_Hint;
	}, [_civ, _amount, player]] call TNL_fnet_execPublic;
	
	_civ call SLR_fw_getBounty;
	
	
};

if (_type == "clientTicket") then
{
	_civ = _this select 1;
	_amount = _this select 2;
	_cop    = _this select 3;
	_didpay = 0;
	acceptTicket = 0;
	
	if (!(createDialog "TNL_dlg_genYesNo")) exitWith 
	{
		hint "Dialog Error!";
	};
	
	((findDisplay 1101) displayCtrl 1) ctrlSetStructuredText parseText "Ticket";
	((findDisplay 1101) displayCtrl 2) ctrlSetStructuredText parseText format["%1 gave you a ticket of $%2. Do you want to pay?", name _cop call TNL_fplayer_formatName, _amount];
	((findDisplay 1101) displayCtrl 10) buttonSetAction "acceptTicket = 1; closeDialog 0;";
	((findDisplay 1101) displayCtrl 11) buttonSetAction "acceptTicket = 0; closeDialog 0;";
	waitUntil{(isNull(findDisplay 1101))};
	
	if (acceptTicket == 1) then 
	{
		if (TNL_gVar_paycheckAccNum != "") then //Has registered bank account
		{
			_acc = TNL_gVar_paycheckAccNum;
			_balance = [_acc, 2] call TNL_fbank_getDetail; 
			
			if (_balance < _amount) then //Cant afford to pay ticket but remove what he has anyway
			{
		
				_didnotpay = _amount - _balance;
				[_acc, 2, 0] call TNL_fbank_setDetail; //remove money
				[_acc, date, 6, [[] call TNL_fcenv_time, -(_balance), "Ticket"]] call TNL_fbank_historyAdd;
				taxesPaid = taxesPaid + _balance;
				
				[{
					if (player == (_this select 0)) then 
					{
						[format ["%1 did not have enough to pay the ticket of $%2 but managed to pay $%3 of it!", name (_this select 2) call TNL_fplayer_formatName, (_this select 3), (_this select 4)]] call TNL_fextHint_Hint;
					};
				}, [_cop, player, _amount, _didnotpay]] call TNL_fnet_execPublic;
			} 
			else //He can pay so remove his money
			{
				_didpay = _amount;
				[_acc, 2, (_balance - _amount)] call TNL_fbank_setDetail; //remove money
				[_acc, date, 6, [[] call TNL_fcenv_time, -(_balance - _amount), "Ticket"]] call TNL_fbank_historyAdd;
				taxesPaid = taxesPaid + _amount;
				
				[{
					["Ticket", (_this select 0)] call SLR_fw_addCrimeLog;
				if (player == (_this select 0)) then 
				{
					[format ["%1 paid the ticket of $%2.", name (_this select 1) call TNL_fplayer_formatName, (_this select 2)]] call TNL_fextHint_Hint;
				}; 
				}, [_cop, player, _amount]] call TNL_fnet_execPublic;
			};
			
			[format ["You got a ticket of $%1 and paid $%2. The Money has been withdrawed from your bank acount and will be transfered to the governement with your next paycheque", _amount, _didpay]] call TNL_fextHint_Hint;
		}
		else //Pay by cash
		{
			if (("money" call TNL_finv_getItemAmount) >= _amount) then
			{
				["money", -(_amount)] call TNL_finv_addInventoryItem;
				taxesPaid = taxesPaid + _amount;
				_didpay = _amount;
				
				[{
				if (player == (_this select 0)) then 
				{
					[format ["%1 paid the ticket of $%2.", name (_this select 1) call TNL_fplayer_formatName, (_this select 2)]] call TNL_fextHint_Hint;
				}; 
				}, [_cop, player, _amount]] call TNL_fnet_execPublic;
			}
			else
			{
				_money = "money" call TNL_finv_getItemAmount;
				taxesPaid = taxesPaid + _money;
				["money", -(_money)] call TNL_finv_addInventoryItem;
				_didpay = _money;
				
				[{
					if (player == (_this select 0)) then 
					{
						[format ["%1 did not have enough to pay the ticket of $%2 but managed to pay $%3 of it!", name (_this select 2) call TNL_fplayer_formatName, (_this select 3), (_this select 4)]] call TNL_fextHint_Hint;
					};
				}, [_cop, player, _amount, _money]] call TNL_fnet_execPublic;
				
			};
			
			[format ["You got a ticket of $%1 and paid $%2 cash.", _amount, _didpay]] call TNL_fextHint_Hint;
		};
		
		false call TurnWantedFunc;
		
	} 
	else //Refused to pay
	{
		[{
		if (player == (_this select 0)) then 
		{
			[format ["%1 refused to pay the ticket of $%2!", name (_this select 1) call TNL_fplayer_formatName, (_this select 2)]] call TNL_fextHint_Hint;
		};
		}, [_cop, player, _amount]] call TNL_fnet_execPublic;
		["You refused to pay the ticket!"] call TNL_fextHint_Hint;
	};
};