_illegalMoney = "illegalMoney" call TNL_finv_getItemAmount;

if (_illegalMoney <= 0) exitWith
{
	["You have nothing to convert..."] call TNL_fextHint_Hint;
};

if (isCop) exitWith
{
	["You shouldnt even have illegal money..."] call TNL_fextHint_Hint;
};

["money", _illegalMoney] call TNL_finv_addInventoryItem;
["illegalMoney", -(_illegalMoney)] call TNL_finv_addInventoryItem;
