/*
Name: init.sqf
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (2009/05/28)
Description: Mission database saving system
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

/*
Move player off the map (save old position as TNL_db_origPos) to debugZone marker, create intro camera (TNL_db_introCam),
call TNL_fdb_rulesOpen function

Params:
	- Nothing
Returns:
	- Nothing
*/
TNL_fdb_start =
{	
	private ["_pos"];
	cutText ["Loading...", "BLACK FADED", 1];
	
	playMusic "EP1_Track10";
	2 fadeSound 0;
	10 fadeMusic 1;
	
	TNL_db_origPos = getPos player;
	
	_pos = getMarkerPos "debugZone";
	player setPos [(_pos select 0) + (random 100) - 50, (_pos select 1) + (random 100) - 50, 0];
	
	sleep 0.5;
	
	cutText ["Welcome to The Roleplay Project!", "BLACK IN", 3];
	
	TNL_db_introCam = "camera" camCreate [6164.32,-93545.73,-4354.97];
	TNL_db_introCam cameraEffect ["Internal", "BACK"];
	
	
	TNL_db_introCam camPrepareTarget [6164.32,-93545.73,-4354.97];
	TNL_db_introCam camPreparePos [6659.09,6354.98,43.26];
	TNL_db_introCam camPrepareFOV 0.700;
	TNL_db_introCam camCommitPrepared 0;

	waitUntil {camCommitted TNL_db_introCam};
	showCinemaBorder false;
	cutText ["Please wait while the server finishes loading.\nIt is expected to take a while, so please be patient.", "PLAIN DOWN", 15];
	enableEnvironment false;
	waitUntil {server getVariable "loaded"};
	enableEnvironment true;
	sleep 3;
	[] call TNL_fdb_rulesOpen;
	while {TNL_db_stage < 4} do
	{
		waitUntil {!dialog};
		if (TNL_db_stage >= 4) exitWith {};
		cutText ["This mission requires you to log-in.\nPress any button to open the login window.", "PLAIN DOWN", 1];
		waitUntil {dialog};
		if (TNL_db_stage >= 4) exitWith {};
		cutText  ["","PLAIN DOWN"];
	};
};

/*
Calls a function to reopen a specified dialog (based off login stage - TNL_db_stage)
Called from TNL_fui_keySpoof function (client\keySpoof.sqf)

Params:
	- Nothing
Returns:
	- Nothing
*/
TNL_fdb_force =
{
	switch (TNL_db_stage) do
	{
		case 0:
		{
			[] call TNL_fdb_rulesOpen;
		};
		case 1:
		{
			[] call TNL_fdb_welcomeOpen;
		};
		case 2:
		{
			[] spawn TNL_fdb_selectCharOpen;
		};
		case 3:
		{
			[] spawn TNL_fdb_selectCharOpen;
		};
		default
		{
			hint format ["Fatal error in TNL_fdb_force!!!\nTNL_db_stage is not declared or has a wrong value: %1", TNL_db_stage];
		};
	};
};

/*
Creates the server rules dialog

Params:
	- Nothing
Returns:
	- Nothing
*/
TNL_fdb_rulesOpen =
{
	TNL_db_stage = 0; //Initial login stage
	if (!createDialog "TNL_dlg_dbServerRules") exitWith
	{
		hint "Error in function TNL_fdb_rulesOpen - Failed to open TNL_dlg_dbServerRules dialog!";
	};
	[] spawn
	{
		((findDisplay 201) displayCtrl 1) ctrlSetStructuredText parseText (server getVariable "TNL_db_serverRules");
	};
};

/*
Creates the welcome dialog with mission description and register/login buttons

Params:
	- Nothing
Returns:
	- Nothing
*/
TNL_fdb_welcomeOpen =
{
	TNL_db_stage = 1; //1st login stage, player has already agreed to the server rules
	if (!createDialog "TNL_dlg_dbWelcome") exitWith
	{
		hint "Error in function TNL_fdb_welcomeOpen - Failed to open TNL_dlg_dbWelcome dialog!";
	};
};

/*
Creates the register dialog

Params:
	- Nothing
Returns:
	- Nothing
*/
TNL_fdb_registerOpen =
{
	if (!createDialog "TNL_dlg_dbRegister") exitWith
	{
		hint "Error in function TNL_fdb_registerOpen - Failed to open TNL_dlg_dbRegister dialog!";
	};
	
	//If user closes the dialog (ESC) he probably wants to chose login dialog instead, so lets take him back to the welcome dialog
	waitUntil {!dialog};
	if (TNL_db_stage == 1) then
	{
		[] call TNL_fdb_welcomeOpen;
	};
};

