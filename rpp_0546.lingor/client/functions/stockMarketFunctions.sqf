TNL_fsmarket_openEnterDlg = 
{
	private ["_dlg"];
	//_dlg = createDialog "DlgSMarketEnter";
	
	[player] call TNL_fatm_open;
			
	((findDisplay 601) displayCtrl 3) ctrlSetStructuredText parseText "Credit cards:";
	((findDisplay 601) displayCtrl 2) ctrlSetStructuredText parseText "Select card";
	((findDisplay 601) displayCtrl 11) ctrlSetStructuredText parseText "Insert card";
	((findDisplay 601) displayCtrl 10) buttonSetAction "closeDialog 0; (call compile lbData[1,(lbCurSel 1)]) call TNL_fsmarket_enterStockMarket;";
};

TNL_fsmarket_enterStockMarket = 
{
	private ["_name", "_bankAcc", "_bankPin", "_getPin"];
	_name = (_this select 1);
	_bankAcc = (_this select 0);
	_bankPin = [_bankAcc,1] call TNL_fbank_getDetail;
	
	if (typeName _name != "ARRAY") then
	{
		_name = TNL_db_charName;
	};
		
	if (_bankAcc call TNL_fbank_accExists) then
	{
		["You enter the stock exchange"] call TNL_fextHint_Hint;
		[_name, _bankAcc, _bankPin] spawn TNL_fsmarket_openStockMarket;
	}
	else
	{
		["Invalid bank account details to enter stock market"] call TNL_fextHint_Hint;
	};

};

TNL_fsmarket_openStockMarket =
{
	private ["_dlg"];
	_dlg = createDialog "DlgSMarketMain";
	
	//[_dlg, _this] spawn TNL_fsmarket_loadStockMarket;
	
	[_dlg, _this] spawn
	{
		while {!isNull (findDisplay 1502)} do
		{
			[(_this select 0), (_this select 1)] spawn TNL_fsmarket_loadStockMarket;
			sleep 2;
		};
	};
};

TNL_fsmarket_loadStockMarket = 
{
	private ["_dlg", "_name", "_bankAcc", "_bankPin", "_lbCurSel"];
	_dlg = (_this select 0);
	_name = ((_this select 1) select 0);
	_bankAcc = ((_this select 1) select 1);
	_bankPin = ((_this select 1) select 2);
	_lbCurSel = lbCurSel 150220;

	lbClear 150220;
	
	{
		_index = lbAdd[150220, format["%1", (_x select 0)]];
		lbsetData[150220,_index, (_x select 0)];
	} forEach (corporations getVariable "corporations");
	
	if (_lbCurSel >= 0) then 
	{ 
		lbSetCurSel [150220,_lbCurSel];
		[(lbData [150220, lbCurSel 150220])] spawn TNL_fsmarket_corporationSelChanged;
	}
	else
	{
		lbSetCurSel [150220, 0];
	};
	
	((findDisplay 1502) displayCtrl 150217) ctrlSetStructuredText parseText format["%1", [_bankAcc,3] call TNL_fcvar_stringAddDashes];
	((findDisplay 1502) displayCtrl 150218) ctrlSetStructuredText parseText format["%1", _bankPin];
	((findDisplay 1502) displayCtrl 150219) ctrlSetStructuredText parseText format["%1", [_bankAcc,2] call TNL_fbank_getDetail];
	
	buttonSetAction[150221, format['["%1", %2, ["%3", "%4"]] spawn TNL_fsmarket_openTradeDlg;', _bankAcc, _bankPin, _name select 0, _name select 1]];
	
};


