_item = (_this select 0);
_amount = ((_this select 1) select 0);
_fillHunger = 0;
_text = "";

if (_item call TNL_finv_getItemAmount < _amount) exitWith 
{
	["You do not have enough of this item"] call TNL_fextHint_Hint;
};

closeDialog 0;


_foodArray =
[
	["Minnow", 0.25, "The fish(s) is uncooked and doesn't have much weight to it, it doesnt fill you much"],
	["Bluegill", 6, "You eat the fish(s)"],
	["Catfish", 15, "You eat the fish(s)"],
	["Perch", 9, "You eat the fish(s)"],
	["Trout", 12, "You eat the fish(s)"],
	["RockBass", 21, "You eat the fish(s)"],
	
	["Sardine", 8, "You eat the fish(s)"],
	["Monkfish", 30, "You eat the fish(s)"],
	["Salmon", 20, "You eat the fish(s)"],
	["Shark", 100, "It was hard but you ate it"],
	["Tuna", 30, "You eat the fish(s)"],
	["Whale", 100, "It was hard but you ate it"],
	["Swordfish", 40, "You eat the fish(s)"]
];

{
	if (_x select 0 == _item) exitWith
	{
		_fillHunger = _x select 1;
		_text = _x select 2;
	};
} forEach _foodArray;

[_fillHunger * _amount] call TNL_fhunger_increaseHunger;
[format["%1", _text]] call TNL_fextHint_Hint;
[_item, -(_amount)] call TNL_finv_addInventoryItem;
