_weapons = weapons player;
_illegalOnly = true;

if (count _this >= 1) then
{
	_illegalOnly = (_this select 0);
};

_dropWeapons = [];

if (count _weapons > 0) then 
{
	{
		if (_illegalOnly) then
		{
			if (((_x) call TNL_finv_isIllegal)) then
			{
				player removeWeapon _x;
				_dropWeapons = _dropWeapons + [_x];
			};
		}
		else
		{
			player removeWeapon _x;
			_dropWeapons = _dropWeapons + [_x];
		};
	} forEach _weapons;
};

call compile format ['weaponholder%1 = "WeaponHolder" createVehicle getpos(nowhere); weaponholder%1 setVehicleInit "this setVehicleVarName ""weaponholder%1""; weaponholder%1 = this;"; processInitCommands;', player];
sleep 0.5;
call compile format["CurWeaponHolder = weaponholder%1;", player];

[{ 
	{
		(_this select 0) ADDWEAPONCARGO [_x, 1];
	} forEach (_this select 1); (_this select 0) setpos (_this select 2); 
	
	if (isServer) then 
	{
		[(_this select 0), 300] spawn SLR_SafeDeleteVehicle;
	};
}, [CurWeaponHolder, _dropWeapons, (getpos player)]] call TNL_fnet_execPublic;

sleep 0.5;