TNL_fsmarket_corporationSelChanged = 
{
	private ["_corpName"];
	_corpName = (_this select 0);
	
	private ["_corpArray"];
	_corpArray = _corpName call TNL_fcorp_getCorpArray;
	
	private ["_income", "_expenses", "_revenue", "_date"];
	_income = ((_corpArray select 4) select 1);
	_expenses = ((_corpArray select 4) select 0);
	_revenue = ((_income) - (_expenses));
	_date = (_corpArray select 2) call TNL_fmisc_formatDate;
	
	((findDisplay 1502) displayCtrl 150201) ctrlSetStructuredText parseText format["%1", _income];
	((findDisplay 1502) displayCtrl 150202) ctrlSetStructuredText parseText format["%1", _expenses];
	((findDisplay 1502) displayCtrl 150203) ctrlSetStructuredText parseText format["%1", _revenue];
	((findDisplay 1502) displayCtrl 150204) ctrlSetStructuredText parseText format["%1", _date];
	
	private ["_numFirms"];
	_numFirms = 0;
	{
		if ((_x select 3) == _corpName) then { _numFirms = _numFirms + 1; };
	} forEach (corporations getVariable "firms");
	
	((findDisplay 1502) displayCtrl 150205) ctrlSetStructuredText parseText format["%1", _numFirms];
	
	{
		if ((_x select 0) == _corpName) then
		{
			((findDisplay 1502) displayCtrl 150206) ctrlSetStructuredText parseText format["%1", (_x select 1)];
			((findDisplay 1502) displayCtrl 150207) ctrlSetStructuredText parseText format["%1", (_x select 2)];
			
			((findDisplay 1502) displayCtrl 150210) ctrlSetStructuredText parseText format["%1", (_x select 4)];
			((findDisplay 1502) displayCtrl 150211) ctrlSetStructuredText parseText format["%1", (_x select 5)];
			
			if ((_x select 1) < (_x select 7)) then
			{
				((findDisplay 1502) displayCtrl 150208) ctrlSetStructuredText parseText format["<t color='#dd0000'>%1</t>", ((_x select 3) select 0)];
				((findDisplay 1502) displayCtrl 150209) ctrlSetStructuredText parseText format["<t color='#dd0000'>%1%2</t>", ((_x select 3) select 1), "%"];
			}
			else
			{
				((findDisplay 1502) displayCtrl 150208) ctrlSetStructuredText parseText format["<t color='#00cc44'>+%1</t>", ((_x select 3) select 0)];
				((findDisplay 1502) displayCtrl 150209) ctrlSetStructuredText parseText format["<t color='#00cc44'>+%1%2</t>", ((_x select 3) select 1), "%"];
			};
		};
		
		private ["_i"];
		_i = 2;
		{
			_id = parseNumber format["15021%1", _i];
			if ((_x select 0) == "buy") then
			{
				((findDisplay 1502) displayCtrl _id) ctrlSetStructuredText parseText format["<t color='#00cc44'>Buy: %1, %2U</t>", (_x select 1), (_x select 2), "%"];
			};
			
			if ((_x select 0) == "sell") then
			{
				((findDisplay 1502) displayCtrl _id) ctrlSetStructuredText parseText format["<t color='#dd0000'>Sell: %1, %2U</t>", (_x select 1), (_x select 2), "%"];
			};
		
		_i = _i + 1;
		} forEach (_x select 8);
	} forEach (stockmarket getVariable "stockmarket");
	
};

TNL_fsmarket_openTradeDlg =
{
	_corpName = (lbData [150220, lbCurSel 150220]);
	_dlg = createDialog "DlgSMarketTrade";
	
	//[_this, _corpName] spawn TNL_fsmarket_loadTradeDlg;
	
	[_this, _corpName] spawn
	{
		while {!isNull (findDisplay 1503)} do
		{
			[(_this select 0), (_this select 1)] spawn TNL_fsmarket_loadTradeDlg;
			sleep 0.1;
		};
	};
};

