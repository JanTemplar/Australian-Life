RPP_fnc_inFishingBoat =
{
	private ["_availableLocations", "_fishingMarkers"];

	if (isNil "RPP_bool_isFishing") then
	{
		RPP_bool_isFishing = false;
	};
	
	if (RPP_bool_isFishing) exitWith
	{
		//Already in boat
	};	
	
	if (RPP_bool_stopFishing) exitWith {};
	
	RPP_bool_isFishing = true;
	
	_pos = position fishing_logic;
	while {not (surfaceisWater _pos)} do
	{
		_pos = [vehicle player, 600, 600] call RPP_fnc_fishing_generateLocation;
	};
	
	_possibleItems = [];
	_toolsOnHand = [];
	{
		_tools = (_x select 0);
		_items = (_x select 1);
		
		{
			if ((_x call TNL_finv_getItemAmount) > 0) then
			{
				_toolsOnHand set[(count _toolsOnHand), _x];
				{
					_possibleItems set[(count _possibleItems), _x];
				} forEach _items;
			};
		} forEach _tools;
	} forEach RPP_arr_fishingTypes;
	
	if (count _toolsOnHand <= 0) exitWith { sleep 5; RPP_bool_isFishing = false; };
	
	["Your fishing radar has picked up a group of fish in the nearby area! follow the noise!"] call TNL_fextHint_Hint;
	
	_randomItem = [];
	while {((count _randomItem) <= 0)} do
	{
		_chance = random 100;
		
		_randomInArr = (round (random (count _possibleItems)));

		if (_randomInArr >= (count _possibleItems)) then
		{
			_randomInArr = _randomInArr - 1;
		};
		
		_randomItem = _possibleItems select _randomInArr;
		
		if (_chance <= (_randomItem select 2)) exitWith {};
		
		_randomItem = [];
	};

	if (count _randomItem <= 0) exitWith { sleep 10; RPP_bool_isFishing = false; };
	
	_item = (_randomItem select 0);
	_amount = (ceil(random (_randomItem select 1)));
	
	[_pos,_item,_amount] spawn RPP_fnc_fishing_startFishing;

	[] spawn RPP_fnc_fishing_waitUntilPlayerNotInBoat;
};


RPP_fnc_fishing_waitUntilPlayerNotInBoat =
{
	waitUntil {(not(typeOf (vehicle player) in ["Fishing_Boat"])) or (not (RPP_bool_isFishing)) or (!alive player)};

	RPP_bool_isFishing = false;
};

RPP_fnc_fishing_generateLocation = 
{
	private ["_obj", "_x", "_y", "_randomLocation"];
	_obj = _this select 0;
	_x = _this select 1;
	_y = _this select 2;
	_randomLocation = [((position _obj select 0)+((-_x)+(random (_x * 2)))),((position _obj select 1)+((-_y)+(random (_y * 2)))),0];

	_randomLocation
};

RPP_fnc_fishing_startFishing =
{
	private ["_location", "_item", "_amount", "_tick", "_foundLocation"];
	_location = _this select 0;
	_item = _this select 1;
	_amount = _this select 2;
	
	_tick = (vehicle player distance _location);
	_foundLocation = false;
	while {alive player} do
	{
		_distance = (vehicle player distance _location);
			
		if (_tick >= _distance) then
		{
			player say3D "SndFishBeep";
			_tick = 0;
		};
				
		if (_distance <= 20) exitWith
		{	
			_foundLocation = true;
		};

		if (not(RPP_bool_isFishing)) exitWith {};
				
		_tick = _tick + 5;
		sleep 0.1;
	};
	
	if (_foundLocation) then
	{
		_sleeper = 0;
		_failed = false;
		
		["Your fishing radar has found you a group of fish in this area, you begin fishing, dont move away or you will lose the catch!"] call TNL_fextHint_Hint;
		while {_sleeper <= 20} do
		{
			if (vehicle player distance _location > 30) then
			{
				_failed = true;
			};
				
			if (not(alive player)) then
			{
				_failed = true;
			};
				
			if (not(RPP_bool_isFishing)) then
			{
				_failed = true;
			};
				
			_sleeper = _sleeper + 1;
			sleep 1;
		};
			
		if (not(_failed)) then
		{
			_vehicleWeight = (vehicle player) getVariable "weight";
			_vehicleMaxWeight = (vehicle player) getVariable "maxweight";
			_itemWeight = _item call TNL_finv_getItemWeight;
			_itemTotalWeight = _itemWeight * _amount;
		
			if ((_itemTotalWeight + _vehicleWeight) >= _vehicleMaxWeight) then
			{
				_amount = round(((_vehicleMaxWeight - _vehicleWeight) / _itemTotalWeight) * _amount);
			};
			
			while {not ([vehicle player, _item, _amount] call TNL_ftrunk_addStorage)} do
			{
				["There is not enough room in your vehicle to get the catch!"] call TNL_fextHint_Hint;
				sleep 7;
			};
			
			[format["You have caught %2 %1s!", _item call TNL_finv_getItemName, _amount]] call TNL_fextHint_Hint;
		}
		else
		{
			["You unfortunately have lost the catch!"] call TNL_fextHint_Hint;
		};
	};

	//Fish

	//Stop fishing
	sleep ((30) + (random 180));
	RPP_bool_isFishing = false;
};