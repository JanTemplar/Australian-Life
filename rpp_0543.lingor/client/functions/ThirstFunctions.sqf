/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

TNL_fthirst_decreaseThirst = 
{
	private ["_amount"];
	_amount = (_this select 0);
	_thirst = Gvar_int_player_thirst;
	_maxThirst = Gvar_int_player_maxThirst;
	_total = (_thirst - _amount);
	_damage = damage player;
	
	if (_total <= 0) then
	{
		if (alive player) then
		{
			cutText ["You are dehydrating, drink something quickly!", "PLAIN DOWN"];
			player setDamage ((_damage) + (0.05));
			if !(alive player) then { ["You have died from dehydration..."] call TNL_fextHint_Hint; };
		};
	};
	
	Gvar_int_player_thirst = _total;
};

TNL_fthirst_increaseThirst = 
{
	private ["_amount"];
	_amount = (_this select 0);
	_thirst = Gvar_int_player_thirst;
	_maxThirst = Gvar_int_player_maxThirst;
	_total = (_thirst + _amount);
	
	if (_total > _maxThirst) then
	{
		Gvar_int_player_thirst = Gvar_int_player_maxThirst;
	}
	else
	{
		Gvar_int_player_thirst = _total;
	};

};

TNL_fthirst_checkThirst = 
{
	private ["_returnStr"];
	_returnStr = "";
	
	if (Gvar_int_player_thirst <= 5) then
	{
		_returnStr = "Feel faint";
	};
	
	if (Gvar_int_player_thirst <= 10 && Gvar_int_player_thirst > 5) then
	{
		_returnStr = "Dehydrated";
	};
	
	if (Gvar_int_player_thirst <= 25 && Gvar_int_player_thirst > 10) then
	{
		_returnStr = "Very thirsty";
	};
	
	if (Gvar_int_player_thirst <= 50 && Gvar_int_player_thirst > 25) then
	{
		_returnStr = "Thirsty";
	};
	
	if (Gvar_int_player_thirst <= 75 && Gvar_int_player_thirst > 50) then
	{
		_returnStr = "A little thirsty";
	};
	
	if (Gvar_int_player_thirst <= 95 && Gvar_int_player_thirst > 75) then
	{
		_returnStr = "Not thirsty";
	};
	
	if (Gvar_int_player_thirst > 95) then
	{
		_returnStr = "Bloated";
	};

	_returnStr 
};

TNL_fthirst_thirstLoop = 
{
	if (Gvar_int_player_thirst <= 8) then
	{
		cutText ["You are thirsty, drink something!", "PLAIN DOWN"];
		[] spawn TNL_fthirst_dehydrationEffect;
	}
	else
	{
		if (Gvar_bool_player_thirstEffectEnabled) then
		{
			"wetDistortion" ppEffectEnable false;
			Gvar_bool_player_thirstEffectEnabled = false;
		};
	};
			
	
	[(floor(random Gvar_int_player_thirstDecrease))] call TNL_fthirst_decreasethirst;
};

TNL_fthirst_dehydrationEffect = 
{
	Gvar_bool_player_thirstEffectEnabled = true;

	"wetDistortion" ppEffectEnable true;
	"wetDistortion" ppEffectAdjust [0.5, 1, 1, 4.1, 3.7, 2.5, 1.85, 0.0051, 0.0051, 0.0051, 0.0051, 0.5, 0.3, 10, 6.0];
	"wetDistortion" ppEffectCommit 0;
	
};