_item = (_this select 0);
_amount = 0;
_refuelVcl = empty;
_nearestObjects = nearestObjects [player, ["AllVehicles"], 4];

closeDialog 0;

if (isNil "TNL_gVar_bool_refueling") then
{
	TNL_gVar_bool_refueling = false;
};

if (vehicle player != player) exitWith
{
	["Leave the vehicle to refuel another vehicle"] call TNL_fextHint_Hint;
};

if (count _nearestObjects >= 2) then
{
	_refuelVcl = (_nearestObjects select 1);
};

if (_refuelVcl == empty) exitWith
{
	//Message no vehicle
	["No vehicle nearby"] call TNL_fextHint_Hint;
};

if (TNL_gVar_bool_refueling) exitWith
{
	["You are already refueling a vehicle"] call TNL_fextHint_Hint;
};

_fuel = fuel _refuelVcl;
_refuelAmount = 0.10;
_maxFuel = 0.40;

if (_fuel > _maxFuel) exitWith
{
	[format["Vehicle cannot be refueled over %1L with a fuel can (Current fuel: %2L)", _maxFuel, _fuel]] call TNL_fextHint_Hint;	
};

if ((_fuel + _refuelAmount) > _maxFuel) then
{
	_fuel = _maxFuel;
	_refuelAmount = 0;
};

_refuelVcl setFuel (_fuel + _refuelAmount);

TNL_gVar_bool_refueling = true;

[{(_this select 0) switchMove "AinvPknlMstpSlayWrflDnon_medic";}, [player]] call TNL_fnet_execPublic;
[_item, -1] call TNL_finv_addInventoryItem;

sleep 5;
TNL_gVar_bool_refueling = false;