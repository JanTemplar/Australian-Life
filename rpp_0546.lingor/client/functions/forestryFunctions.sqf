//Copyright (C) 2009  Matthew Simms & Petr Klíma

/*
	* Type: Function
	* Name: TNL_fforestry_plantSprout
	* Description: Begins the planting cycle for forestry trees and bushes by creating object and executes growth cycle for it
	* Parameters: 
		(0) Item class of the sprout (string)
	* Returns: nothing
*/
TNL_fforestry_plantSprout = 
{
	private ["_sproutClass", "_sproutType", "_growClass", "_surfaceType", "_modelClass", "_random", "_deathChance", "_nearestObjects"];
	_sproutClass = (_this select 0);
	_sproutType = (_sproutClass) call TNL_fforestry_getSproutType;
	_growClass = (_sproutClass) call TNL_fforestry_getSproutGrowClass;
	_surfaceType = surfaceType getpos player;
	_modelClass = (_sproutClass) call TNL_fforestry_getModelGrowClass;
	_random = (random 100);
	_deathChance = (_sproutClass) call TNL_fforestry_getGrowthDeathChance;
	_nearestObjects = nearestObjects [player, [_modelClass], 6];
	
	closeDialog 0;

	if (count _nearestObjects <= 0) then
	{	
		if !((player) call TNL_fplayer_inVehicle) then
		{
			if (_surfaceType in TNL_gVar_arr_forestry_plantableSurfaceTypes) then
			{
				[_sproutClass, 1] call TNL_finv_takeItemAmount;
				if (_random > _deathChance) then
				{
					_varName = format["plant_%1_%2_%3_%4", (round(position player select 0)), (round(position player select 1)), (round(position player select 2)), _sproutClass];
					_object = _modelClass createVehicle position player;
					_object setPos [position player select 0, position player select 1, TNL_gVar_int_forestry_plantStartHeight];
					call compile format['_object setVehicleInit "this setVehicleVarName ""%1""; _object = this; destroyAction = this addAction [""Destroy"", ""client\useAction.sqf"", [""forestry_destroy"", this]];";', _varName];
					processInitCommands;	
					[_object, (_sproutClass) call TNL_fforestry_getGrowthTime, _sproutClass, (_sproutClass) call TNL_fforest_getSproutGrowthChance] spawn TNL_fforestry_GrowthCycle;
					[format["You have planted a %1 here, It will now start to grow and have a chance of growing sprouts on it", (_sproutClass) call TNL_finv_getItemName]] call TNL_fextHint_Hint;
				}	
				else
				{
					["You tried your best to plant the sprout, but it has died"] call TNL_fextHint_Hint;
				};
			}	
			else
			{
				["You cannot plant a sprout on this terrain type"] call TNL_fextHint_Hint;
			};
		}
		else
		{
			["You cannot plant a sprout whilst in a vehicle"] call TNL_fextHint_Hint;
		};
	}
	else
	{
		["You cannot plant here, there is something already planted around here"] call TNL_fextHint_Hint;
	};
};

/*
	* Type: Function
	* Name: TNL_fforestry_destroyPlant
	* Description: Cuts the tree/bush down before it has chance to grow
	* Parameters: 
		(0) The plant object to be destroyed (object)
	* Returns: nothing
*/
TNL_fforestry_destroyPlant = 
{
	private ["_object", "_itemAmount"];
	_object = (_this select 0);
	_itemAmount = "hatchet" call TNL_finv_getItemAmount;
	
	if (_itemAmount > 0) then
	{
		["You cut the plant down, killing it before it had chance to grow"] call TNL_fextHint_Hint;
		deleteVehicle _object;
	} 
	else
	{
		["You require a hatchet to cut down this"] call TNL_fextHint_Hint;
	};
};

