//The New Life (RPG Mission)
//Copyright (C) 2009  Matthew Simms & Petr Klíma

TNL_ftrunk_openTrunk = 
{
	private ["_objectName"];
	_objectName = _this select 0;
	
	if (!createDialog "DlgTrunk") then
	{
		hint "Error in trunkFunctions.sqf in function TNL_ftrunk_openTrunk failed to open dialog (DlgTrunk)";
	};
	
	[_objectName] call TNL_ftrunk_loadTrunk;
};

TNL_ftrunk_loadTrunk =
{
	private ["_objectName", "_storage", "_storageName", "_storageWeight", "_storageMaxWeight", "_playerWeight"];
	
	_objectName = _this select 0;
	_oldObjectName = _objectName;
	
	
	if ((typeName _objectName) == "STRING") then
	{
		_vehicles = nearestObjects[vehicle player, ["ALL"], 25];
		{
			if (format["%1",_x] == format["%1",_objectName]) then
			{
				_objectName = _x;
			};
		} foreach _vehicles;
	};
	
	TNL_GLOBAL_CUR_TRUNK = _objectName;

	lbClear 2;
	lbClear 3;
	
	if (_objectName isKindOf "Static") then
	{
		((findDisplay 1001) displayCtrl 1) ctrlSetStructuredText parseText "Storage:";
	}
	else
	{
		_status = (_objectName) getVariable "trunklocked";
		
		if (_status) then
		{
			["The trunk is locked"] call TNL_fextHint_Hint;
			closeDialog 0;
		};
		
		((findDisplay 1001) displayCtrl 1) ctrlSetStructuredText parseText "Vehicle Trunk:";
	};
	
	_storage = _objectName getVariable "storage";
	_storageName = _objectName getVariable "name";
	_storageWeight = _objectName getVariable "weight";
	_storageMaxWeight = _objectName getVariable "maxweight";
	_playerWeight = [] call TNL_finv_getPlayerWeight;
	
	if (_storageMaxWeight == 0) then
	{
		_storageMaxWeight = "oo";
	};
	
	
	ctrlSetText[5, format["%1 Weight: %2/%3kg |", _storageName, _storageWeight, _storageMaxWeight]];
	ctrlSetText[6, format["Inventory Weight: %1/%2kg |", _playerWeight select 0, _playerWeight select 1]];
	

	{
		_itemClass = (_x select 0);
		_itemAmount = (_x select 1);
		_itemArray = (_itemClass) call TNL_finv_getItemArray;
		_itemName = ((_itemArray select 2) select 0);
		_itemDesc = ((_itemArray select 2) select 1);
		_itemWeight = (_itemArray select 4);
		_itemTotalWeight = (_itemWeight * _itemAmount);
		_vehicleAddWeight = 0;
		_servTime = (_x select 3);

		if ((((_itemClass call TNL_finv_getItemTypes) select 0) == "VEHICLE") or 
			(((_itemClass call TNL_finv_getItemTypes) select 0) == "ANIMAL")) then
		{
			_vclParams = (_x select 2);
			{
				_varName = (_x select 0);
				_varValue = (_x select 1);
				
				if (_varName == "weight") then
				{
					_vehicleAddWeight = _varValue;
					_itemTotalWeight = _itemWeight;
				};
			
			} forEach _vclParams;
		};
		
		if (_itemAmount > 0) then
		{
			_index = lbAdd[2, format["%1, %2x, (%3/%4kg)", _itemName, _itemAmount, (_itemWeight + _vehicleAddWeight), _itemTotalWeight]];
			lbSetData[2, _index, format["[""%1"",%2, %3, %4, %5]", _itemClass, _objectName, _itemAmount, _servTime, (_itemWeight + _vehicleAddWeight)]];
		};
		
	} foreach _storage;

	[3, Gvar_arr_inv_inventory] call TNL_ftrunk_populateList;
	
	_weapons = [weapons player] call TNL_fw_createWeaponsArray;
	[3,_weapons] call TNL_ftrunk_populateList;
	
	_mags = [magazines player] call TNL_fw_createWeaponsArray;
	[3,_mags] call TNL_ftrunk_populateList;
	
	{
		_vcl = _x select 0;
		_vclClass = _x select 1;
		_itemWeight = _vclClass call TNL_finv_getItemWeight;
		_vehicleWeight = _vcl getVariable "weight";
		_vehicleMaxWeight = _vcl getVariable "maxweight";
		if ((player distance (getpos _vcl) <= 12) and (_vcl != _objectName)) then
		{
			_index = lbAdd[3, format["%1, 1x, (%2kg)", (_vclClass call TNL_finv_getItemName), (_itemWeight + _vehicleWeight)]];
			lbSetData[3, _index, format["[""%1"",""%2""]", _vclClass, _vcl]];
		};
	} forEach Gvar_arr_inv_ownedVehicles;
	
	{
		_obj = _x;
		_weight = _obj getVariable "weight";
		_class = typeOf _obj;
		_name = _obj getVariable "type";
		
		
		if ((alive _obj) && (not (isNull _obj)) && (not(isNil "_weight")) && (not(isNil "_class"))) then
		{
			_index = lbAdd[3, format["%1, 1x, (%2kg)", _name, _weight]];
				lbSetData[3, _index, format["[""%1"",""%2""]", _class, _obj]];
		};

	} forEach (nearestObjects [player, ["Animal"], 12]);
	
	TNL_GLOBAL_CUR_TRUNK = _objectName;

	if ((lbCurSel 2) != -1) then 
	{ 
		lbSetCurSel [2, lbCurSel 2]; 
	}
	else
	{
		lbSetCurSel [2, 0]; 
	};
	
	if ((lbCurSel 3) != -1) then
	{
		lbSetCurSel [3, lbCurSel 3]; 
	}
	else
	{
		lbSetCurSel [3, 0]; 
	};

};

