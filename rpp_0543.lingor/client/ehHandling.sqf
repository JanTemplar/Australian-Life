/*
Name: eventHandlers.sqf
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (2009/05/29)
Description: Executes specified code when the even handler is triggered
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

_params = _this select 0;
switch (_this select 1) do
{
	case "GetIn":
	{
		//hint "Got in";
	};
	case "GetOut":
	{
		//hint "Got out";
	};
	default
	{
		hint format ["An unhandled EH was triggered: %1", _this select 1];
	};
};