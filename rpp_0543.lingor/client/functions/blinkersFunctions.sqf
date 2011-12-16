TNL_fveh_blinkersSwitch =
{
/*
[vehicle player, 1] call TNL_fveh_blinkersSwitch
*/
	_car = _this select 0;
	_switch = _this select 1;

	if (isNil {_car getVariable "TNL_veh_blinkers"}) then
	{
		_car setVariable ["TNL_veh_blinkers", 0, true];
	};
	
	_state = _car getVariable "TNL_veh_blinkers";
	//hint format ["state: %1\nswitch: %2", _state, _switch];

	switch (_state) do
	{
		case 0:
		{
			if (_switch < 3) then
			{
				_car setVariable ["TNL_veh_blinkers", _switch, true];
				[_car, _switch] spawn TNL_fveh_blinkersEffects;
			}
			else
			{
				_car setVariable ["TNL_veh_blinkers", 3, true];
				[_car, 1] spawn TNL_fveh_blinkersEffects;
				[_car, 2] spawn TNL_fveh_blinkersEffects;
			};
		};
		case 3: //EMG signal lights
		{
			_car setVariable ["TNL_veh_blinkers", 0, true];
			if (_switch != 3) then
			{
				[_car, _switch] spawn
				{
					sleep 0.5;
					_this call TNL_fveh_blinkersSwitch;
				};
			};
		};
		default
		{
			_car setVariable ["TNL_veh_blinkers", 0, true];
			if (_switch == 3) then
			{
				[_car, _switch] spawn
				{
					sleep 0.5;
					_this call TNL_fveh_blinkersSwitch;
				};
			};
		};
	};
};


TNL_fveh_blinkersEffects =
{
	_left = [[-0.85, -2.15, -0.72], [-0.9, 2.21, -0.75]];
	_right = [[0.65, -2.15, -0.72], [0.7, 2.21, -0.75]];
	_color = [1,0.5,0,1];
	
	_car = _this select 0;
	_switch = _this select 1;

	private "_pos";
	if (_switch == 1) then
	{
		_pos = _left;
	}
	else
	{
		_pos = _right;
	};
	
	_lifetime = 0.01;
	while { ((_car getVariable "TNL_veh_blinkers") != 0) && (alive _car) } do
	{
		_light1 = "#lightpoint" createVehicleLocal (_car modelToWorld (_pos select 0));
		_light2 = "#lightpoint" createVehicleLocal (_car modelToWorld (_pos select 1));
		_light1 setLightBrightness 0.0015;
		_light2 setLightBrightness 0.0015;
		_light1 setLightAmbient [1,0.5,0];//[_color select 0, _color select 1, color select 2];
		_light2 setLightAmbient [1,0.5,0];//[_color select 0, _color select 1, color select 2];
		_light1 setLightColor [1,0.5,0];//[_color select 0, _color select 1, color select 2];
		_light2 setLightColor [1,0.5,0];//[_color select 0, _color select 1, color select 2];
		_light1 lightAttachObject [_car, (_pos select 0)];
		_light2 lightAttachObject [_car, (_pos select 1)];

		_i = 0;
		while { (_i < 40) && ((_car getVariable "TNL_veh_blinkers") != 0) && (alive _car) } do
		{
			drop ["Ca\Data\kouleSvetlo.p3d","","Billboard", 1, _lifetime, _car modelToWorld (_pos select 0), (velocity _car), 0, 1.275, 1, 0, [0.5], [_color], [0,0,0], 0, 0, "", "", ""];
			drop ["Ca\Data\kouleSvetlo.p3d","","Billboard", 1, _lifetime, _car modelToWorld (_pos select 1), (velocity _car), 0, 1.275, 1, 0, [0.5], [_color], [0,0,0], 0, 0, "", "", ""];
			sleep _lifetime;
			_i = _i + 1;
		};
	
		deleteVehicle _light1;
		deleteVehicle _light2;
		sleep (_lifetime * 45);
	};
};