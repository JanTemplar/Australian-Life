_art = _this select 0;

// Place the Object
if (_art == "use") then
{
	_exitvar = 0;
	if (player != vehicle player) exitWith 
	{
		["You are in a vehicle..."] call TNL_fextHint_Hint;
	};
	
	{	
		if (player distance (_x select 0) < (_x select 1)) exitWith 
		{
		
			_exitvar = 1;
		};
	} forEach INV_PlacingVerbotArray;
	
	if (_exitvar == 1) exitWith 
	{
		["cannot place!"] call TNL_fextHint_Hint;
	};
	
	_item    = _this select 1;
	
	if ((count INV_objSpawned) >= INV_objMaxObject) exitWith
	{
		[format["You have placed too many objects the limit is %1",  INV_objMaxObject]] call TNL_fextHint_Hint;
	};
	
	_className = "";
	_distance = [];
	_height = [];
	_other = [];
	
	{
		if (_item == (_x select 0)) exitWith
		{
			_className = _x select 1;
			_distance = _x select 2;
			_height = _x select 3;
			_other = _x select 4;
		};
	} forEach INV_objItemScriptNames;
	
	if (_className == "" OR count _distance == 0 OR count _height == 0 OR count _other == 0) exitWith 
	{
		player groupchat "Error";
	};
	
	[_distance, _height, _other, _className, _item] execVM "slr\objPlace.sqf";
};

// Serverloop
if (_art == "Serverloop") then
{
		while {true} do
		{
			for [{_i=0}, {_i < count INV_objServerSpawned}, {_i=_i+1}] do
			{
				if (! (isNull ((INV_objServerSpawned select _i) select 0)) ) then
				{
					_obj  = ((INV_objServerSpawned select _i) select 0);
					_idle = ((INV_objServerSpawned select _i) select 1);
					_near = false;
					_exit = false;
					
					{
						if (!( isNull _x)) then
						{
							if ((_x distance _obj) < 50) exitWith
							{
								_near = true; _exit = true;
							};
						};
						if (_exit) exitWith {};
					} forEach ([] call TNL_cfplayer_activeSlots);
					
					if (!_near) then
					{
						_idle = _idle + 10;
					}
					else
					{
						_idle = 0;
					};
					
					(INV_objServerSpawned select _i) set [1, _idle];
					
					if (_idle > INV_objIdleTime) then
					{
						_obj call SLR_DeleteObject;
					};
				};
			};
			sleep 15.095;
		};
};


// Pick-up the Object
if (_art == "pack") then 
{
	_object = _this select 1;
	_className = typeOf _object;
	_exitvar   = 0;
	_item = "";
	{  
		if (_className == (_x select 1)) exitWith 
		{
			_item = _x select 0;
		}; 
	} forEach INV_objItemScriptNames;
	
	if (_item == "") exitWith 
	{
		["Error in inv_objs.sqf"] call TNL_fextHint_Hint;
	};
	
	if (!([_item, 1] call TNL_finv_addInventoryItem)) exitWith 
	{
		["Cannot pick up!"] call TNL_fextHint_Hint;
	};
	
	["Item packed!"] call TNL_fextHint_Hint;
	_object call SLR_DeleteObject;
};


