

RPP_fnc_leadAnimal =
{
	private ["_obj"];
	_obj = _this select 0;
	
	if (not alive _obj) exitWith
	{
	
	};
	
	if (vehicle player != player) then
	{
		["Cannot be inside a vehicle"] call TNL_fextHint_Hint;
		RPP_gVar_boolean_leadingAnimal = true;
	};
	
	if (RPP_gVar_boolean_leadingAnimal) then
	{
		RPP_gVar_boolean_leadingAnimal = false;
		
		detach RPP_gVar_obj_leadAnimal;
	}
	else
	{
		RPP_gVar_boolean_leadingAnimal = true;
		
		RPP_gVar_obj_leadAnimal = _obj;
		RPP_gVar_obj_leadAnimal attachTo [player, [0,1,0]]; 
	};
	
	[] spawn
	{
		while {RPP_gVar_boolean_leadingAnimal} do
		{
			if (not alive RPP_gVar_obj_leadAnimal) then
			{
				RPP_gVar_boolean_leadingAnimal = false;
				detach RPP_gVar_obj_leadAnimal;
			};
			
			if (player distance RPP_gVar_obj_leadAnimal >= 10) then
			{
				RPP_gVar_boolean_leadingAnimal = false;
				detach RPP_gVar_obj_leadAnimal;
			};
			
			sleep 0.5;
		};
	};
};

RPP_fnc_butcher =
{
	private ["_obj"];
	_obj = _this select 0;
	_knifeAmount = "ButcheringKnife" call TNL_finv_getItemAmount;
	
	if (not alive _obj) exitWith
	{
	
	};
	
	if (_knifeAmount <= 0) exitWith
	{
		["You require a butchering knife to do this."] call TNL_fextHint_Hint;
	};

	_typeOfMeat = _obj getVariable "meat";
	_weight = _obj getVariable "weight";
	_name = _typeOfMeat call TNL_finv_getItemName;
	_amountOfMeat = round(round(round(_weight / 10))/2);
	_weightOfMeat = (_typeOfMeat call TNL_finv_getItemWeight) * _amountOfMeat;
	_playerWeight = [] call TNL_finv_getPlayerWeight;
	_totalPlayerWeight = _playerWeight select 0;
	_maxWeight = _playerWeight select 1;
	
	if ((_weightOfMeat + _totalPlayerWeight) > _maxWeight) exitWith
	{
		[format["The animal is producing meat with a total weight of %1kg, you cannot fit this into your inventory!", _weightOfMeat]] call TNL_fextHint_Hint;
	};
	
	_obj setDamage 1;
	
	//[{ if (isServer) then { [_obj] spawn { sleep 5; deleteVehicle (_this select 0); }; };},[_obj]] call TNL_fnet_execPublic;
	
	[_typeOfMeat, _amountOfMeat] call TNL_finv_addInventoryItem;
	
	[format["You butcher the animal producing %1 %2(s)", _amountOfMeat, _name]] call TNL_fextHint_Hint;
	[{ (_this select 0) switchMove (_this select 1);}, [player, "AinvPknlMstpSlayWrflDnon_medic"]] call TNL_fnet_execPublic;
};


RPP_fnc_examineAnimal = 
{
	private ["_obj", "_weight"];
	_obj = _this select 0;
	_weight = _obj getVariable "weight";
	_isMale = _obj getVariable "isMale";
	_milk = _obj getVariable "totalMilk";
	
	if (_isMale) then
	{
		_isMale = "Male";
	}
	else
	{
		_isMale = "Female";	
	};
	
	if (_milk >= 1) then
	{
		_milk = "Can Milk: Yes, ready: Yes";
	}
	else
	{
		_milk = "Can Milk: Yes, ready: No";
	};
	
	if (not (_obj getVariable "produceMilk")) then
	{
		_milk = "Can Milk: No!";
	};
	
	_age = _obj getVariable "age";
	
	[format["The animals weight is: %1\nSex: %2\n%3\nAge: %4", _weight, _isMale, _milk, _age]] call TNL_fextHint_Hint;
};

RPP_fnc_getMilk = 
{
	private ["_obj", "_milk", "_potAmount"];
	_obj = _this select 0;
	_milk = _obj getVariable "totalMilk";
	_potAmount = "ClayPot" call TNL_finv_getItemAmount;
	
	if (not alive _obj) exitWith
	{
	
	};
	
	if (_potAmount <= 0) exitWith
	{
		["You need a clay pot to do this"] call TNL_fextHint_Hint;
	};
	
	if (not alive _obj) exitWith
	{
		["The animal is dead..."] call TNL_fextHint_Hint;
	};
	
	if (_milk < 1.0) exitWith
	{
		[format["The animal is not yet ready to be milked!\nMilk available: %1", _milk]] call TNL_fextHint_Hint;
	};
	
	_obj setVariable ["totalMilk", 0, true];
	[{ (_this select 0) switchMove (_this select 1);}, [player, "AinvPknlMstpSlayWrflDnon_medic"]] call TNL_fnet_execPublic;
	["ClayPot", -1] call TNL_finv_addInventoryItem;
	["ClayPotM", 1] call TNL_finv_addInventoryItem;
	
	["You milk the animal and fill the claypot with milk!"] call TNL_fextHint_Hint;
};