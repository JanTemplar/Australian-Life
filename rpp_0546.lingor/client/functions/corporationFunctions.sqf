/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

TNL_fcorp_increaseFirmIncome =
{
	private ["_object", "_amount", "_firms"];
	_object = (_this select 0);
	_amount = (_this select 1);
	_firms = corporations getVariable "firms";
	
	{
		_firm = (_x select 0);
		
		if (str _firm == str _object) then
		{
			_money = (_x select 6);
			_money set[1, ((_amount) + (_money select 1))];
			(_x) set[6, _money];
		};		
	} forEach _firms;
	
	corporations setVariable["firms", _firms, true];
	[TNL_gVar_str_tables_corporations, [corporations], [ [(corporations getVariable "corporations"), "corporations"], [_firms, "firms"] ]] call TNL_fsav_clientRequestSave;
};

TNL_fcorp_increaseFirmExpenses = 
{
	private ["_object", "_amount", "_firms"];
	_object = (_this select 0);
	_amount = (_this select 1);
	_firms = corporations getVariable "firms";
	
	{
		_firm = (_x select 0);
		
		if (str _firm == str _object) then
		{
			_money = (_x select 6);
			_money set[0, ((_amount) + (_money select 0))];
			(_x) set[6, _money];
		};
	} forEach _firms;
	
	corporations setVariable["firms", _firms, true];
	[TNL_gVar_str_tables_corporations, [corporations], [ [(corporations getVariable "corporations"), "corporations"], [_firms, "firms"] ]] call TNL_fsav_clientRequestSave;
};

TNL_fcorp_openRegisterDlg = 
{
	private ["_registerCost", "_money"];
	_registerCost = governor getVariable "corporationRegisterCost";
	_money = "money" call TNL_finv_getItemAmount;
	

	if (createDialog "DlgCorpRegister") then
	{
		((findDisplay 1402) displayCtrl 2) ctrlSetStructuredText parseText format[localize "STRS_corp_register_info", _registerCost, _money, (TNL_gVar_int_corporationNewCorpStocksOwned/TNL_gvar_int_corporationStartingStocks)*100, "%"];
	};
};

