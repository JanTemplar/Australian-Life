/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/


TNL_fweather_switchWeather = 
{	
	_switch = ((random(count TNL_gVar_arr_weatherTypes)-1));
	
	if (_switch < 0) then { _switch = 0; };
	
	_weatherClass = ((TNL_gVar_arr_weatherTypes select _switch) select 0);

	[_weatherClass, true] call TNL_fweather_changeToWeather;
};

TNL_fweather_changeToWeather = 
{
	private ["_weatherClass", "_activateTemp"];
	_weatherClass = (_this select 0);
	_activateTemp = (_this select 1);
	
	
	{
		if ((_x select 0) == _weatherClass) then
		{
			_weatherTemp = (_weatherClass) call TNL_fweather_getWeatherTemp;
			_weatherOtherActivate = (_weatherClass) call TNL_fweather_getWeatherOtherActivates;
			_weatherCode = (_weatherClass) call TNL_fweather_getWeatherCode;
			
			if (_activateTemp) then
			{
				[{TNL_gVar_int_Temperature = (_this select 0);}, [_weatherTemp]] call TNL_fnet_execPublic;
			};
			
			[(_this select 0)], [_weatherCode] call TNL_fnet_execPublic;

			{
				[_x, false] call TNL_fweather_changeToWeather;
			} forEach (_weatherOtherActive);
	
		};
	
	
	} forEach TNL_gVar_arr_weatherTypes;


};

TNL_fweather_getWeatherTemp = 
{
	private ["_weatherclass", "_return"];
	_weatherClass = (_this);
	_return = 0;
	
	{
		if ((_x select 0) == _weatherClass) then
		{
			_return = (_x select 1);
		};
	} forEach TNL_gVar_arr_weatherTypes;

	_return
};

TNL_fweather_getWeatherOtherActivates = 
{
	private ["_weatherclass", "_return"];
	_weatherClass = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _weatherClass) then
		{
			_return = (_x select 2);
		};
	} forEach TNL_gVar_arr_weatherTypes;

	_return
};

TNL_fweather_getWeatherCode = 
{
	private ["_weatherclass", "_return"];
	_weatherClass = (_this);
	_return = {};
	
	{
		if ((_x select 0) == _weatherClass) then
		{
			_return = (_x select 3);
		};
	} forEach TNL_gVar_arr_weatherTypes;

	_return
};