TNL_ftrunk_populateList =
{	
	private ["_idc", "_array"];
	_idc = _this select 0;
	_array = _this select 1;
	
	{
		_itemClass = (_x select 0);
		_itemAmount = (_x select 1);
		_itemArray = (_itemClass) call TNL_finv_getItemArray;
		_itemName = ((_itemArray select 2) select 0);
		//_itemDesc = ((_itemArray select 2) select 1);
		_itemWeight = (_itemArray select 4);
		_itemTotalWeight = (_itemWeight * _itemAmount);
		
		if (_itemAmount > 0) then
		{
			_index = lbAdd[_idc, format["%1, %2x, (%3/%4kg)", _itemName, _itemAmount, _itemWeight, _itemTotalWeight]];
			lbSetData[_idc, _index, format["[""%1""]", _itemClass]];
		};
	
	} forEach _array;
};

TNL_ftrunk_dropItem =
{
	private ["_itemClass", "_objectName", "_amount", "_storage", "_storageWeight", "_storageMaxWeight", "_itemAmount", "_itemWeight", "_itemCanDrop", "_isPublic", "_totalItemWeight", "_result"];
	_itemClass = ((_this select 0) select 0);
	_itemName = _itemClass call TNL_finv_getItemName;
	_objectName = TNL_GLOBAL_CUR_TRUNK;
	_amount = parseNumber ctrlText (_this select 1);
	_storage = _objectName getVariable "storage";
	_storageWeight = _objectName getVariable "weight";
	_storageMaxWeight = _objectName getVariable "maxweight";
	_storageName = _objectName getVariable "name";
	_itemAmount = _itemClass call TNL_finv_getItemAmount;
	_itemWeight = _itemClass call TNL_finv_getItemWeight;
	_itemCanDrop = _itemClass call TNL_finv_isDroppable;
	_isPublic = _objectName getVariable "ispublic";
	_totalItemWeight = (_itemWeight * _amount);
	_result = false;
	_type = ((_itemClass call TNL_finv_getItemTypes) select 0);
	_otherType = ((_itemClass call TNL_finv_getItemTypes) select 1);
	_allowedTypes = ["VEHICLE", "WEAPON", "MAGAZINE", "ANIMAL"];
	_params = [];
	_vcl = nowhere;
	_animal = nowhere;
	
	if ((_type == "WEAPON") or (_type == "VEHICLE") or (_type == "ANIMAL")) then
	{
		_amount = 1;
	};
	
	if (_type == "VEHICLE") then
	{
		{
			if (format["%1", (_x select 0)] == ((_this select 0) select 1)) then
			{
				_vcl = (_x select 0);
			};
		} forEach Gvar_arr_inv_ownedVehicles;
		
		if (_vcl == nowhere) then
		{
			player groupchat "Unable to store vehicle details!";
		};
		
		_vehicleStorage = _vcl getVariable "storage";
		_vehicleWeight = _vcl getVariable "weight";
		_vehicleMaxWeight = _vcl getVariable "maxweight";
		_cisternFuel = _vcl getVariable "TNL_gas_cisternFuel";
		_fuel = fuel _vcl;
		_dmg = damage _vcl;
		_params = _params + [["fuel", _fuel], ["damage", _dmg], ["storage",_vehicleStorage],["weight",_vehicleWeight],["maxweight", _vehicleMaxWeight],["TNL_gas_cisternFuel",_cisternFuel]];
		_itemWeight = (_itemWeight + _vehicleWeight);
	};
	
	if (_type == "ANIMAL") then
	{
		{
			if (format["%1", _x] == ((_this select 0) select 1)) then
			{
				_animal = _x;
			};
		} forEach (nearestObjects [player, ["Animal"], 12]);
		
		if (_animal == nowhere) then
		{
			player groupchat "Unable to store animal details!";
		};
		
		_animalType = _animal getVariable "type";
		_animalClass = _animal getVariable "class";
		_maxWeight = _animal getVariable "maxWeight";
		_minWeight = _animal getVariable "minWeight";
		_weight = _animal getVariable "weight";
		_produceMeat = _animal getVariable "produceMeat";
		_meat = _animal getVariable "meat";
		_produceMilk = _animal getVariable "produceMilk";
		_totalMilk = _animal getVariable "totalMilk";
		_age = _animal getVariable "age";
		//_feedsOn = _animal getVariable "feedsOn";
		_isMale = _animal getVariable "isMale";
		
		_params = _params + 
		[
			["type", _animalType], 
			["class", _animalClass], 
			["maxWeight",_maxWeight],
			["minWeight",_minWeight],
			["weight", _weight],
			["produceMeat", _produceMeat],
			["meat", _meat],
			["produceMilk", _produceMilk],
			["totalMilk", _totalMilk],
			["isMale", _isMale],
			["age", _age]
		];
		_itemWeight = _weight;		
	};
	
	if (((TNL_gVar_int_timeSinceLastUsedTrunk)+TNL_gVar_int_timeUntilCanUseTrunk) < time) then
	{
		if (_itemCanDrop) then
		{
			if ((_itemAmount >= _amount) or (_type in _allowedTypes)) then
			{
				if ([_objectName, _itemClass, _amount, _params] call TNL_ftrunk_addStorage) then
				{
					TNL_gVar_int_timeSinceLastUsedTrunk = time;
					if !((player) call TNL_fplayer_inVehicle) then
					{
						[{(_this select 0) switchMove "AinvPknlMstpSlayWrflDnon_AmovPercMstpSnonWnonDnon";}, [player]] call TNL_fnet_execPublic;
					};
					
					_type = ((_itemClass call TNL_finv_getItemTypes) select 0);
					_otherType = ((_itemClass call TNL_finv_getItemTypes) select 1);
				
					if (_type == "ITEM") then
					{
						[_itemClass, _amount] call TNL_finv_takeItemAmount;
						_result = true;
					};
						
					if (_type == "VEHICLE") then
					{
						_vcl call TNL_fvcl_removeOwnedVehicle;
						[_vcl,0] call SLR_SafeDeleteVehicle;
						_result = true;
					};
					
					if (_type == "ANIMAL") then
					{
						[{ if (isServer) then { deleteVehicle (_this select 0); };},[_animal]] call TNL_fnet_execPublic;
						RPP_gVar_int_totalAnimals = RPP_gVar_int_totalAnimals - 1;
						_result = true;
					};
					
					if (_type == "WEAPON") then
					{
						if (!([player,_otherType] call TNL_fplayer_hasWeaponType)) then
						{
							[_objectName, _itemClass, -(_amount)] call TNL_ftrunk_addStorage;
							["You have no weapon to store!"]  call TNL_fextHint_Hint;
						}
						else
						{
							player removeWeapon _itemClass;
							_result = true;
						};
					};
					
					if (_type == "MAGAZINE") then
					{
						_mags = magazines player;
						_numMags = 0;
						{
							if (_x == _itemClass) then
							{
								_numMags = _numMags + 1;
							};
						} forEach _mags;
						
						if (_numMags >= _amount) then
						{
							_i = 0;
							while {_i != _amount} do
							{
								_i = _i + 1;
								player removeMagazine _itemClass;
							};
							
							_result = true;
						}
						else
						{
							["Not enough magazines!"] call TNL_fextHint_Hint; 
							[_objectName, _itemClass, -(_amount)] call TNL_ftrunk_addStorage;
							_result = false;
						};
					};
					
					if (_result) then
					{
						[format[localize "STRS_trunk_dropItem", _amount, _itemName, _storageName]] call TNL_fextHint_Hint;
						[player, [player], 15, format["%1 has dropped %2 %3(s) into %4", (name player) call TNL_fplayer_formatName, _amount, _itemName, _storageName]] call TNL_fnet_HintToClientsInDistanceOfObject;
					};
				}
				else
				{
					[format[localize "STRS_trunk_exceedMaxWeight", _storageMaxWeight]] call TNL_fextHint_Hint;
				};
		
			}
			else
			{
				[format[localize "STRS_trunk_notEnoughDrop", _itemName, _amount, _itemAmount]] call TNL_fextHint_Hint;
			};
		}
		else
		{
			[localize "STRS_inv_undroppable"] call TNL_fextHint_Hint;
		};
	}
	else
	{
		["You are still dropping items"] call TNL_fextHint_Hint;
	};
	
	[_objectName] call TNL_ftrunk_loadTrunk;
	_result
};