/*
	* Type: Function
	* Name: TNL_fforestry_GrowthCycle
	* Description: Starts the growth cycle for the bush/tree
	* Parameters: 
		(0) Object of the growing bush/tree (object)
		(1) Growth time for the bush/tree (int)
		(2) Item class of the growing sprout (string)
		(3) Chance for a sprout to grow on it every growth cycle (int)
	* Returns: nothing
*/
TNL_fforestry_GrowthCycle =
{
	private ["_object", "_growthTime", "_sproutClass", "_growthChance", "_sproutType", "_plantName", "_growthSproutClass", "_itemReq", "_growCycleTime", "_increasedHeightAmount", "_i"];
	_object = (_this select 0);
	_growthtime = (_this select 1);
	_sproutClass = (_this select 2);
	_growthChance = (_this select 3);
	_sproutType = (_sproutClass) call TNL_fforestry_getSproutType;
	_plantName = (_sproutClass) call TNL_fforestry_getPlantName;
	_growthSproutClass = (_sproutClass) call TNL_fforest_getGrowthSproutClass;
	_itemReq = (_sproutClass) call TNL_fforest_getRequiredItemToPickSprout;
	
	private ["_growCycleTime", "_increaseHeightAmount"];
	_growCycleTime = _growthTime / TNL_gVar_int_forestry_numGrowthCycles;
	_increaseHeightAmount = TNL_gVar_int_forestry_plantStartHeight / TNL_gVar_int_forestry_numGrowthCycles;
	
	private ["_i"];
	_i = 0;
	
	_object setVariable["numSprouts", 0, true];
	_object setVariable["sproutType", _growthSproutClass, true];
	_object setVariable["sproutReqItem", _itemReq, true];
	
	while {_i < TNL_gVar_int_forestry_numGrowthCycles} do 
	{
		sleep _growCycleTime;
		_rand = (random 100);
		if (_rand <= _growthChance) then { _object setVariable["numSprouts", (_object getVariable "numSprouts")+1, true]; };
		
		if ((getTerrainHeightASL (getPosASL _object)) < ((getposASL _object) select 2)) then
		{
			_increaseHeightAmount = 0;
		}
		else
		{
			_object setpos [position _object select 0, position _object select 1, (position _object select 2)+ (abs _increaseHeightAmount)];
		};
		_i = _i + 1;
	};
	
	if (_sproutType == "TREE") then
	{
		[_object, _sproutClass] call TNL_fforestry_setupTree;
	}
	else
	{
		[_object, _sproutClass] call TNL_fforestry_setupBush;
	};
};

