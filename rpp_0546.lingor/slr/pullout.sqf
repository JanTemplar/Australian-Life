_who = _this select 1;
_car = _this select 0;
_rem = 0;
_pull = 0;
_num = 0;
_crew = crew _car;

closeDialog 0;

if ((count _crew) < 1) exitWith
{
	_who groupChat "The car is empty.";
};

if ((_who in _crew)) exitWith
{
	_who groupChat "Not possible in a vehicle.";
};

if (_who distance (_crew select 0) > 3) exitWith
{
	_who groupChat "You have to be closer.";
};

//_car removeAction _pullout;
_rem = 1;
	
if (alive _who) then
{
	_who groupChat format ["You're pulling out %1. Stay close to the car!", (name (_crew select 0)) call TNL_fplayer_formatName];
	[{ if (player == (_this select 0)) then { player groupChat format ["%1 is pulling you out of the car!", (_this select 1)]; }; }, [(_crew select 0), _who]] call TNL_fnet_execPublic;
	
	_rem = 1;

	_said = 0;

	while {_num < 10} do
	{
		if (_who distance (_crew select 0) > 3) exitWith
		{
			_who groupChat "You were too far away.";
			//pullout = player addAction ["Pull out", "pullout.sqf", "", 2];
			_num = 11;
		};
				
		if (locked _car) then
		{
			if (_said == 0) then
			{
				_said = 1;
				_who groupChat "The car's locked. This might take a while.";
				sleep 0.3;
			};
		};

		sleep 0.3;
		_pull = _pull + 1;
		_num = _num + 1;
	};

	if (_pull == 10) then
	{
		//pullout = player addAction ["Pull out", "pullout.sqf", "", 2];

		//_car lock false;

		[{(_this select 0) switchMove "AmovPercMstpSnonWnonDnon_AcrgPknlMstpSnonWnonDnon_getInLow";},[_who]] call TNL_fnet_execPublic;
		sleep 0.4;
		//_who globalChat format ["I have pulled %1 out of a car!", (_crew select 0)];


		[{
			if (player == (_this select 0)) then
			{
				_car = vehicle player;
				_victim = player;

				player action ["eject", _car];
			};
			(_this select 0) switchmove "AmovPercMrunSlowWrflDf_AmovPpneMstpSrasWrflDnon";
		}, [(_crew select 0)]] call TNL_fnet_execPublic;

		//(_crew select 0) action ["eject",_car];
	};
}
else
{
	if ({!(_x in ["Throw", "Put", "NVGoggles", "Binocular"])} count (weapons _who) == 0 && (locked car)) exitWith
	{
		_who groupChat "The car's locked. I would need a gun to smash the window...";
	};
	
	_who groupChat format ["You're pulling out %1. Stay close to the car!", (_crew select 0)];
//	(_crew select 0) globalChat format ["Help! %1 is pulling me out of a car!", _who];
	(_crew select 0) groupChat format ["%1 is pulling you out of the car!", _who];
	
	//player removeAction pullout;
	_rem = 1;

	_said = 0;
	while {_num < 10} do
	{
		if (_who distance (_crew select 0) > 3) exitWith
		{
			_who groupChat "You were too far away.";
			//pullout = player addAction ["Pull out", "pullout.sqf", "", 2];
			_num = 11;
		};
				
		if ({!(_x in ["Throw", "Put", "NVGoggles", "Binocular"])} count (weapons _who) == 0 && (locked car)) exitWith
		{
			_who groupChat "He locked it! I would need a gun to smash the window now...";
			_pull = -10;
			//pullout = player addAction ["Pull out", "pullout.sqf", "", 2];
		};		

		if (locked _car) then
		{
			if ({!(_x in ["Throw", "Put", "NVGoggles", "Binocular"])} count (weapons _who) == 0) exitWith
			{
				_who groupChat "He locked it! I would need a gun to smash the window now...";
				_pull = -10;
			};

			if (_said == 0) then
			{
				_said = 1;
				_who groupChat "The car's locked. This might take a while.";
				sleep 0.5;
			};
		};

		sleep 0.25;
		_pull = _pull + 1;
		_num = _num + 1;
	};
	if (_pull == 10) then
	{
		//pullout = player addAction ["Pull out", "pullout.sqf", "", 2];

		//_car lock false;

		[{(_this select 0) switchMove "AmovPercMstpSnonWnonDnon_AcrgPknlMstpSnonWnonDnon_getInLow";},[_who]] call TNL_fnet_execPublic;
		sleep 0.4;

		[{
			if (player == (_this select 0)) then
			{
				_car = vehicle player;
				_victim = player;

				player action ["eject", _car];
			};
			(_this select 0) switchmove "AmovPercMrunSlowWrflDf_AmovPpneMstpSrasWrflDnon";
		}, [(_crew select 0)]] call TNL_fnet_execPublic;

		//(_crew select 0) action ["eject",_car];
	};
};

if (_rem == 1) then
{
	//_pullout = car addAction ["Pull out", "pullout.sqf"];
};