/*
==============================
TNL_fcvar_parseTime
==============================
Parse the provided time into a digital, 24-hour format
	* Parameters:
		Hours <int>
		Minutes <int>
		
	* Returns:
		Digital time <time>
		
	* Example:
		_time = [12,56] call TNL_fcvar_parseTime;
*/
//[__thisFile, format ["Bad input in TNL_fbank_createAcc: param - expected NUMBER, provided %1", typeName _owner]] call TNL_fcore_debug;
TNL_fcvar_parseTime =
{
		if (typeName _this != "ARRAY") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_parseTime: expected ARRAY OF PARAMETERS, provided %1", typeName _this]] call TNL_fcore_debug};
		if (count _this != 2) exitWith {[__thisFile, format ["Bad input in TNL_fcvar_parseTime: expected 2 parameters, provided %1", count _this]] call TNL_fcore_debug};
	private ["_hours", "_minutes", "_time"];
	
	_hours = _this select 0;	if (typeName _hours != "SCALAR") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_parseTime: param1 - expected NUMBER, provided %1", typeName _hours]] call TNL_fcore_debug};
	_minutes = _this select 1;	if (typeName _minutes != "SCALAR") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_parseTime: param2 - expected NUMBER, provided %1", typeName _minutes]] call TNL_fcore_debug};
	
	if (_minutes < 10) then
	{
		_minutes = format ["0%1", _minutes];
	};
	
	_time = format ["%1:%2", _hours, _minutes];
	_time
};

/*
==============================
TNL_fcenv_time
==============================
Return the current time in a digital, 24 hour format - 15:45
	* Parameters:
		-NONE-
		
	* Returns:
		Digital time <string>
		
	* Example:
		_time = [] call TNL_fcenv_time;
*/
TNL_fcenv_time =
{
	private ["_time", "_hours", "_minutes"];
	_hours = date select 3;
	_minutes = date select 4;
	
	if (_minutes < 10) then
	{
		_minutes = format ["0%1", _minutes];
	};
	
	_time = format ["%1:%2", _hours, _minutes];
	_time
};

/*
==============================
TNL_fcvar_arrayCompare
==============================
Compare 2 arrays between each other
	* Parameters:
		First array <array>
		Second array <array>
		
	* Returns:
		True if matches, false if not <bool>
		
	* Example:
		[ [1,2,3], [2,1,3] ] call TNL_fcvar_arrayCompare;
*/
TNL_fcvar_arrayCompare =
{
		if (typeName _this != "ARRAY") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_arrayCompare: expected ARRAY OF PARAMETERS, provided %1", typeName _this]] call TNL_fcore_debug};
		if (count _this != 2) exitWith {[__thisFile, format ["Bad input in TNL_fcvar_arrayCompare: expected 2 parameters, provided %1", count _this]] call TNL_fcore_debug};	
	private ["_array1", "_array2", "_i", "_return"];
	
	_array1 = _this select 0; if (typeName _array1 != "ARRAY") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_arrayCompare: param1 - expected ARRAY, provided %1", typeName _array1]] call TNL_fcore_debug};
	_array2 = _this select 1; if (typeName _array2 != "ARRAY") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_arrayCompare: param2 - expected ARRAY, provided %1", typeName _array2]] call TNL_fcore_debug};

	_return = true;
	if ( (count _array1) != (count _array2) ) then
	{
		_return = false;
	}
	else
	{
		_i = 0;
		while {_i < (count _array1) && _return} do
		{
			if ( (typeName (_array1 select _i)) != (typeName (_array2 select _i)) ) then
			{
				_return = false;
			}
			else
			{
				if (typeName (_array1 select _i) == "ARRAY") then
				{
					if (!([_array1 select _i, _array2 select _i] call TNL_fcvar_arrayCompare)) then
					{
						_return = false;
					};
				}
				else
				{
					if ((_array1 select _i) != (_array2 select _i)) then
					{
						_return = false;
					};
				};
			};
			_i = _i + 1;
		};
	};
	
	_return
};

/*
==============================
TNL_fcvar_parseNum
==============================
Parses a large number to a string (without +e thing)
	* Parameter: Number to modify <float>
		
	* Returns:
		Parsed number <string>
		
	* Example:
		1547419441 call TNL_fcvar_parseNum;
*/
TNL_fcvar_parseNum =
{
	private ["_num", "_i", "_new", "_neg", "_div"];
	
	_num = _this;	if (typeName _num != "SCALAR") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_parseNum: param - expected NUMBER, provided %1", typeName _num]] call TNL_fcore_debug};
	
	if (_num >= 1000000 || _num <= -1000000) then
	{
		_i = 0;
		_new = "";
		_neg = false;
		if (_num < 0) then
		{
			_num = _num * -1;
			_neg = true;
		};
		while {_num > 0} do
		{
			_div = _num % 10^(_i+1);
			_num = _num - _div;

			_new = format ["%1%2", _div / 10^_i, _new];

			_i = _i + 1;
		};
		if (_neg) then
		{
			_new = format ["-%1", _new];
		};
	}
	else
	{
		_new = str _num;
	};
	
	_new
};

