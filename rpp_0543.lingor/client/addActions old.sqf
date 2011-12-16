/*
Name: addActions.sqf
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (2009/05/29)
Description: Adds basic actions
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/


	{
		(_x select 0) addAction [(_x select 1), "client\useAction.sqf", ["shop", (_x select 0)]];
	} forEach TNL_ShopArray;

	{
		(_x select 0) addAction [(_x select 1), "client\useAction.sqf", ["license", (_x select 0)]];
	} forEach TNL_arr_lic_licensePurchase;

	{
		_x addAction ["ATM", "client\useAction.sqf", ["atm"]];
	} forEach [atm1];

	{
			if ((_x select 1) != player) then
			{
				(_x select 1) addAction["Interaction", "client\useAction.sqf", ["interaction", (_x select 1)]];
			};
	} foreach Gvar_arr_mission_PlayerArray;


	vehicle player addAction ["Animations", "client\useAction.sqf", ["anim"]];
	vehicle player addAction [localize "STRS_ACTION_INVENTORY", "client\useAction.sqf", ["inventory"]];
	vehicle player addAction ["Stats", "client\useAction.sqf", ["stats"]];

	
player addAction ["login", "client\useAction.sqf", ["welcome"]];