/*
Creates the login dialog

Params:
	- Nothing
Returns:
	- Nothing
*/
TNL_fdb_loginOpen =
{
	if (!createDialog "TNL_dlg_dbLogin") exitWith
	{
		hint "Error in function TNL_fdb_registerOpen - Failed to open TNL_dlg_dbLogin dialog!";
	};
	
	//If user closes the dialog (ESC) he probably wants to chose register dialog instead, so lets take him back to the welcome dialog
	waitUntil {!dialog};
	if (TNL_db_stage == 1) then
	{
		[] call TNL_fdb_welcomeOpen;
	};
};

/*
Creates the dialog to select a character to play as

Params:
	- Nothing OR Previously selected LB entry (num)
Returns:
	- Nothing
*/
TNL_fdb_selectCharOpen =
{
	private ["_chars", "_index"];
	TNL_db_stage = 2; //2nd login stage, player is already logged in
	if (!createDialog "TNL_dlg_dbSelectChar") exitWith
	{
		hint "Error in function TNL_fdb_selectCharOpen - Failed to open TNL_dlg_dbSelectChar dialog!";
	};

	
	//Request player's characters of the server
	TNL_net_returned = "";
	[
		compile format ['
		if (isServer) then
		{ 
			_player = %2;
			_var = (TNL_db_userArray select %1) select 2;
			
			[_player, _var] call TNL_fnet_returnToClient;

		};
		', TNL_db_userID,  player]
	] spawn TNL_fnet_execPublic;
	waitUntil {TNL_net_returned != ""};
	_chars = call compile TNL_net_returned;

	TNL_net_returned = null;
	
	//Player has no characters on his account, call TNL_fdb_makeCharOpen to open the character creation dialog
	if (count _chars < 1) exitWith
	{
		closeDialog 0;
		[] call TNL_fdb_makeCharOpen;
	};
	
	//Populate listbox with the returned characters
	{
		_index = lbAdd[10, format["%1 %2", _x select 0, _x select 1]];
		lbSetData[10, _index, format['["%1","%2"]', _x select 0, _x select 1]];
	} forEach _chars;
	
	TNL_db_userChars = _chars; //Globalize player's characters for future need
	
	//If previously selected entry was specified then select it, otherwise select the 1st
	if (count _this > 0) then
	{
		lbSetCurSel [10, _this select 0];
	}
	else
	{
		lbSetCurSel [10, 0];
	};
};

/*
Creates a yes/no dialog to confirm the player really wants to delete the character

Params:
	- Character ID (num)
Returns:
	- Nothing
*/
TNL_fdb_deleteCharOpen =
{
	private ["_id"];
	_id = _this select 0;

	[
		"Delete?",
		format ["Do you really want to permanently delete the character named <t font='Zeppelin33'>%1 %2</t>?", (TNL_db_userChars select _id) select 0, (TNL_db_userChars select _id) select 1],
		format ['closeDialog 0; [] spawn {closeDialog 0; [%1] call TNL_fdb_deleteChar;};', _id],
		format ['closeDialog 0; [] spawn {sleep 0.1; closeDialog 0; [%1] call TNL_fdb_selectCharOpen;};', _id]
	] spawn TNL_fui_createYesNoDlg;
};

/*
Perform a delete of the selected character

Params:
	- Character ID (num)
Returns:
	- Nothing
*/
TNL_fdb_deleteChar =
{
	private ["_id", "_firstname", "_surname"];
	_id = _this select 0;
	
	//Gonna need this for the notification
	_firstname = (TNL_db_userChars select _id) select 0;
	_surname = (TNL_db_userChars select _id) select 1;
	
	//Request removal on the server:
	[
		compile format ['
		if (isServer) then
		{ 
			((TNL_db_userArray select %1) select 2) set [%2, ">DELETE<"];
			(TNL_db_userArray select %1) set [2, ((TNL_db_userArray select %1) select 2) - [">DELETE<"]];
		};
		', TNL_db_userID, _id]
	] spawn TNL_fnet_execPublic;
	

	//Delete from the player's local character array:
	TNL_db_userChar set [_id, ">DELETE<"];
	TNL_db_userChar = TNL_db_userChar - [">DELETE<"];
	

	//Create a notification dialog:
	if (!createDialog "TNL_dlg_genNotify") exitWith
	{
		hint "Error in function TNL_fdb_deleteChar - Failed to open TNL_dlg_genNotify dialog!";
	};
	
	((findDisplay 1102) displayCtrl 1) ctrlSetStructuredText parseText "Character Deleted";
	((findDisplay 1102) displayCtrl 2) ctrlSetStructuredText parseText format ["The character named <t font='Zeppelin33'>%1 %2</t> was permanently deleted.", _firstname, _surname];
	buttonSetAction [10, 'closeDialog 0; [] spawn {sleep 0.1; closeDialog 0; [] spawn TNL_fdb_selectCharOpen;};'];
};

/*
Create a dialog to create a new character

Params:
	- [account's username (str), account's password (str)] OR Nothing
Returns:
	- Nothing
*/
TNL_fdb_makeCharOpen =
{
	private "_displ";
	TNL_db_stage = 3; //3rd login stage, player just needs to create a character
	if (!createDialog "TNL_dlg_dbMakeChar") exitWith
	{
		hint "Error in function TNL_fdb_makeCharOpen - Failed to open TNL_dlg_dbMakeChar dialog!";
	};
	
	disableSerialization;
	_displ = findDisplay 206;
	if (count _this > 0) then
	{
		(_displ displayCtrl 22) ctrlSetStructuredText parseText localize "STRS_db_accCreated";
		(_displ displayCtrl 23) ctrlSetStructuredText parseText format [localize "STRS_db_accDetails", _this select 0, _this select 1];
	}
	else
	{
		(_displ displayCtrl 22) ctrlSetStructuredText parseText localize "STRS_db_startNewLife";
		(_displ displayCtrl 23) ctrlSetStructuredText parseText localize "STRS_db_startNewLifeDesc";
	};
};

/*
For login dialog - check whether the input is correct

Params:
	- Nothing
Returns:
	- Nothing
*/
TNL_fdb_loginCheck =
{
	private ["_name", "_pw", "_displ", "_id", "_pwAcc"];
	
	_name = toLower ctrlText 1;
	_pw = ctrlText 2;
	
	disableSerialization;
	_displ = findDisplay 203;
	//Reset the texts to default:
	(_displ displayCtrl 11) ctrlSetStructuredText parseText localize "STRS_db_username";
	(_displ displayCtrl 12) ctrlSetStructuredText parseText localize "STRS_db_password";
	
	//Check for missing username and/or password:
	if (_name == "" || _pw == "") exitWith
	{
		(_displ displayCtrl 10) ctrlSetStructuredText parseText localize "STRS_db_loginMissing";
		if (_name == "") then
		{
			(_displ displayCtrl 11) ctrlSetStructuredText parseText localize "STRS_db_usernameRed";
		};
		if (_pw == "") then
		{
			(_displ displayCtrl 12) ctrlSetStructuredText parseText localize "STRS_db_passwordRed";
		};
	};
	
	//Check whether the username exists:
	TNL_net_returned = "";
	[
		compile format ['
		if (isServer) then
		{ 
			_name = %2;
			_id = ["%1"] call TNL_fdb_getUserID;
			
			[_name, _id] call TNL_fnet_returnToClient;
		};
		', _name, player]
	] spawn TNL_fnet_execPublic;
	waitUntil {TNL_net_returned != ""};
	_id = parseNumber TNL_net_returned;
	
	TNL_net_returned = null;

	if (_id == -1) exitWith
	{
		(_displ displayCtrl 10) ctrlSetStructuredText parseText localize "STRS_db_loginBadName";
		(_displ displayCtrl 11) ctrlSetStructuredText parseText localize "STRS_db_usernameRed";
	};
	
	
	//Check whether the PW matches:
	TNL_net_returned = "";
	[
		compile format ['
		if (isServer) then
		{ 
			_name = %2;
			_pw = (TNL_db_userArray select %1) select 1;
			[_name, _pw] call TNL_fnet_returnToClient;

		};
		', _id, player]
	] spawn TNL_fnet_execPublic;
	waitUntil {TNL_net_returned != ""};
	_pwAcc = TNL_net_returned;
	
	TNL_net_returned = null;
	
	if (_pw != _pwAcc) exitWith
	{
		(_displ displayCtrl 10) ctrlSetStructuredText parseText localize "STRS_db_loginBadPW";
		(_displ displayCtrl 12) ctrlSetStructuredText parseText localize "STRS_db_passwordRed";
	};
	
	TNL_db_userID = _id; //Globalize user's ID for future needs
	
	// Call TNL_fdb_selectCharOpen function to open the character selection dialog:
	closeDialog 0;
	[] call TNL_fdb_selectCharOpen;
};

/*
For register dialog - check whether the input is correct

Params:
	- Nothing
Returns:
	- Nothing
*/
TNL_db_registerCheck =
{
	private ["_name", "_pw1", "_pw2", "_displ", "_error", "_id"];
	
	_name = toLower ctrlText 1;
	_pw1 = ctrlText 2;
	_pw2 = ctrlText 3;
	
	disableSerialization;
	_displ = findDisplay 204;
	(_displ displayCtrl 11) ctrlSetStructuredText parseText localize "STRS_db_username";
	(_displ displayCtrl 12) ctrlSetStructuredText parseText localize "STRS_db_password";
	
	_error = false;
	//Check for missing username:
	if (_name == "") then
	{
		(_displ displayCtrl 11) ctrlSetStructuredText parseText localize "STRS_db_usernameRed";
		_error = true;
	};
	//Check for missing password and its verification:
	if (_pw1 == "" || _pw2 == "") then
	{
		(_displ displayCtrl 12) ctrlSetStructuredText parseText localize "STRS_db_passwordRed";
		_error = true;
	};
	if (_error) exitWith
	{
		(_displ displayCtrl 10) ctrlSetStructuredText parseText localize "STRS_db_registerMissing";
	};
	
	_error = false;
	//Check the username and PW for disallowed characters:
	if ( ([_name, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"] call TNL_fcvar_hasForbiddenChars) || (count toArray _name) > 20 ) then
	{
		(_displ displayCtrl 11) ctrlSetStructuredText parseText localize "STRS_db_firstNameRed";
		_error = true;
	};
	if ( ([_pw1, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ001234567890"] call TNL_fcvar_hasForbiddenChars) || (count toArray _pw1) > 20 ) then
	{
		(_displ displayCtrl 11) ctrlSetStructuredText parseText localize "STRS_db_usernameRed";
		_error = true;
	};
	if (_error) exitWith
	{
		(_displ displayCtrl 10) ctrlSetStructuredText parseText localize "STRS_db_charBadInput";
	};
	
	
	//Check availability of the username:
	TNL_net_returned = "";
	[
		compile format ['
		if (isServer) then
		{ 
			_name = %2;
			_id = ["%1"] call TNL_fdb_getUserID;
			
			[_name, _id] call TNL_fnet_returnToClient;
		};
		', _name, player]
	] spawn TNL_fnet_execPublic;
	waitUntil {TNL_net_returned != ""};
	_id = parseNumber TNL_net_returned;
	
	TNL_net_returned = null;

	if (_id != -1) exitWith
	{
		(_displ displayCtrl 10) ctrlSetStructuredText parseText localize "STRS_db_registerTaken";
		(_displ displayCtrl 11) ctrlSetStructuredText parseText localize "STRS_db_usernameRed";
	};
	
	//Check if password matches its verification:
	if (_pw1 != _pw2) exitWith
	{
		(_displ displayCtrl 10) ctrlSetStructuredText parseText localize "STRS_db_registerNoMatch";
		(_displ displayCtrl 12) ctrlSetStructuredText parseText localize "STRS_db_passwordRed";
	};

	
	//Add user to the database on the server:
	TNL_net_returned = "";
	[
		compile format ['
		if (isServer) then
		{ 
			TNL_db_userArray = TNL_db_userArray + [ ["%1", "%2", [] ] ];
			[TNL_gVar_str_tables_serverVars, ["TNL_db_userArray"], TNL_db_userArray] call TNL_fsav_clientRequestSave;
	
			
			_player = %3;
			_id = ["%1"] call TNL_fdb_getUserID;
			
			[_player, _id] call TNL_fnet_returnToClient;
		};
		', _name, _pw1, player]
	] spawn TNL_fnet_execPublic;
	waitUntil {TNL_net_returned != ""};
	TNL_db_userID = parseNumber TNL_net_returned;
	
	TNL_net_returned = null;
	
	//Close register dialog and call TNL_fdb_makeCharOpen for new character dialog:
	closeDialog 0;
	[_name, _pw1] call TNL_fdb_makeCharOpen;
};

/*
For create character dialog - check whether the input is correct

Params:
	- Nothing
Returns:
	- Nothing
*/
TNL_fdb_charCheck =
{
	private ["_firstname", "_surname", "_displ", "_error", "_explode"];
	
	_firstname = toLower (ctrlText 1);
	_surname = toLower (ctrlText 2);
	
	disableSerialization;
	_displ = findDisplay 206;
	(_displ displayCtrl 11) ctrlSetStructuredText parseText localize "STRS_db_firstName";
	((findDisplay 206) displayCtrl 12) ctrlSetStructuredText parseText localize "STRS_db_surname";
	
	_error = false;
	//Check for empty first name and surname:
	if (_firstname == "") then
	{
		(_displ displayCtrl 11) ctrlSetStructuredText parseText localize "STRS_db_firstNameRed";
		_error = true;
	};
	if (_surname == "") then
	{
		(_displ displayCtrl 12) ctrlSetStructuredText parseText localize "STRS_db_surnameRed";
		_error = true;
	};
	if (_error) exitWith
	{
		(_displ displayCtrl 10) ctrlSetStructuredText parseText localize "STRS_db_charNameMissing";
	};
	
	_error = false;
	//Check names for disallowed characters:
	if ( ([_firstname, "abcdefghijklmnopqrstuvwxyz"] call TNL_fcvar_hasForbiddenChars) || (count toArray _firstname) > 20 ) then
	{
		(_displ displayCtrl 11) ctrlSetStructuredText parseText localize "STRS_db_firstNameRed";
		_error = true;
	}
	else
	{
		(_displ displayCtrl 11) ctrlSetStructuredText parseText localize "STRS_db_firstName";
	};
	if ( ([_surname, "abcdefghijklmnopqrstuvwxyz'"] call TNL_fcvar_hasForbiddenChars) || (count toArray _surname) > 20 ) then
	{
		(_displ displayCtrl 12) ctrlSetStructuredText parseText localize "STRS_db_surnameRed";
		_error = true;
	}
	else
	{
		(_displ displayCtrl 12) ctrlSetStructuredText parseText localize "STRS_db_surname";
	};
	if (_error) exitWith
	{
		(_displ displayCtrl 10) ctrlSetStructuredText parseText localize "STRS_db_charBadInput";
	};
	
	_error = false;
	//Compare entered names with list of banned ones (TNL_db_bannedFirstNames and TNL_db_bannedSurnames):
	if (_firstname in TNL_db_bannedFirstNames) then
	{
		(_displ displayCtrl 11) ctrlSetStructuredText parseText localize "STRS_db_firstNameRed";
		(_displ displayCtrl 10) ctrlSetStructuredText parseText localize "STRS_db_charBannedName";
		_error = true;
	}
	else
	{
		(_displ displayCtrl 11) ctrlSetStructuredText parseText localize "STRS_db_firstName";
	};
	if (_surname in TNL_db_bannedSurnames) then
	{
		(_displ displayCtrl 12) ctrlSetStructuredText parseText localize "STRS_db_surnameRed";
		(_displ displayCtrl 10) ctrlSetStructuredText parseText localize "STRS_db_charBannedName";
		_error = true;
	}
	else
	{
		(_displ displayCtrl 12) ctrlSetStructuredText parseText localize "STRS_db_surname";
	};
	if (_error) exitWith {};

	//##### Capitalize names:
	_explode = toArray (_firstname);
	_firstname = toUpper (toString ([_explode select 0]));

	_i = 1;
	while {_i < count _explode} do
	{
		_firstname = _firstname + toString ([_explode select _i]);
		_i = _i + 1;
	};
	
	_explode = toArray (_surname);
	_surname = toUpper (toString ([_explode select 0]));

	_i = 1;
	while {_i < count _explode} do
	{
		_surname = _surname + toString ([_explode select _i]);
		_i = _i + 1;
	};

	/*		O', Mc and Al' names	-	Have to finish later:
	_surname = "";
	_no = 0;
	if (count _explode >= 3) then
	{
		if (toString ([_explode select 0] + [_explode select 1] + [_explode select 2]) == "al'") then //For names starting with Al'
		{
			_no = 4;
			_surname = toUpper (toString ([_explode select 0])) + (toString ([_explode select 1] + [_explode select 2])) + toUpper (toString ([_explode select 3]));
		}
		else
		{
			if ((toString ([_explode select 0] + [_explode select 1]) == "o'") || (toString ([_explode select 0] + [_explode select 1]) == "mc")) then //For names starting with O' or Mc
			{
				_no = 3;
				_surname = toUpper (toString ([_explode select 0])) + (toString ([_explode select 1])) + toUpper (toString ([_explode select 2]));
			};
		};
	}
	else
	{
		if (count _explode >= 2) then
		{
			if ((toString ([_explode select 0] + [_explode select 1]) == "o'") || (toString ([_explode select 0] + [_explode select 1]) == "mc")) then //For names starting with O' or Mc
			{
				_no = 3;
				_surname = toUpper (toString ([_explode select 0])) + (toString ([_explode select 1])) + toUpper (toString ([_explode select 2]));
			};
		};
	};

	while {_no < count _explode} do
	{
		_surname = _surname + toString ([_explode select _no]);
		_no = _no + 1;
	};*/

	
	//Check whether such name already exists:
	private ["_id"];
	_error = false;
	_name = format ["%1 %2", _firstname, _surname];
	_charList = users getVariable "TNL_db_charList";
	if (!(_name in _charList)) then
	{
		[
			compile format ['
				if (isServer) then
				{		
					((TNL_db_userArray select %3) select 2) set [(count ((TNL_db_userArray select %3) select 2)), ["%1", "%2"] ];
					[TNL_gVar_str_tables_serverVars, ["TNL_db_userArray"], TNL_db_userArray] call TNL_fsav_clientRequestSave;
				};
			', _firstname, _surname, TNL_db_userID]
		] spawn TNL_fnet_execPublic;

		_id = count _charList;
		_charList = _charList + [_name];
		TNL_db_charListID = _id; //Globalize character's ID in the TNL_db_charList
		users setVariable ["TNL_db_charList", _charList, true];
		[TNL_gVar_str_tables_users, [users], [ [_charList, "TNL_db_charList"] ]] call TNL_fsav_clientRequestSave;
		call compile format ["TNL_db_arrayChar%1 = []", _id]; //Create a variable to save locally all the character-related vars
		
		TNL_db_charName = [_firstname, _surname];
	}
	else
	{
		_error = true
	};
	if (_error) exitWith
	{
		(_displ displayCtrl 10) ctrlSetStructuredText parseText format [localize "STRS_db_charExists", _firstname, _surname];
		(_displ displayCtrl 11) ctrlSetStructuredText parseText localize "STRS_db_firstNameRed";
		(_displ displayCtrl 12) ctrlSetStructuredText parseText localize "STRS_db_surnameRed";
	};
	
	//[] call TNL_fdb_setCharData; //Prepare the character's data array	
	
	closeDialog 0;
	_id call TNL_fdb_selectFaceStart;
};

TNL_fdb_selectFaceStart =
{
	private ["_pos", "_name", "_id"];
	TNL_db_stage = 4;
	_id = _this;

	TNL_db_introCam cameraEffect ["Terminate", "BACK"];
	camDestroy TNL_db_introCam;
	
	_pos = player modelToWorld [0.0,0.5,1.7];
	TNL_db_faceCam = "camera" camCreate _pos;
	TNL_db_faceCam cameraEffect ["internal", "BACK"];
	TNL_db_faceCam camSetTarget player;
	TNL_db_faceCam camCommit 0;
	
	TNL_db_camAngle = getDir player;
	TNL_db_camHeight = getPos TNL_db_faceCam select 2;
	
	TNL_fdb_lastFace = -1;
	
	[] call TNL_fdb_selectFaceOpen;
	
	while {TNL_db_stage == 4} do
	{
		waitUntil {dialog};
		if (TNL_db_stage != 4) exitWith {};
		cutText  ["","PLAIN DOWN"];
		waitUntil {!dialog};
		if (TNL_db_stage != 4) exitWith {};
		cutText  ["Use your arrow keys to move the camera Up/Down/Left/Right.\nPress numeric 0 to reset to default camera position.\nPress SPACEBAR to open the face selection dialog.","PLAIN DOWN",0];
	};
};

TNL_fdb_selectFaceOpen =
{
	private ["_name", "_i", "_num", "_name", "_index"];

	if (!createDialog "TNL_dlg_dbSelectFace") exitWith
	{
		hint "Error in function TNL_fdb_selectFaceOpen - Failed to open TNL_dlg_dbSelectFace dialog!";
	};
	
	_name = (format ["%1 %2", TNL_db_charName select 0, TNL_db_charName select 1]);
	((findDisplay 207) displayCtrl 2) ctrlSetStructuredText parseText _name;
	
	_i = 1;
	while {_i <= 107} do
	{
		if (_i < 10) then
		{
			_num = format ["0%1", _i];
		}
		else
		{
			_num = str _i;
		};
		
		_name = format [localize "STRS_db_face", _i, localize (format ["str_fn_man_face%1", _num])];
		_index = lbAdd [1, _name];
		lbSetData [1, _index, _num];
		
		_i = _i + 1;
	};
	
	if (TNL_fdb_lastFace == -1) then
	{
		TNL_fdb_lastFace = round (random 106);
	};
	lbSetCurSel [1, TNL_fdb_lastFace];
};

TNL_fdb_faceUpdate =
{
	private ["_num", "_face"];
	_num = lbData [1, _this select 0];
	
	TNL_fdb_lastFace = _this select 0;
	player setFace (format ["Face%1", _num]);
};

TNL_fdb_faceMove =
{
	private ["_pos"];
	switch (_this select 0) do
	{
		case 0: //Center
		{
			TNL_db_camAngle = getDir player;
		};
		case 1: //Left
		{
			TNL_db_camAngle = TNL_db_camAngle - 2;
		};
		case 2: //Right
		{
			TNL_db_camAngle = TNL_db_camAngle + 2;
		};
		case 3: //Up
		{
			if (TNL_db_camHeight < 3) then
			{
				TNL_db_camHeight = TNL_db_camHeight + 0.02;
			};
		};
		case 4: //Down
		{
			if (TNL_db_camHeight > 0.5) then
			{
				TNL_db_camHeight = TNL_db_camHeight - 0.02;
			};
		};
	};
	
	TNL_db_faceCam setPosASL [(getPosASL player select 0) + sin TNL_db_camAngle * 0.5,(getPosASL player select 1) + cos TNL_db_camAngle * 0.5, TNL_db_camHeight + (getPosASL player select 2)];
};

TNL_fdb_faceSave =
{
	private ["_num", "_face"];
	_num = lbData [1, _this select 0];
	_face = (format ["Face%1", _num]);

	
	//Save character's face into its array
	
	//call compile format ['TNL_db_arrayChar%1 = ["%2"]', TNL_db_charListID, _face];
	//_data = [] call TNL_fdb_getCharData;
	_data = [_face];
	[_data] call TNL_fdb_setCharData;

	TNL_db_faceCam cameraEffect ["Terminate", "BACK"];
	camDestroy TNL_db_faceCam;
	
	TNL_db_introCam = "camera" camCreate [10605.24,1834.24,102.10];
	TNL_db_introCam cameraEffect ["Internal", "BACK"];
	
	TNL_db_introCam camPrepareTarget [-12950.60,97255.17,-18791.84];
	TNL_db_introCam camPreparePos [10605.24,1834.24,102.10];
	TNL_db_introCam camPrepareFOV 0.700;
	TNL_db_introCam camCommitPrepared 0;
	
	[] spawn TNL_fdb_selectCharOpen;
	
	['Money', 800] call TNL_finv_addInventoryItem;
	
	
};

/*
Final touches before player can start playing

Params:
	- Character ID (number)
Returns:
	- Nothing
*/
TNL_fdb_finalize =
{
	private ["_char", "_txt"];
	TNL_db_charID = _this select 0; //Globalize character ID for future needs
	TNL_db_charName = _this select 1; //Globalize character name for future needs
	TNL_db_stage = 5; //5th and last login stage - the player has chosen his character and is ready to play
	
	_name = format ["%1 %2", TNL_db_charName select 0, TNL_db_charName select 1];
	
	2 fadeSound 1;
	10 fadeMusic 0;
	
	TNL_db_charListID = _name call TNL_fdb_nameGetId;

	[player, ([] call TNL_fdb_getCharData) select 0] call TNL_fdb_setFace; //Call function to update player's faces for connected clients
	[] spawn TNL_fjip_updateFaces; //Call function to load everyone's faces
	
	//Prepare welcome message based on time of day:
	if (dayTime > 0 && dayTime < 12) then
	{
		_txt = format [localize "STRS_db_welcomeMorning", _name];
	}
	else
	{
		if (dayTime >= 12 && dayTime < 18) then
		{
			_txt = format [localize "STRS_db_welcomeAfternoon", TNL_db_charName select 0, TNL_db_charName select 1];
		}
		else
		{
			_txt = format [localize "STRS_db_welcomeEvening", TNL_db_charName select 0, TNL_db_charName select 1];
		};
	};
	
	player setPos TNL_db_origPos; //Return player to his original positon
	
	//Destroy camera, show welcome message:
	TNL_db_introCam cameraEffect ["Terminate", "BACK"];
	camDestroy TNL_db_introCam;
	cutText [_txt, "BLACK FADED", 0];
	sleep 2;
	cutText [_txt, "BLACK IN", 2];
	
	_currentUsers = users getVariable "currentUsers";
	_currentUsers set[(count _currentUsers), [name player, TNL_db_charName select 0, TNL_db_charName select 1]];
	users setVariable ["currentUsers", _currentUsers, true];
	_name = format ["%1 %2", TNL_db_charName select 0, TNL_db_charName select 1];
	
	[{  
		if (isServer) then 
		{ 
			[(_this select 0), (_this select 1), (_this select 2)] call TNL_fsav_clientRequestLoad; 
		{ if (not (_x select 3)) then { [str (_x select 0), (_this select 0), (_this select 1), (_this select 3)] call TNL_fsav_clientLoadSetVariables; }; } forEach Gvar_arr_trunk_storages;
		
		}; 
	}, [TNL_db_charName select 0, TNL_db_charName select 1, TNL_gVar_arr_tables_clientLoad, TNL_gVar_arr_tables_localStoragesLoad]] call TNL_fnet_execPublic; 
	
	sleep 6;
	[] call TNL_fmarkers_revealAllMarkers;
	[] call TNL_fmarkers_revealFoundMarkers;
	
	[] call TNL_fps_loadShopMarkers;
	
	if (count TNL_wallet_walletArray == 0) then
	{
		["idCard", _name call TNL_fdb_nameGetId, TNL_db_charName select 0, TNL_db_charName select 1, false, 100] call TNL_fwallet_addItem;
	};
};

TNL_fdb_handleInput =
{
	private ["_idc", "_full", "_text"];
	_idc = _this select 0;
	_full = _this select 1;
	_text = ctrlText _idc;
	
	if (_full) then
	{
		_text = [_text, "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZWXYZ!@#$%^&*()<>.,_-+=/?"] call TNL_fcvar_stringFilter;
	}
	else
	{
		_text = [_text, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZWXYZ"] call TNL_fcvar_stringFilter;
	};
	_text = [_text, 20] call TNL_fcvar_stringShorten;
	
	ctrlSetText [_idc, _text];
};

TNL_fdb_nameGetId =
{
	private ["_name", "_chars", "_id"];
	_name = _this;
	_chars = users getVariable "TNL_db_charList";
	
	_id = _chars find _name;
	
	_id
};

TNL_fdb_idGetName =
{
	private ["_id", "_chars", "_name"];
	_id = _this;
	_chars = users getVariable "TNL_db_charList";
	
	
	if (_id < count _chars) then
	{
		_name = _chars select _id;
	}
	else
	{
		_name = "";
	};
	
	_name
};
/*
[  username, [pw, [id1, id2]] ]
db_username = [ [firstname1, surname1, [data1, data2]], [firstname2, surname2, [data1, data2]] ]
*/

TNL_fdb_setCharData =
{
	private ["_new", "_id"];
	_new = _this select 0;
	_id = TNL_db_charListID;
	
	if (typeName _this == "ARRAY") then
	{
		if (count _this > 1) then
		{
			_id = _this select 0;
			_new = _this select 1;
		};
	};
	
	call compile format ['users setVariable ["TNL_db_charData%1", _new, true]', _id];
};
TNL_fdb_getCharData =
{
	private ["_id", "_data"];
	if (typeName _this == "ARRAY") then
	{
		if (count _this == 0) then
		{
			_id = TNL_db_charListID;
		}
		else
		{
			_id = _this select 0;
		};
	}
	else
	{
		_id = _this;
	};
	call compile format ['
	if (isNil {users getVariable "TNL_db_charData%1"}) then
	{
		_data = [];
	}
	else
	{
		_data = users getVariable "TNL_db_charData%1";
	};
	', _id];
	_data	
};

TNL_fdb_setFace =
{
	_unit = _this select 0;
	_face = _this select 1;
	
	[
		compile format ['
			%1 setFace "%2";
			diag_log text "TNL>>>Updating face for %1 to %2";
		', _unit, _face]
	] spawn TNL_fnet_execPublic;
};