_item = (_this select 0);
_amount = ((_this select 1) select 0);
_fillThirst = 0;
_text = "";
_addItem = "";
_addItemAmount = 0;

if (_item call TNL_finv_getItemAmount < _amount) exitWith 
{
	["You do not have enough of this item"] call TNL_fextHint_Hint;
};

closeDialog 0;

_drinkArray =
[
	["ClayPotW", 25, "You drink from the clay pot(s)", ["ClayPot",_amount]],
	["ClayPotM", 100, "You drink from the clay pot(s)", ["ClayPot",_amount]]
];

{
	if (_x select 0 == _item) exitWith
	{
		_fillThirst = _x select 1;
		_text = _x select 2;
		_addItem = (_x select 3) select 0;
		_addItemAmount = (_x select 3) select 1;
	};
} forEach _drinkArray;

[_fillThirst * _amount] call TNL_fthirst_increaseThirst;
[format["%1", _text]] call TNL_fextHint_Hint;
[_item, -(_amount)] call TNL_finv_addInventoryItem;

if (_addItem != "") then
{
	[_addItem, (_addItemAmount)] call TNL_finv_addInventoryItem;
};