TNL_ftrunk_takeItem = 
{
	private ["_itemClass", "_objectName"];
	_itemClass = ((_this select 0) select 0);
	_itemName = _itemClass call TNL_finv_getItemName;
	_objectName = TNL_GLOBAL_CUR_TRUNK;
	_itemAmount = ((_this select 0) select 2);
	_itemWeight = _itemClass call TNL_finv_getItemWeight;
	_amount = parseNumber ctrlText (_this select 1);
	_storage = _objectName getVariable "storage";
	_storageName = _objectName getVariable "name";
	_playerWeight = [] call TNL_finv_getPlayerWeight;
	_totalWeight = (_itemWeight * _amount);
	_type = ((_itemClass call TNL_finv_getItemTypes) select 0);
	_otherType = ((_itemClass call TNL_finv_getItemTypes) select 1);
	_allowedTypes = ["VEHICLE", "WEAPON", "MAGAZINE", "ANIMAL"];
	_result = false;
	_servTime = ((_this select 0) select 3);
	_skip = false;
	_update = true;
	_userWeight = (_playerWeight select 0);

	if (count _this >= 3) then
	{
		_update = (_this select 2);
	};

	if (_type == "WEAPON") then
	{
		_amount = 1;
	};
	
	if ((_type == "VEHICLE") or (_type == "ANIMAL")) then
	{
		_totalWeight = 0;
		_amount = 1;
		_skip = true;
	};
	
	if (_itemAmount >= _amount) then
	{
		if ((_userWeight + _totalWeight) <= (_playerWeight select 1)) then
		{
			if ([_objectName,_itemClass,-(_amount), [], _skip] call TNL_ftrunk_addStorage) then
			{
				_type = ((_itemClass call TNL_finv_getItemTypes) select 0);
				
				if (_type == "ITEM") then
				{
					_result = [_itemClass, _amount] call TNL_finv_addInventoryItem;
					
					if (!(_result)) then
					{
						[_objectName,_itemClass,_amount] call TNL_ftrunk_addStorage;
						["This will exceed your max weight!"] call TNL_fextHint_Hint;
					};
				};
				
				if (_type == "ANIMAL") then
				{
					_animalType = ((_itemClass call TNL_finv_getItemTypes) select 1);
				
					_animalParams = [];
					
					_i = 0;
					{
						if (ceil(_x select 3) == ceil(_servTime)) then
						{
							_animalParams = (_x select 2);
							_storage set[_i,"REMOVE"];
						};
					_i = _i + 1;
					} forEach _storage;
					_storage = _storage - ["REMOVE"];
					_isPublic = TNL_GLOBAL_CUR_TRUNK getVariable "ispublic";
					TNL_GLOBAL_CUR_TRUNK setVariable["storage", _storage, _isPublic];
					
					_animalWeight = 0;
					{
						_var = (_x select 0);
						if (_var == "weight") then
						{
							_animalWeight = (_x select 1);
						};		
					} forEach _animalParams;
					
					
					[{ if (isServer) then { [(_this select 0), (_this select 1), (_this select 2), (_this select 3)] spawn RPP_fnc_animal_spawn; };},[_animalType,_itemClass, (position vehicle player), _animalParams]] call TNL_fnet_execPublic;				
					
					_storageWeight = TNL_GLOBAL_CUR_TRUNK getVariable "weight";
					_storageWeight = _storageWeight - _animalWeight;
					
					TNL_GLOBAL_CUR_TRUNK setVariable ["weight", _storageWeight, true];
					
					_result = true;
				};
						
				if (_type == "VEHICLE") then
				{
					[_itemClass, player] call TNL_fmission_createVehicle;
					_vclParams = [];
					_vcl = vcl;
					
					_i = 0;
					{
						if (ceil(_x select 3) == ceil(_servTime)) then
						{
							_vclParams = (_x select 2);
							_storage set[_i,"REMOVE"];
						};
					_i = _i + 1;
					} forEach _storage;
					
					
					_storage = _storage - ["REMOVE"];
					
					_isPublic = TNL_GLOBAL_CUR_TRUNK getVariable "ispublic";
					TNL_GLOBAL_CUR_TRUNK setVariable["storage", _storage, _isPublic];
					{
						_varName = (_x select 0);
						if (_varName in ["damage", "fuel"]) then
						{
							if (_varName == "damage") then { _vcl setDamage (_x select 1); };
							if (_varName == "fuel") then { _vcl setFuel (_x select 1); };
						}
						else
						{
							_varName = (_x select 0);
							_varValue = (_x select 1);

							_vcl setVariable[_varName, _varValue, true];
						};
					} forEach _vclParams;
					
					_vclWeight = _vcl getVariable "weight";
					_storageWeight = TNL_GLOBAL_CUR_TRUNK getVariable "weight";
					_storageWeight = _storageWeight - _vclWeight;
					
					TNL_GLOBAL_CUR_TRUNK setVariable ["weight", _storageWeight, true];
					
					_result = true;
				};
					
				if (_type == "WEAPON") then
				{
					if (!([player,_otherType] call TNL_fplayer_hasWeaponType)) then
					{
						player addWeapon _itemClass;
						_result = true;
					}
					else
					{
						[_objectName,_itemClass,_amount] call TNL_ftrunk_addStorage;
					};
				};
					
				if (_type == "MAGAZINE") then
				{
					_magazineMaxSize = 0;
					if (_otherType == "RIFLE") then
					{
						_magazineMaxSize = 12;	
					}
					else
					{
						_magazineMaxSize = 8;	
					};
					
					if (((([_otherType,player] call TNL_fw_getMagazineCount) + _amount) >= _magazineMaxSize)) then
					{
						["You cannot take that many!"] call TNL_fextHint_Hint;
						[_objectName,_itemClass,_amount] call TNL_ftrunk_addStorage;
					}
					else
					{
						_i = 0;
						while {_i != _amount} do
						{
							_i = _i + 1;
							player addMagazine _itemClass;
						};
						_result = true;
					};
				};

				if (_result) then
				{
					[format[localize "STRS_trunk_takeItem", _itemName, _amount, _storageName]] call TNL_fextHint_Hint;
					[player, [player], 15, format["%1 has taken %2 %3(s) from %4", (name player) call TNL_fplayer_formatName, _amount, _itemName, _storageName]] call TNL_fnet_HintToClientsInDistanceOfObject;
				};
			}
			else
			{
				//hint "This will exceed you max weight!";
			};
		}
		else
		{
			[localize "STRS_inv_overWeight"] call TNL_fextHint_Hint;
		};
	}
	else
	{
		[format[localize "STRS_trunk_notEnoughTake", _itemName, _amount, _itemAmount]] call TNL_fextHint_Hint;
	};
	
	if (_update) then
	{
		[TNL_GLOBAL_CUR_TRUNK] call TNL_ftrunk_loadTrunk;
	};
};

