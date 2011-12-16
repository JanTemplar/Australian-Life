_array = _this;

if (isNil "TNL_canDropItems") then
{
	TNL_canDropItems = true;
};

if (!TNL_canDropItems) exitWith { ["Cannot drop items yet!"] call TNL_fextHint_Hint; };


TNL_canDropItems = false;

if (vehicle player == player) then
{
	[{(_this select 0) switchmove "AinvPknlMstpSlayWrflDnon_medic";}, [player]] call TNL_fnet_execPublic;
};
_class = "Suitcase";
[_class, player] call TNL_fmission_createVehicle;
_vcl = vcl;
_vcl setpos getpos player;
_itemWeights = 0;
	
{
	_weight = (_x select 0) call TNL_finv_getItemWeight;
	_itemWeights = _itemWeights + ((_weight) * (_x select 1));
	[_vcl, (_x select 0), +(_x select 1)] call TNL_ftrunk_addStorage;

} forEach _array;
	
_vcl setVariable ["maxweight", _itemWeights, true];
_vcl setVariable ["weight", _itemWeights, true];
_vcl setVariable ["trunklocked", false, true];
_despawnTime = 3600;
_vcl call TNL_fvcl_removeOwnedVehicle;
	
sleep 5;
	
[{ 
	if (isServer) then 
	{ 
		[(_this select 0), (_this select 1)] spawn
		{
			_sleeper = 0;
			_vcl = (_this select 0);
			_weight = _vcl getVariable "weight";
				
			while {_sleeper <= (_this select 1)} do
			{	
				_vclWeight = _vcl getVariable "weight";
				_toDelete = true;
				
				{
					if ((_x select 0) == "Money") then
					{
						if ((_x select 1) > 0) then
						{
							_toDelete = false;
						};
					};
				} forEach (_vcl getVariable "storage");
					
				if ((_vclWeight <= 0) and (_toDelete)) then
				{
					_sleeper = (_this select 1);
				};
						
				if (_weight != _vclWeight) then
				{
					_weight = _vcl getVariable "weight";
					_vcl setVariable ["maxweight", _weight, true];
				};
				
				_sleeper = _sleeper + 0.5;
				sleep 0.5;
			};
			[_vcl,0] call SLR_SafeDeleteVehicle;
		};
	};
},[_vcl, _despawnTime]] spawn TNL_fnet_execPublic;
	
sleep 4;
TNL_canDropItems = true;