TNL_fsmarket_loadTradeDlg =
{
	private ["_stockMarket", "_bankAcc", "_bankPin", "_userName", "_corpName", "_curSel", "_curSel2"];
	_stockMarket = stockmarket getVariable "stockmarket";
	_bankAcc = ((_this select 0) select 0);
	_bankPin = ((_this select 0) select 1);
	_userName = ((_this select 0) select 2);
	_corpName = (_this select 1);
	_curSel = lbCurSel 150222;
	_curSel2 = lbCurSel 150231;
	
	lbClear 150222;
	lbClear 150231;
	

	((findDisplay 1503) displayCtrl 150223) ctrlSetStructuredText parseText format["%1U", [_bankAcc,2] call TNL_fbank_getDetail];
	{
		if (_x select 0 == _corpName) then
		{
			{
				if ((((_x select 0) select 0) != "") && (((_x select 0) select 1) != "")) then
				{
					_index = lbAdd[150222, format["%1 %2", ((_x select 0) select 0), ((_x select 0) select 1)]];	
					lbSetData[150222, _index, format['["%1", "%2", %3, ["%4", "%5"], ["%6", "%7"]]',_corpName, _bankAcc, _bankPin, _userName select 0, _userName select 1, ((_x select 0) select 0), ((_x select 0) select 1)]];
				};
				
				if ((((_x select 0) select 0) == _userName select 0) && (((_x select 0) select 1) == _userName select 1)) then
				{
					((findDisplay 1503) displayCtrl 150224) ctrlSetStructuredText parseText format["%1U", (_x select 2)];
				};
	
			} forEach (_x select 6);
		};
	} forEach _stockMarket;
	
	private ["_offers"];
	_offers = stockmarket getVariable "offers";
	
	{
		if ((_corpName == (_x select 5))) then
		{
			if ((str _userName) == (str (_x select 0))) then
			{
				_index = lbAdd[150231, format["%1x %2Uea (%3U) %4 %5", (_x select 1), (_x select 2), ((_x select 1) * (_x select 2)), ((_x select 4) select 0), ((_x select 4) select 1)]];
				lbSetData[150231, _index, format['%1', _x]];
			};
		};
	} forEach _offers;
	
	if (_curSel < 0) then { lbSetCurSel [150222,0]; } else { lbSetCurSel[150222,_curSel]; };
	if (_curSel2 < 0) then { lbSetCurSel [150231, 0]; } else { lbSetCurSel [150231, _curSel2]; };
	
};

TNL_fsmarket_offersListChanged = 
{
	private ["_data"];
	_data = call compile (_this select 0);
	//[(lbData[150231, lbCurSel 150231]), (_data select 1)] call TNL_fsmarket_declineOffer;
	
	buttonSetAction[150233, "[(lbData[150231, lbCurSel 150231])] call TNL_fsmarket_declineOffer; closeDialog 0;"];
	buttonSetAction[150232, format['[(lbData[150231, lbCurSel 150231]), "%1"] call TNL_fsmarket_acceptOffer; closeDialog 0;', (_data select 1)]];
};