/*
==============================
TNL_fcvar_addDigitSeparators
==============================
Add decimal separators to a number
	* Parameter: Number to modify <string> OR <float>
		
	* Returns:
		Number with separators <string>
		
	* Example:
		1547419441 call TNL_fcvar_addDigitSeparators;
*/
TNL_fcvar_addDigitSeparators =
{
	private ["_orig", "_chars", "_point", "_decimal", "_real", "_i", "_index"];
	
	_orig = _this;	if ((typeName _orig != "SCALAR") && (typeName _orig != "STRING")) exitWith {[__thisFile, format ["Bad input in TNL_fcvar_addDigitSeparators: param - expected NUMBER or STRING, provided %1", typeName _num]] call TNL_fcore_debug};
	if (typeName _orig != "STRING") then
	{
		_orig = _orig call TNL_fcvar_parseNum;
	};

	_chars = toArray _orig;
	
	_point = _chars find ((toArray ".") select 0);

	_decimal = [];
	_real = _chars;
	if (_point != -1) then
	{
		_i = _point + 1;
		while {_i < count _chars} do
		{
			_decimal = _decimal + [_chars select _i];
			_i = _i + 1;
		};
		_real resize _point;
	};

	_i = (count _real) - 3;
	_index = _i;
	while {_i > 0} do
	{
		_real = [_real, _index, (toArray ",") select 0] call TNL_fcvar_arrayPush;
		_i = _i - 3;
		_index = _index - (3 + 1);
	};
	
	if (count _decimal > 0) then
	{
		format ["%1.%2", toString _real, toString _decimal]
	}
	else
	{
		toString _real
	};
};

/*
==============================
TNL_fcmath_getBearing
==============================
Get the angle between one object an another
	* Parameters:
		Object to get bearing from <object>
		Static object to compute the bearing from <object>
		
	* Returns:
		Number with separators <string>
		
	* Example:
		_angle = [player, house1] call TNL_fcmath_getAngleToObject;
*/
TNL_fcmath_getBearing =
{
	private ["_static", "_obj", "_x1", "_y1", "_x2", "_y2", "_x", "_y", "_adj", "_ang"];
	_obj = _this select 0;	
	_static = _this select 1;

	_x1 = getPos _obj select 0;
	_y1 = getPos _obj select 1;
	_x2 = getPos _static select 0;
	_y2 = getPos _static select 1;
	_x = (_x2 - _x1);
	_y = (_y2 - _y1);

	_adj = sqrt (_x^2 + _y^2);

	if (_x < 0) then
	{
		_ang = acos (-_x / _adj);
		if (_y < 0) then
		{
			_ang = 360 - _ang;
		};
	}
	else
	{
		_ang = acos (_x / _adj);
		if (_y < 0) then
		{
			_ang = _ang + 180;
		}
		else
		{
			_ang = 180 - _ang;
		};
	};

	_ang = _ang + getDir _static;
	if (_ang > 360) then
	{
		_ang = _ang - 360;
	};
	if (_ang < 0) then
	{
		_ang = _ang + 360;
	};

	_ang
};


/*
==============================
TNL_fcvar_arrayFlip
==============================
Flips the array (first index will become the last)
	* Parameter: Array to be flipped <array>
		
	* Returns:
		Flipped array <array>
		
	* Example:
		_array = _array call TNL_fcvar_arrayFlip;
*/
TNL_fcvar_arrayFlip =
{
	private ["_array", "_new", "_i", "_j"];
	_array =+ _this;	if (typeName _array != "STRING") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_arrayFlip: param - expected ARRAY, provided %1", typeName _array]] call TNL_fcore_debug};
	
	_new = [];
	_i = (count _array) - 1;
	_j = 0;
	while {_i > 0} do
	{
		_new set [_j, _array select _i];
		_i = _i - 1;
		_j = _j + 1;
	};
	//hint str ([1,2] call TNL_fcvar_arrayFlip)
	_new
};

