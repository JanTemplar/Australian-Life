_item = (_this select 0);
_amount = 0;
_repairVcl = empty;
_nearestObjects = nearestObjects [player, ["AllVehicles"], 4];
_skill = "repair" call TNL_fskills_getSkill; 
_repairTime = ((100 - _skill) * 1.25);

closeDialog 0;

if (isNil "TNL_gVar_bool_repairing") then
{
	TNL_gVar_bool_repairing = false;
};

if (vehicle player != player) exitWith
{
	["Leave the vehicle to repair another vehicle"] call TNL_fextHint_Hint;
};

if (count _nearestObjects >= 2) then
{
	_repairVcl = (_nearestObjects select 1);
};

if (_repairVcl == empty) exitWith
{
	//Message no vehicle
	["No vehicle nearby"] call TNL_fextHint_Hint;
};

if (TNL_gVar_bool_repairing) exitWith
{
	["You are already repairing a vehicle"] call TNL_fextHint_Hint;
	//Already repairing
};

TNL_gVar_bool_repairing = true;

_posPlayerY = ((getPosATL player) select 2);
_posVehicleY = ((getPosATL _repairVcl) select 2);

if ((_posPlayerY + 0.10) <= _posVehicleY) then
{
	if ([player] call TNL_fplayer_inBuilding) then
	{
		//Public animation
		[{(_this select 0) switchMove "ActsPercSnonWnonDnon_carFixing";}, [player]] call TNL_fnet_execPublic;
		
		_counter = 1;
		_failure = false;
		_dmg = getDammage _repairVcl;
		
		while {_counter <= _repairTime} do
		{
			if (!alive player) exitWith
			{
				_failure = true;
			};
			
			if (!alive _repairVcl) exitWith
			{
				_failure = true;
				["Vehicle was destroyed"] call TNL_fextHint_Hint;
			};
			
			if (player != vehicle player) exitWith
			{
				_failure = true;
				["You cant do this while in a vehicle"] call TNL_fextHint_Hint;
			};
			
			if (player distance getpos(_repairVcl) >= 5) exitWith
			{
				_failure = true;
				["You have moved too far away"] call TNL_fextHint_Hint;
			};
			
			_animState = animationState player;
			if (_animState != "ActsPercSnonWnonDnon_carFixing") exitWith
			{
				_failure = true;
				["You stop repairing the vehicle"] call TNL_fextHint_Hint;
			};
			
			titleText [format["Repairing... time remaining: %1", (_repairTime - _counter)], "PLAIN"];
			
			sleep 2;
			_repairVcl say3D "SndRepair";
			_counter = _counter + 2;
		};
		
		if (!(_failure)) then
		{
			["Vehicle has been repaired"] call TNL_fextHint_Hint;
			[{(_this select 0) switchMove "AmovPercMstpSnonWnonDnon";}, [player]] call TNL_fnet_execPublic;
			["repair", ("repair" call TNL_fskills_getNormalIncrease)] call TNL_fskills_increaseSkill;
			[_item, -1] call TNL_finv_addInventoryItem;
			_repairVcl setDamage 0;
		};
			
	}
	else
	{
		["You are currently not in a building that supports repairing"] call TNL_fextHint_Hint;
	};
}
else
{
	["The vehicle must be raised above the ground to be repaired"] call TNL_fextHint_Hint;
};


TNL_gVar_bool_repairing = false;