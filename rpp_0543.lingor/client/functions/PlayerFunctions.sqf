/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

TNL_fplayer_getPlayerName =
{
	private ["_name", "_dbname", "_users"];
	_name = _this;
	_dbname = [];
	_users = users getVariable "currentUsers";
	
	{
		if (_x select 0 == _name) exitWith
		{
			_dbName = [(_x select 1), (_x select 2)];
		};
	} forEach _users;
	
	_dbName
};

TNL_fplayer_formatName =
{
	private ["_name", "_formatName"];
	_name = _this call TNL_fplayer_getPlayerName;
	_formatName = "";
	
	if (count _name >= 2) then
	{
		_formatName = format["%1 %2", _name select 0, _name select 1];
	};
	_formatName
};

TNL_fplayer_getWeapons =
{
	private ["_Weapons", "_foundArray"];
	_Weapons = weapons player;
	_foundArray = [ ];

	{
		_weaponClass = (_x);
	
		_found = false;
		_i = 0;
			
		{
			if (count _foundArray > 0) then
			{
				_class = _x select 0;
				_amount = _x select 1;
						
				if (_class == _weaponClass) then
				{
					_found = true;
					_x set[1,(_amount + 1)];
				};
			};

			_i = _i + 1;
		} foreach _foundArray;
			
		if (!_found) then
		{
			_foundArray = _foundArray + [ [_weaponClass, 1] ];
		};
	} foreach _Weapons;		
	
	_foundArray
};

TNL_fplayer_getMagazines = 
{
	private ["_Magazines", "_foundArray"];
	_Magazines = magazines player;
	_foundArray = [ ];
	
	{
		_weaponClass = (_x);
	
		_found = false;
		_i = 0;
			
		{
			if (count _foundArray > 0) then
			{
				_class = _x select 0;
				_amount = _x select 1;
						
				if (_class == _weaponClass) then
				{
					_found = true;
					_x set[1,(_amount + 1)];
				};
			};

			_i = _i + 1;
		} foreach _foundArray;
			
		if (!_found) then
		{
			_foundArray = _foundArray + [ [_weaponClass, 1] ];
		};
	} foreach _Magazines;		

	_foundArray
};

TNL_fplayer_inVehicle =
{
	private ["_unit", "_return"];
	_unit = _this;
	_return = false;
	
	if (_unit == vehicle _unit) then
	{
		_return = false;
	}
	else
	{
		_return = true;
	};
	
	_return
};


TNL_fplayer_getRespawn = 
{
	private ["_player", "_respawn"];
	_player = _this select 0;
	_respawn = "";
	
	{
		_unit = _x select 3;
		if (format["%1",_unit] == format["%1",_player]) then
		{
			_respawn = (_x select 2);
		};
	
	} forEach Gvar_arr_mission_PlayerArray;
	
	_respawn
};

TNL_fplayer_hasWeaponType = 
{
	private ["_obj", "_hasWeapon", "_type"];
	_obj = _this select 0;
	_type = _this select 1;
	_hasWeapon = false;
	
	{
		_weapon = _x;
		_weaponType = ((_weapon call TNL_finv_getItemTypes) select 1);
		
		if (_weaponType == _type) then
		{
			_hasWeapon = true;
		};
	} forEach (weapons _obj);
	
	_hasWeapon
};

TNL_fplayer_hasWeapon = 
{
	private ["_hasWeapon"];
	_hasWeapon = false;
	
	if (([player,"RIFLE"] call TNL_fplayer_hasWeaponType) or ([player,"PISTOL"] call TNL_fplayer_hasWeaponType)) then
	{
		_hasWeapon = true;
	};

	_hasWeapon
};




TNL_fplayer_inBuilding =
{
	private ["_player", "_return"];
	_player = (_this select 0);
	_return = false;
	
	_house = getpos nearestBuilding _player;
	_object = getpos player;
	_box = boundingBox (nearestBuilding _player);
	

	if (player distance _house < ((_box select 1) select 0)) then
	{
		_return = true;
	}
	else
	{
		_return = false;
	};

	_return
};

TNL_fplayer_getPlayerTypesCount = 
{
	private ["_type", "_count"];
	_type = (_this select 0);
	_count = 0;
	
	{
		if (_type in (_x select 0)) then
		{
			if (alive call compile (_x select 0)) then
			{
				_count = _count + 1;
			};
		};
	} forEach Gvar_arr_mission_PlayerArray;

	_count
};
