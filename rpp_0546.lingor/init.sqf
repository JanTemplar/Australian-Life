/*
Name: init.sqf
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (2009/05/28)
Description: Mission init
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

#define __isServer ((isDedicated) && (isServer))

TNL_version = 0.542;

//Enable (true) / Disable (false) debug mode:
TNL_debug = false;

//Enable (true) / Disable (false) database saving (using external tool):
TNL_savingEnabled = false;


// If enabled no scripts at all will be loaded. Use for quick testing of anything that doesn't need them
TNL_quickTest = false;
sleep 0.1;
showCinemaBorder false;

if (TNL_quickTest) exitWith 
{
	//createDialog "TNL_dlg_genSlider";
	onMapSingleClick "vehicle player setPos _pos";
	sleep 0.1;
	sleep 0.1;
	cutText ["Quick test mode enabled, no scripts were loaded!", "PLAIN DOWN"];
	
	[] spawn
	{
	
		player addweapon "M9";
		_found = false;
		_obj = empty;
		while {not _found} do
		{
			_objs = nearestObjects[player,["WEAPONHOLDER"],3];
			_pistols = [ "M9" ];
			{
				_content = getWeaponCargo _x;
				_obj = _x;
				{
					player groupchat format["%1 %2", _x, typeName _x];
					if ((_x select 0) in _pistols) exitWith
					{
						player groupchat "Found!";
						_found = true;
					};
				} forEach _content;
				
				if (_found) exitWith
				{
				};
			
			} forEach _objs;
			sleep 0.001;
		};
		
		_obj attachTo [player,[-0.4,0.50,1.0]];
		_obj setDir 60;
		_obj setVectorDirAndUp [[-1,3,1],[-1,3,1]];
		
		//player switchMove "ActsPercMstpSnonWpstDnon_sceneBardakPistol01";
		player groupchat "Attaching!";
	};
			
	
	
	//createDialog "DlgEmployeeOpen";
	
	//"B_30mm_HE" createVehicle getpos test_dummy;
};

startLoadingScreen ["Starting The Roleplay Project", "RscDisplayLoadMission"];

TNL_core_lenghtDay = 60;



//Misc
_h = execVM "tableNames.sqf";
waitUntil {scriptDone _h};

_h = execVM "functions.sqf";
waitUntil {scriptDone _h};

_h = execVM "DefineVars.sqf";
waitUntil {scriptDone _h};

progressLoadingScreen 0.25; //Misc

if (isServer) then 
{
	dbCodeA = compile preProcessFile "\database\fileIO.sqf";
	publicVariable "dbCodeA";
	dbCodeB = compile preProcessFile "\database\mySQL.sqf";
	publicVariable "dbCodeB";
	dbCodeC = compile preProcessFile "\database\databaseDefine.sqf";
	publicVariable "dbCodeC";
	dbCodeD = compile preProcessFile "\database\databaseFunctions.sqf";
	publicVariable "dbCodeD";
};

//Common
_h = execVM "common\load.sqf";
waitUntil {scriptDone _h};

progressLoadingScreen 0.50; //Finished loading common scripts

// Server:
if (isServer) then
{
	_h = execVM "\scripts\serverLoad.sqf";
	waitUntil {scriptDone _h};
	
	[TNL_gVar_arr_tables_serverLoadAll] spawn TNL_fsav_serverLoad;
};

// Client:
if (!__isServer) then
{
	_h = execVM "client\load.sqf";
	waitUntil {scriptDone _h};
};

//SLR ported stuff
_h = execVM "slr\init.sqf";


progressLoadingScreen 0.75;

// Join in progress:
[] spawn TNL_fJIP_joinedServer;
onPlayerConnected "[_id, _name, _uid] spawn TNL_fJIP_onPlayerConnected;";
onPlayerDisconnected "[_id, _name, _uid] spawn TNL_fJIP_onPlayerDisconnected;";


endLoadingScreen; //Finished loading	


//##### TESTING PART BELLOW #######################################

//need to find a place for this later:
TNL_db_bannedFirstNames = ["corporation"];
TNL_db_bannedSurnames = ["corporation"];


player addEventHandler ["killed", "[_this select 0, _this select 1] call TNL_fres_killed;"];
player addEventHandler ["fired",  {["fired", (_this select 4)] execVM "slr\stun.sqf" }];

['keychain', 1] call TNL_finv_addInventoryItem;
['Wallet', 1] call TNL_finv_addInventoryItem;

if (TNL_debug) then
{
	['Pickaxe_iron', 1] call TNL_finv_addInventoryItem;
	['money', 15000] call TNL_finv_addInventoryItem;
	['Fishing_rod', 1] call TNL_finv_addInventoryItem;
	['Minnow', 2] call TNL_finv_addInventoryItem;
	['ClayPot', 5] call TNL_finv_addInventoryItem;
	//['CisternFuelCan', 2] call TNL_finv_addInventoryItem;
	['RepairKit', 1] call TNL_finv_addInventoryItem;
	['RefuelCan', 1] call TNL_finv_addInventoryItem;
	['Lockpick', 1] call TNL_finv_addInventoryItem;
	['Crowbar', 1] call TNL_finv_addInventoryItem;
	['Fishing_net', 1] call TNL_finv_addInventoryItem;
	['radio', 1] call TNL_finv_addInventoryItem;
	['ButcheringKnife', 1] call TNL_finv_addInventoryItem;
	onMapSingleClick "vehicle player setPos _pos";
	
	[] spawn
	{
	
	};
};

if (name player == "Weed") then
{
	onMapSingleClick "vehicle player setPos _pos";
};

if (!__isServer && !TNL_debug) then
{
	[] call TNL_fdb_start;
}
else
{
	//TNL_db_charName = ["Matthew", "Simms"];
	//TNL_db_charID = 0;
	//["idCard", TNL_db_charID, TNL_db_charName select 0, TNL_db_charName select 1, false, 100] call TNL_fwallet_addItem;
};



sleep 2;

sleep 2;



