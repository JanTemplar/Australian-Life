/*
Name: functions.sqf
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (2009/05/29)
Description: Client side functions
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/
//ctrlSetBackgroundColor ctrlSetActiveColor
#define __thisFile "client\functions\genericFunctions.sqf"


/*
==============================
TNL_fui_createYesNoDlg
==============================
Displays a choice dialog with yes/no option
	* Parameters:
		Dialog's title <string>
		Dialog's message <string>
		Action assigned to YES button <string>
		Action assigned to NO button <string>
		
	* Returns:
		Nothing
		
	* Example:
		["Heal?", "Heal yourself?", "closeDialog 0; player setDamage 0", "closeDialog 0"] spawn TNL_fui_createYesNoDlg
	
	* Note:
		The function has to be always SPAWNED, it cannot be called due to the sleep usage (workaround for structuredText issues)
*/
TNL_fui_createYesNoDlg =
{
		if (typeName _this != "ARRAY") exitWith {[__thisFile, format ["Bad input in TNL_fui_createYesNoDlg: expected ARRAY OF PARAMETERS, provided %1", typeName _this]] call TNL_fcore_debug};
		if (count _this != 4) exitWith {[__thisFile, format ["Bad input in TNL_fui_createYesNoDlg: expected 4 parameters, provided %1", count _this]] call TNL_fcore_debug};
	private ["_title", "_msg", "_yesAction", "_noAction"]; 
	
	_title		= _this select 0;	if (typeName _title != "STRING") exitWith {[__thisFile, format ["Bad input in TNL_fui_createYesNoDlg: param1 - expected STRING, provided %1", typeName _title]] call TNL_fcore_debug};
	_msg		= _this select 1;	if (typeName _msg != "STRING") exitWith {[__thisFile, format ["Bad input in TNL_fui_createYesNoDlg: param2 - expected STRING, provided %1", typeName _msg]] call TNL_fcore_debug};
	_yesAction	= _this select 2;	if (typeName _yesAction != "STRING") exitWith {[__thisFile, format ["Bad input in TNL_fui_createYesNoDlg: param3 - expected STRING, provided %1", typeName _yesAction]] call TNL_fcore_debug};
	_noAction	= _this select 3;	if (typeName _noAction != "STRING") exitWith {[__thisFile, format ["Bad input in TNL_fui_createYesNoDlg: param4 - expected STRING, provided %1", typeName _noAction]] call TNL_fcore_debug};
	
	sleep 0.01;
	if (!createDialog "TNL_dlg_genYesNo") exitwith
	{
		hint "Error in function TNL_fui_createYesNoDlg - Failed to open TNL_dlg_genYesNo dialog!";
		false
	};
	
	((findDisplay 1101) displayCtrl 1) ctrlSetStructuredText parseText _title; //Set dialog's title
	((findDisplay 1101) displayCtrl 2) ctrlSetStructuredText parseText _msg; //Set dialog's text
	buttonSetAction [10, _yesAction]; //Set action for YES button
	buttonSetAction [11, _noAction]; //Set action for NO button
};

/*
==============================
TNL_fui_createNotifyDlg
==============================
Displays a notification dialog with OK button
	* Parameters:
		Dialog's title <string>
		Dialog's message <string>
		Action assigned to OK button <string>
		
	* Returns:
		Nothing
		
	* Example:
		["Healing...", "You have been patched up.", "closeDialog 0; player setDamage 0"] spawn TNL_fui_createNotifyDlg
	
	* Note:
		The function has to be always SPAWNED, it cannot be called due to the sleep usage (workaround for structuredText issues)
*/
TNL_fui_createNotifyDlg =
{
		if (typeName _this != "ARRAY") exitWith {[__thisFile, format ["Bad input in TNL_fui_createNotifyDlg: expected ARRAY OF PARAMETERS, provided %1", typeName _this]] call TNL_fcore_debug};
		if (count _this != 3) exitWith {[__thisFile, format ["Bad input in TNL_fui_createNotifyDlg: expected 3 parameters, provided %1", count _this]] call TNL_fcore_debug};
	private ["_title", "_msg", "_okAction"]; 

	_title		= _this select 0;	if (typeName _title != "STRING") exitWith {[__thisFile, format ["Bad input in TNL_fui_createNotifyDlg: param1 - expected STRING, provided %1", typeName _title]] call TNL_fcore_debug};
	_msg		= _this select 1;	if (typeName _msg != "STRING") exitWith {[__thisFile, format ["Bad input in TNL_fui_createNotifyDlg: param2 - expected STRING, provided %1", typeName _msg]] call TNL_fcore_debug};
	_okAction	= _this select 2;	if (typeName _okAction != "STRING") exitWith {[__thisFile, format ["Bad input in TNL_fui_createNotifyDlg: param3 - expected STRING, provided %1", typeName _okAction]] call TNL_fcore_debug};
	
	sleep 0.01;
	if (!createDialog "TNL_dlg_genNotify") exitWith
	{
		hint "Error in function TNL_fui_createNotifyDlg - Failed to open TNL_dlg_genNotify dialog!";
		false
	};
	
	((findDisplay 1102) displayCtrl 1) ctrlSetStructuredText parseText _title;
	((findDisplay 1102) displayCtrl 2) ctrlSetStructuredText parseText _msg;
	buttonSetAction [10, _okAction];
};

