_type = [];
_shedClass = "LAND_SHED_WOODEN";
_flagClass = "FlagCarrierBIS_EP1";
_drugsCanProcess = [ ["mari", 75, 3] ];

if (isNil "drugLabExploding") then
{
	drugLabExploding = false;
};

if (count _this >= 3) then
{
	_type = ((_this select 3) select 0);
}
else
{
	_type = (_this select 0);
};


if (_type == "use") then
{
	if (isCop) exitWith {};
	if (player != vehicle player) exitwith {};
	
	_className  = _shedClass;
	["DrugShed", -1] call TNL_finv_addInventoryItem;
	["You have placed the drug lab!"] call TNL_fextHint_Hint;

	_shed = _className createvehicle (getpos player);
	sleep 0.5;
	_flag = _flagClass createVehicle (getpos _shed);
	
	_flag setVehicleInit "this addaction ['Destroy', 'slr\drugShed.sqf', ['destroy']]; this setVehicleVarName format['drugflag_%1',round time];";
	_flag setVehicleInit "this addAction ['Process Drugs', 'slr\drugShed.sqf', ['process']];";
	processinitcommands;

};

if (_type == "process") then
{
	_Dlg = createDialog "TNL_dlg_genListSelectAmount";
	_availableDrugs = [];
	_skill = "drugmanu" call TNL_fskills_getSkill;
	{
		_item = (_x select 0);
		_name = _item call TNL_finv_getItemName;
		_failureChance = (_x select 1) - _skill;
		
		if (_failureChance < 0) then { _failureChance = 0; };
		
		_index = lbAdd[2, format["%1", _name, round _failureChance]];
		lbSetData[2,_index,_item];
		
	} forEach _drugsCanProcess;
	
	lbSetCurSel[2,0];
	
	((findDisplay 1105) displayCtrl 1) ctrlSetStructuredText parseText "Select Drug";
	((findDisplay 1105) displayCtrl 3) buttonSetAction "['produce'] execVM 'slr\drugShed.sqf';";
};

if (_type == "produce") then
{
	_amount = parseNumber ctrlText 5;
	_data = lbData[2,lbCurSel 2];
	_failureChance = 0;
	_critFailureChance = 0;
	_requiredMats = _data call TNL_finv_getItemRequiredMaterials;
	_normalIncrease = "drugmanu" call TNL_fskills_getNormalIncrease;
	_failIncrease = "drugmanu" call TNL_fskills_getFailIncrease;
	_failed = false;
	
	closeDialog 0;

	{
		if (_x select 0 == _data) then
		{
			_failureChance = (_x select 1);
			_critFailureChance = (_x select 2);
		};	
	} forEach _drugsCanProcess;
	
	
	_hasRequiredMats = [_requiredMats, Gvar_arr_inv_inventory, _amount] call TNL_ffact_hasRequiredMaterials;
	
	if (!_hasRequiredMats) exitWith
	{
		["You dont have enough resources to produce this!"] call TNL_fextHint_Hint;
		closeDialog 0;
	};

	_i = 0;
	_finalAmount = 0;
	_failureAmount = 0;
	while {_i < _amount} do
	{
		_skill = "drugmanu" call TNL_fskills_getSkill;
		_failureChance = _failureChance - _skill;
		if (_failureChance == 0) then { _failureChance = 0; };
		_chance = random 100;
		
		if (_chance <= _failureChance) then
		{
			_chance = random 100;
			if (drugLabExploding) then { _critFailureChance = 0; };
			
			if (_chance <= _critFailureChance) then 
			{
				//Holy shit run for the hills!
				[{
					_timer = 13;
					if (isServer) then
					{
						[getpos (_this select 0), _timer] spawn
						{
							sleep (_this select 1);
							"Bo_GBU12_LGB" createVehicle (_this select 0);
						};
					};
					
					if (player distance (getpos (_this select 0)) <= 50) then
					{
						drugLabExploding = true;
						["The drug lab is overloading...run for the hills!"] call TNL_fextHint_Hint;
						[] spawn
						{
							sleep _timer;
							drugLabExploding = false;
						};
					};
					
					if (player == (_this select 0)) then
					{
						_Shed = nearestobject [player, _shedClass];
						_Flag = nearestobject [player, _flagClass];
						["sendsms", "A explosion has been reported!", "POLICE", _Flag] execVM "slr\phones.sqf";
						sleep _timer;
						deleteVehicle _shed;
						deleteVehicle _Flag;
					};
						
				}, [player]] call TNL_fnet_execPublic;
				_failed = true;
				
			};
			_failureAmount = _failureAmount + 1;
			["drugmanu", _failIncrease] call TNL_fskills_increaseSkill;
		}
		else
		{
			_finalAmount = _finalAmount + 1;
			["drugmanu", _normalIncrease] call TNL_fskills_increaseSkill;
		};
	
		_i = _i + 1;
	};
	
	if (!_failed) then
	{
		[format["Produced %1x %2.\nFailed %3x", _finalAmount, _data call TNL_finv_getItemName, _failureAmount]] call TNL_fextHint_Hint;
	
		{
			[(_x select 0), -((_x select 1)*_amount)] call TNL_finv_addInventoryItem;
		} forEach _requiredMats;
		[_data, _finalAmount] call TNL_finv_addInventoryItem;
	};

};

if (_type == "destroy") then
{
	_Shed = nearestobject [player, _shedClass];
	_Flag = nearestobject [player, _flagClass];
	
	if (drugLabExploding) exitWith { ["Nice try..."] call TNL_fextHint_Hint; };
	
		
	if (IsCop) then
	{
		_Player = vehicle player;
		[{ [format["%1 has destroyed a drug lab!", (name _this select 0) call TNL_fplayer_formatName]] call TNL_fextHint_Hint;}, [_Player]] call TNL_fnet_execPublic;
	}
	else
	{
		["You have destroyed your shed"] call TNL_fextHint_Hint;
		["DrugShed", 1] call TNL_finv_addInventoryItem;
	};
		
	deleteVehicle _Shed;
	deleteVehicle _Flag;
};
