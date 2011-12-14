/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

TNL_fgather_handleAction =
{
	private ["_gatherClass", "_gatherType", "_gatherArray"];
	_gatherClass = (_this select 0);
	_gatherType = (_this select 1);
	_gatherArray = (_gatherClass) call TNL_fgather_getGatherArray;
	
	if ((count _gatherArray) > 0) then
	{
		[_gatherArray, _gatherType] spawn TNL_fgather_StartGathering;
	};
};

TNL_fgather_IsInGatherVehicle = 
{
	private ["_obj", "_arr", "_found"];
	_obj = (_this select 0);
	_arr = (_this select 1);
	_found = false;
	
	{
		if ((typeOf _obj) == _x) then
		{
			_found = true;
		};
	} forEach _arr;

	_found
};

TNL_fgather_hasRequiredItems =
{
	private ["_arr", "_return"];
	_arr = (_this);
	_return = true;
	
	{
		_itemAmount = (_x) call TNL_finv_getItemAmount;
		
		if (_itemAmount <= 0) then
		{
			_return = false;
		};
	
	} forEach _arr;
	
	_return
};

TNL_fgather_getRequiredItemsMessage =
{
	private ["_arr", "_msg", "_i"];
	_arr = (_this);
	_msg = "";
	
	_i = 0;
	{
		if (_i == 0) then
		{
			_msg = format["%1", (_x) call TNL_finv_getItemName];
		}
		else
		{
			_msg = _msg + format[" and %1", (_x) call TNL_finv_getItemName];
		};
	
		_i = _i + 1;
	} forEach _arr;

	_msg
};

TNL_fgather_getGatherArray =
{
	private ["_gatherClass", "_returnArr"];
	_gatherClass = (_this);
	_returnArr = [];
	
	{
		_classes = (_x select 1);
		_array = (_x);
		{
			if (_x == _gatherClass) then
			{
				_returnArr = (_array);
			};
		
		} forEach _classes;
	
	} forEach TNL_gVar_arr_gatherDefine;
	
	_returnArr
};

TNL_fgather_alreadyGatheredAtLocation =
{
	private ["_distance", "_gatheredHere"];
	_distance = (_this select 0);
	_gatheredHere = false;
	
	{
		_location = (_x select 0);
		
		if (player distance _location <= _distance) then
		{
			_gatheredHere = true;
		};
	
	
	} forEach TNL_gVar_arr_gatheredLocations;

	_gatheredHere
};

TNL_fgather_checkGatheredLocations = 
{
		{
			_time = (_x select 1);

			if (((_time - time) + TNL_gVar_int_timeUntilRegather) <= 0) then
			{
				(_x) set[0,[0,0,0]];
			};
		} forEach TNL_gVar_arr_gatheredLocations;
};


