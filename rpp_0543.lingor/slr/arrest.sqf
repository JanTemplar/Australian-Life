_type = (_this select 0);

if (_type == "createDlg") then
{
	createDialog "TNL_dlg_genSliderInput";
	_unitObj = call compile (_this select 1);
	UnitInteractWi = _unitObj;
	
	sliderSetPosition[13, 5];
	sliderSetRange[13, 1, 45];
	
	((findDisplay 901) displayCtrl 1) ctrlSetStructuredText parseText "Arrest Menu";
	((findDisplay 901) displayCtrl 2) ctrlSetStructuredText parseText "Set the time you want to arrest the civilian for!";
	((findDisplay 901) displayCtrl 10) buttonSetAction "[""clientArrest"", [round(sliderPosition 13),UnitInteractWi]] execVM ""slr\arrest.sqf""; closeDialog 0;";
	
	while {!(isNull(findDisplay 901))} do
	{
		((findDisplay 901) displayCtrl 12) ctrlSetText format["Time: %1 Minutes", round(sliderPosition 13)];
		sleep 0.2;
		
		if (player distance (getpos _unitObj) >= 10) exitWith
		{
			//hint "The civilian has moved too far away!";
			closeDialog 0;
		};
	};
	
	UnitInteractWi = null;
};

if (_type == "arrest") then
{
	[] call TNL_finv_removeIllegalItems;
	
	local_arrest    = 1;
	//["local_arrest", local_arrest] spawn ClientSaveVar;
	
	// Set Civ Hunger + Thirst to 0, Nutrition to 100 so they Cannot Starve in Jail
	Gvar_int_player_hunger = 60;
	Gvar_int_player_thirst = 60;
	
	holmenu = 0;
	unholmenu = 0;
	holstervar = false;
	unholstervar = false;
	phasweapon  = false;
	HandWeapon = false;

	player setDamage 0;
	
	CivTimeInPrison = (_this select 1);
	[format["You have been arrested for %1 minutes!", CivTimeInPrison]] call TNL_fextHint_Hint;
};

/* Server arrest */
if (_type == "serverArrest") then
{
	_civObj      = _this select 1;
	_jailTime = (_this select 2)*60;
	_timeMinutes = (_this select 2);
	_copObj      = _this select 3;
	_exitart     = "";
	
	//Set vars so server knows the civilian has been arrested.
	call compile format ['%1_arrest = 1; publicVariable "%1_arrest"; %1_markerjammed = 0; publicVariable "%1_markerjammed";', _civobj];
	
	//Move civilian to jail and wait for him to get there.
	showMap true;
	_civobj setPos getMarkerPos "prisonspawn";
	waitUntil {_civobj Distance prison_logic < 100};
	
	//Public code to notify public and execute arrest locally for the civilian
	[{
		["PrisonIn", (_this select 0)] call SLR_fw_addCrimeLog;
		if (player == (_this select 0)) then 
		{
			["arrest", (_this select 3)] execVM "slr\arrest.sqf";
			false call TurnWantedFunc;
		}; 
		
		[format ["%1 has been arrested for %2 minutes by %3!", (name (_this select 0)) call TNL_fplayer_formatName, (_this select 3), (name (_this select 2)) call TNL_fplayer_formatName]] call TNL_fextHint_Hint;
	}, [_civobj, _jailTime, _copobj, _timeMinutes]] call TNL_fnet_execPublic;
	
	//Wait and do checks until the prisoner is released or escapes.
	_counter = 0;
	while {true} do 
	{
		_civArrest = call compile format ["%1_arrest", _civobj];
		
		if (isNull(_civobj)) exitWith //Prisoner has left the game
		{
			_exitart = "";
		};
		
		if (!(alive _civobj)) exitWith //Prisoner has died
		{
			_exitart = "died";
		};
		
		if (_counter >= _jailTime) exitWith //Prisoner ready to be released
		{
			_exitart = "servedtime";
		};
		
		if (_civArrest == 0) exitWith //Prisoner to be released for other reasons
		{
			_exitart = "other";
		};
		
		if (_civobj Distance prison_logic >= 100) exitWith //Prisoner has escaped
		{
			_exitart = "escaped";
		};
		
		sleep 5;
		_counter = _counter + 5;
	};
	
	if ((_exitart == "servedtime") or (_exitart == "other")) then //Ready to release
	{
		call compile format ["%1_arrest = 0; publicVariable ""%1_arrest""", _civobj];
		_civobj setPos getMarkerPos "jail_freemarker"; //Move prisoner out of jail
		
		//Public code to release prisoner from jail
		[{
			["PrisonOut", (_this select 0)] call SLR_fw_addCrimeLog;
			if (player == (_this select 0)) then //Crimelog entry to be added
			{
				local_arrest = 0; 
				//["local_arrest", local_arrest] spawn ClientSaveVar; 
				["You are free from prison!"] call TNL_fextHint_Hint;
			}; 
			
			[format ["%1 is now free from jail!", (_this select 0)]] call TNL_fextHint_Hint;
		}, [_civobj]] call TNL_fnet_execPublic;
	};
	
	if (_exitart == "escaped") then //Escaped
	{
		//Public code for escaped prisoner
		[{
			["PrisonEsc", (_this select 0)] call SLR_fw_addCrimeLog;
			if (player == (_this select 0)) then 
			{
				local_arrest = 0; 
				//[""local_arrest"", local_arrest] spawn ClientSaveVar;
			}; 
			call compile format ["%1_arrest = 0;  %1_wanted = 1;", (_this select 0)];
			[format ["%1 has escaped from prison!", (_this select 0)]] call TNL_fextHint_Hint;
		}, [_civobj]] call TNL_fnet_execPublic;
	};
};

if (_type == "clientArrest") then
{
	_time = ((_this select 1) select 0); //Time to be in prison for (needs to be multiplied by 60 for minutes)
	_criminal = ((_this select 1) select 1); //Civilian to be arrested.

	[{if (isServer) then {["serverArrest", (_this select 0), (_this select 1), (_this select 2)] execVM "slr\arrest.sqf";}; }, [_criminal, _time, player]] call TNL_fnet_execPublic;
	[format ["You have arrested %2 for %1 minutes!", _time, (name _criminal) call TNL_fplayer_formatName]] call TNL_fextHint_Hint; //Arrest message for cop
	_criminal call SLR_fw_getBounty;
};