TNL_ftrunk_addStorage = 
{
	private ["_objectName", "_itemClass", "_amount"];
	_objectName = _this select 0;
	_itemClass = _this select 1;
	_amount = _this select 2;
	_params = [];
	_skip = false;
	if (count _this > 3) then
	{
		_params = _this select 3;
	};
	if (count _this > 4) then
	{
		_skip = _this select 4;
	};
	_return = false;
	_storage = _objectName getVariable "storage";
	_storageWeight = _objectName getVariable "weight";
	_storageMaxWeight = _objectName getVariable "maxweight";
	_isPublic = _objectName getVariable "ispublic";
	_itemWeight = _itemClass call TNL_finv_getItemWeight;
	_itemCanDrop = _itemClass call TNL_finv_isDroppable;
	_totalItemWeight = (_itemWeight * _amount);
	_afterWeight = (_totalItemWeight + _storageWeight);
	
	
	
	if ((((_itemClass call TNL_finv_getItemTypes) select 0) == "VEHICLE") or (((_itemClass call TNL_finv_getItemTypes) select 0) == "ANIMAL")) then
	{
		{
			if ((_x select 0) == "weight") then
			{
				_afterWeight = _afterWeight + (_x select 1);
			};
		} forEach _params;
		
	};
	
	if (_afterWeight <= _storageMaxWeight || _storageMaxWeight == 0) then
	{
		_return = true;
		_found = false;
		if (!_skip) then
		{
			_forceSkip = false;
			if (((_itemClass call TNL_finv_getItemTypes) select 0) == "VEHICLE" && (count _this <= 3)) then
			{
				_forceSkip = true;
			};
			
			if (((_itemClass call TNL_finv_getItemTypes) select 0) == "ANIMAL" && (count _this <= 3)) then
			{
				_forceSkip = true;
			};
		
			if (((((_itemClass call TNL_finv_getItemTypes) select 0) != "VEHICLE") && (((_itemClass call TNL_finv_getItemTypes) select 0) != "ANIMAL")) || (_forceSkip)) then
			{
				{
					if (_x select 0 == _itemClass) exitWith
					{
						_found = true;
						_x set[1,((_x select 1) + (_amount))];
						_x set[2, _params];
						_x set[3, time];
					};
				} foreach _storage;
			};
	
			if (!_found) then
			{
				_storage = _storage + [ [_itemClass, _amount, _params, time] ];
			};
		};
		
		if ((!(_objectName isKindOf "AllVehicles")) and (!(typeOf _objectName in ["Suitcase"])))  then
		{
			if (_isPublic) then
			{
				[TNL_gVar_str_tables_trunk_storages, [_objectName], [ [_storage, "storage"], [_afterWeight, "weight"] ]] call TNL_fsav_clientRequestSave;
			}
			else
			{	
				[TNL_gVar_str_tables_trunk_localStorages, [str _objectName, (TNL_db_charName select 0), (TNL_db_charName select 1)], [ [_storage, "storage"], [_afterWeight, "weight"] ]] call TNL_fsav_clientRequestSave;
			};
		};
		

		_objectName setVariable["storage", _storage, _isPublic];
		_objectName setVariable["weight", _afterWeight, _isPublic];
		
	};
	
	_return
};