/*
	* Type: Function
	* Name: TNL_fforestry_setupTree
	* Description: Sets up the tree after it has finished growing
	* Parameters: 
		(0) Object of the tree (object)
		(1) Sprout class (string)
	* Returns: nothing
*/
TNL_fforestry_setupTree = 
{
	private ["_object", "_sproutClass", "_plantName", "_growClass", "_gatherValues", "_skillUsed", "_decreasedDamagePerSkill", "_skillAmount", "_totalDamage", "_itemClass", "_minAmount", "_maxAmount", "_total"];
	_object = (_this select 0);
	_sproutClass = (_this select 1);
	_plantName = (_sproutClass) call TNL_fforestry_getPlantName;
	_growClass = (_sproutClass) call TNL_fforestry_getSproutGrowClass;
	_gatherValues = (_growClass) call TNL_fforestry_treeGetGatherValues;
	_skillUsed = (_growClass) call TNL_fforestry_treeGetUsedSkill;
	_decreasedDamagePerSkill = (_growClass) call TNL_fforestry_treeGetDecreasedDamagePerSkill;
	_skillAmount = (_skillUsed) call TNL_fskills_getSkill;
	_totalDamage = ((100) - (_skillAmount * _decreasedDamagePerSkill));
	_itemClass = (_gatherValues select 0);
	_minAmount = (_gatherValues select 1);
	_maxAmount = (_gatherValues select 2);
	_total = (floor(random((_maxAmount - _minAmount)+ _minAmount)));
	if (_total <= 0) then { _total = 1; };
	_object setVariable["grownFrom", _sproutClass, true];
	_object setVariable["class", _growClass, true];
	_object setVariable["numResources", _total, true];
	_object setVariable["resourceClass", _itemClass, true];
	_object setVariable["damage", _totalDamage, true];
	
	call compile format['
		_object setVehicleInit "this removeAction destroyAction;
								this addAction [""Cut down %1"", ""client\useAction.sqf"", [""forestry_cutdown"", this], 6];
								
								if ((this getVariable ""numSprouts"") > 0) then
								{
									sproutAction = this addAction [""Pick sprout off %1"", ""client\useAction.sqf"", [""forestry_picksprout"", this], 6];
								};";
							', _plantName];
	processInitCommands;
};

/*
	* Type: Function
	* Name: TNL_fforestry_setupBush
	* Description: Sets up the bush after it has finished growing
	* Parameters: 
		(0) Object of the bush (object)
		(1) Sprout class (string)
	* Returns: nothing
*/
TNL_fforestry_setupBush = 
{
	private ["_object", "_sproutClass", "_plantName", "_plantName", "_growClass", "_gatherValues", "_deathValues", "_usedSkill", "_harvestValues", "_skillAmount", "_minAmount", "_maxAmount", "_itemClass", "_total", "_maxGatheredTillDeath", "_deathLimitIncreasesBy", "_perSkillDeathLimitIncreases", "_increase", "_totalIncrease"];
	_object = (_this select 0);
	_sproutClass = (_this select 1);
	_plantName = (_sproutClass) call TNL_fforestry_getPlantName;
	_growClass = (_sproutClass) call TNL_fforestry_getSproutGrowClass;
	_gatherValues = (_growClass) call TNL_fforestry_bushGetGatherValues;
	_deathValues = (_growClass) call TNL_fforestry_bushGetDeathValues;
	_usedSkill = (_growClass) call TNL_fforestry_bushGetUsedSkill;
	_harvestValues = (_growClass) call TNL_fforestry_getHarvestCycleValues;
	_skillAmount = (_usedSkill) call TNL_fskills_getSkill;
	_minAmount = (_gatherValues select 0);
	_maxAmount = (_gatherValues select 1);
	_itemClass = (_gatherValues select 2);
	_total = (floor(random((_maxAmount - _minAmount)+ _minAmount)));
	_maxGatheredTillDeath = (_deathValues select 0);
	_deathLimitIncreasesBy = (_deathValues select 1);
	_perSkillDeathLimitIncreases = (_deathValues select 2);
	if (_total <= 0) then { _total = 1; };
	
	[{ if (isServer) then { TNL_gVar_arr_forestry_serverBushes = TNL_gVar_arr_forestry_serverBushes + [ [(_this select 0), (_this select 1), (_this select 2), (_this select 3), time] ]; }; }, [_object, (_harvestValues select 0), (_harvestValues select 1), (_harvestValues select 2)]] call TNL_fnet_execPublic;
	
	_increase = floor(_skillAmount / _deathLimitIncreasesBy);
	_totalIncrease = (((_increase) * (_perSkillDeathLimitIncreases)) + _maxGatheredTillDeath);

	_object setVariable["grownFrom", _sproutClass, true];
	_object setVariable["class", _growClass, true];
	_object setVariable["deathMax", _totalIncrease, true];
	_object setVariable["curHarvested", 0, true];
	_object setVariable["maxCapacity", _total, true];
	_object setVariable["resourceClass", _itemClass, true];
	_object setVariable["numResources", 0, true];

	call compile format['
		_object setVehicleInit "this removeAction destroyAction;
								this addAction [""Harvest %1"", ""client\useAction.sqf"", [""forestry_harvest"", this], 6];
							if ((this getVariable ""numSprouts"") > 0) then
							{
								sproutAction = this addAction [""Pick sprout off %1"", ""client\useAction.sqf"", [""forestry_picksprout"", this], 6];
							};
								this addAction [""Check %1"", ""client\useAction.sqf"", [""forestry_checkBush"", this], 6];";
							', _plantName];
	processInitCommands;
};

/*
	* Type: Function
	* Name: TNL_fforestry_checkBush
	* Description: Checks the fruit on the bush and displays a hint with the amount of fruit
	* Parameters: 
		(0) Object of the bush (object)
	* Returns: nothing
*/
TNL_fforestry_checkBush =
{
	private ["_object", "_numResources", "_resourceClass", "_sproutclass", "_plantName"];
	_object = (_this select 0);
	_numResources = _object getVariable "numResources";
	_resourceClass = _object getVariable "resourceClass";
	_sproutClass = (_object) getVariable "grownFrom";
	_plantName = (_sproutClass) call TNL_fforestry_getPlantName;
	
	if (_numResources > 0) then
	{
		[format["You see %1 %2(s) on the %3.", _numResources, (_resourceClass) call TNL_finv_getItemName, _plantName]] call TNL_fextHint_Hint;
	}
	else
	{
		[format["You see nothing on the %1", _plantName]] call TNL_fextHint_Hint;
	};
};

/*
	* Type: Function
	* Name: TNL_fforestry_harvestBush
	* Description: Harvests 1 fruit from the bush
	* Parameters: 
		(0) Object of the bush (object)
	* Returns: nothing
*/
TNL_fforestry_harvestBush = 
{
	private ["_object", "_resourceAmount", "_resourceClass", "_bushClass", "_requiredItem", "_timeToHarvest", "_timeDecreasePerSkill", "_usedSkill", "_skillAmount", "_harvestAnim", "_optimalSkillRange", "_itemAmount", "_sproutClass", "_plantName", "_totalTime"];
	_object = (_this select 0);
	_resourceAmount = (_object) getVariable "numResources";
	_resourceClass = (_object) getVariable "resourceClass";
	_bushClass = (_object) getVariable "class";
	_requiredItem = (_bushClass) call TNL_fforestry_getBushRequiredItem;
	_timeToHarvest = (_bushClass) call TNL_fforestry_getBushTimeToHarvest;
	_timeDecreasePerSkill = (_bushClass) call TNL_fforestry_getBushTimeIncreasedPerSkill;
	_usedSkill = (_bushClass) call TNL_fforestry_bushGetUsedSkill;
	_skillAmount = (_usedSkill) call TNL_fskills_getSkill;
	_harvestAnim = (_bushClass) call TNL_fforestry_getBushHarvestAnim;
	_optimalSkillRange = (_bushClass) call TNL_fforestry_getBushOptimalSkillGain;
	_itemAmount = 0;
	_sproutClass = (_object) getVariable "grownFrom";
	_plantName = (_sproutClass) call TNL_fforestry_getPlantName;
	_totalTime = ((_timeToHarvest) - ((_skillAmount * _timeDecreasePerSkill)));
	
	if (_requiredItem != "") then
	{
		_itemAmount = (_requiredItem) call TNL_finv_getItemAmount;
	};
	
	if ((_itemAmount > 0) || (_requiredItem == "")) then
	{
		if !(TNL_gVar_bool_cuttingTree) then
		{	
			if (_resourceAmount > 0) then
			{
				TNL_gVar_bool_cuttingTree = true;
				[format["You start to harvest the %1", _plantName, ((round(_totalTime * 100))/100)]] call TNL_fextHint_Hint;
		
				[{ (_this select 0) switchMove (_this select 1); }, [player, _harvestAnim]] call TNL_fnet_execPublic;
		
				sleep _totalTime;
			
				if (player distance _object <= 12) then
				{
					if (((_object) getVariable "numResources") >= 1) then
					{
						if ([_resourceClass, 1] call TNL_finv_addInventoryItem) then
						{
							[_usedSkill, ((_usedSkill) call TNL_fskills_getReducedIncrease)] call TNL_fskills_increaseSkill;
							_object setVariable ["numResources",((_object getVariable "numResources")-1), true];
							_object setVariable ["curHarvested", ((_object getVariable "curHarvested") +1), true];
							[format["You have gathered %1 %2(s) from the %3.", 1, (_resourceClass) call TNL_finv_getItemName, _plantName]] call TNL_fextHint_Hint;
							
							_deathMax = (_object) getVariable "deathMax";
							_curHarvested = (_object) getVariable "curHarvested";
							
							if (_deathMax <= _curHarvested) then
							{
								if ((_skillAmount >= (_optimalSkillRange select 0)) && (_skillAmount <= (_optimalSkillRange select 1))) then
								{
									[_usedSkill, ((_usedSkill) call TNL_fskills_getOptimalIncrease)] call TNL_fskills_increaseSkill;
								}
								else
								{
									[_usedSkill, ((_usedSkill) call TNL_fskills_getNormalIncrease)] call TNL_fskills_increaseSkill;
								};
							
								[format["The %1 has died", _plantName]] call TNL_fextHint_Hint;
								deleteVehicle _object;
							};
						};
					};
				}
				else
				{
					["You moved too far away"] call TNL_fextHint_Hint;
				};
			}
			else
			{
				["You there is nothing left to harvest"] call TNL_fextHint_Hint;
			};
			TNL_gVar_bool_cuttingTree = false;
		}
		else
		{
			["You are already doing a action"] call TNL_fextHint_Hint;
		};
	}
	else
	{
		[format["You require the item %1 to do this", (_requiredItem) call TNL_finv_getItemName]] call TNL_fextHint_Hint;
	};
};

TNL_fforestry_cutTree =
{
	private ["_object", "_damage", "_resourceAmount", "_resourceClass"];
	_object = (_this select 0);
	_resourceAmount = (_object) getVariable "numResources";
	_resourceClass = (_object) getVariable "resourceClass";
	_treeClass = (_object) getVariable "class";
	_requiredItem = (_treeClass) call TNL_fforestry_getTreeRequiredItem;
	_timeToCut = (_treeClass) call TNL_fforestry_getTreeCuttingTime;
	_timeDecreasedPerSkill = (_treeClass) call TNL_fforestry_getTreeCuttingTimeDecreasedPerSkill;
	_damagePerHit = (_treeClass) call TNL_fforestry_getTreeDamagePerHit;
	_usedSkill = (_treeClass) call TNL_fforestry_treeGetUsedSkill;
	_skillAmount = (_usedSkill) call TNL_fskills_getSkill;
	_itemAmount = 0;
	_optimalSkill = (_treeClass) call TNL_fforestry_getTreeOptimalSkillRange;
	_totalTime = ((_timeToCut) - ((_skillAmount * _timeDecreasedPerSkill)));
	_anims = (_treeClass) call TNL_fforestry_getTreeAnimations;
	
	if (_totalTime < 0) then { _totalTime = 0; };
	
	if (_requiredItem != "") then
	{
		_itemAmount = (_requiredItem) call TNL_finv_getItemAmount;
	};
	
	if ((_itemAmount > 0) || (_requiredItem == "")) then
	{
		if !(TNL_gVar_bool_cuttingTree) then
		{
			TNL_gVar_bool_cuttingTree = true;
			
			[{ (_this select 0) switchMove (_this select 1); }, [player, (_anims select 0)]] call TNL_fnet_execPublic;
			
			[format["You start chopping at the tree", ((round(_totalTime * 100))/100)]] call TNL_fextHint_Hint;
			sleep _totalTime;
			_damage = (_object) getVariable "damage";
			_totalDamage = ((_damage) - (random(_damagePerHit)));
			
			if (player distance _object <= 12) then
			{
				if (_totalDamage <= 0) then
				{
					_trunkClass = (_treeClass) call TNL_fforestry_getTreeTrunkClass;
					_trunk = _trunkClass createVehicle getpos _object;
					waitUntil {alive _trunk};
					_trunk setpos [position _object select 0, position _object select 1, position _object select 2];
					[format["You cut down the tree, you think the trunk could be cut up into %1 logs", _resourceAmount]] call TNL_fextHint_Hint;
					deleteVehicle _object;
					
					if ((_skillAmount >= (_optimalSkill select 0)) && (_skillAmount <= (_optimalSkill select 1))) then
					{
						[_usedSkill, ((_usedSkill) call TNL_fskills_getOptimalIncrease)] call TNL_fskills_increaseSkill;
					}
					else
					{
						[_usedSkill, ((_usedSkill) call TNL_fskills_getNormalIncrease)] call TNL_fskills_increaseSkill;
					};
					
					
					_varName = format["treetrunk_%1_%2_%3", (round(position player select 0)), (round(position player select 1)), (round(position player select 2))];
					call compile format['_trunk setVehicleInit "this setVehicleVarName ""%1""; _trunk = this; this addAction [""Chop up"", ""client\useAction.sqf"", [""forestry_chopup"", this]];";', _varName];
					player reveal _trunk;
					processInitCommands;
					
					_trunk setVariable["resourceClass", _resourceClass, true];
					_trunk setVariable["numResources", _resourceAmount, true];
					_trunk setVariable["class", _treeClass, true];
					
				}
				else
				{
					[_usedSkill, ((_usedSkill) call TNL_fskills_getReducedIncrease)] call TNL_fskills_increaseSkill;
					[format["You chip the tree, tree damage: %1", ((round(_totalDamage * 100))/100)]] call TNL_fextHint_Hint;
					_object setVariable["damage", _totalDamage, true];
				};
			}
			else
			{
				["You moved too far away"] call TNL_fextHint_Hint;
			};
		TNL_gVar_bool_cuttingTree = false;
		}
		else
		{
			["You are already doing a action"] call TNL_fextHint_Hint;
		};	
	}
	else
	{
		[format["You require the item %1 to do this", (_requiredItem) call TNL_finv_getItemName]] call TNL_fextHint_Hint;
	};
};

TNL_fforestry_chopTreeTrunk = 
{
	private ["_object"];
	_object = (_this select 0);
	_treeClass = (_object) getVariable "class";
	_anims = (_treeClass) call TNL_fforestry_getTreeAnimations;
	_requiredItem = (_treeClass) call TNL_fforestry_getTreeRequiredItem;
	_itemAmount = 0;

	if (_requiredItem != "") then
	{
		_itemAmount = (_requiredItem) call TNL_finv_getItemAmount;
	};
	
	if !(TNL_gVar_bool_cuttingTree) then
	{
		if ((_itemAmount > 0) || (_requiredItem == "")) then
		{
			["You start chopping the fallen tree into logs"] call TNL_fextHint_Hint;
			TNL_gVar_bool_cuttingTree = true;
			[{ (_this select 0) switchMove (_this select 1); }, [player, (_anims select 1)]] call TNL_fnet_execPublic;
			sleep 2;
			TNL_gVar_bool_cuttingTree = false;
			_numResources = (_object) getVariable "numResources";
			_resourceClass = (_object) getVariable "resourceClass";
		
			if ([_resourceClass,1] call TNL_finv_addInventoryItem) then
			{
				[format["You manage to chop 1 %1 from the fallen tree", (_resourceClass) call TNL_finv_getItemName]] call TNL_fextHint_Hint;
				_object setVariable ["numResources", ((_numResources)-1), true];

				if (((_numResources)-1) <= 0) then
				{
					deleteVehicle _object;
				};
			};
		};
	}
	else
	{
		["You are already doing a action"] call TNL_fextHint_Hint;
	};
			

};


TNL_fforestry_pickSprout = 
{
	private ["_object", "_sproutClass", "_requiredItem", "_numSprouts", "_sproutName", "_canPick"];
	_object = (_this select 0);
	_sproutClass = (_object) getVariable "sproutType";
	_requiredItem = (_object) getVariable "sproutReqItem";
	_numSprouts = (_object) getVariable "numSprouts";
	_sproutName = (_sproutClass) call TNL_finv_getItemName;
	_canPick = true;
	
	if (_requiredItem != "") then
	{
		if ((_requiredItem) call TNL_finv_getItemAmount <= 0) then
		{
			[format["You require the item %1 to pick the sprouts from this", ((_requiredItem) call TNL_finv_getItemName)]] call TNL_fextHint_Hint;
			_canPick = false;
		};
	
	};
	
	if (_canPick) then
	{
		if (_numSprouts > 0) then
		{
			if ([_sproutClass,1] call TNL_finv_addInventoryItem) then
			{
				_object setVariable["numSprouts", (_object getVariable "numSprouts")-1, true];
				[format["You pick 1 %1 from this, there is %2 sprout(s) left", _sproutName, (_numSprouts)-1]] call TNL_fextHint_Hint;
			};
		}
		else
		{
			
			["There is no sprouts left to pick"] call TNL_fextHint_Hint;
		};
	};
	
	if ((_object getVariable "numSprouts") <= 0) then
	{
		_object setVehicleInit "this removeAction sproutAction;";
		processInitCommands;
	};

};

TNL_fforestry_getHarvestCycleValues = 
{
	private ["_bushClass", "_return"];
	_bushClass = (_this);
	_return = [];

	{
		if ((_x select 0) == _bushClass) then 
		{
			_return = (_x select 7);
		};
	} forEach TNL_gVar_arr_forestry_bushes;

	_return
};

TNL_fforestry_getBushHarvestAnim = 
{
	private ["_bushClass", "_return"];
	_bushClass = (_this);
	_return = [];

	{
		if ((_x select 0) == _bushClass) then 
		{
			_return = (_x select 9);
		};
	} forEach TNL_gVar_arr_forestry_bushes;

	_return
};

TNL_fforestry_getBushOptimalSkillGain = 
{
	private ["_bushClass", "_return"];
	_bushClass = (_this);
	_return = [];

	{
		if ((_x select 0) == _bushClass) then 
		{
			_return = (_x select 4);
		};
	} forEach TNL_gVar_arr_forestry_bushes;

	_return
};

TNL_fforestry_getBushTimeIncreasedPerSkill = 
{	
	private ["_bushClass", "_return"];
	_bushClass = (_this);
	_return = [];

	{
		if ((_x select 0) == _bushClass) then 
		{
			_return = (_x select 6);
		};
	} forEach TNL_gVar_arr_forestry_bushes;

	_return
};

TNL_fforestry_bushGetUsedSkill = 
{
	private ["_bushClass", "_return"];
	_bushClass = (_this);
	_return = [];

	{
		if ((_x select 0) == _bushClass) then 
		{
			_return = ((_x select 3) select 0);
		};
	} forEach TNL_gVar_arr_forestry_bushes;

	_return
};

TNL_fforestry_getBushTimeToHarvest = 
{
	private ["_bushClass", "_return"];
	_bushClass = (_this);
	_return = [];

	{
		if ((_x select 0) == _bushClass) then 
		{
			_return = (_x select 5);
		};
	} forEach TNL_gVar_arr_forestry_bushes;

	_return
};

TNL_fforestry_getBushRequiredItem = 
{
	private ["_bushClass", "_return"];
	_bushClass = (_this);
	_return = [];

	{
		if ((_x select 0) == _bushClass) then 
		{
			_return = (_x select 8);
		};
	} forEach TNL_gVar_arr_forestry_bushes;

	_return
};

TNL_fforestry_bushGetDeathValues = 
{
	private ["_bushClass", "_return"];
	_bushClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _bushClass) then 
		{
			_return = (_x select 2);
		};
	} forEach TNL_gVar_arr_forestry_bushes;

	_return
};