/*
==============================
TNL_fcvar_arrayPush
==============================
Push a value into an array
	* Parameters:
		Array to be operated with <array>
		Index where the value is to be pushed <integer>
		Value to be pushed in <any>
		
	* Returns:
		Changed array <array>
		
	* Example:
		_array = [1,3,4,5];
		_array = [_array, 1, 2] call TNL_fcvar_arrayPush;
		//_array = [1,2,3,4,5]
*/
TNL_fcvar_arrayPush =
{
		if (typeName _this != "ARRAY") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_arrayPush: expected ARRAY OF PARAMETERS, provided %1", typeName _this]] call TNL_fcore_debug};
		if (count _this != 3) exitWith {[__thisFile, format ["Bad input in TNL_fcvar_arrayPush: expected 3 parameters, provided %1", count _this]] call TNL_fcore_debug};	
	private ["_array", "_index", "_value", "_i", "_count", "_temp2", "_temp1"];
	
	_array = +_this select 0;	if (typeName _array != "ARRAY") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_arrayPush: param1 - expected ARRAY, provided %1", typeName _array]] call TNL_fcore_debug};
	_index = _this select 1;	if (typeName _index != "SCALAR") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_arrayPush: param2 - expected NUMBER, provided %1", typeName _array]] call TNL_fcore_debug};
	_value = _this select 2;
	
	_i = _index;	
	_count = count _array;
	_temp2 = _array select _i;
	while {_i < _count} do
	{
		_temp1 = _array select (_i + 1);
		_array set [_i + 1, _temp2];
		_temp2 = _temp1;
		
		_i = _i + 1;
	};
	
	_array set [_index, _value];
	_array
};

/*
==============================
TNL_fcvar_hasForbiddenChars
==============================
Search string for disallowed characters
	* Parameters:
		String to be checked <string>
		Allowed characters <string>
		
	* Returns:
		True if forbidden character(s) found, false is not <bool>
		
	* Example:
		_string = "abc1";
		_if = [_string, "abc"] call TNL_fcvar_hasForbiddenChars;
		// _if = true
*/
TNL_fcvar_hasForbiddenChars =
{
		if (typeName _this != "ARRAY") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_hasForbiddenChars: expected ARRAY OF PARAMETERS, provided %1", typeName _this]] call TNL_fcore_debug};
		if (count _this != 2) exitWith {[__thisFile, format ["Bad input in TNL_fcvar_hasForbiddenChars: expected 2 parameters, provided %1", count _this]] call TNL_fcore_debug};	
	private ["_string", "_allowed", "_chars", "_return"];
	
	_string = _this select 0;	if (typeName _string != "STRING") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_hasForbiddenChars: param1 - expected STRING, provided %1", typeName _string]] call TNL_fcore_debug};
	_allowed = _this select 1;	if (typeName _allowed != "STRING") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_hasForbiddenChars: param2 - expected STRING, provided %1", typeName _allowed]] call TNL_fcore_debug};
	
	_chars = toArray _string;
	_allowed = toArray _allowed;
	
	_return = false;
	{
		if (!(_x in _allowed)) exitWith
		{
			_return = true;
		};
	} forEach _chars;
	
	_return
};

/*
==============================
TNL_fcvar_stringFilter
==============================
Removes any characters that are not in the allowed list.
	* Parameters:
		Input string <string>
		Allowed characters <string>
		
	* Returns:
		Cleaned up string <string>
		
	* Example:
		_str = "ad87asd7484gdsdgtw";
		_str =[_str, "0123456789"] call TNL_fcvar_stringFilter;
		//_str = "877484"
*/
TNL_fcvar_stringFilter =
{
		if (typeName _this != "ARRAY") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_stringFilter: expected ARRAY OF PARAMETERS, provided %1", typeName _this]] call TNL_fcore_debug};
		if (count _this != 2) exitWith {[__thisFile, format ["Bad input in TNL_fcvar_stringFilter: expected 2 parameters, provided %1", count _this]] call TNL_fcore_debug};
	private ["_string", "_entry", "_allowed", "_chars", "_i"];
	
	_string = _this select 0;	if (typeName _string != "STRING") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_stringFilter: param1 - expected STRING, provided %1", typeName _string]] call TNL_fcore_debug};
	_allowed = _this select 1;	if (typeName _allowed != "STRING") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_stringFilter: param2 - expected STRING, provided %1", typeName _allowed]] call TNL_fcore_debug};
	
	_allowed = toArray _allowed;	
	_chars = toArray _string;
	
	
	_i = 0;
	while {_i < count _chars} do
	{
		if (!(_chars select _i in _allowed)) then
		{
			_chars set [_i, ">remove<"];
		};
		_i = _i + 1;
	};
	
	_string = toString (_chars - [">remove<"]);
	
	_string;
};

