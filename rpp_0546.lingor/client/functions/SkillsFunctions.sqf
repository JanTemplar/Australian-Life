TNL_fskills_getSkill = 
{
	private ["_skillClass", "_skill"];
	_skillClass = (_this);
	_skill = 0.0;
	
	{
		if ((_x select 0) == _skillClass) then
		{
			_skill = (_x select 2);
		};
	
	} forEach TNL_gVar_arr_skills;

	_skill
};

TNL_fskills_decreaseSkill =
{
	private ["_skill", "_amount", "_total"];
	_skill = (_this select 0);
	_amount = (_this select 1);
	
	{
		if ((_x select 0) == _skill) then
		{
			_skillAmount = ((_x select 2) - (_amount));
			
			if (_skillAmount < 0) then { _skillAmount = 0; };
			
			(_x) set[2, _skillAmount];
		};
	} forEach TNL_gVar_arr_skills;
};

TNL_fskills_increaseSkill =
{
	private ["_skill", "_amount", "_total"];
	_skill = (_this select 0);
	_amount = (_this select 1);
	_total = random (_amount);
	
	{
		if ((_x select 0) == _skill) then
		{
			_total = _total + (_x select 2);
			
			if (_total > 100) then { _total = 100; };
			
			(_x) set[2, _total];
		};
	} forEach TNL_gVar_arr_skills;
};

TNL_fskills_getNormalIncrease = 
{
	private ["_skillClass", "_return"];
	_skillClass = (_this);
	_return = 0.0;
	
	{
		if ((_x select 0) == _skillClass) then
		{
			_return = ((_x select 3) select 0);
		};
	
	} forEach TNL_gVar_arr_skills;

	_return
};

TNL_fskills_getOptimalIncrease = 
{
	private ["_skillClass", "_return"];
	_skillClass = (_this);
	_return = 0.0;
	
	{
		if ((_x select 0) == _skillClass) then
		{
			_return = ((_x select 3) select 1);
		};
	
	} forEach TNL_gVar_arr_skills;

	_return
};

TNL_fskills_getReducedIncrease = 
{
	private ["_skillClass", "_return"];
	_skillClass = (_this);
	_return = 0.0;
	
	{
		if ((_x select 0) == _skillClass) then
		{
			_return = ((_x select 3) select 2);
		};
	
	} forEach TNL_gVar_arr_skills;

	_return
};

TNL_fskills_getFailIncrease = 
{
	private ["_skillClass", "_return"];
	_skillClass = (_this);
	_return = 0.0;
	
	{
		if ((_x select 0) == _skillClass) then
		{
			_return = ((_x select 3) select 3);
		};
	
	} forEach TNL_gVar_arr_skills;

	_return
};