/*
==============================
TNL_fui_inputOnlyThis
==============================
Allows the user to enter only the specified characters into edit boxes. Any other characters will be deleted.
	* Parameters:
		EditBox's IDC <idc>
		Allowed characters <string>
		
	* Returns:
		Nothing
		
	* Example:
		[1, "0123456789"] call TNL_fui_inputOnlyThis;
*/
TNL_fui_inputOnlyThis =
{
	private ["_idc", "_allowed", "_entry", "_i"];
	_idc = _this select 0;
	_allowed = _this select 1;
	
	_allowed = toArray _allowed;	
	_entry = toArray (ctrlText _idc);
	
	
	_i = 0;
	while {_i < count _entry} do
	{
		if (!(_entry select _i in _allowed)) then
		{
			_entry set [_i, ">remove<"];
		};
		_i = _i + 1;
	};
	
	_entry = toString (_entry - [">remove<"]);
	
	ctrlSetText [_idc, _entry];
};

/*
==============================
TNL_fui_inputLimitChars
==============================
Set the maximal number of characters that can be entered into an editBox. Any characters over the limit will be deleted.
	* Parameters:
		EditBox's IDC <idc>
		Characters limit <integer>
		
	* Returns:
		Nothing
		
	* Example:
		[1, 5] call TNL_fui_inputLimitChars;
*/
TNL_fui_inputLimitChars =
{
	private ["_idc", "_limit", "_array"];
	_idc = _this select 0;
	_limit = _this select 1;
	
	_array =  toArray (ctrlText _idc);
	if (count _array > _limit) then
	{
		_array resize _limit;
		
		ctrlSetText [_idc, toString _array];
	};
};

/*
==============================
TNL_fui_getAspectRatio
==============================
Returns the selected aspect ratio in the video options
	* Parameters:
		Output type <string>:
			- "number"
			- "array"
			- "string"
		
	* Returns:
		Aspect ratio <selected type>
		
	* Example:
		"string" call TNL_fui_getAspectRatio => "16:10"
*/
TNL_fui_getAspectRatio =
{
	_output = toLower _this;
	_ratio = (round ((safeZoneW / safeZoneH) * 100)) / 100;
	
	if (_output == "number") then
	{
		_ratio
	}
	else
	{
		if (_ratio == 1.0) then
		{
			_ratio = (round ((safeZoneW / safeZoneH) * 1000)) / 1000;
			if (_ratio == 1.0) then
			{
				_ratio = [4,3];
			}
			else
			{
				_ratio = [12,3];
			};
		}
		else
		{
			switch (_ratio) do
			{
				case 1.33:
				{
					_ratio = [16,9];
				};
				case 1.2:
				{
					_ratio = [16,10];
				};
				case 0.94:
				{
					_ratio = [5,4];
				};
				default
				{
					_ratio = [];
					//hint str ((round ((safeZoneW / safeZoneH) * 1000)) / 1000);
				};
			};
		};
		
		if (_output == "array") then
		{
			_ratio
		}
		else
		{
			if (count _ratio == 0) then
			{
				_ratio = "error";
			}
			else
			{
				_ratio = format["%1:%2", _ratio select 0, _ratio select 1];
			};
			
			_ratio
		};
	};
};