TNL_fsmarket_stockHoldersListChanged =
{
	private ["_data", "_corpName", "_bankAcc", "_bankPin", "_userName", "_stockHolder"];
	_data =  call compile (_this select 0);
	_corpName = _data select 0;
	_bankAcc = _data select 1;
	_bankPin = _data select 2;
	_userName = _data select 3;
	_stockHolder = _data select 4;
	
	private ["_stockPrice", "_stockVolume", "_userOwns", "_offerAmount", "_totalOfferPercent", "_stockHolderOwns", "_offerPrice", "_totalOfferPrice", "_offerValue"];
	_stockPrice = 0;
	_stockVolume = 0;
	_userOwns = 0;
	_offerAmount = (round (parseNumber (ctrlText 150226)));
	_totalOfferPercent = 0;
	_stockHolderOwns = 0;
	_offerPrice = parseNumber (ctrlText 150227);
	_totalOfferPrice = _offerPrice * _offerAmount;
	_offerValue = 0;
	
	{
		if ((_x select 0) == _corpName) then
		{
			_stockPrice = (_x select 1);
			_stockVolume = (_x select 2);

			{
				if (str (_x select 0) == str (_userName)) then
				{
					_userOwns = (_x select 1); 
				};
				
				if (str (_x select 0) == str (_stockHolder)) then
				{
					_stockHolderOwns = (_x select 1);
				};
				
			} forEach (_x select 6);
		
		};
	} forEach (stockmarket getVariable "stockmarket");
	
	private ["_marketValue", "_userOwnsPercent", "_offerPercent", "_stockHolderOwnsPercent", "_takeOverCost"];
	_marketValue = _offerAmount * _stockPrice;
	_userOwnsPercent = 0;
	_offerPercent = 0;
	_stockHolderOwnsPercent = 0;
	

	if (_userOwns > 0) then
	{
		_userOwnsPercent = (_userOwns/_stockVolume)*100;
	};
	
	if (_offerAmount > 0) then
	{
		_offerPercent = (_offerAmount/_stockVolume)*100;
	};
	
	if (_stockHolderOwns > 0) then
	{
		_stockHolderOwnsPercent = (_stockHolderOwns/_stockVolume)*100;
	};
	_takeOverCost = (((_stockVolume - _userOwns) * _stockPrice) * 10);
	
	if (_stockHolderOwns >= _offerAmount) then
	{
		buttonSetAction[150234, format['[["%1","%2"], %3, %4, "%5", ["%6","%7"], "%8", %9] call TNL_fsmarket_makeOffer;', _stockHolder select 0, _stockHolder select 1, _offerAmount, _offerPrice, _bankAcc, _userName select 0, _userName select 1, _corpName, _stockPrice]];
	}
	else
	{
		buttonSetAction[150234,""];
		//["The stock holder does not have this many stocks to sell"] call TNL_fextHint_Hint;
	};
	
	if (str _stockHolder == str _userName) then
	{
		buttonSetAction[150234,""];
	};
	
	buttonSetAction[150236, format['["%1"] call TNL_fsmarket_viewDetails;', _corpName]];
	buttonSetAction[150235, format['["%1", %2, %3, "%4", ["%5","%6"]] call TNL_fsmarket_takeOverCorporation; closeDialog 0;', _corpName, _userOwnsPercent, _takeOverCost, _bankAcc, _userName select 0, _userName select 1]];
	buttonSetAction[150230, format['["%1", %2, %3, ["%4", "%5"], "%6"] call TNL_fsmarket_sellStocks; closeDialog 0;', _corpName, _offerAmount, _offerPrice, _userName select 0, _userName select 1, _bankAcc]];
	
	((findDisplay 1503) displayCtrl 150228) ctrlSetStructuredText parseText format["$%1", _takeOverCost];
	((findDisplay 1503) displayCtrl 150225) ctrlSetStructuredText parseText format["Stock price for %1 is $%2 the number of stocks is %7, you own %3%13, you are making a offer to %5 %6 who owns %4 (%12%13) for %11 (%14%13) stocks at $%9ea, total %10U with a market value of $%8", _corpName, _stockPrice, _userOwnsPercent, _stockHolderOwns, _stockHolder select 0, _stockHolder select 1, _stockVolume, _marketValue, _offerPrice, _totalOfferPrice, _offerAmount, _stockHolderOwnsPercent, "%", _offerPercent];

};

