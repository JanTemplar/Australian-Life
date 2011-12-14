if ((_this select 0) == "") exitWith {player groupChat localize "STRS_inv_no_selection";};
_item        = _this select 0;
_fabriknum   = _this select 1;
_type        = _this select 2;
_queue       = (INV_ItemFabriken select _fabriknum) select 8;
_ablage      = (INV_ItemFabriken select _fabriknum) select 7;
_spawn       = (INV_ItemFabriken select _fabriknum) select 4;
_crate       = (INV_ItemFabriken select _fabriknum) select 3;
_name        = (INV_ItemFabriken select _fabriknum) select 2;
_infos       = _item call INV_getitemArray;
_cost	     = (_infos call INV_getitemBuyCost)*0.5;
_itemart     = _infos call INV_getitemType; 
_amount      = (["geld", _ablage] call INV_GetStorageAmount);

if(_type == "mani")then

{
	
_nichtmoglich = 0;
_EFabrik = 0;
_benoetigteItems = (_item call INV_getitemMaterials);	
_extraItems	= [
"Diamondring",
"diamondbroach",
"diamondnecklace",
"woodchair",
"steel",
"blackpowder",
"glass",
"plastic",
"LeeEnfield",
"x_303",
"Huntingrifle",
"x_22_LR_17_HMR",
"RH_asvalk",
"RH_asval",
"RH_20Rnd_9x39_val_mag",
"RH_PDW",
"RH_PDW_AIM",
"RH_PDW_ACOG",
"RH_30Rnd_6x35_PDW",
"RH_anac",
"RH_anacg",
"RH_6Rnd_44_Mag"
];

{
if(_item == _x ) then
{
_EFabrik = 1;
};
} forEach _extraItems;
	
	
	if (_EFabrik == 1) then
	{
		{
		_cost = (_x select 1);													
		_amount = ([(_x select 0), _ablage] call INV_GetStorageAmount);			
		if (_amount < _cost) then {_nichtmoglich = 1;};
		} forEach _benoetigteItems;	
		
		if (_nichtmoglich == 1) exitWith {player groupChat localize "STRS_inv_fac_not_enough"};	
		
		{
		_cost = (_x select 1);
		[(_x select 0), -(_cost), _ablage] call INV_AddItemStorage;
		}forEach _benoetigteItems;
		
		call compile format['%1 = %1 + [_item]; %2pend = %2pend + 1; ["%2pend", %2pend] spawn ClientSaveVar;', _queue, _item];
		player groupChat "Added to the production line";
		call compile format['["%1", %1] spawn ClientSaveVar;["%2", %2] spawn ClientSaveVar;', _ablage, _queue];
	}
	else
	{
		if (_amount < _cost) exitWith {player groupChat localize "STRS_inv_fac_not_enough"};
		["geld", -(_cost), _ablage] call INV_AddItemStorage;
		call compile format['%1 = %1 + [_item]; %2pend = %2pend + 1; ["%2pend", %2pend] spawn ClientSaveVar;', _queue, _item];
		player groupChat "Added to the production line";
		call compile format['["%1", %1] spawn ClientSaveVar;["%2", %2] spawn ClientSaveVar;', _ablage, _queue];
	};
};
if(_type == "create")then

{

if(fvspam)exitwith{}; 
_Cancel = 2;
_NoCreate = ["EDiamondring","Diamondring","Platinumring","EPlatinumring","An2_1_TK_CIV_EP1"];
{
if(_item == _x ) then
{
_Cancel = 1;
};
} forEach _NoCreate;

if(_type == "cancel")then

{
call compile format["fpend = %1pend;", _item]; 
if(fpend < 1)exitwith{player groupchat "You do not have any items to Cancel"}; 
call compile format['%1 = %1 - [_item]; %2pend = %2pend - 1; ["%2pend", %2pend] spawn ClientSaveVar;', _queue, _item];
['geld', _cost] call INV_AddInventoryItem;
player groupchat "Item Canceled";

};
if(_Cancel == 1) exitwith {player groupChat "You can not create this item"};

call compile format['favail = %1avail; if(%1avail > 0)then{%1avail = %1avail - 1;["%1avail", %1avail] spawn ClientSaveVar};', _item];
if(favail < 1)exitwith{player groupchat "There are no vehicles of this type available"}; 

if (_itemart == "Item")     then {player groupchat "creating...";fvspam=true;sleep 1;[_item, 1, _ablage] spawn INV_CreateItem;fvspam=false};
if (_itemart == "waffe")    then {player groupchat "creating...";fvspam=true;sleep 1;[(_infos call INV_getitemClassName), 1, _crate] spawn INV_CreateWeapon;fvspam=false};
if (_itemart == "magazin")  then {player groupchat "creating...";fvspam=true;sleep 1;[(_infos call INV_getitemClassName), 1, _crate] spawn INV_CreateMag;fvspam=false};
if (_itemart == "Fahrzeug") then {player groupchat "creating...";fvspam=true;sleep 5;[_item, _spawn] spawn INV_CreateVehicle;fvspam=false};

player groupchat "item created!";

};

if(_type == "export")then

{

if (_itemart == "magazin")exitwith{player groupchat "you cannot export this item!"};   

if(fvspam)exitwith{}; 

closeDialog 0;

fvspam=true;

call compile format['favail = %1avail', _item];
if(favail < 1)exitwith{player groupchat "There are no items/vehicles of this type available"}; 

if (_itemart == "Fahrzeug") then {[_item] execVM "choosecity.sqf";};
if (_itemart == "waffe") then {[_item] execVM "exportweapon.sqf";};
_itemType     = _infos call INV_getitemKindOf;
if (_itemType == "service") then {[_item] execVM "choosegasstation.sqf";};
if (_itemType == "Shop") then {[_item] execVM "chooseshop.sqf";};


fvspam=false;
};