/*
==============================
TNL_fui_getUiSize
==============================
Returns the selected UI size in the video options
	* Parameters:
		Output type <string>:
			- "number"
			- "string"
		
	* Returns:
		Aspect ratio <selected type>
		
	* Example:
		"string" call TNL_fui_getUiSize => "small"
*/
TNL_fui_getUiSize =
{
	private ["_output", "_ratio", "_4to3", "_16to9", "_16to10", "_12to3", "_error", "_sizes", "_index", "_return"];
	_output = toUpper (_this);
	_ratio = "STRING" call TNL_fui_getAspectRatio;
	
	_4to3 = [1.819, 1.429, 1.176, 1];
	_16to9 = [2.423, 1.905, 1.569, 1.333];
	_16to10 = [2.182, 1.1714, 1.412, 1.120];
	_12to3 = [1.821, 1.430, 1.178, 1.001];
	_error = false;
	
	switch (_ratio) do
	{
		case "4:3":
		{
			_sizes = _4to3;
		};
		case "5:4":
		{
			_sizes = _4to3;
		};
		case "16:9":
		{
			_sizes = _16to9;
		};
		case "16:10":
		{
			_sizes = _16to10;
		};
		case "12:3":
		{
			_sizes = _12to3;
		};
		default
		{
			_error = true;
		};
	};
	
	if (!_error) then
	{
		_index = _sizes find ((round (safeZoneW * 1000)) / 1000);
		//hint str _index;
		if (_index == -1) exitWith
		{
			_error = true;
		};
	};
	
	if (_error) then
	{
		if (_output == "STRING") then
		{
			_return = "error";
		}
		else
		{
			_return = -1;
		};
	}
	else
	{
		if (_output == "STRING") then
		{
			switch (_index) do
			{
				case 0:
				{
					_return = "verysmall";
				};
				case 1:
				{
					_return = "small";
				};
				case 2:
				{
					_return = "normal";
				};
				case 3:
				{
					_return = "large";
				};
			};
		}
		else
		{
			_return = _index;
		};
	};

	_return
};


