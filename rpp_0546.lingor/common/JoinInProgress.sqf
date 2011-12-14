/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

TNL_fJIP_onPlayerConnected =
{
	private ["_id", "_name", "_uid"]; 
	_id = (_this select 0);
	_name = (_this select 1);
	_uid = (_this select 2);
	
	[] execVM "common\playersDefine.sqf";
};

TNL_fJIP_onPlayerDisconnected = 
{
	private ["_id", "_name", "_uid"]; 
	_id = (_this select 0);
	_name = (_this select 1);
	_uid = (_this select 2);
	
	if (isServer) then
	{
		//Remove the player
		_users = users getVariable "currentUsers";
	
		_i = 0;
		{
			if (_x select 0 == _name) exitWith
			{
				_users set[_i, "REMOVE"];
				_users = _users - ["REMOVE"];
			};
		_i = _i + 1;
		} forEach _users;
		
		users setVariable ["currentUsers", _users, true];
	};

};

TNL_fJIP_joinedServer = 
{
	//[{if (isServer) then { [] call TNL_ftime_serverUpdateClients; };},[]] call TNL_fnet_execPublic;
};