TNL_fforestry_bushGetGatherValues = 
{
	private ["_bushClass", "_return"];
	_bushClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _bushClass) then 
		{
			_return = (_x select 1);
		};
	} forEach TNL_gVar_arr_forestry_bushes;

	_return
};

TNL_fforestry_treeGetDecreasedDamagePerSkill =
{
	private ["_treeClass", "_return"];
	_treeClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _treeClass) then 
		{
			_return = ((_x select 4) select 1);
		};
	} forEach TNL_gVar_arr_forestry_trees;

	_return
};

TNL_fforestry_getTreeAnimations =
{
	private ["_treeClass", "_return"];
	_treeClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _treeClass) then 
		{
			_return = (_x select 9);
		};
	} forEach TNL_gVar_arr_forestry_trees;

	_return
};

TNL_fforestry_getTreeOptimalSkillRange =
{
	private ["_treeClass", "_return"];
	_treeClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _treeClass) then 
		{
			_return = (_x select 5);
		};
	} forEach TNL_gVar_arr_forestry_trees;

	_return
};

TNL_fforestry_getTreeTrunkClass = 
{
	private ["_treeClass", "_return"];
	_treeClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _treeClass) then 
		{
			_return = ((_x select 1) select 0);
		};
	} forEach TNL_gVar_arr_forestry_trees;

	_return
};

