/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/
TNL_fhunger_decreaseHunger = 
{
	private ["_amount"];
	_amount = (_this select 0);
	_hunger = Gvar_int_player_hunger;
	_maxHunger = Gvar_int_player_maxHunger;
	_total = (_hunger - _amount);
	_damage = damage player;
	
	if (_total <= 0) then
	{
		if (alive player) then
		{
			cutText ["You are starving, eat something quickly!", "PLAIN DOWN"];
			player setDamage ((_damage) + (0.05));
			if !(alive player) then { ["You have died from starvation..."] call TNL_fextHint_Hint; };
		};
	};
	
	Gvar_int_player_hunger = _total;
};

TNL_fhunger_increaseHunger = 
{
	private ["_amount"];
	_amount = (_this select 0);
	_hunger = Gvar_int_player_hunger;
	_maxHunger = Gvar_int_player_maxHunger;
	_total = (_hunger + _amount);
	
	if (_total > _maxHunger) then
	{
		Gvar_int_player_hunger = Gvar_int_player_maxHunger;
	}
	else
	{
		Gvar_int_player_hunger = _total;
	};

};

TNL_fhunger_checkHunger = 
{
	private ["_returnStr"];
	_returnStr = "";
	
	if (Gvar_int_player_hunger <= 5) then
	{
		_returnStr = "Feel faint";
	};
	
	if (Gvar_int_player_hunger <= 10 && Gvar_int_player_hunger > 5) then
	{
		_returnStr = "Starving";
	};
	
	if (Gvar_int_player_hunger <= 25 && Gvar_int_player_hunger > 10) then
	{
		_returnStr = "Very hungry";
	};
	
	if (Gvar_int_player_hunger <= 50 && Gvar_int_player_hunger > 25) then
	{
		_returnStr = "Hungry";
	};
	
	if (Gvar_int_player_hunger <= 75 && Gvar_int_player_hunger > 50) then
	{
		_returnStr = "A little hungry";
	};
	
	if (Gvar_int_player_hunger <= 95 && Gvar_int_player_hunger > 75) then
	{
		_returnStr = "Not hungry";
	};
	
	if (Gvar_int_player_hunger > 95) then
	{
		_returnStr = "Full";
	};

	_returnStr 
};

TNL_fhunger_hungerLoop = 
{
	if (Gvar_int_player_hunger <= 8) then
	{
		cutText ["You are getting hungry, eat something.", "PLAIN DOWN"];
		[] spawn TNL_fhunger_starvationEffect;
	}
	else
	{
		if (Gvar_bool_player_hungerEffectEnabled) then
		{
			"radialBlur" ppEffectEnable false;
			Gvar_bool_player_hungerEffectEnabled = false;
		};
	};
			
	
	[(floor(random Gvar_int_player_hungerDecrease))] call TNL_fhunger_decreaseHunger;
};

TNL_fhunger_starvationEffect = 
{
	Gvar_bool_player_hungerEffectEnabled = true;
	
	"radialBlur" ppEffectEnable true;
	"radialBlur" ppEffectAdjust[0.2, 0.2, 0, 0];
	"radialBlur" ppEffectCommit 0;
};

