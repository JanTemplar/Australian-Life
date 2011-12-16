//Mayor Voting

_voteMinLimit = 2; //The minimal number of votes for the voting to count
_this = _this select 3;
_type  = _this select 0;
_money = "Money" call TNL_finv_getItemAmount;
_mayorpay = 0;
_copdefaultpay = 0;
_welfareamount = 0;
_welfareincomelimit = 0;
_welfarebanklimit = 0;
_wealthaxlimit = 0;

if (_type == "ClientElectMayor") then
{
	if (isNil("ElectTimeRestriction")) then 
	{
		ElectTimeRestriction = false;
	};
	
	if (ElectTimeRestriction) exitWith 
	{
		["You just voted."] call TNL_fextHint_Hint;
	};
	
	_playerObj = call compile (_this select 1);
	
	if (_playerObj == player) exitWith
	{
		["Cannot vote for yourself"] call TNL_fextHint_Hint;
	};
	
	[{if (isServer) then { [0,1,2,["ServerElectMayor", (_this select 0), (_this select 1)]] execVM "slr\mayor.sqf";};}, [_playerObj, player]] call TNL_fnet_execPublic;

	[format["Voted for %1", (name _playerObj) call TNL_fplayer_formatName]] call TNL_fextHint_Hint;
	ElectTimeRestriction = true;
	sleep 5;
	ElectTimeRestriction = false;
};

if (_type == "ServerElectMayor") then
{
	_candidate =  format["%1", (_this select 1)];
	_elector  =  format["%1", (_this select 2)];
	
	_inVoteArray = false;
	_electorExists = false;
	{
		_can = (_x select 0);
		_voters = (_x select 1);
		
		if (_can == _candidate) then
		{
			{
				if (_x == _elector) then
				{
					_electorExists = true;
				};
		
			} forEach _voters;
			
			if (!_electorExists) then
			{
				_x set[(count _x),_elector];
			};
			
			_inVoteArray = true;
		};
	} forEach voteArray;
	
	if (!_inVoteArray) then
	{
		voteArray set[(count voteArray), [_candidate, [_elector]]];
	};
};

if (_type == "ServerMayorLoop") then
{
	_currentMayor = "";
	while {true} do
	{	
		_MaxStimmen = _voteMinLimit;
		_MaxPos     = -1;
		
		 [{[format["Votes are being counted.. remember more than %1 is required to win!", (_this select 0)]] call TNL_fextHint_Hint;}, [_voteMinLimit]] call TNL_fnet_execPublic;
		
		_totalVotes = 0;
		{
			_playerName = (name (call compile(_x select 0))) call TNL_fplayer_formatName;
			_votes = count (_x select 1);
			
			if (_votes > _MaxStimmen) then
			{
				_MaxStimmen = (count (_x select 1));
				_MaxPos     = _x;
				
				[{[format["%1 takes the lead with %2 votes!", (_this select 0), (_this select 1)]] call TNL_fextHint_Hint;}, [_playerName, _votes]]  call TNL_fnet_execPublic;
			}
			else
			{
				[{[format["%1 received %2 votes!", (_this select 0), (_this select 1)]] call TNL_fextHint_Hint;}, [_playerName, _votes]]  call TNL_fnet_execPublic;
			};
			
			_totalVotes = _totalVotes + _votes;
			
			sleep 3;
		} forEach voteArray;
		
		if ((typeName _MaxPos == "SCALAR") and (_currentMayor == "")) then
		{
				[{["No Mayor has been elected!"] call TNL_fextHint_Hint;}, []]  call TNL_fnet_execPublic;
				//"hint localize ""STRS_regierung_nomajor"";" call ISSE_pub_execPstr;
				_currentMayor = "";
		}
		else
		{	
			if (typeName _MaxPos == "SCALAR") then
			{	
				[{["The Mayor stays in post"] call TNL_fextHint_Hint;}, []]  call TNL_fnet_execPublic;
				//"hint localize ""STRS_regierung_majorstays"";" call ISSE_pub_execPstr;
			}
			else
			{
				if (_currentMayor == (_MaxPos select 0)) then
				{
					[{["Mayor Stays!"] call TNL_fextHint_Hint;}, []]  call TNL_fnet_execPublic;
				}
				else
				{
					_currentMayor = (_MaxPos select 0);
					_mayorObj = call compile _currentMayor;
					//hint format["%1 is mayor! He won with %2 percent of the votes ", name _mayorObj, (_maxStimmen / _totalVotes * 100)];
					[{ player say3D "SndMayorElection"; [format["%1 is the new Mayor!, He won with %2 percent of the votes!", (_this select 0), (_this select 1)]]call TNL_fextHint_Hint; if (player == (_this select 2)) then { isMayor = true;} else { isMayor = false;};}, [(name _mayorObj) call TNL_fplayer_formatName, (_maxStimmen / _totalVotes * 100), _mayorObj]] call TNL_fnet_execPublic;

					
					//format["hint format[localize ""STRS_mayor_new"", ""%3"", %2]; if ((rolenumber-1) == %1) then {isMayor = true;} else {isMayor = false;};", _MaxPos, _MaxStimmen, _MayorString] call ISSE_pub_execPstr;
				};
			};
		};
		
		currentMayor = (name (call compile _currentMayor)) call TNL_fplayer_formatName;
		PUBLICVARIABLE "currentMayor";
		voteArray = [];
		sleep 900;
	};
};

