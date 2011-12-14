/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

TNL_fextHint_Hint = 
{
	private ["_tohint", "_completeHint"];
	_tohint = _this select 0;
	_completeHint = "";
	
	if (_toHint != "" && _toHint != "silent") then
	{
		Gvar_arr_extHint_extendedHints = Gvar_arr_extHint_extendedHints + [ [_toHint, 10] ];
	};
	
	{
		if ((_x select 0) != "") then
		{
			_completeHint = _completeHint + (_x select 0) + "\n\n";
		};
	} foreach Gvar_arr_extHint_extendedHints;
	
	if (_toHint == "silent") then
	{
		hintSilent _completeHint;
	}
	else
	{
		hintSilent _completeHint;
	};
};

TNL_fextHint_Refresh = 
{
	{
		_hint = (_x select 0);
		_timeLeft = (_x select 1);
		
		if (_timeLeft <= 0) then
		{
			if (_hint != "") then
			{
				_x set[0, ""];
				["silent"] spawn TNL_fextHint_Hint;
			};
		}
		else
		{
			_x set[1, _timeLeft - 1];
		};
	} foreach Gvar_arr_extHint_extendedHints;
	
};