_art = _this select 0;

if (_art == "use") then 
{
	if (!(createDialog "DlgMobilePhone")) exitWith {hint "Dialog Error!";};
	
	{
		_index = lbAdd[2, format["%1", (name _x) call TNL_fplayer_formatName]];
		lbSetData[2, _index, format["%1", _x]];
	} forEach ([] call TNL_cfplayer_activeSlots);
	
	_index = lbAdd[2, "Police"];
	lbSetData[2, _index, "POLICE"];
	
	lbSetCurSel [2, 0];
	ctrlSetText [4, format["SMS Price: $%1", SMS_Cost]];
	buttonSetAction [3, "[""sendsms"", ctrlText 1, lbData [2, lbCurSel 2], player] execVM ""slr\phones.sqf""; closedialog 0;"];
};
	
if (_art == "sendsms") then 
{
	_smstext = _this select 1;
	_smsplayer = _this select 2;
	_player = _this select 3;
	_money = "money" call TNL_finv_getItemAmount;
	
	if (_smsplayer == "POLICE") exitWith
	{
		[{
			if (([player, "COP"] call TNL_fmission_playerIsType)) then
			{
				[format["POLICE CALL (%1): %2", (_this select 0), (_this select 1)]] call TNL_fextHint_Hint;
				_markername = format["police_call_%1_%2", (_this select 0), (round time)];
				_markercreatepos = getpos (_this select 0);
				_markerrams = createMarkerLocal [_markername, _markercreatepos];
				_markername setMarkershapeLocal "icon";
				_markername setMarkerColorLocal "ColorRed";
				_markername setMarkerSizeLocal [1, 1];
				_markername setMarkerTypeLocal "Marker";
				_markername setMarkerTextLocal format["Police call from %1", (name (_this select 0)) call TNL_fplayer_formatName];
				
				[_markerName] spawn
				{
					sleep 120;
					deleteMarkerLocal (_this select 0);
				};
			};
		}, [_player, _smstext]] call TNL_fnet_execPublic;
	};

	_smsplayer = call compile (_this select 2);

	if (_smstext == "")	exitWith 
	{
		["You cant send a SMS with no text!"] call TNL_fextHint_Hint;
	};
	
	if (isNull _smsplayer) exitWith 
	{
		["Player does not exist!"] call TNL_fextHint_Hint;
	};
	
	if (_money < SMS_Cost) exitWith 
	{
		["No money!"] call TNL_fextHint_Hint;
	};
	
	if (count (toArray _smstext) > 1500) exitWith 
	{
		["Too long..."] call TNL_fextHint_Hint;
	};
	
	['money', -(SMS_Cost)] call TNL_finv_AddInventoryItem;
	[format ["You sent an SMS to %1", _smsplayer]] call TNL_fextHint_Hint;
	
	[{	
		if (((_this select 1) == player) and (("mobilephone" call TNL_finv_getItemAmount) > 0)) then
		{
			[format["(%2) %1", (_this select 0), (name (_this select 2)) call TNL_fplayer_formatName]] call TNL_fextHint_Hint;
			//Play sound
			player say ["SndSMSAlert",5];
		};
		
		if (((_this select 1) == player) and (("mobilephone" call TNL_finv_getItemAmount) == 0)) then
		{
			[{ if (player == (_this select 0)) then { ["He does not have a mobile phone"] call TNL_fextHint_Hint;};}, [(_this select 2)]] call TNL_fnet_execPublic;
		};
	}, [_smstext, _smsplayer, player]] call TNL_fnet_execPublic;
};
