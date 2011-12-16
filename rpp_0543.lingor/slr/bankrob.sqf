govmentLooses = 0;
_array = _this select 3;
_art   = _array select 0;
_cops = ["COP"] call TNL_fplayer_getPlayerTypesCount;

if (_art == "rob") then
{	
	_robbAmount = 0;
	_robTime = 120;
	if (robb_possible == 0) exitWith 
	{
		["Cannot rob the bank yet"] call TNL_fextHint_Hint;
	};
	
	if (isCop) exitWith { };

	if (_cops < 3) exitWith 
	{
		["There has to be at least 3 cops on duty to rob the bank"] call TNL_fextHint_Hint;
	};
	
	if (!(call TNL_fplayer_hasWeapon)) exitWith
	{
		["You have no weapon!"] call TNL_fextHint_Hint;
	};
	
	robb_possible = 0;
	
	[{
		titleText [format["The bank is being robbed! it will take them around %1 minutes!", (_this select 0)], "plain"];
		if (player distance MainBank < 500) then
		{
			MainBank say ["SndBankAlarm", 1500];
		};
	}, [(_robTime/60)]] call TNL_fnet_execPublic;
		
	_scriptabbruch = 0;
	_skipTime = 15; 
	_robbMoney = (5 * _skipTime);
	_robbAmount = round(_robbMoney*(count call TNL_cfplayer_activeSlots));
	_totalRobbed = 0;
	for [{_i=0}, {_i < _robTime}, {_i=_i+_skipTime}] do
	{
		if (isstunned) exitWith
		{
			[{ ["The robbers have been stopped!"] call TNL_fextHint_Hint;}] call TNL_fnet_execPublic;
			_scriptabbruch = 1;
		};
		
		if (player distance MainBank >= 10) exitWith
		{
			[{ ["The robbers have started there escape!"] call TNL_fextHint_Hint;}] call TNL_fnet_execPublic;
			
			sleep 10;
			
			if ((isstunned) or (!alive player)) then
			{
				_scriptabbruch = 1;	
			};
		};
		
		[{
			if (player != (_this select 0)) then
			{
				if (TNL_gVar_paycheckAccNum != "") then
				{
					[format["$%1 has been taken from your account by the robbers!", (_this select 1)]] call TNL_fextHint_Hint;
					_acc = TNL_gVar_paycheckAccNum;
					_balance = [_acc, 2] call TNL_fbank_getDetail; //get the current account balance
					[_acc, 2, (_balance - (_this select 1))] call TNL_fbank_setDetail; 
				}
				else
				{
					["You dont have a active paycheck account for the robbers to take your money"] call TNL_fextHint_Hint;
				};
			};
			
			if (isServer) then
			{
				GovernmentTaxAccount = GovernmentTaxAccount - (_this select 1);
				publicVariable "GovernmentTaxAccount";
			};
		}, [player, _robbMoney]] call TNL_fnet_execPublic;
		
		_totalRobbed = _totalRobbed + _robbAmount;
		sleep _skipTime;											
	};					
	
	if (_scriptabbruch == 1) exitWith {};
	
	["IllegalMoney", _totalRobbed] call TNL_finv_addInventoryItem;
	[{[format["The robbers have escaped with $%1!", (_this select 0)]] call TNL_fextHint_Hint;}, [_totalRobbed]] call TNL_fnet_execPublic;
	
	[{
		if (isServer) then { [0,1,2,["rob_victims"]] execVM "slr\bankRob.sqf"; };
		call compile format['%1_wanted = 1; bounty_%1 = bounty_%1 + %2;', (_this select 0), (_this select 2)];
		["Bank", (_this select 0), (_this select 1)] spawn SLR_fw_addCrimeLog;
	}, [player, _money, _totalRobbed]] call TNL_fnet_execPublic;
	
	local_useBankPossible = false;
	sleep (60*15);
	local_useBankPossible = true;
};	


if (_art == "server_rob") then
{
	if (isServer) exitWith
	{	
		robb_possible = 0;
		publicVariable "robb_possible";
		sleep (60*15);
		robb_possible = 1;
		publicVariable "robb_possible";	
	};
};