TNL_fforestry_getTreeDamagePerHit = 
{
	private ["_treeClass", "_return"];
	_treeClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _treeClass) then 
		{
			_return = ((_x select 4) select 2);
		};
	} forEach TNL_gVar_arr_forestry_trees;

	_return
};

TNL_fforestry_getTreeCuttingTimeDecreasedPerSkill =
{
	private ["_treeClass", "_return"];
	_treeClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _treeClass) then 
		{
			_return = (_x select 7);
		};
	} forEach TNL_gVar_arr_forestry_trees;

	_return
};

TNL_fforestry_getTreeCuttingTime =
{
	private ["_treeClass", "_return"];
	_treeClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _treeClass) then 
		{
			_return = (_x select 6);
		};
	} forEach TNL_gVar_arr_forestry_trees;

	_return
};

TNL_fforestry_getTreeRequiredItem =
{
	private ["_treeClass", "_return"];
	_treeClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _treeClass) then 
		{
			_return = (_x select 8);
		};
	} forEach TNL_gVar_arr_forestry_trees;

	_return
};

TNL_fforestry_treeGetUsedSkill = 
{
	private ["_treeClass", "_return"];
	_treeClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _treeClass) then 
		{
			_return = ((_x select 4) select 0);
		};
	} forEach TNL_gVar_arr_forestry_trees;

	_return
};

