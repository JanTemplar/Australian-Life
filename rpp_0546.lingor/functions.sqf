/*
Name: functions.sqf
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.1 (2009/05/29)
Description: Core mission functions
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

TNL_net_varReady = false;

/*###########
Networking functions:
############*/

//Required for public functions to work:
"TNL_net_publicExecVar" addPublicVariableEventHandler
{
	(_this select 1) call TNL_fnet_execCommand;
	
};

TNL_fnet_execPublic =
{
	TNL_net_publicExecVar = _this;
	publicVariable "TNL_net_publicExecVar";
	_this call TNL_fnet_execCommand;
};

TNL_fnet_execCommand =
{
	private ["_function", "_params"];
	
	_function = _this select 0;
	
	if ((count _this) == 2) then
	{
		_params = _this select 1;
	}
	else
	{
		_params = [];
	};
	
	if ((typeName _function) == "STRING") then
	{
		_function = call compile (_this select 0);
	};
	
	_params call _function;
};

TNL_fnet_returnToClient = 
{	
	private ["_name", "_val"];
	
	_name = _this select 0;
	_val = _this select 1;

	if (typeName _name == "STRING") then
	{
		if (toLower _name == "server") then
		{
			[
				compile format ["
				if (isServer) then
				{
					TNL_net_returned = '%2';
					TNL_net_ready = true;
				};
				", _name, _val]
			] spawn TNL_fnet_execPublic;
		}
		else
		{
		
		};
	}
	else
	{
		[
			compile format ["
			if (player == %1) then
			{
				TNL_net_returned = '%2';
				TNL_net_ready = true;
			};
			", _name, _val]
		] spawn TNL_fnet_execPublic;
	};
};

TNL_fnet_playMove =
{
	try
	{
		(_this select 0) playMove (_this select 1);
	}
	catch
	{
		hint format ["Error in %1!\n\n%2", "TNL_fnet_playMove", _exception];
	};
};
TNL_fnet_switchMove =
{
	try
	{
		(_this select 0) switchMove (_this select 1);
	}
	catch
	{
		hint format ["Error in %1!\n\n%2", "TNL_fnet_switchMove", _exception];
	};
};
TNL_fnet_hint =
{
	try
	{
		hint format ["%1", _this select 0];
	}
	catch
	{
		hint format ["Error in %1!\n\n%2", "TNL_fnet_hint", _exception];
	};
};

/*
Add zeros in front of a number to a specified length
	* Parameters:
		number to modify <str>
		number of digits <int>
	* Returns: <string>
*/
TNL_fvar_addZeros =
{
	try
	{
		private ["_num", "_digits"];
		
		_num    = _this select 0;
		_digits = _this select 1;

		while {count (toArray _num) < _digits} do
		{
			_num = "0" + _num;
		};
		
		_num;
	}
	catch
	{
		hint format ["Error in %1!\n\n%2", "TNL_fvar_addZeros", _exception];
	};
};

/*
Return stance (standing, kneeling, prone) of a unit
	* Parameters:
		unit <object>
	* Returns:
		<string>
			"up" - standing
			"middle" - kneeling
			"down" - prone
			"other" - other
	* Example:
		_stance = player call TNL_fmisc_getStance;
*/
TNL_fmisc_getStance =
{
	_anim = toArray (animationState _this); //Get the animation name of the chosen unit and convert it to array of chars
	_stance = "other";
	
	if (count _anim > 8) then //We don't want zero divisor in case the anim name doesn't follow the standards and is <8 chars long
	{
		_anim = toLower (toString ([_anim select 5] + [_anim select 6] + [_anim select 7])); //Get the stance part from the anim name and convert to string
		
		switch (_anim) do
		{
			case "erc":
			{
				_stance = "up";
			};
			case "knl":
			{
				_stance = "middle";
			};
			case "pne":
			{
				_stance = "down";
			};
		};
	};
	
	_stance;
};

TNL_fmisc_formatDate = 
{
	private ["_date", "_return"];
	_date = (_this);
	_return = format["%1/%2/%3", _date select 2, _date select 1, _date select 0];
	_return
};


TNL_fcredits_start = 
{
	private ["_i"];
	
	/*
	createDialog "RscAnimatedLetters";
	disableUserInput true;
	setMousePosition [-1, -1]; 
	_i = 0;
	{
		if (_x == "END") then
		{
			_skip = 0;
			while {_skip <= 7} do
			{
				["", _skip] execVM "ca\data\scripts\credits\animateLetters.sqf";
				_skip = _skip + 1;
			};
			_i = 0;
		}
		else
		{
			[_x, _i] execVM "ca\data\scripts\credits\animateLetters.sqf";
		};
		
		if (_i == 7) then
		{
			_i = 0;
		};
		
		sleep 2;
		_i = _i + 1;
	} forEach TNL_gVar_arr_credits_names;
	disableUserInput false;
	closeDialog 0;
	
	*/
};