TNL_ftrunk_lockTrunk =
{
	private ["_objectName"];
	_objectName = _this select 0;
	_found = false;
	_vehicles = nearestObjects[vehicle player, ["ALL"], 25];
	
	if ((typeName _objectName) == "STRING") then
	{
		{
			if (format["%1",_x] == format["%1",_objectName]) then
			{
				_objectName = (_x);
			};
			
	
		} foreach _vehicles;
	};
	
	{
		if (_x select 0 == _objectName) then
		{
			_found = true;
		};
		
	} foreach Gvar_arr_inv_ownedVehicles;
	
	if (_found) then
	{
		_lockStatus = _objectName getVariable "trunklocked";
		_storageName = _objectName getVariable "name";
		
		if (_lockStatus) then
		{
			["Trunk unlocked"] call TNL_fextHint_Hint;
			[player, [player], 15, format["%1 has unlocked the trunk of his %2", (name player) call TNL_fplayer_formatName, _storageName]] call TNL_fnet_HintToClientsInDistanceOfObject;
			_objectName setVariable["trunklocked", false, true];
		}
		else
		{
			["Trunk locked"] call TNL_fextHint_Hint;
			[player, [player], 15, format["%1 has locked the trunk of his %2", (name player) call TNL_fplayer_formatName, _storageName]] call TNL_fnet_HintToClientsInDistanceOfObject;
			_objectName setVariable["trunklocked", true, true];
		};
	};
	_objectName say3D "SndLockcar";

};