TNL_fforestry_treeGetGatherValues = 
{
	private ["_treeClass", "_return"];
	_treeClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _treeClass) then 
		{
			_return = (_x select 3);
		};
	} forEach TNL_gVar_arr_forestry_trees;

	_return
};

TNL_fforestry_getPlantName = 
{
	private ["_sproutClass", "_return"];
	_sproutClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _sproutClass) then 
		{
			_return = (_x select 7);
		};
	} forEach TNL_gVar_arr_forestry_sprouts;

	_return
};


TNL_fforestry_getGrowthDeathChance = 
{
	private ["_sproutClass", "_return"];
	_sproutClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _sproutClass) then 
		{
			_return = (_x select 6);
		};
	} forEach TNL_gVar_arr_forestry_sprouts;

	_return
};


TNL_fforestry_getGrowthTime = 
{
	private ["_sproutClass", "_return"];
	_sproutClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _sproutClass) then 
		{
			_return = (_x select 4);
		};
	} forEach TNL_gVar_arr_forestry_sprouts;

	_return
};

TNL_fforest_getGrowthSproutClass = 
{
	private ["_sproutClass", "_return"];
	_sproutClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _sproutClass) then 
		{
			_return = ((_x select 5) select 0);
		};
	} forEach TNL_gVar_arr_forestry_sprouts;

	_return
};

