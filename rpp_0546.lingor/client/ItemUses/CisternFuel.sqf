_item = (_this select 0);
_amount = 0;
_refuelVehicle = empty;

_nearestObjects = nearestObjects [player, ["AllVehicles"], 10];

closeDialog 0;

{
	if (typeOf _x in ["V3S_Refuel_TK_GUE_EP1", "MtvrRefuel", "KamazRefuel"]) then
	{
		_refuelVehicle = _x;
	};
} forEach _nearestObjects;


if (_refuelVehicle != empty) then
{
	_cistern = _refuelVehicle getVariable ["TNL_gas_cisternFuel",0];
	_toAdd = 100;
	
	if (_cistern >= 900) then
	{
		_toAdd = 0;
		_cistern = 1000;
	};
	
	if (_cistern >= 1000) exitWith
	{
		["The truck is already at max capacity"] call TNL_fextHint_Hint;
	};
	
	[_item, -1] call TNL_finv_addInventoryItem;
		
	_refuelVehicle setVariable["TNL_gas_cisternFuel",(_cistern)+_toAdd,true];
		
	[format["You have used the barrel to add %1 cistern fuel to the truck (Cistern: %2)",_toAdd,_cistern+_toAdd]] call TNL_fextHint_Hint;

}
else
{
	["There are no suitable refuel vehicles nearby"] call TNL_fextHint_Hint;
};