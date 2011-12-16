RPP_fnc_radioCreateChannel =
{
	private ["_freq", "_group"];
	_freq = _this;
	
	_group = createGroup civilian;
	"Logic" createUnit [[1,1,1], _group, format ['radio_channel_%1 = this; this disableConversation true; this setVariable ["BIS_noCoreConversations", true];', _freq]];
	radio_logic setVariable ["channels", (radio_logic getVariable "channels") + [_freq], true];
};

RPP_fnc_radioJoinChannel =
{
	_freq = _this;
	
	if (!(_freq call RPP_fnc_radioChannelExists)) then
	{
		[{
			if (isServer) then
			{
				(_this select 0) call RPP_fnc_radioCreateChannel;
			};
		}, [_freq]] call TNL_fnet_execPublic;
	};
	[{
		if (isServer) then
		{
			call compile format ['[%2] joinSilent group radio_channel_%1', (_this select 1), (_this select 0)];
		};
		
		if (player == (_this select 0)) then
		{
			call compile format ['[%2] joinSilent group radio_channel_%1', (_this select 1), (_this select 0)];
		};
	}, [player, _freq]] call TNL_fnet_execPublic;
	
	[] spawn
	{
		waitUntil {("radio" call TNL_finv_getItemAmount <= 0)};
		[{  [(_this select 0)] joinSilent grpNull; }, [player]] call TNL_fnet_execPublic;
	};
};

RPP_fnc_radioChannelExists =
{
	private ["_freq", "_return"];
	_freq = _this;
	_return = false;
	
	if (_freq in (radio_logic getVariable "channels")) then
	{
		_return = true;
	}
	else
	{
		_return = false;
	};

	_return
};