TNL_fforest_getSproutGrowthChance = 
{
	private ["_sproutClass", "_return"];
	_sproutClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _sproutClass) then 
		{
			_return = ((_x select 5) select 1);
		};
	} forEach TNL_gVar_arr_forestry_sprouts;

	_return
};

TNL_fforest_getRequiredItemToPickSprout = 
{
	private ["_sproutClass", "_return"];
	_sproutClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _sproutClass) then 
		{
			_return = ((_x select 5) select 2);
		};
	} forEach TNL_gVar_arr_forestry_sprouts;

	_return
};

TNL_fforestry_getModelGrowClass =
{
	private ["_sproutClass", "_return"];
	_sproutClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _sproutClass) then 
		{
			_return = (_x select 3);
		};
	} forEach TNL_gVar_arr_forestry_sprouts;

	_return
};

TNL_fforestry_getSproutType = 
{
	private ["_sproutClass", "_return"];
	_sproutClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _sproutClass) then 
		{
			_return = (_x select 1);
		};
	} forEach TNL_gVar_arr_forestry_sprouts;

	_return
};

TNL_fforestry_getSproutGrowClass =
{
	private ["_sproutClass", "_return"];
	_sproutClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _sproutClass) then 
		{
			_return = (_x select 2);
		};
	} forEach TNL_gVar_arr_forestry_sprouts;

	_return
};