TNL_fsmarket_viewDetails =
{
	private ["_corpName", "_stockMarket", "_corporations", "_str"];
	_corpName = (_this select 0);
	_stockMarket = stockmarket getVariable "stockmarket";
	_corporations = corporations getVariable "corporations";
	_str = "";
	
	{
		if (_x select 0 == _corpName) then
		{
			_str = "-- Stock Details -- \n";
			_str = _str + "Stock price: " + str (_x select 1) + "\n";
			_str = _str + "Stock Volume: " + str (_x select 2) + "\n";
			_str = _str + "Dividend Yield: " + str (_x select 4) + "\n";
			_str = _str + "Owners: \n";
			{
				if ((((_x select 0) select 0) != "") && (((_x select 0) select 1) != "")) then
				{
					_str = _str + ((_x select 0) select 0) + " " + ((_x select 0) select 1) + " " + str (_x select 1) + "x\n";
				};
			} forEach (_x select 6);
		};
	
	} forEach _stockMarket;
	
	{
		if (_x select 0 == _corpName) then
		{
			_str = _str + "\n-- Corporation Details -- \n";
			_str = _str + "Corporation name: " + (_x select 0) + "\n";
			_str = _str + "Owner: " + ((_x select 1) select 0) + " " + ((_x select 1) select 1) + "\n";
			_str = _str + "Date founded: " + ((_x select 2) call TNL_fmisc_formatDate) + "\n";
			_str = _str + "Expenses: " + str ((_x select 4) select 0) + "\n";
			_str = _str + "Income: " + str ((_x select 4) select 1) + "\n";
		
		};
	} forEach _corporations;
	
	hintC _str;
};

TNL_fsmarket_takeOverCorporation = {};
//Disabled due to bug in taking over own corporation.
/*
{
	private ["_corpName", "_stocksOwned", "_takeOverCost", "_bankAcc", "_user", "_bankBalance"];
	_corpName = (_this select 0);
	_stocksOwned = (_this select 1);
	_takeOverCost = (_this select 2);
	_bankAcc = (_this select 3);
	_user = (_this select 4);
	_bankBalance = [_bankAcc,2] call TNL_fbank_getDetail;
	
	if (_stocksOwned >= TNL_gVar_int_percentRequiredToTakeOver) then
	{
		if (_bankBalance >= _takeOverCost) then
		{
			[format["You take over %1 for %2U, you now own all the corporation", _corpName, _takeOverCost]] call TNL_fextHint_Hint;
			[_bankAcc, 2, ((_bankBalance) - (_takeOverCost))] call TNL_fbank_setDetail;
			[_corpName, TNL_db_charName] call TNL_fcorp_switchCorpOwner;
			_name = format ["%1 %2", TNL_db_charName select 0, TNL_db_charName select 1];
			["creditCard", ((_corpName call TNL_fcorp_getCorpBank) select 0), (_name call TNL_fdb_nameGetId) call TNL_fdb_idGetName] call TNL_fwallet_addItem;
			_offers = stockmarket getVariable "offers";
				
			{
				if ((_x select 5) == _corpName) then
				{
					(_x) set[5,""];
				};
			} forEach _offers;
			
			stockmarket setVariable["offers", _offers, true];
		}
		else
		{
			["You cannot afford to take over the corporation"] call TNL_fextHint_Hint;
		};
	}
	else
	{
		[format["You require %1%2 of the corporations stocks to take over it, you currently own %3%2", TNL_gVar_int_percentRequiredToTakeOver, "%", _stocksOwned]] call TNL_fextHint_Hint; 
	};
	
	closeDialog 0;
};
*/

TNL_fsmarket_sellStocks = 
{
	private ["_corpName", "_offerAmount", "_offerPrice", "_user", "_bankAcc"];
	_corpName = (_this select 0);
	_offerAmount = (_this select 1);
	_offerPrice = (_this select 2);
	_user = (_this select 3);
	_bankAcc = (_this select 4);
	
	{
		if ((_x select 0) == _corpName) then 
		{
			_stockPrice = (_x select 1);
			{
				if (str (_x select 0) == str _user) then
				{
					if ((_x select 1) >= _offerAmount) then
					{
						if (_offerPrice <= _stockPrice) then
						{
							_totalPrice = (_offerAmount * _offerPrice);
							_bankBalance = [_bankAcc,2] call TNL_fbank_getDetail;
							[_bankAcc, 2, ((_bankBalance) + (_totalPrice))] call TNL_fbank_setDetail;
							[_user, ["Public", "Shareholders"], _corpName, _offerAmount] call TNL_fsmarket_transferStocks;
							[format["You sell %1 stocks for %2Uea (%3)", _offerAmount, _offerPrice, _totalPrice]] call TNL_fextHint_Hint;
							[_corpName, "sell", _offerAmount, _totalPrice] call TNL_fsmarket_addAction;
						}
						else
						{
							["Nobody wants to purchase the stocks off you for that price"] call TNL_fextHint_Hint;
						};
					}
					else
					{
						["You do not have enough stocks to sell this many"] call TNL_fextHint_Hint;
					};
				};
			} forEach (_x select 6);
		};
	} forEach (stockmarket getVariable "stockmarket");
};

