TNL_fs_getTax =
{
	private ["_type", "_tax"];
	_type = _this;
	_tax = 0;
	
	{
		if (_type == (_x select 1)) then
		{
			_tax = (_x select 2);
		};
	} forEach INV_ItemTypenArray;

	_tax
};

/* Run to get the bounty on the civilian */
SLR_fw_getBounty = 
{
	private ["_civ"];
	_civ = _this;
	_civbounty = call compile format ["bounty_%1", _civ];
	
	if (_civbounty != 0) then 
	{
		if (_civbounty > wantedbonus) then 
		{
			['money', wantedbonus] call TNL_finv_AddInventoryItem;
			[format["You got a wanted bonus of $%1", wantedbonus]] call TNL_fextHint_Hint;
		};
		
		['money', _civbounty] call TNL_finv_AddInventoryItem;
		call compile format ["bounty_%1 = 0; publicVariable ""bounty_%1""; ", _civ];
		
		[format ["You got a bounty of $%1", _civbounty]] call TNL_fextHint_Hint;
	};

	call compile format ["%1_wanted = 0; publicVariable ""%1_wanted"";", _civ];
};

/* Switch wanted true/false */
TurnWantedFunc = 
{
	if (_this) then 
	{
		call compile format ["civ%1_wanted = 1; publicVariable ""civ%1_wanted"";", rolenumber];
	} 
	else 
	{
		call compile format ["civ%1_wanted = 0; publicVariable ""civ%1_wanted"";", rolenumber];
	};
};

/* Adds log to the crime log */
SLR_fw_addCrimeLog =
{
	private ["_logtime", "_logdate", "_logtext", "_logType", "_logPlayer", "_logInfos"];
	_logType     = _this select 0;
	_logPlayer  = format["%1", _this select 1];
	_logInfo = "";
	
	if (count _this > 2) then 
	{
		_logInfo = _this select 2;
	};
	
	
	_logtime    = format ["%1:%2", date select 3, date select 4];
	_logdate    = format["%1/%2/%3", date select 1, date select 2, date select 0];
	_logtext    = "";
	switch (_logType) do 
	{
		case "Bank":      {_logtext = format["Robbed the bank and stole $%1", _logInfo];};
		case "Stole":     {_logtext = format["Stole money from another civ."];};
		case "KilledCiv": {_logtext = format["Killed another civ", _logInfo];};
		case "KilledCop": {_logtext = format["Killed another cop", _logInfo];};
		case "PrisonIn":  {_logtext = format["Was sent to prison"];};
		case "PrisonOut": {_logtext = format["Was released from prison"];};
		case "PrisonEsc": {_logtext = format["Escaped from prison"];};
		case "Died":      {_logtext = format["Has died"];};
		case "Ticket":    {_logtext = format["Paid a ticket of $%1", _logInfo];};
		case "Bomb":      {_logtext = format["Used a bomb"];};
		case "terrorIn":  {_logtext = format["Entered the terror camp"];};
	};

	CopLog = CopLog + [ [_logplayer, _logtext, _logdate, _logtime] ];
};

//Deletes vehicle after an amount of time
SLR_SafeDeleteVehicle = 
{
	private ["_vcl", "_deltime"];
	_vcl     = _this select 0;
	_deltime = _this select 1;
	sleep _deltime;
	if (not(isNull(_vcl))) then
	{
		_vcl setVehicleInit "";
		call compile format["%1 = nil;", _vcl];
		deleteVehicle _vcl;			
	};
};

SLR_CreateObject = 
{													
	private ["_classname", "_position", "_dir", "_objname"];												
	_classname = _this select 0;							
	_position  = _this select 1;							
	_dir       = 0; 
	if (count _this > 2) then 
	{
		_dir = _this select 2;
	};				
	_objname   = "";		
   
	call compile format ['				
	object_%1_%2 = _classname createVehicle [0,0,0]; 
	object_%1_%2 setVehicleInit "this setVehicleVarName ""object_%1_%2""; object_%1_%2 = this; clearWeaponCargo this; clearMagazineCargo this;"; 										
	_objname = "object_%1_%2";																										
	processInitCommands;												
	object_%1_%2 setdir %4;																				
	object_%1_%2 setPos %3;														
	INV_ObjectsArray = INV_ObjectsArray + [object_%1_%2];						
	[{INV_ServerObjArray = INV_ServerObjArray + [(_this select 0)];}, [object_%1_%2]] call TNL_fnet_execPublic;															
	', player, round(time), _position, _dir];		
   
   _objname
};
   
SLR_DeleteObject = 
{										
	[{						
		if (not (isNil (str(_this select 0)))) then 
		{						
			if (not(isNull (_this select 0))) then 
			{																								
				if (isServer) then 
				{
					(_this select 0) setVehicleInit """";
				};	
				
					INV_ObjectsArray   = INV_ObjectsArray - [(_this select 0)]; 																																								
					INV_ServerObjArray = INV_ServerObjArray - [(_this select 0)];																																																								
				if (isServer) then 
				{
					deleteVehicle (_this select 0);
				};		
			};																																	
			//(_this select 0) = nil;																
		};								
	}, [_this]] call TNL_fnet_execPublic;
};