TNL_ftrunk_openChangeDialog =
{
	if (!createDialog "DlgTrunkChange") then
	{
		hint "Error trunkFunctions.sqf, in function TNL_ftrunk_openChangeDialog failed to open DlgTrunkChange!";
	};
	
	[] call TNL_ftrunk_loadChange;
};

TNL_ftrunk_loadChange = 
{
	private ["_i"];
	_i = 0;
	_vehicles = nearestObjects[vehicle player, ["LandVehicle", "Air", "Ship"], 10];
	
	{
		_locked = _x getVariable "trunklocked";
		_name = _x getVariable "name";
		
		if (!_locked) then
		{
			_index = lbAdd[1, format["%1 (%2)", _name, _x]];
			lbSetData[1, _index, format["%1", _x]];
			
			
			_i = _i + 1;
		};
		
	} foreach _vehicles;
	
	{
		if (vehicle player distance (getpos (_x select 0)) < 10) then
		{
			_index = lbAdd[1, format["%1", _x select 1]];
			lbSetData[1, _index, format["%1", _x select 0]];
			_i = _i + 1;
		};
		
	} foreach Gvar_arr_trunk_storages;

	ctrlSetText[2, format["Found: %1", _i]];
	lbSetCurSel[1,0];
};

TNL_ftrunk_changeTrunk = 
{
	private ["_data"];
	_data = _this select 0;
	_objectName = call compile _data;
	_vehicles = nearestObjects[vehicle player, ["ALL"], 10];
	_locked = false;
	
	{
		if (format["%1",_x] == _data) then
		{
			_objectName = _x;
			_locked = _x getVariable "trunklocked";
		};
		
		
	} foreach _vehicles;
	
	if (vehicle player distance (getpos (_objectName)) < 10 && (not (_locked))) then
	{
		closeDialog 0;
		sleep 0.05;
		[_objectName] spawn TNL_ftrunk_loadTrunk;	
	}
	else
	{
		["This is too far away"] call TNL_fextHint_Hint;
		[] call TNL_ftrunk_loadChange;
	};
};

/*
TNL_ftrunk_remStorage = 
{
	private ["_objectName", "_itemClass", "_amount"];
	_return = false;
	_objectName = _this select 0;
	_itemClass = _this select 1;
	_amount = _this select 2;
	_storage = _objectName getVariable "storage";
	_storageWeight = _objectName getVariable "weight";
	_storageMaxWeight = _objectName getVariable "maxweight";
	_isPublic = _objectName getVariable "ispublic";
	_itemWeight = _itemClass call TNL_finv_getItemWeight;
	//_totalItemWeight 
	
	
	_return
};
*/