TNL_fgather_StartGathering =
{
	private ["_arr"];
	_arr = (_this select 0);
	_gatherType = (_this select 1);
	_startMessage = ((_arr select 2) select 0);
	_successMessage = (((_arr select 2) select 1) select 0);
	_failMessage = (((_arr select 2) select 1) select 1);
	_failMessageDueToItems = (((_arr select 2) select 1) select 2);
	_startLocalMessage = (((_arr select 2) select 2) select 0);
	_successLocalMessage = (((_arr select 2) select 2) select 1);
	_failLocalMessage = (((_arr select 2) select 2) select 2);
	_usesSkill = ((_arr select 3) select 0);
	_timeToGather = (((_arr select 3) select 1) select 0);
	_chanceToIncreaseSkill = (((_arr select 3) select 1) select 1);
	_timeDecreasePerOneSkill = (((_arr select 3) select 1) select 2);
	_chanceToSucceedPerOneSkill = (((_arr select 3) select 1) select 3);
	_decreasesHunger = ((((_arr select 3) select 1) select 4) select 0);
	_amountHungerDecreasesBy = ((((_arr select 3) select 1) select 4) select 1);
	_decreasesThirst = ((((_arr select 3) select 1) select 4) select 2);
	_amountThirstDecreasesBy = ((((_arr select 3) select 1) select 4) select 3);
	_maxSkillreq = ((((_arr select 3) select 1) select 5) select 0);
	_minSkillreq = ((((_arr select 3) select 1) select 5) select 1);
	_difficulty = (((_arr select 3) select 1) select 6);
	_animation = (_arr select 4);
	_itemsCanGet = (_arr select 5);
	_chanceToSucceed = (_arr select 6);
	_requiredItems = (_arr select 7);
	_distanceCanMove = (_arr select 8);
	_getSkillOnSuccess = ((_arr select 9) select 0);
	_getSkillOnFail = ((_arr select 9) select 1);
	_requiredToMove = ((_arr select 10) select 0);
	_needToMoveMessage = ((_arr select 10) select 1);
	_distanceNeedToBeMoved = ((_arr select 10) select 2);
	_hasRequiredItems = (_requiredItems) call TNL_fgather_hasRequiredItems;
	_message = (_requiredItems) call TNL_fgather_getRequiredItemsMessage;
	_skillAmount = (_usesSkill) call TNL_fskills_getSkill;
	_totalGatherTime = ((_timeToGather) - ((_skillAmount * _timeDecreasePerOneSkill)));
	_totalChanceToSucceed = ((_chanceToSucceed) + ((_skillAmount * _chanceToSucceedPerOneSkill)));
	_randomChance = (random 100);
	_randomChanceToIncreaseSkill = (random 100);
	_playerLocation = getpos(vehicle player);
	_randomItem = "";
	_amountGot = 0;
	_hasItemsAvailable = false;
	_canGather = true;
	_result = false;
	_selectedItemsArr = [];
	_itemSelectedItemConsumes = "";
	_selectedItemConsumesItem = false;
	_amountOfItemConsumes = 0;
	_itemConsumedOnFail = false;
	_itemConsumesMoreThanOne = false;
	_error = false;
	GatherResult = [];
	
	if (_randomChanceToIncreaseSkill > _chancetoIncreaseSkill) then
	{
		_getSkillOnSuccess = false;
		_getSkillOnFail = false;
	};
	
	if ((_gatherType == "ground") && (_requiredToMove)) then
	{
		_gatheredHere = [_distanceNeedToBeMoved] call TNL_fgather_alreadyGatheredAtLocation;
		if (_gatheredHere) then
		{ 
			[_needToMoveMessage] call TNL_fextHint_Hint;
			_canGather = false;
		};
	};
if (_canGather) then
{	
	if (count _itemsCanGet > 0) then
	{
		// Old random item code
		/*
		_randomPick = (round(random(count(_itemsCanGet)-1)));
		
		//if (_randomPick == (count _itemsCanGet)) then { _randomPick = _randomPick - 1; };
		
		_totalIncrease = floor(_skillAmount / _maxItemsIncreasedPerEveryXSkill);
		_totalItemIncrease = ((_totalIncrease) * (_amountIncreasePerXSkill));
		
		_randomItem = ((_itemsCanGet select _randomPick) select 0);
		_ItemMax = ((((_itemsCanGet select _randomPick) select 1) select 1) + _totalItemIncrease);
		_ItemMin = (((_itemsCanGet select _randomPick) select 1) select 0);
		_default = (((_itemsCanGet select _randomPick) select 2) select 0);
		_amountGot = (floor(random ((_itemMax - _itemMin)+ _itemMin)));
		
		if (_amountGot <= 0) then { _amountGot = 1; };
		*/
		
		/* Get random item */
		{
			_randomItemRoll = (random 100);
			
			_itemChance = ((_x select 2) select 1);
			_itemDefault = ((_x select 2) select 0);
			_itemRequiresItem = ((_x select 5) select 0);
			_itemRequiredItem = ((_x select 5) select 1);
			_consumesItem = ((_x select 4) select 0);
			_itemConsumed = ((_x select 4) select 1);
			
			if (_itemDefault) then
			{
				if (!(_itemRequiresItem) || ((_itemRequiresItem) && (_itemRequiredItem call TNL_finv_getItemAmount > 0))) then
				{
					if (!(_consumesItem) || ((_consumesItem) && (_itemConsumed call TNL_finv_getItemAmount > 0))) then
					{
						_selectedItemsArr = _selectedItemsArr + [ (_x) ];
					};
				};
			}
			else
			{
				if (_itemChance >= _randomItemRoll) then
				{
					if (!(_itemRequiresItem) || ((_itemRequiresItem) && (_itemRequiredItem call TNL_finv_getItemAmount > 0))) then
					{
						if (!(_consumesItem) || ((_consumesItem) && (_itemConsumed call TNL_finv_getItemAmount > 0))) then
						{
							_selectedItemsArr = _selectedItemsArr + [ (_x) ];
						};
					};
				};
			};
		} forEach _itemsCanGet;
		
		if (count _selectedItemsArr > 0) then
		{
			_random = (round(random(count(_selectedItemsArr)-1)));
			
			_itemRequiresItem = (((_selectedItemsArr select _random) select 5) select 0);
			_itemRequiredItem = (((_selectedItemsArr select _random) select 5) select 1);
			
			_selectedItemConsumesItem = (((_selectedItemsArr select _random) select 4) select 0);
			_itemSelectedItemConsumes = (((_selectedItemsArr select _random) select 4) select 1);
			_itemConsumesMoreThanOne = (((_selectedItemsArr select _random) select 4) select 2);
			_amountOfItemConsumes = (((_selectedItemsArr select _random) select 4) select 3);
			_itemConsumedOnFail = (((_selectedItemsArr select _random) select 4) select 4);
					
			_maxItemsIncreasedPerEveryXSkill = (((_selectedItemsArr select _random) select 3) select 0);
			_amountIncreasePerXSkill = (((_selectedItemsArr select _random) select 3) select 1);
			_totalIncrease = 0;
			if (_maxItemsIncreasedPerEveryXSkill > 0) then //Stupid zero division bug DIE
			{
				_totalIncrease = floor(_skillAmount / _maxItemsIncreasedPerEveryXSkill);
			}
			else
			{
				_totalIncrease = floor _skillAmount;
			};
			_totalItemIncrease = ((_totalIncrease) * (_amountIncreasePerXSkill));
				
			_randomItem = ((_selectedItemsArr select _random) select 0);
			_itemMax = ((((_selectedItemsArr select _random) select 1) select 1) + _totalItemIncrease);
			_itemMin = (((_selectedItemsArr select _random) select 1) select 0);
			_amountGot = (floor(random ((_itemMax - _itemMin)+ _itemMin)));
			
			if ((_itemConsumesMoreThanOne) && (_selectedItemConsumesItem)) then
			{
				if (_amountGot <= 0) then { _amountGot = 1; };
				_amountOfItemConsumes = _amountOfItemConsumes * _amountGot;
			};
			
			_hasItemsAvailable = true;
		}
		else
		{
			_error = true;
			[_arr, _gatherType] spawn TNL_fgather_StartGathering;
		};
		
		if (_amountGot <= 0) then { _amountGot = 1; };
		
		if ((_hasItemsAvailable) && (_selectedItemConsumesItem) && (_itemSelectedItemConsumes call TNL_finv_getItemAmount < _amountOfItemConsumes)) then
		{
			_hasItemsAvailable = false;
		};
	};

	
	_totalChanceToSucceed = _totalChanceToSucceed - _difficulty;
	
	if (_totalGatherTime < 0) then { _totalGatherTime = 0; };
	if (_totalChanceToSucceed > 100) then { _totalChanceToSucceed = 100; };
	if (_totalChanceToSucceed < 0) then { _totalChanceToSucceed = 0; };

	if ((!(TNL_gVar_bool_gatheringItems)) and (!(_error))) then
	{
		if (_hasRequiredItems) then
		{
			[format[_startMessage, ((round(_totalGatherTime * 100))/100)]] call TNL_fextHint_Hint;
			[player, [player], 15, format[_startLocalMessage, (name player) call TNL_fplayer_formatName]] call TNL_fnet_HintToClientsInDistanceOfObject;
			TNL_gVar_bool_gatheringItems = true;
			TNL_gVar_arr_gatheredLocations = TNL_gVar_arr_gatheredLocations + [ [(getpos player), time] ];
			
			if !((player) call TNL_fplayer_inVehicle) then
			{
				[{(_this select 0) switchMove (_this select 1);}, [player, _animation]] call TNL_fnet_execPublic;
			};
			
			Gvar_bool_player_ableToUseAnimation = false;
			sleep _totalGatherTime;
			Gvar_bool_player_ableToUseAnimation = true;
			
			if (vehicle player distance (_playerLocation) <= _distanceCanMove) then
			{
			
				if (_randomChance <= _totalChanceToSucceed) then //Success!!
				{
					_result = true;
					if (_getSkillOnSuccess) then
					{
						if ((_skillAmount >= _minSkillReq) && (_skillAmount <= _maxSkillReq)) then
						{
							[_usesSkill, ((_usesSkill) call TNL_fskills_getOptimalIncrease)] call TNL_fskills_increaseSkill;
						}
						else
						{
							if (_skillAmount > _maxSkillReq) then
							{
								[_usesSkill, ((_usesSkill) call TNL_fskills_getNormalIncrease)] call TNL_fskills_increaseSkill;
							}
							else
							{
								[_usesSkill, ((_usesSkill) call TNL_fskills_getReducedIncrease)] call TNL_fskills_increaseSkill;
							};
						};
					}; 
					
					if (_hasItemsAvailable) then
					{
						if (_selectedItemConsumesItem) then
						{
							[_itemSelectedItemConsumes,-(_amountOfItemConsumes)] call TNL_finv_addInventoryItem;
						};
						
						if ([_randomItem,_amountGot] call TNL_finv_addInventoryItem) then
						{
							_result = true;
							[player, [player], 15, format[_successLocalMessage, (name player) call TNL_fplayer_formatName, (_amountGot), (_randomItem) call TNL_finv_getItemName]] call TNL_fnet_HintToClientsInDistanceOfObject;
							[format[_successMessage, (_randomItem) call TNL_finv_getItemName, (_amountGot)]] call TNL_fextHint_Hint;
						}
						else
						{
							_result = false;
							hint "You would be over weight...";
							
							if (_selectedItemConsumesItem) then
							{
								[_itemSelectedItemConsumes,+(_amountOfItemConsumes)] call TNL_finv_addInventoryItem;
							};
						};
					}
					else
					{
						_result = false;
						if (_getSkillOnFail) then
						{
							[_usesSkill, ((_usesSkill) call TNL_fskills_getFailIncrease)] call TNL_fskills_increaseSkill;
						};
						[_failMessageDueToItems] call TNL_fextHint_Hint;
						[player, [player], 15, format[_failLocalMessage, (name player) call TNL_fplayer_formatName]] call TNL_fnet_HintToClientsInDistanceOfObject;
					};
				}
				else //fail
				{
					if (_getSkillOnFail) then
					{
						[_usesSkill, ((_usesSkill) call TNL_fskills_getFailIncrease)] call TNL_fskills_increaseSkill;
					};
					
					if ((_itemConsumedOnFail) && (_selectedItemConsumesItem) && (_hasItemsAvailable)) then
					{
						[_itemSelectedItemConsumes,-(_amountOfItemConsumes)] call TNL_finv_addInventoryItem;
					};
					
					if !(_hasItemsAvailable) then
					{
						[_failMessageDueToItems] call TNL_fextHint_Hint;
					}
					else
					{
						[_failMessage] call TNL_fextHint_Hint;
					};
						[player, [player], 15, format[_failLocalMessage, (name player) call TNL_fplayer_formatName]] call TNL_fnet_HintToClientsInDistanceOfObject;
					_result = false;
				};
				
				if (_decreasesHunger) then
				{
					[(random _amountHungerDecreasesBy)] call TNL_fhunger_decreaseHunger;
				};
				
				if (_decreasesThirst) then
				{
					[(random _amountThirstDecreasesBy)] call TNL_fthirst_decreaseThirst;
				};
			}
			else
			{
				["You have moved too far away"] call TNL_fextHint_Hint;
				_result = false;
			};
			TNL_gVar_bool_gatheringItems = false;
		}
		else
		{
			[format["You cannot do this, you require these items: %1", _message]] call TNL_fextHint_Hint;
		};
	}
	else
	{
		if (!(_error)) then
		{
			["You are already gathering items!"] call TNL_fextHint_Hint;
		};
	};
	
};
	TNL_gVar_pay_doneAction = true;
	if (!_error) then { GatherResult = [_result,_randomItem,_amountGot]; };
};