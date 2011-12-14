/*
Name: vehicleFunctions.sqf
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (15/06/09)
Description: Functions for vehicles
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

TNL_fvcl_removeOwnedVehicle = 
{
	private ["_vcl"];
	_vcl = _this;
	
	_i = 0;
	{	
		if ((_x select 0) == _vcl) then
		{
			Gvar_arr_inv_ownedVehicles set[_i, "REMOVE"];
		};
	
	_i = _i + 1;
	} forEach Gvar_arr_inv_ownedVehicles;
	
	Gvar_arr_inv_ownedVehicles = Gvar_arr_inv_ownedVehicles - ["REMOVE"];
};

TNL_fvcl_menu = 
{
	private ["_objectName"];
	_objectName = _this select 0;
	_className = _this select 1;
	
	if (!createDialog "DlgVclMenu") then
	{
		hint "Error failed to open vehicle menu!";
	};	
	
	[1,_objectName, _className] call TNL_fvcl_populateVehicleMenu;
};

TNL_fvcl_lockVehicle = 
{
	private ["_objectName"];
	_objectName = _this select 0;
	_found = false;
	_vehicles = nearestObjects[vehicle player, ["LandVehicle", "Air", "Ship"], 25];
	
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
	
	if ((player == _objectName) and (player == driver _objectName)) then
	{
		_found = true;
	};
	
	if (_found) then
	{
		_lockStatus = locked _objectName;
		_vclName = _objectName getVariable "name";
		
		
		if (_lockStatus) then
		{
			["Unlocked vehicle"] call TNL_fextHint_Hint;
			[player, [player], 15, format["%1 has unlocked his %2", (name player) call TNL_fplayer_formatName, _vclName]] call TNL_fnet_HintToClientsInDistanceOfObject;
			[{(_this select 0) lock false}, [_objectName]] call TNL_fnet_execPublic;
		}
		else
		{
			["Locked vehicle"] call TNL_fextHint_Hint;
			[player, [player], 15, format["%1 has locked his %2", (name player) call TNL_fplayer_formatName, _vclName]] call TNL_fnet_HintToClientsInDistanceOfObject;
			[{(_this select 0) lock true}, [_objectName]] call TNL_fnet_execPublic;
		};
		
		_objectName say3D "SndLockcar";
	};

};

TNL_fvcl_populateVehicleMenu = 
{
	private ["_idc", "_objectName", "_className"];
	_idc = _this select 0;
	_objectName = _this select 1;
	_className = _this select 2;
	
	if (typeName _objectName != "STRING") then
	{
		_className = _objectName getVariable "name";
	};


	_otherVals = _className call TNL_finv_getOtherValues;
	
	{
		_found = false;
		{
			if ([player, _x] call TNL_fmission_playerIsType) then
			{
				_found = true;
			};
		} foreach (_x select 0);
		
		if (count (_x select 0) <= 0) then
		{
			_found = true;
		};
		
		_hasFound = false;
		

		if (count (_x select 3) <= 0) then
		{
			_hasFound = true;
		}
		else
		{
			{
				_type = _x;
				_itemTypes = (_className) call TNL_finv_getItemTypes;

				if (_hasFound) exitWith {};
				
				if (count _itemTypes <= 0) then
				{
					_hasFound = false;
				}
				else
				{
					if (toLower(_itemTypes select 1) == toLower(_type)) then
					{
						_hasFound = true;
					};
				};
			} foreach (_x select 3);
		};
			
		if (_found && _hasFound) then
		{
			_index = lbAdd[_idc, format["%1", _x select 1]];
			lbSetData[_idc, _index, format["[""%1"", ""%2""]", _x select 2, _objectName]];
		};
		
		
	} foreach Gvar_arr_mission_vehicleMenu;
	

	lbSetCurSel[_idc,0];
};

TNL_fvcl_menuSelect = 
{
	private ["_data"];
	_data = _this select 0;
	_objectName = _data select 1;
	_obj = player;
	
	_vehicles = nearestObjects[vehicle player, ["ALL"], 25];
	if ((typeName _objectName) == "STRING") then
	{
		{
			if (format["%1",_x] == format["%1",_objectName]) then
			{
				_obj = _x;
			};	
		} foreach _vehicles;
	};

	
	switch (_data select 0) do
	{
		case "vcltrunk":
		{
			[_objectName] call TNL_ftrunk_openTrunk;
		};
		
		case "trunklock":
		{
			[_objectName] call TNL_ftrunk_lockTrunk;
		};
		
		case "vcllock":
		{	
			[_objectName] call TNL_fvcl_lockVehicle;
		};
		
		case "pullout":
		{
			[_obj, player] execVM "slr\pullout.sqf";
		};
	};
};

TNL_fvcl_getObject = 
{
	private ["_objectStr", "_returnObject"];
	
	
};
	