TNL_fnet_callOnServer =
{
	private ["_functions", "_params", "_return"];
	_function = _this select 0;
	_params   = _this select 1;
	
	TNL_net_callReturned = false;
	[
		call compile format ['
			if (isServer) then
			{
				TNL_net_callReturn = %2 call %1;
				
				publicVariable "TNL_net_callReturn";
				
				TNL_net_callReturned = true;
				publicVariable "TNL_net_callReturned";
			};
		', _function, _params]
	] call TNL_fnet_execPublic;
	
	waitUntil {TNL_net_callReturned};
	
	_return = TNL_net_callReturn;
	//hint format ["%1", _return];
	
	TNL_net_callReturned = false;
	publicVariable "TNL_net_callReturned";
};
//#################################################




/*
Get if the player is the requested type
	* Parameters:
		Player or another player <object>
		Type such as "CIV" or "COP" <string>
	* Returns:
		true/false if player is that type of player <boolean>
*/
TNL_fmission_playerIsType = 
{
	private ["_obj", "_type", "_bool"];
	_obj = _this select 0;
	_type = _this select 1;
	_bool = false;
	{
		if (_obj == call compile (_x select 3)) then
		{
			{
				if (_x == _type) then
				{
					_bool = true;
				};
				
			} foreach (_x select 0);
		};
	
	} foreach Gvar_arr_mission_PlayerArray;

	_bool
};


TNL_fmission_createVehicle = 
{
	private ["_vclClass", "_object"];
	_vclClass = _this select 0;
	_object = _this select 1;
	_canLock = true;
	_varName = format["VCL_%1_%2_%3", (round random 2000), (round random 2000), (round random 2000)];
	_vclMaxWeight = ((_vclClass call TNL_finv_getOtherValues) select 0);
	_arr = (_vclClass call TNL_fsiren_getValues);
	_siren = false;
	
	
	
	if (count _arr == 0) then
	{
		_siren = false;
	}
	else
	{
		
		_siren = _arr select 0;
	};
	

	_excludeLock = ["CONTAINER", "STORAGE"];
	
	if (((_vclClass call TNL_finv_getItemTypes) select 1) in _excludeLock) then
	{
		_canLock = false;
	};
	
	call compile format['
	vcl = "%4" createVehicle %5;
	vcl setVehicleInit "this setVehicleVarName ""%2"";
	vcl = this;
	this addAction [""Menu (%3)"", ""client\useAction.sqf"", [""vehiclemenu"", [this, ""%3""]], 6];
	if (%7) then
	{
		this addAction [""Lock/Unlock (%3)"", ""client\useAction.sqf"", [""lock"", [this]], 6];
	};
	vcl addEventHandler [""GetIn"", {[_this, ""GetIn""] call TNL_eh_handling}];
	vcl addEventHandler [""GetOut"", {[_this, ""GetOut""] call TNL_eh_handling}];
	";
	vcl setVariable["storage",[], true];
	vcl setVariable["weight", 0, true];
	vcl setVariable["maxweight", %1, true];
	vcl setVariable["name", "%4", true];
	vcl setVariable["ispublic", true, true];
	vcl setVariable["trunklocked", true, true];
	vcl setVariable["TNL_siren_mounted", %6, true];
	vcl setVariable["TNL_siren_state", 0, true];
	vcl setVariable ["TNL_gas_cisternFuelType", 2, true]; 
	vcl setVariable ["TNL_gas_cisternFuel", 0, true];
	player reveal vcl;
	ClearWeaponCargo vcl;
	ClearMagazineCargo vcl;
	vcl setFuelCargo 0;
	Gvar_arr_inv_ownedVehicles = Gvar_arr_inv_ownedVehicles + [ [vcl, "%4", 1, (format["%1", vcl]) ] ];
	processInitCommands; 
	', _vclMaxWeight, _varName, (_vclClass call TNL_finv_getItemName), _vclClass, getpos (_object), _siren, _canLock];

};

TNL_fw_createWeaponsArray =
{
	private ["_weapons", "_arr"];
	_weapons = _this select 0;
	_arr = [];
	
	{
		_weapon = _x;
		_inArr = false;
		
		{
			if (_weapon == (_x select 0)) then
			{
				_x set[1, ((_x select 1)+1)];
				_inArr = true;
			};
		} forEach _arr;
		
		if (!_inArr) then
		{
			_arr set[(count _arr),[_weapon,1]];
		};
	} forEach _weapons;

	_arr
};

TNL_fw_getMagazineCount =
{
	private ["_type", "_obj", "_count"];
	_type = _this select 0;
	_obj = _this select 1;
	_count = 0;

	{
		_mag = _x;
		_magType = ((_magType call TNL_finv_getItemTypes) select 1);
		
		if (_magType == _type) then
		{
			_count = _count + 1;
		};
	
	} forEach (magazines _obj);

	_count
};



//Faces 01 - 107
TNL_fswitchUnit = 
{
	private ["_unitName"];
	_unitName = _this select 0;
	_oldUnit = player;
	_oldPos = getpos(_oldUnit);
	_oldRank = rank _oldUnit;
	_oldScore = score _oldUnit;
	_oldDir = getDir _oldUnit;
	
	[{(_this select 0) setPos (_this select 1); (_this select 2) setPos[0,0,0];}, [_unitName,_oldPos, _oldUnit]] call TNL_fnet_execPublic;
	
	addSwitchableUnit _unitName;
	selectPlayer _unitName;
	removeSwitchableUnit _unitName;
	removeSwitchableUnit _oldUnit;
	
	_unitName setFace "custom";
	_unitName setDir _oldDir;
	_unitName setRank _oldRank;
	_unitName addScore _oldRank;
	
	[{deleteVehicle (_this select 0);},[_oldUnit]] call TNL_fnet_execPublic;

};





TNL_fui_addDigitSeparators =
{
	_text = toArray (_this select 0);
	
	_i = 0;
	_real = [];
	_decimal = [];
	_realD = true;
	while {_i < count _text} do
	{
		if ( (_text select _i) == ((toArray ".") select 0) ) then
		{
			_realD = false;
		};
		if (_realD) then
		{
			_real = _real + [_text select _i];
		}
		else
		{
			_decimal = _decimal + [_text select _i];
		};
		
		_i = _i + 1;
	};

	_i = (count (_real - (toArray ","))) - 3;
	_j = 0;
	_add = [];
	while {_i > 0} do
	{
		_add set [_j, _i];
		
		_i = _i - 3;
		_j = _j + 1;
	};
	
	{
		_text = [_real, _x, (toArray ",") select 0] call TNL_fcvar_arrayPush;
	} forEach _add;
	
	_text = (toString _text) + (toString _decimal);
	
	_text;
};



/*
==============================
TNL_fcore_debug
==============================
Displays an error message, pastes the exception code into the clipboard and adds an entry to the RPT log.
	* Parameters:
		Script where the error occured <string>
		Error message <string>
		
	* Returns:
		Nothing
		
	* Example:
		["error.sqf", "intentional error message!"] call TNL_fcore_debug;
*/
TNL_fcore_debug =
{
	private ["_file", "_error", "_msg"];
	_file = _this select 0;
	_error = _this select 1;
	
	hint parseText format [localize "STRS_core_debugMsg", TNL_version, _file, _error];
	_msg = format [">>>TNL DEBUG<<>>v%1<<>>%2<<>>%3<<<", TNL_version, _file, _error];
	copyToClipboard _msg;
	diag_log (text _msg);
};