/*
==============================
TNL_fcvar_stringShorten
==============================
Set the maximal number of characters that can be entered into an editBox. Any characters over the limit will be deleted.
	* Parameters:
		Input string <string>
		Character limit <integer>
		
	* Returns:
		Shortened string <string>
		
	* Example:
		_str = "12345"
		_str = [_str, 3] call TNL_fcvar_stringShorten;
		//_str = "123";
*/
TNL_fcvar_stringShorten =
{
		if (typeName _this != "ARRAY") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_stringShorten: expected ARRAY OF PARAMETERS, provided %1", typeName _this]] call TNL_fcore_debug};
		if (count _this != 2) exitWith {[__thisFile, format ["Bad input in TNL_fcvar_stringShorten: expected 2 parameters, provided %1", count _this]] call TNL_fcore_debug};
	private ["_string", "_limit", "_chars"];
	_string = _this select 0;	if (typeName _string != "STRING") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_stringShorten: param1 - expected STRING, provided %1", typeName _string]] call TNL_fcore_debug};
	_limit = _this select 1;	if (typeName _limit != "SCALAR") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_stringShorten: param2 - expected NUMBER, provided %1", typeName _limit]] call TNL_fcore_debug};
	
	_chars =  toArray _string;
	if (count _chars > _limit) then
	{
		_chars resize _limit;
		
		_string = toString _chars;
	};
	
	_string;
};

/*
==============================
TNL_fcvar_stringAddDashes
==============================
Adds dashes into string in a specified interval
	* Parameters:
		Input string <string>
		Interval <integer>
		
	* Returns:
		Modified string <string>
		
	* Example:
		_str = "123456"
		_str = [_str, 2] call TNL_fcvar_stringAddDashes;
		//_str = "12-34-56";
*/
TNL_fcvar_stringAddDashes =
{
		if (typeName _this != "ARRAY") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_stringAddDashes: expected ARRAY OF PARAMETERS, provided %1", typeName _this]] call TNL_fcore_debug};
		if (count _this != 2) exitWith {[__thisFile, format ["Bad input in TNL_fcvar_stringAddDashes: expected 2 parameters, provided %1", count _this]] call TNL_fcore_debug};
	private ["_string", "_interval", "_chars", "_i"];
	
	_string = _this select 0;	if (typeName _string != "STRING") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_stringAddDashes: param1 - expected STRING, provided %1", typeName _string]] call TNL_fcore_debug};
	_interval = _this select 1;	if (typeName _limit != "SCALAR") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_stringAddDashes: param2 - expected NUMBER, provided %1", typeName _interval]] call TNL_fcore_debug};
	
	_chars = (toArray _string) - (toArray "-");
	_count = count _chars;
	
	_i = _interval;
	_index = _i;
	while {_i < _count} do
	{
		_chars = [_chars, _index, (toArray "-") select 0] call TNL_fcvar_arrayPush;
		_i = _i + _interval;
		_index = _index + (_interval + 1);
	};
	
	_string = toString _chars;
	
	_string;
};

/*
==============================
TNL_fcvar_makePossessive
==============================
Makes a possessive form of the word provided
	* Parameters:
		Word <string>
		
	* Returns:
		Possessive form <string>
		
	* Example:
		_str = "Michael" call TNL_fcvar_makePossessive;
		//_str = "Michael's"
*/
TNL_fcvar_makePossessive =
{
		if (typeName _this != "STRING") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_makePossessive: expected STRING, provided %1", typeName _this]] call TNL_fcore_debug};
	private "_word";
	_word = toArray _this;
	
	if (toString ([_word select (count _word - 1)]) == "s") then
	{
		_word = format ["%1'", toString _word];
	}
	else
	{
		_word = format ["%1's", toString _word];
	};
	
	_word
};


/*
==============================
TNL_fcvar_capitalize
==============================
Capitalizes the 1st letter
	* Parameters:
		Word to capitalize <string>
		
	* Returns:
		Capitalized word <string>
		
	* Example:
		_str = "michael" call TNL_fcvar_capitalize;
		//_str = "Michael"
*/
TNL_fcvar_capitalize =
{
		if (typeName _this != "STRING") exitWith {[__thisFile, format ["Bad input in TNL_fcvar_capitalize: expected STRING, provided %1", typeName _this]] call TNL_fcore_debug};
	private ["_name", "_new", "_i"];
	_name = toArray (toLower _this);
	
	_new = toUpper (toString [_name select 0]);
	_i = 1;
	{
		_new = format ["%1%2", _new, toString [_name select _i]];
		_i = _i + 1;
	} forEach _name;
	
	_new
};

