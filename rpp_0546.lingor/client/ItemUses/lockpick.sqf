_item = (_this select 0);
_amount = 0;
_vcl = empty;
_nearestObjects = nearestObjects [player, ["AllVehicles"], 4];
_found = false;

closeDialog 0;

if (isNil "TNL_gVar_bool_lockpicking") then
{
	TNL_gVar_bool_lockpicking = false;
};

if (count _nearestObjects >= 2) then
{
	_vcl = (_nearestObjects select 1);
};

if (_vcl == empty) exitWith
{
	//Message no vehicle
	["No vehicle nearby"] call TNL_fextHint_Hint;
};

if (player != vehicle player) exitWith
{
	["You are already in a vehicle"] call TNL_fextHint_Hint;
	//Cannot do in vehicle
};

{
	if (_x select 0 == _vcl) then
	{
		_found = true;
	};
} foreach Gvar_arr_inv_ownedVehicles;

if (_found) exitWith
{
	["You already own the vehicle"] call TNL_fextHint_Hint;
};

_startMessage = "%1 has started lockpicking a vehicle!";
_skill = "lockpicking" call TNL_fskills_getSkill; 
_chance = random 100;
_succeedChance = 10;
_totalChance = _succeedChance + _skill;
_lockpickTime = (100 - _skill);
[{(_this select 0) switchMove "ActsPercSnonWnonDnon_assembling";}, [player]] call TNL_fnet_execPublic;

[player, [player], 6, format[_startMessage, (name player) call TNL_fplayer_formatName]] call TNL_fnet_HintToClientsInDistanceOfObject;

_counter = 1;
_failure = false;
while {_counter <= _lockpickTime} do
{
	if (!alive player) exitWith
	{
		_failure = true;
	};
			
	if (!alive _vcl) exitWith
	{
		_failure = true;
		["Vehicle was destroyed"] call TNL_fextHint_Hint;
	};
			
	if (player != vehicle player) exitWith
	{
		_failure = true;
		["You cant do this while in a vehicle"] call TNL_fextHint_Hint;
	};
			
	if (player distance getpos(_vcl) >= 5) exitWith
	{
		_failure = true;
		["You have moved too far away"] call TNL_fextHint_Hint;
	};
			
	_animState = animationState player;
	if (_animState != "ActsPercSnonWnonDnon_assembling") exitWith
	{
		_failure = true;
		["You stop lockpicking the vehicle"] call TNL_fextHint_Hint;
	};
			
	titleText [format["Lockpicking... time remaining: %1", ((round (_lockpickTime)) - _counter)], "PLAIN"];
			
	sleep 1;
	_counter = _counter + 1;
};

if (!(_failure)) then
{
	if (_chance <= _totalChance) then
	{
		//Success
		[{(_this select 0) lock false}, [_vcl]] call TNL_fnet_execPublic;
		["lockpicking", ("lockpicking" call TNL_fskills_getNormalIncrease)] call TNL_fskills_increaseSkill;
		["You have lockpicked the vehicle successfully"] call TNL_fextHint_Hint;
		_random = random 100;
		
		if (_random <= 50) then
		{
			_vcl say3D "SndCarAlarm";
		};
	}
	else //Failure
	{
		["You break the lockpick!"] call TNL_fextHint_Hint;
		["lockpicking", ("lockpicking" call TNL_fskills_getFailIncrease)] call TNL_fskills_increaseSkill;
		[_item,-1] call TNL_finv_addInventoryItem;
	};

	[{(_this select 0) switchMove "AmovPercMstpSnonWnonDnon";}, [player]] call TNL_fnet_execPublic;
};