TNL_fsmarket_isPublicTrader =
{
	private ["_name"];
	_name = (_this);
	
	if ((_name select 0 == "Public") && (_name select 1 == "Shareholders")) then
	{
		true;
	}
	else
	{
		false;
	};
};

TNL_fsmarket_makeOffer =
{
	private ["_offers", "_stockHolder", "_offerAmount", "_offerPrice"];
	_stockHolder = (_this select 0);
	_offerAmount = (_this select 1);
	_offerPrice = (_this select 2);
	
	if (!(_stockHolder call TNL_fsmarket_isPublicTrader)) then
	{
		_offers = stockmarket getVariable "offers";
		_offers = _offers + [ [(_this select 0), (_this select 1), (_this select 2), (_this select 3), (_this select 4), (_this select 5)] ];
		stockmarket setVariable["offers", _offers, true];
		[format["You made a offer to %1 %2 for %3 stocks at %4U each", _stockHolder select 0, _stockHolder select 1, _offerAmount, _offerPrice]] call TNL_fextHint_Hint;
	}
	else
	{
		if (_offerPrice >= (_this select 6)) then
		{
			_bankBalance = [(_this select 3),2] call TNL_fbank_getDetail;
			_totalPrice = ((_offerAmount) * (_offerPrice));
				
			if (_bankBalance >= _totalPrice) then
			{
				closedialog 0;
				[(_this select 5), "buy", _offerAmount, _totalPrice] call TNL_fsmarket_addAction;
				[(_this select 3), 2, ((_bankBalance) - (_totalPrice))] call TNL_fbank_setDetail;
				[_stockHolder, (_this select 4), (_this select 5), _offerAmount] call TNL_fsmarket_transferStocks;
				[format["You purchase %1 stocks at %2Uea with a total cost of %3U", _offerAmount, _offerPrice, _totalPrice]] call TNL_fextHint_Hint;
			}
			else
			{
				["You cannot afford to purchase this many stocks for that price"] call TNL_fextHint_Hint;
			};
		}
		else
		{
			[format["They will only sell there stocks for %1U or higher", (_this select 6)]] call TNL_fextHint_Hint;
		};
	};
};

TNL_fsmarket_acceptOffer =
{
	private ["_data"];
	_data = call compile (_this select 0);
	_user = (_data select 0);
	_offerAmount = (_data select 1);
	_offerPrice = (_data select 2);
	_bankAcc = (_data select 3);
	_offerFrom = (_data select 4);
	_corpName = (_data select 5);
	_bankBalance = [_bankAcc,2] call TNL_fbank_getDetail;
	_stockHolderBankBalance = [(_this select 1),2] call TNL_fbank_getDetail;
	_stockMarket = stockmarket getVariable "stockmarket";
	_totalPrice = (_offerAmount * _offerPrice);
		
	{
		if (_x select 0 == _corpName) then
		{
			{
				if (((str _user) == (str (_x select 0)))) then
				{
					if (_offerAmount <= (_x select 1)) then
					{
						if (_bankBalance >= _totalPrice) then
						{
							[_corpName, "buy", _offerAmount, _totalPrice] call TNL_fsmarket_addAction;
							[_user, _offerFrom, _corpName, _offerAmount] call TNL_fsmarket_transferStocks;
							[_bankacc, 2, ((_BankBalance) - (_totalPrice))] call TNL_fbank_setDetail;
							[(_this select 1), 2, ((_stockHolderBankBalance) + (_totalPrice))] call TNL_fbank_setDetail;
							[_data] call TNL_fsmarket_removeOffer;
							[format["You have sold %1 of your stocks for a total of %2U to %3 %4", _offerAmount, _totalPrice, _offerFrom select 0, _offerFrom select 1]] call TNL_fextHint_Hint;
						}
						else
						{
							[format["%1 %2 does not have enough money to purchase the stocks off you", _offerFrom select 0, _offerFrom select 1]] call TNL_fextHint_Hint;
						};
					}
					else
					{
						[format["You do not have enough stocks to sell %1 of them", _offerAmount]] call TNL_fextHint_Hint;
					};
				};
			} forEach (_x select 6);
		};
	} forEach _stockMarket;
};

