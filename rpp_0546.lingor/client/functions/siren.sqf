TNL_fsiren_getValues =
{
	private ["_car", "_array", "_return"];
	_car = _this;
	_array = [];
	_return = [];
	
	if (typeName _car == "OBJECT") then
	{
		_car = typeOf _car;
	};
	
	_array = (_car call TNL_finv_getOtherValues);
	
	if (count _array < 5) then
	{
		_return = [];
	}
	else
	{
		_return = _array select 4;
	};
	
	
	_return
};
TNL_fsiren_toggle =
{
	private ["_car", "_params", "_state"];
	_car = _this;
	_params = _car call TNL_fsiren_getValues;

	if ((player == driver _car) && (_car getVariable "TNL_siren_mounted")) then
	{
		_state = _car getVariable "TNL_siren_state";
		
		[
			compile format ['
				if (isServer) then
				{		
					["%1", %2, "%3"] call TNL_fssiren_toggleHandle;
				};
			', _car, _state, _params select 1]
		] spawn TNL_fnet_execPublic;
		
		switch (_state) do
		{
			case 0: //Turn on the lights
			{
				["Lights on!"] call TNL_fextHint_Hint;
				_car setVariable ["TNL_siren_state", 1, true];
				[{[(_this select 0), (_this select 1)] spawn TNL_fsiren_lights;}, [_car, _params select 1]] call TNL_fnet_execPublic; 
			};
			case 1: //Turn on the sound
			{
				["Sounds on!"] call TNL_fextHint_Hint;
				_car setVariable ["TNL_siren_state", 2, true];
				[{[(_this select 0), (_this select 1)] spawn TNL_fsiren_sounds;}, [_car, _params select 1]] call TNL_fnet_execPublic; 
			};
			case 2: //Turn off
			{
				["All off."] call TNL_fextHint_Hint;
				_car setVariable ["TNL_siren_state", 0, true];
			};
		};
	};
};

TNL_fsiren_lights =
{
	private ["_car", "_type", "_params"];
	_car = _this select 0;
	_type = _this select 1;
	
	_params = ((_car call TNL_fsiren_getValues) select 2) select 0;
	
	while {_car getVariable "TNL_siren_state" != 0} do
	{
		if (!alive _car) exitWith
		{
			_car setVariable ["TNL_siren_state", 0, true];
		};
		
		
		switch (toLower _type) do
		{
			case "singleblue":
			{
				private ["_light", "_size"];
				if (dayTime > 7 && dayTime < 17) then
				{
					_size = 3;
				}
				else
				{
					_size = 0.5;
				};
				
				_light = "#lightpoint" createVehicleLocal (_car modelToWorld (_params select 0));
				_light setLightBrightness (_params select 2);
				_light setLightAmbient (_params select 1);
				_light setLightColor (_params select 1);
				_light lightAttachObject [_car, (_params select 0)];
				
				_ps = "#particlesource" createVehicleLocal (_car modelToWorld (_params select 0));
				_ps setParticleCircle [0, velocity _car];
				_ps setParticleRandom [0, [0, 0, 0], [0, 0, 0], 0, 0, [0, 0, 0, 0], 0, 0];
				_ps setParticleParams ["Ca\Data\kouleSvetlo.p3d", "", "Billboard", 1, 0.05, (_params select 0), (velocity _car), 0, 1.275, 1, 0, [_size], [[0,0,1,1]], [0,0,0], 0, 0, "", "", _car];
				_ps setDropInterval 0.05;
				
				sleep 0.25;
				deleteVehicle _light;
				deleteVehicle _ps;
				sleep 0.25;
			};
		};
	};
};

TNL_fsiren_sounds =
{
	private ["_car", "_type", "_params"];
	_car = _this select 0;
	_type = _this select 1;
	
	_params = ((_car call TNL_fsiren_getValues) select 2) select 0;
	
	while {_car getVariable "TNL_siren_state" == 2} do
	{
		if (!alive _car) exitWith
		{
			_car setVariable ["TNL_siren_state", 0, true];
		};
		
		switch (toLower _type) do
		{
			case "singleblue":
			{
				if (vehicle player distance _car < 700) then
				{
					if ((speed _car > -3) && (speed _car < 3)) then
					{
						sleep 1;
					}
					else
					{
						if (speed _car <= 45) then
						{
							_car say["polSirenShort", 1];
							sleep 1.27;
						}
						else
						{
							_car say["polSirenLong", 1];
							sleep 1.14;
						};
					};
				}
				else
				{
					sleep 5;
				};
			};
		};
	};
};