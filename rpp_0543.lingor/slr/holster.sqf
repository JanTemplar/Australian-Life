_artarray = _this select 3;
_art = "";

if (count _this >= 4) then
{
	_art = _artarray select 0;
}
else
{
	_art = "unholsterPistol";
	closeDialog 0;
};

if (("pistol" call TNL_finv_getItemAmount) <= 0) then
{
	["pistol", 0] call TNL_finv_addInventoryItem;
};

_type = _art;
	
if (isNil "INV_changeweapon_active") then 
{
	INV_changeweapon_active = 0;
};
		
if (INV_changeweapon_active == 1) exitWith 
{
	["You cannot holster/unholster the weapon now!"] call TNL_fextHint_Hint;
};
		
INV_changeweapon_active = 1;
		
if (player == vehicle player) then 
{
	[{(_this select 0) switchmove "normal";}, [player]] call TNL_fnet_execPublic;
	sleep 0.5;
};
		
if (isNil "INV_InventarPistol") then 
{
	INV_InventarPistol = "";
};
		
if (("pistol" call TNL_finv_GetItemAmount) == 0) then 
{
	INV_InventarPistol = "";
};
		
_HandWeapon = "";
_invWeapon  = "";
	
if ((_type == "HolsterPistol") or (_type == "unholsterPistol")) then 
{
	{ 
		if (((_x call TNL_finv_getItemTypes) select 1) == "PISTOL") then 
		{
			_HandWeapon = _x;
		}; 
	} forEach (weapons player);
		
	_invWeapon = INV_InventarPistol;
} 
else 
{
		
};
		
if (_type == "HolsterPistol") then 
{
	if (_HandWeapon == "") exitWith 
	{
		["No weapon!"] call TNL_fextHint_Hint;
	};
		
	player RemoveWeapon _HandWeapon;
	sleep 4;
		
	if (_invWeapon != "") then 
	{
		player AddWeapon _invWeapon;
		["Weapon hidden already!"] call TNL_fextHint_Hint;
	} 
	else 
	{
		["Weapon hidden!"] call TNL_fextHint_Hint;
	};
		
	if (_type == "HolsterPistol") then 
	{
		unholstervar = true;
		holstervar = true;
		['pistol', 1] call TNL_finv_setItemAmount;
		INV_InventarPistol = _HandWeapon;
	} 
	else 
	{
		
	};					
};															
		
if (_type == "unholsterPistol") then 
{
	if (_invWeapon == "") exitWith {};
	if (_HandWeapon != "") then 
	{
		player RemoveWeapon _invWeapon; 
		sleep 4;
		["hidden already!"] call TNL_fextHint_Hint;
	} 
	else 
	{
		["Taken out weapon!"] call TNL_fextHint_Hint;			
	};
			
	if (_type == "unholsterPistol") then 
	{
		player AddWeapon INV_InventarPistol;
		INV_InventarPistol = _HandWeapon;
		holstervar = false;
		unholstervar = false;
			
		if (not(INV_InventarPistol == "")) then 
		{
			['pistol', 1] call TNL_finv_setItemAmount;
		} 
		else 
		{
			['pistol', -1] call TNL_finv_setItemAmount;
			if ((vehicle player == player) && (isCop)) then
			{
				[{(_this select 0) switchmove "AmovPercMstpSnonWnonDnon_AmovPercMstpSrasWpstDnon_end";}, [player]] call TNL_fnet_execPublic;
			};
		};																								
	} 
	else 
	{
				
	};									
};	
																			
sleep 4;				
INV_changeweapon_active = 0;