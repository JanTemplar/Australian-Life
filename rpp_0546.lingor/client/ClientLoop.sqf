/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

//Timer ticks
_markerTicks = 0; //Marker ticks
_hintTicks = 0; //Extended Hint ticks
_hungerTicks = 0; //Hunger ticks
_thirstTicks = 0; //Thirst ticks 
_actionTicks = 0; //Action ticks 
_timeTicks = 0; //time ticks
_gatherTicks = 0; //Gather ticks
_skillsSaveTicks = 0; //Skills Saving ticks

while {true} do //endless loop
{	
	if (round(_markerTicks) == 3.0) then 
	{	 
		[] spawn TNL_fmarkers_revealCheck; //Check if any markers need revealing
		_markerTicks = 0; //reset marker ticks
	}; //markers
	
	if (round(_hintTicks) == 2.0) then 
	{
		[] spawn TNL_fextHint_Refresh; //Refresh the hints to make sure any need removing
		_hintTicks = 0; //reset hint ticks
	}; //extended hint
	
	if (round(_hungerTicks) == Gvar_int_player_hungerLoopTime) then //if hunger ticks = hunger loop time (defined in defineVars.sqf)
	{
		[] spawn TNL_fhunger_hungerLoop; //hunger loop
		_hungerTicks = 0; //reset hunger ticks
	}; //hunger
	
	if (round(_thirstTicks) == Gvar_int_player_thirstLoopTime) then //if thirst ticks = thirst loop time (defined in defineVars.sqf)
	{
		[] spawn TNL_fthirst_thirstLoop; //thirst loop
		_thirstTicks = 0; //reset thirst ticks
	}; //thirst
	
	if (round(_actionTicks) == 1.0) then 
	{
		if !(TNL_factions_curAddingActions) then
		{
			[] spawn TNL_factions_actionsLoop; //add or remove actions
		};
		_actionTicks = 0; //reset action ticks
	}; //actions
	
	if (round(_timeTicks) == TNL_gVar_int_clientTimeLoopTicks) then //if time ticks = time loop (defined in timeDefine.sqf)
	{
		[] spawn TNL_ftime_clientTimeLoop; //increase time
		_timeTicks = 0; //reset time ticks
	}; //time 
	
	if (round(_gatherTicks) == 5.0) then
	{
		[] spawn TNL_fgather_checkGatheredLocations;
		_gatherTicks = 0;
		
		if (typeOf (vehicle player) in ["Fishing_Boat"]) then
		{
			[] spawn RPP_fnc_inFishingBoat;
		};
	};
	
	if (_skillsSaveTicks == 900) then
	{
		if (not (isNil "TNL_db_charName")) then
		{
			[TNL_gVar_str_tables_skills, [TNL_db_charName select 0, TNL_db_charName select 1], TNL_gVar_arr_skills] call TNL_fsav_clientRequestSave;
		};
		_skillsSaveTicks = 0;		
	};
	
	_weight = call TNL_finv_getPlayerWeight;
	if ((_weight select 0) > (_weight select 1)) then
	{
		[] call TNL_finv_isOverWeight;
	};
	
	
	//increase time ticks
	_skillsSaveTicks = _skillsSaveTicks + 1;
	_gatherTicks = _gatherTicks + 1.0;
	_timeTicks = _timeTicks + 1.0; 
	_actionTicks = _actionTicks + 1.0;
	_thirstTicks = _thirstTicks + 1.0;
	_markerTicks = _markerTicks + 1.0;
	_hintTicks = _hintTicks + 1.0;
	_hungerTicks = _hungerTicks + 1.0;
	sleep 1; 
}; //loop