if (_type == "MayorTax") then 
{
	_item = _this select 1;
	_mag  = _this select 2;
	_weap = _this select 3;
	_vcl  = _this select 4;
	_bank = _this select 5;
	_fueltaxes = _this select 6;
	_wealthaxlimit = _this select 7;
	_wealthtaxvalue = _this select 8;
	_ictax1 = _this select 9;
	_ictax2 = _this select 10;
	_ictax3 = _this select 11;
	_ictax4 = _this select 12;
	_ictax5 = _this select 13;
	_welfareincomelimit = _this select 14;
	_welfarebanklimit = _this select 15;
	_welfareamount = _this select 16;
	_mayorpay = _this select 17;
	_chiefpolpay = _this select 18;
	_interestrate = _this select 19;
	_copdefaultpay = _this select 20;
	
	// Set Vars
	GblFuelTaxes = _fueltaxes;
	GblFactTax = _wealthaxlimit;
	GblWealthTax = _wealthtaxvalue;
	GblIncomeTaxClass1 = _ictax1;
	GblIncomeTaxClass2 = _ictax2;
	GblIncomeTaxClass3 = _ictax3;
	GblIncomeTaxClass4 = _ictax4;
	GblIncomeTaxClass5 = _ictax5;
	GblWelfareIncomeLimit = _welfareincomelimit;
	GblWelfareBankLimit = _welfarebanklimit;
	add_civmoney = _welfareamount;
	MayorExtraPay = _mayorpay;
	PoliceChiefExtraPay = _chiefpolpay;
	zinsen_prozent = _interestrate;
	add_copmoney = _copdefaultpay;
	
	// Publish them
	Publicvariable "GblFuelTaxes";
	Publicvariable "GblFactTax";
	Publicvariable "GblWealthTax";
	Publicvariable "GblIncomeTaxClass1";
	Publicvariable "GblIncomeTaxClass2";
	Publicvariable "GblIncomeTaxClass3";
	Publicvariable "GblIncomeTaxClass4";
	Publicvariable "GblIncomeTaxClass5";
	Publicvariable "GblWelfareIncomeLimit";
	Publicvariable "GblWelfareBankLimit";
	Publicvariable "add_civmoney";
	Publicvariable "MayorExtraPay";
	Publicvariable "PoliceChiefExtraPay";
	Publicvariable "zinsen_prozent";
	Publicvariable "add_copmoney";
	[{(INV_ItemTypenArray select 0) SET [2, (_this select 0)]; (INV_ItemTypenArray select 1) SET [2, (_this select 1)]; (INV_ItemTypenArray select 2) SET [2, (_this select 2)]; (INV_ItemTypenArray select 3) SET [2, (_this select 3)]; bank_steuer = (_this select 4); hint "The Government has changed Various Taxes, Social-Welfare, Payments, Interest-Rates and/or other Details!"; }, [_item, _vcl, _mag, _weap, _bank]] call TNL_fnet_execPublic;
	sleep 10;
	[{ [format["The Government made these Numbers public:\n\nMayor Salary: %1$\nChief-Police Salary: %2$\nCop Default Salary: %3$\nWelfare: %4$\nWelfare-Income-limit:%5$\nWelfare-Bank-Limit:%6$\n\nWealth-Tax Bank-Limit: %7$\nWealth-Tax: %8 Percent\n\nVAT:\nItems: %9 Percent\nVehicles: %10 Percent\nWeapons: %11 Percent\nMagazines: %12 Percent\nBank-Trans.: %13 Percent\nFuel: %14 Percent", MayorExtraPay, PoliceChiefExtraPay, add_copmoney, add_civmoney, GblWelfareIncomeLimit, GblWelfareBankLimit, str GblFactTax, GblWealthTax, ((INV_ItemTypenArray select 0) select 2), ((INV_ItemTypenArray select 1) select 2), ((INV_ItemTypenArray select 2) select 2), ((INV_ItemTypenArray select 3) select 2), bank_steuer, GblFuelTaxes]] call TNL_fextHint_Hint;}] call TNL_fnet_execPublic;
};

if (_type == "ClientSetLaws") then
{
	_whichLaw = _this select 1;
	_text   = _this select 2;
	
	if (_whichLaw == -1) exitWith {};
	//if ((_text call ISSE_str_Length) > 60) exitWith {player groupChat localize "STRS_text_zu_lang";};
	[{lawsArray SET [(_this select 0), (_this select 1)]; [format ["Law #%1 has been changed. This is the new Law: %2", (_this select 0), (_this select 1)]] call TNL_fextHint_Hint;}, [_whichLaw, _text]] call TNL_fnet_execPublic;
};