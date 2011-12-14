_item = (_this select 0);
_amount = 0;
_vcl = empty;
_nearestObjects = nearestObjects [player, ["AllVehicles"], 4];
_found = false;

closeDialog 0;

if (count _nearestObjects >= 2) then
{
	_vcl = (_nearestObjects select 1);
};

if (_vcl == empty) exitWith
{
	//Message no vehicle
	["No vehicle nearby"] call TNL_fextHint_Hint;
};

if (player != vehicle player) exitWith
{
	["You are already in a vehicle"] call TNL_fextHint_Hint;
	//Cannot do in vehicle
};

{
	if (_x select 0 == _vcl) then
	{
		_found = true;
	};
} foreach Gvar_arr_inv_ownedVehicles;

if (_found) exitWith
{
	["You own the vehicle"] call TNL_fextHint_Hint;
};


[{(_this select 0) switchMove "AmelPercMstpSlowWrflDnon_StrokeGun";}, [player]] call TNL_fnet_execPublic;
sleep 3;
_vcl say3D "SndWindowSmash";
_vcl setVariable["trunklocked", false, true];
["You break the vehicle trunk open"] call TNL_fextHint_Hint;