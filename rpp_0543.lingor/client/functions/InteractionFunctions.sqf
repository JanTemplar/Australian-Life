/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

TNL_finteraction_openDialog = 
{
	private ["_unit"];
	_unit = _this select 0;
	
	if (!createDialog "DlgInteraction") then
	{
		hint "OMGZ!! ERROR in script InteractionFunctions.sqf at function TNL_finteraction_openDialog failed to createDialog!";
	};
	
	[_unit] spawn TNL_finteraction_loadDialog;
};

TNL_finteraction_loadDialog =
{
	private ["_unit"];
	_unit = _this select 0;
	
	sleep 0.005;
	
	lbClear 1;
	
	
	{
		_canUse = false;
		_canUseOn = false;
		
		{
			if ([player, (_x)] call TNL_fmission_playerIsType) then
			{
				_canUse = true;
			};
		} foreach (_x select 0);
		
		{
			if ([_unit, (_x)] call TNL_fmission_playerIsType) then
			{
				_canUseOn = true;
			};
		} foreach (_x select 3);
		
		if ((_canUse) && (_canUseOn)) then
		{
			_index = lbAdd[1, format["%1", ((_x select 1) select 0)]];
				lbSetData[1, _index, format['[%1,"%2"]',(_unit), ((_x select 1) select 1)]];
		};
	
	} foreach Gvar_arr_mission_playerInteractionActions;

};

TNL_finteraction_useAction = 
{	
	private ["_data"];
	_data = call compile (_this select 0);
	_execute = (_data select 1) call TNL_finteraction_getCode;
	call compile format['%1', _execute];
};

TNL_finteraction_getCode = 
{
	private ["_actionClass", "_returnStr"];
	_actionClass = _this;
	_returnStr = "";
	{
		if (((_x select 1) select 1) == (_actionClass)) then
		{
			_returnStr = (_x select 2);
		};
	
	} foreach Gvar_arr_mission_playerInteractionActions;
	
	_returnStr
};