TNL_fsmarket_addAction =
{
	private ["_corpName", "_actionType", "_amount", "_cost"];
	_corpName = (_this select 0);
	_actionType = (_this select 1);
	_amount = (_this select 2);
	_cost = (_this select 3);
	_stockMarket = stockmarket getVariable "stockmarket";
	
	{
		if (_x select 0 == _corpName) then
		{
			_actions = (_x select 8);

			if (count _actions > 4) then
			{
				(_actions) set[0,((_x select 8) select 1)];
				(_actions) set[1,((_x select 8) select 2)];
				(_actions) set[2,((_x select 8) select 3)];
				(_actions) set[3,((_x select 8) select 4)];
				(_actions) set[4,[_actionType, _amount, _cost]];
			}
			else
			{
				_actions = _actions + [ [_actionType, _amount, _cost] ];
			};
			
			(_x) set[8,_actions];
		};

	} forEach _stockMarket;
	
	stockMarket setVariable["stockmarket", _stockmarket, true];
	[TNL_gVar_str_tables_stockmarket, [stockmarket], [ [_stockMarket, "stockmarket"] ]] call TNL_fsav_clientRequestSave;
};

TNL_fsmarket_transferStocks = 
{
	private ["_transferFrom", "_transferTo", "_corpName", "_amount"];
	_transferFrom = (_this select 0);
	_transferTo = (_this select 1);
	_corpName = (_this select 2);
	_amount = (_this select 3);
	_stockMarket = stockmarket getVariable "stockmarket";
	_found = false;
	
	{
		if (_x select 0 == _corpName) then
		{
			{
				if (str (_x select 0) == str _transferFrom) then
				{
					(_x) set[1,((_x select 1)- _amount)];
					
					if (_x select 1 <= 0) then
					{
						(_x) set[0,["",""]];
					};
				};
				
				if (str (_x select 0) == str _transferTo) then
				{
					(_x) set[1,((_x select 1)+ _amount)];
					_found = true;
				};
			
			} forEach (_x select 6);
			
			if !(_found) then
			{
				_new = (_x select 6);
				_new = _new + [ [_transferTo, _amount] ];
				(_x) set[6,_new];
			};
		};
	} forEach _stockMarket;

	stockmarket setVariable["stockmarket", _stockmarket, true];
	[TNL_gVar_str_tables_stockmarket, [stockmarket], [ [_stockMarket, "stockmarket"] ]] call TNL_fsav_clientRequestSave;
};

TNL_fsmarket_declineOffer =
{
	private ["_data"];
	_data = call compile (_this select 0);
	[_data] call TNL_fsmarket_removeOffer;
	["You decline the offer"] call TNL_fextHint_Hint;
};

TNL_fsmarket_removeOffer =
{
	private ["_offer"];
	_offer = (_this select 0);
	_offers = stockmarket getVariable "offers";
	
	{
		if (str _offer == str _x) then
		{
			(_x select 0) set[0,""];
			(_x select 0) set[1,""];
		};
	} forEach _offers;
	
	stockmarket setVariable["offers", _offers, true];
};