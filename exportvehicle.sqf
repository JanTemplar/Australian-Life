/*
_preis      = _this select 0;
_item       = _this select 1;
_stock      = _this select 2;
_maxstock   = _this select 3;
_shopnum    = _this select 4;

if(_stock >= _maxstock)exitwith{player groupchat "the shop has reached its maximum stock for this vehicle"};
																			
['geld', _preis] call INV_AddInvItem;

player groupchat format["The vehicle has been exported for $%1!", _preis];

call compile format['if(%1avail > 0)then{%1avail = %1avail - 1;["%1avail", %1avail] spawn ClientSaveVar};', _item];

format['["%1", (%2 + 1), %3] call INV_itemstocksupdate;', _item, _stock, _shopnum] call broadcast;

closedialog 0;
*/

_preis = _this select 0; // "Money"
_item = _this select 1;
_stock = _this select 2;
_maxstock = _this select 3;
_shopnum = _this select 4;
// Checks the stock levels
if(_stock >= _maxstock)exitwith{player groupchat "the shop has reached its maximum stock for this vehicle"};
//Closes dialog to stop button spamming.
closedialog 0;
// Checks if they have the item. If they do, it removes it.
call compile format['if(%1avail > 0)then{%1avail = %1avail - 1;["%1avail", %1avail] spawn ClientSaveVar};', _item];
//Informs them of a successful export.
player groupchat format["The vehicle has been exported for $%1!", _preis];
// Gives the player the money for the sale
['geld', _preis] call INV_AddInvItem;
// Updates the stores' stock of the exported item.
format['["%1", (%2 + 1), %3] call INV_itemstocksupdate;', _item, _stock, _shopnum] call broadcast;