TNL_fcorp_clientRegisterCorporation = 
{
	private ["_corpName", "_money", "_registerCost"];
	_corpName = (_this select 0);
	_money = "money" call TNL_finv_getItemAmount;
	_registerCost = governor getVariable "corporationRegisterCost";
	
	if (!([_corpName, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "] call TNL_fcvar_hasForbiddenChars) && ((count toArray _corpName) <= 20)) then
	{
		if (_money >= _registerCost) then
		{
			if ([_corpName, TNL_db_charName, [  [["Public", "Shareholders"], (TNL_gvar_int_corporationStartingStocks - TNL_gVar_int_corporationNewCorpStocksOwned), 0], [TNL_db_charName, (TNL_gVar_int_corporationNewCorpStocksOwned), 0] ]] call TNL_fcorp_RegisterCorporation) then
			{
				[format["You have registered the %1 corporation, You now own %2%3 of its stocks the rest has been bought by public shareholders.", _corpName, (TNL_gVar_int_corporationNewCorpStocksOwned/TNL_gvar_int_corporationStartingStocks)*100, "%"]] call TNL_fextHint_Hint;
				["money",-(_registerCost)] call TNL_finv_addInventoryItem;
				_name = format ["%1 %2", TNL_db_charName select 0, TNL_db_charName select 1];
				["creditCard", ((_corpName call TNL_fcorp_getCorpBank) select 0), (_name call TNL_fdb_nameGetId) call TNL_fdb_idGetName] call TNL_fwallet_addItem;
			}
			else
			{
				["A corporation with this name already exists"] call TNL_fextHint_Hint;
			};
		}
		else
		{
			["You do not have enough money to register a corporation"] call TNL_fextHint_Hint;
		};
	}
	else
	{
		[format["There is forbidden characters in the name or its too long"]] call TNL_fextHint_Hint;
	};
	
	((findDisplay 1402) displayCtrl 2) ctrlSetStructuredText parseText format[localize "STRS_corp_register_info", _registerCost, ("money" call TNL_finv_getItemAmount), (TNL_gVar_int_corporationNewCorpStocksOwned/TNL_gvar_int_corporationStartingStocks)*100, "%"];
};

TNL_fcorp_RegisterCorporation = 
{
	private ["_corporationName", "_owner", "_startStocks", "_result", "_curCorporations", "_registerCost"];
	_corporationName = (_this select 0);
	_owner = (_this select 1);
	_startStocks = (_this select 2);
	_result = true;
	_curCorporations = corporations getVariable "corporations";
	_curStockMarket = stockmarket getVariable "stockmarket";
	_registerCost = governor getVariable "corporationRegisterCost";

	if ((_corporationName == "") || (_corporationName == " ")) then { _result = false; };
	
	/* Check if corporation name already exists */
	{
		if ((_x select 0) == _corporationName) then
		{
			_result = false; //Corporation already exists
		};
	} forEach _curCorporations;
	
	/* Register corporation */
	if (_result) then
	{
		/* Create the corporation bank account */
		TNL_bank_curBank = "Corporation";
		_name = format ["%1 %2", TNL_db_charName select 0, TNL_db_charName select 1];
		_bankAcc = (_name call TNL_fdb_nameGetId) call TNL_fbank_createAcc;
		
		/* Add corporation to stock market */
		_curStockMarket = _curStockMarket + [ [_corporationName, (round((TNL_gvar_int_corporationStartingStocks/_registerCost)*100)/100), TNL_gvar_int_corporationStartingStocks, [0,0], 0, TNL_gvar_int_corporationStartingStocks, _startStocks, 0, []]];
		stockmarket setVariable ["stockmarket", _curStockMarket, true];
		[TNL_gVar_str_tables_stockmarket, [stockmarket], [ [_curStockMarket, "stockmarket"] ]] call TNL_fsav_clientRequestSave;
		
		/* Create corporations */
		_curCorporations = _curCorporations + [ [_corporationName, _owner, date, _bankAcc, [0,0,0]] ];
		corporations setVariable["corporations", _curCorporations, true];
		[TNL_gVar_str_tables_corporations, [corporations], [ [_curCorporations, "corporations"], [(corporations getvariable "firms"), "firms"] ]] call TNL_fsav_clientRequestSave;
		
	};
	
	_result
};

TNL_fcorp_openSelectCorpDlg = 
{
	if !(createDialog "DlgCorpSelect") then
	{
		["Error opening dialog DlgCorpSelect, in function TNL_fcorp_openSelectCorpDlg, file corporationFunctions.sqf"] call TNL_fextHint_Hint;
	};
	
	{
		if ((str (_x select 1) == str (TNL_db_charName)) or (([(_x select 0), TNL_db_charName] call RPP_fnc_employee_getAccessLevel) == 2)) then
		{
			_index = lbAdd[1401, (_x select 0)];
			lbSetData[1401,_index,(_x select 0)];
		};
	} forEach (corporations getVariable "corporations");
	
	lbSetCurSel[1401,0];
};

TNL_fcorp_openSelectCorpOptionDlg =
{
	if ((_this select 0) != "") then
	{
		if !(createDialog "DlgCorpSelectOption") then
		{
			["Error opening dialog DlgCorpSelectOption, in function TNL_fcorp_openSelectCorpOptionDlg, file corporationFunctions.sqf"] call TNL_fextHint_Hint;
		};
	
		{
			_index = lbAdd[1401, format["%1", (_x select 0)]];
			lbSetData[1401, _index, format["[""%1"", ""%2""]", (_x select 1), (_this select 0)]];
		} forEach TNL_gVar_arr_corporationActions;
	};
};

TNL_fcorp_selectCorpOption = 
{
	private ["_action", "_corpName"];
	_action = ((call compile (_this select 0)) select 0);
	_corpName = ((call compile (_this select 0)) select 1);

	switch (_action) do 
	{
		case "firms":
		{
			[_corpName] call TNL_fcorp_openFirmsDlg;
		};
		case "corpbank":
		{
			[_corpName] call TNL_fcorp_openBankDlg;
		};
		case "summary":
		{
			[] call TNL_fcorp_openSummaryDlg;
		};
		case "purchases":
		{
			[_corpName] call TNL_fcorp_openOffersDlg;
		};
		case "stockmarket":
		{
			_bankAcc = _corpName call TNL_fcorp_getCorpBank;
			[[_corpName, "Corporation"],  (_bankAcc select 0), (_bankAcc select 1)] spawn TNL_fsmarket_openStockMarket;
		};
		case "employee":
		{
			[_corpName] call RPP_fnc_employee_openDialog;	
		};
	};

};

TNL_fcorp_openFirmsDlg = 
{
	if !(createDialog "DlgCorpFirms") then
	{	
		["Error opening dialog DlgCorpFirms, in function TNL_fcorp_openFirmsDlg, file corporationFunctions.sqf"] call TNL_fextHint_Hint;
	}
	else
	{
		[(_this select 0)] call TNL_fcorp_loadFirmsDlg;
	};

};

TNL_fcorp_loadFirmsDlg = 
{
	private ["_corpName"];
	_corpName = (_this select 0);
	
	{
		if ((_x select 3) == (_corpName)) then
		{
			_text = "";
			switch (_x select 1) do
			{
				case "Factory":
				{
					_text = [(_x select 0)] call TNL_ffact_getFactoryName;
				};
				
				case "Workplace":
				{
					_text = (_x select 0) call TNL_fwp_getWorkPlaceName;
				};
				
				case "Shop":
				{
					_text = (_x select 0) getVariable "name";
				};
			};
			
			_createdAt = ((_x select 4) select 0);
			_aquiredAt = ((_x select 4) select 1);
			_income = (_x select 6);
			
			_index = lbAdd[1403, format["%1", (_text)]];
			lbSetData[1403, _index, format['["%1", "%2", %3, %4, "%5", %6]', (_x select 0), (_x select 1), _createdAt, _aquiredAt, (_x select 3), _income]];
		};
	} forEach (corporations getVariable "firms");
	
	lbSetCurSel[1403,0];
	
};

TNL_fcorp_selChangeFirmsDlg = 
{
	private ["_data", "_type", "_object"];
	_data = call compile (_this select 0);
	_type = (_data select 1);
	
	_object = call compile (_data select 0);
	switch (_type) do
	{
		case "Factory":
		{	
			_text = "";
			if (((([_object, "repaired"] call TNL_ffact_getSetting) select 1))) then
			{
				buttonSetAction[1401, "closeDialog 0; [(lbData[1403,lbCurSel 1403])] spawn TNL_fcorp_selectManageFirm;"];
				_text = "operational";
			}
			else
			{
				buttonSetAction[1401, "[""The factory has not been repaired yet""] call TNL_fextHint_Hint;"];
				_text = "not operational";
			};
			_numMembers = (count(((([(_object), "permissionsPublicStorage"] call TNL_ffact_getSetting) select 1) select 3)));
			
		
			((findDisplay 1401) displayCtrl 1404) ctrlSetStructuredText parseText format[localize "STRS_corp_firm_firmInfoFactory", 
				[(_object)] call TNL_ffact_getFactoryName,
				((_data select 3) call TNL_fmisc_formatDate), ((_data select 2) call TNL_fmisc_formatDate),
				_text, 
				(([(_object), "factoryLocked"] call TNL_ffact_getSetting) select 1),
				_numMembers,
				(([(_object), "factoryFunds"] call TNL_ffact_getSetting) select 1),
				((_data select 5) select 1),
				((_data select 5) select 0),
				(((_data select 5) select 1) - ((_data select 5) select 0))];
		};
		
		case "Workplace":
		{
			_text = "";
			buttonSetAction[1401, "closeDialog 0; [(lbData[1403,lbCurSel 1403])] spawn TNL_fcorp_selectManageFirm;"];
			((findDisplay 1401) displayCtrl 1404) ctrlSetStructuredText parseText format
			["The firms name is %1 and it is type of workplace we aquired it on %2 and was created on %3, Income is at %4Ц, Expenses is at %5Ц, Revenue is %6Ц", 
			(_object) call TNL_fwp_getWorkPlaceName,
			((_data select 3) call TNL_fmisc_formatDate), ((_data select 2) call TNL_fmisc_formatDate),
			((_data select 5) select 1),
			((_data select 5) select 0),
			(((_data select 5) select 1) - ((_data select 5) select 0))];
		};
		
		case "Shop":
		{
			_text = "";
			buttonSetAction[1401, "closeDialog 0; [(lbData[1403,lbCurSel 1403])] spawn TNL_fcorp_selectManageFirm;"];
			((findDisplay 1401) displayCtrl 1404) ctrlSetStructuredText parseText format
			["The firms name is %1 and it is type of shop we aquired it on %2 and was created on %3, Income is at %4Ц, Expenses is at %5Ц, Revenue is %6Ц", 
			(_object) getVariable "name",
			((_data select 3) call TNL_fmisc_formatDate), ((_data select 2) call TNL_fmisc_formatDate),
			((_data select 5) select 1),
			((_data select 5) select 0),
			(((_data select 5) select 1) - ((_data select 5) select 0))];
		};
	};
};

TNL_fcorp_selectManageFirm =
{
	private ["_data", "_type", "_object"];
	_data = call compile (_this select 0);
	_type = (_data select 1);
	_object = call compile (_data select 0);
	
	switch (_type) do
	{
		case "Factory":
		{
			[_object] spawn TNL_ffact_openManageFactory;
		};
		
		case "Workplace":
		{
			[_object] spawn TNL_fwp_manageWorkplace;
		};
		
		case "Shop":
		{
			_object spawn TNL_fps_playerShopCorp;
		};
	};

};

TNL_fcorp_openBankDlg = 
{
	private ["_corpName", "_bankAcc", "_accNum", "_accPin", "_bankAmount"];
	_corpName = (_this select 0);
	_bankAcc = (_corpName) call TNL_fcorp_getCorpBank;
	_accNum = _bankAcc select 0;
	_accPin = _bankAcc select 1;
	_bankAmount = [_accNum, 2] call TNL_fbank_getDetail;
	
	if !(createDialog "DlgCorpBankAccounts") then
	{
		["Error opening dialog DlgCorpBankAccounts, in function TNL_fcorp_openBankDlg, file corporationFunctions.sqf"] call TNL_fextHint_Hint;
	};
	
	((findDisplay 1405) displayCtrl 1401) ctrlSetStructuredText parseText format["%1", _bankAmount];
	((findDisplay 1405) displayCtrl 1402) ctrlSetStructuredText parseText format["%1", [_accNum,3] call TNL_fcvar_stringAddDashes];
	((findDisplay 1405) displayCtrl 1403) ctrlSetStructuredText parseText format["%1", _accPin];
	
	_getName = _corpName call TNL_fcorp_getOwner;
	//buttonSetAction[1404, format['copyToClipboard "%1";', (_accNum)]];
	_name = format ["%1 %2", _getName select 0, _getName select 1];
	buttonSetAction [1404, format['closeDialog 0; ["%1", %2] spawn TNL_fbank_manageOpen;', _accNum, (_name call TNL_fdb_nameGetId)]];
};

TNL_fcorp_openSummaryDlg = 
{
	if !(createDialog "DlgCorpSummary") then
	{
		["Error opening dialog DlgCorpSummary, in function TNL_fcorp_openSummaryDlg, file corporationFunctions.sqf"] call TNL_fextHint_Hint;
	};
	
	{
		_index = lbAdd[1402, format["%1", (_x select 0)]];
		lbSetData[1402, _index, (_x select 0)];
	} forEach (corporations getVariable "corporations");
	
	lbSetCurSel [1402,0];
};

TNL_fcorp_DlgCorpSummaryChange =
{
	private ["_corpName"];
	_corpName = (_this select 0);
	
	_owner = _corpName call TNL_fcorp_getOwner;
	_financial = _corpName call TNL_fcorp_getCorpIncome;
	_income = (_financial select 1);
	_expenses = (_financial select 0);
	_revenue = ((_income) - (_expenses));
	_lastRevenue = (_financial select 2);
	
	
	//((findDisplay 1406) displayCtrl 1403) ctrlSetStructuredText parseText format["%1 Report", (_corpName)];
	((findDisplay 1406) displayCtrl 1404) ctrlSetStructuredText parseText format["%1 is owned by %2 %3, there current income is at %4U, expenses are at %5U, and there revenue is at %6U, there last revenue was at %7U", _corpName, _owner select 0, _owner select 1, _income, _expenses, _revenue, _lastRevenue];
};

TNL_fcorp_openOffersDlg = 
{
	if !(createDialog "DlgCorpPurchases") then
	{
		["Error opening dialog DlgCorpPurchases, in function TNL_fcorp_openOffersDlg, file corporationFunctions.sqf"] call TNL_fextHint_Hint;
	};
	[(_this select 0)] call TNL_fcorp_loadOffersDlg;
};

TNL_fcorp_loadOffersDlg =
{
	private ["_corpName"];
	_corpName = (_this select 0);
	
	lbClear 1401;
	lbClear 1402;
	
	{
		_obj = (_x select 0);
		_type = (_x select 1);
		_name = "";
		
		switch (_type) do 
		{
			case "Factory":
			{
				_name = [_obj] call TNL_ffact_getFactoryName;
			};
			
			case "Workplace":
			{
				_name = (_obj) call TNL_fwp_getWorkPlaceName;
			};
			
			case "Shop":
			{
				_name = _obj getVariable "name";
			};
		};
	
		_index = lbAdd[1401, format["%1", _name]];
			lbSetData[1401, _index, format['["%1", "%2", "%3"]', _obj, _name, _corpName]];
	
	} forEach (corporations getVariable "firms");
	
	{
		if ((_x select 4) == _corpName) then
		{
			if ((_x select 0) != "") then
			{
				lbSetCurSel[1402,0];
				_index = lbAdd[1402, format["Offer for %1", (_x select 0)]];
				lbSetData[1402, _index, format['["%1", "%2", "%3", %4, "%5", ["%6","%7"]]', (_x select 0), (_x select 1), (_x select 2), (_x select 3), (_x select 4), ((_x select 5) select 0), ((_x select 5) select 1)]];
			};
		};
	
	} forEach (corporations getVariable "offers");
	
	lbSetCurSel[1401,0];
	
	_bankAmount = [_corpName] call TNL_fcorp_getBankAmount;
	
	((findDisplay 1407) displayCtrl 1410) ctrlSetStructuredText parseText format["Corporation Bank Balance: %1U", _bankAmount];
};

TNL_fcorp_offersFirmsListChange = 
{
	private ["_data", "_obj", "_name"];
	_data = call compile (_this select 0);
	_obj = call compile (_data select 0);
	_name = (_data select 1);
	
	
	{
		if ((_x select 0) == _obj) then
		{
			_owner = (_x select 2);
			_corpOwner = (_x select 3);
			_dateCreated = ((_x select 4) select 0);
			_defaultValue = ((_x select 5) select 0);
			_upkeep = ((_x select 5) select 1);
			_expenses = ((_x select 6) select 0);
			_income = ((_x select 6) select 1);
			_totalExpenses = ((_x select 6) select 2);
			_totalIncome = ((_x select 6) select 3);
			
			((findDisplay 1407) displayCtrl 1404) ctrlSetStructuredText parseText format["%1: This firm is owned by %2, Value: %3U Upkeep: %4U, Expenses: %5U, Income: %6U, Revenue: %7U, Total Expenses: %8U, Total Income: %9U, Total Revenue: %10U", _name, _corpOwner, _defaultValue, _upkeep, _expenses, _income, ((_income) - (_expenses)), _totalExpenses, _totalIncome, ((_totalIncome) - (_totalExpenses))];
		};
	} forEach (corporations getVariable "firms");
	
	buttonSetAction[1409, '[(lbData[1401, lbCurSel 1401]), ctrlText 1408] call TNL_fcorp_createOffer;'];
};

TNL_fcorp_increaseCorpExpenses = 
{
	private ["_corpName", "_amount"];
	_corpName = (_this select 0);
	_amount = (_this select 1);
	_corporations = (corporations getVariable "corporations");
	
	{
		if ((_x select 0) == _corpName) then
		{
			(_x select 4) set[0, (((_x select 4) select 0) + _amount)];
		};
	
	} forEach _corporations;
	
	corporations setVariable["corporations", _corporations, true];
	[TNL_gVar_str_tables_corporations, [corporations], [ [_corporations, "corporations"], [(corporations getVariable "firms"), "firms"] ]] call TNL_fsav_clientRequestSave;
};

TNL_fcorp_increaseCorpIncome = 
{
	private ["_corpName", "_amount"];
	_corpName = (_this select 0);
	_amount = (_this select 1);
	_corporations = (corporations getVariable "corporations");
	
	{
		if ((_x select 0) == _corpName) then
		{
			(_x select 4) set[1, (((_x select 4) select 1) + _amount)];
		};
	
	} forEach _corporations;
	
	corporations setVariable["corporations", _corporations, true];
	[TNL_gVar_str_tables_corporations, [corporations], [ [_corporations, "corporations"], [(corporations getVariable "firms"), "firms"]]] call TNL_fsav_clientRequestSave;
};

TNL_fcorp_createOffer = 
{
	private ["_data", "_amount", "_obj", "_name", "_corpName", "_offers", "_offerTo", "_bankAmount", "_costs", "_defaultValue"];
	_data = call compile (_this select 0);
	_amount = parseNumber (_this select 1);
	_obj = call compile (_data select 0);
	_name = (_data select 1);
	_corpName = (_data select 2);
	_offerTo = "";
	_bankAmount = [_corpName] call TNL_fcorp_getBankAmount;
	_costs = (_obj) call TNL_fcorp_getCosts;
	_defaultValue = (_costs select 0);
	_getName = _corpName call TNL_fcorp_getOwner;
	
	{
		if ((_x select 0) == _obj) then
		{
			_offerTo = (_x select 3);
		};
	} forEach (corporations getVariable "firms");
	
	if (_bankAmount >= _amount) then
	{
		if (_corpName != _offerTo) then
		{
				if (_offerTo == "public owners") then
				{
					if (_amount >= _defaultValue) then
					{
						[_corpName, _amount] call TNL_fcorp_increaseCorpExpenses;
						[format["You have purchased %1 from %2 for %3U", _name, _offerTo, _amount]] call TNL_fextHint_Hint;
						[_CorpName, ((_bankAmount) - (_amount))] call TNL_fcorp_setBankAmount;
						[_obj, _corpName, _getName] call TNL_fcorp_switchFirmOwner;

					}
					else
					{
						[format["The owner will only sell this for %1U", (_defaultValue)]] call TNL_fextHint_Hint;
					};
				}
				else
				{
					[format["You have offered to purchase %1 from %2 for %3U", _name, _offerTo, _amount]] call TNL_fextHint_Hint;
					_offers = corporations getVariable "offers";
					_offers = _offers + [ [_name, _corpName, _obj, _amount, _offerTo, _getName] ];
					corporations setVariable ["offers", _offers, true];
				};
		}
		else
		{
			["You cannot send a offer to your own corporation!"] call TNL_fextHint_Hint;
		};
	}
	else
	{
		[format["Your corporation cannot afford to offer %1U for this firm, you only have %2U in the corporation bank", _amount, _bankAmount]] call TNL_fextHint_Hint;
	};
	
	[_corpName] call TNL_fcorp_loadOffersDlg;
};

TNL_fcorp_offerDecline = 
{
	private ["_data"];
	_data = call compile (_this select 0);
	_data set[2, (call compile (_data select 2))];
	
	["You decline the offer"] call TNL_fextHint_Hint;
	
	[_data] call TNL_fcorp_removeOffer;
	[(_data select 1)] call TNL_fcorp_loadOffersDlg;
};

TNL_fcorp_switchCorpOwner =
{
	private ["_corporation", "_newOwner", "_corporations", "_firms"];
	_corporation = (_this select 0);
	_newOwner = (_this select 1);
	_corporations = corporations getVariable "corporations";
	_firms = corporations getVariable "firms";
	
	{
		if ((_x select 0) == _corporation) then
		{
			_bankAcc = (TNL_db_charID) call TNL_fbank_createAcc;
			_oldAcc = ((_x select 3) select 0);
			
			_bankBalance = [_oldAcc,2] call TNL_fbank_getDetail;
			[(_bankAcc select 0), 2, (_bankBalance)] call TNL_fbank_setDetail;
			[_oldAcc, 2, 0] call TNL_fbank_setDetail;
			
			(_x) set[3,_bankAcc];
			(_x) set[1,_newOwner];
		};
	} forEach _corporations;
	
	corporations setVariable["corporations", _corporations, true];
	corporations setVariable["firms", _firms, true];
	[TNL_gVar_str_tables_corporations, [corporations], [ [_corporations, "corporations"], [_firms, "firms"]]] call TNL_fsav_clientRequestSave;
	
	{
		if ((_x select 3) == _corporation) then
		{
			[(_x select 0), _corporation, _newOwner] call TNL_fcorp_switchFirmOwner;
		};
	} forEach _firms;
};

TNL_fcorp_removeOffer = 
{
	private ["_arr", "_offers"];
	_arr = (_this select 0);
	_offers = (corporations getVariable "offers");
	
	{
		if (format["%1",_x] == format["%1",_arr]) then
		{
			(_x) set[0, ""];
		};
	
	} forEach _offers;
	
	corporations setVariable["offers", _offers, true];
};

TNL_fcorp_removeOldOffers =
{
	private ["_obj"];
	_obj = (_this select 0);
	
	{
		if ((_x select 2) == (_obj)) then
		{
			[_x] call TNL_fcorp_removeOffer;
		};
	} forEach (corporations getVariable "offers");
};

TNL_fcorp_offerAccept = 
{
	private ["_data", "_name", "_corpName", "_obj", "_amount", "_newCorpName"];
	_data = call compile (_this select 0);
	_name = (_data select 0);
	_newCorpName = (_data select 1);
	_obj = call compile (_data select 2);
	_amount = (_data select 3);
	_CorpName = (_data select 4);
	_bankAmount = [_newCorpName] call TNL_fcorp_getBankAmount;
	_oldBankAmount = [_corpName] call TNL_fcorp_getBankAmount;
	_newOwnerName = (_data select 5);
	
	if (_bankAmount >= _amount) then
	{
		[format["You have successfully sold %1 to %2 for %3U", _name, _newCorpName, _amount]] call TNL_fextHint_Hint;
		[_obj, _newCorpName, _newOwnerName] call TNL_fcorp_switchFirmOwner;
		[_corpName, ((_oldBankAmount) + (_amount))] call TNL_fcorp_setBankAmount;
		[_newCorpName, ((_bankAmount) - (_amount))] call TNL_fcorp_setBankAmount;
		[_newCorpName, _amount] call TNL_fcorp_increaseCorpExpenses;
		[_corpName, _amount] call TNL_fcorp_increaseCorpIncome;
		[_data] call TNL_fcorp_removeOffer;
		[_obj] call TNL_fcorp_removeOldOffers;
		
		[{ if ((((_this select 0) select 0) == TNL_db_charName select 0) && (((_this select 0) select 1) == TNL_db_charName select 1)) then { [format["%1 has accepted your offer to purchase %2 for the amount of %3U", (_this select 1), (_this select 2), (_this select 3)]] call TNL_fextHint_Hint; }; }, [_newOwnerName, _corpName, _name, _amount]] call TNL_fnet_execPublic;
	}
	else
	{
		["The other corporation cannot afford to purchase this firm off you"] call TNL_fextHint_Hint;
	};
	
	[_corpName] call TNL_fcorp_loadOffersDlg;
};

TNL_fcorp_offersListChange = 
{
	private ["_data", "_name", "_corpName", "_amount"];
	_data = call compile (_this select 0);
	_name = (_data select 0);
	_corpName = (_data select 1);
	_amount = (_data select 3);
	
	((findDisplay 1407) displayCtrl 1406) ctrlSetStructuredText parseText format["%1: %2 is offering to purchase %1 from your corporation for %3U", _name, _corpName, _amount];
};


