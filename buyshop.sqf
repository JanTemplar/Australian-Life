_this = _this select 3;
_art   = (_this select 0);
_num   = (_this select 1);
_geld  = 'geld' call INV_GetItemAmount;



if (_art == "immobilie") then 
{	
_cost = ((BuyAbleBuildingsArray select _num) select 3);
_name = ((BuyAbleBuildingsArray select _num) select 0);
//if (_name in BuildingsOwnerArray) exitWith {player groupChat "someone owns this shop already";};
if (_geld < _cost)                exitWith {player groupChat localize "STRS_kein_geld";};
['geld', -(_cost)] call INV_AddInvItem;	
player groupChat format[localize "STRS_gotshop", rolestring, (_cost call ISSE_str_IntToStr)];
BuildingsOwnerArray = BuildingsOwnerArray + [_name];
["BuildingsOwnerArray", BuildingsOwnerArray] spawn ClientSaveVar;
workplace_getjobflag_1 setvariable["building1", 1, true];

};

if (_art == "immobilie2") then 
{
_cost = ((BuyAbleBuildingsArray select _num) select 3);
_name = ((BuyAbleBuildingsArray select _num) select 0);
//if (_name in BuildingsOwnerArray) exitWith {player groupChat "someone owns this shop already";};
if (_geld < _cost)                exitWith {player groupChat localize "STRS_kein_geld";};
['geld', -(_cost)] call INV_AddInvItem;	
player groupChat format[localize "STRS_gotshop", rolestring, (_cost call ISSE_str_IntToStr)];
BuildingsOwnerArray = BuildingsOwnerArray + [_name];
["BuildingsOwnerArray", BuildingsOwnerArray] spawn ClientSaveVar;
workplace_getjobflag_2 setvariable["building2", 2, true];
};

if (_art == "immobilie3") then 
{
_cost = ((BuyAbleBuildingsArray select _num) select 3);
_name = ((BuyAbleBuildingsArray select _num) select 0);
if (_name in BuildingsOwnerArray) exitWith {player groupChat "someone owns this shop already";};
if (_geld < _cost)                exitWith {player groupChat localize "STRS_kein_geld";};
['geld', -(_cost)] call INV_AddInvItem;	
player groupChat format[localize "STRS_gotshop", rolestring, (_cost call ISSE_str_IntToStr)];
BuildingsOwnerArray = BuildingsOwnerArray + [_name];
["BuildingsOwnerArray", BuildingsOwnerArray] spawn ClientSaveVar;
workplace_getjobflag_3 setvariable["building3", 3, true];
};

if (_art == "immobilie4") then 
{
_cost = ((BuyAbleBuildingsArray select _num) select 3);
_name = ((BuyAbleBuildingsArray select _num) select 0);
//if (_name in BuildingsOwnerArray) exitWith {player groupChat "someone owns this shop already";};
if (_geld < _cost)                exitWith {player groupChat localize "STRS_kein_geld";};
['geld', -(_cost)] call INV_AddInvItem;	
player groupChat format[localize "STRS_gotshop", rolestring, (_cost call ISSE_str_IntToStr)];
BuildingsOwnerArray = BuildingsOwnerArray + [_name];
["BuildingsOwnerArray", BuildingsOwnerArray] spawn ClientSaveVar;
workplace_getjobflag_4 setvariable["building4", 4, true];
};

if (_art == "immobilie5") then 
{
_cost = ((BuyAbleBuildingsArray select _num) select 3);
_name = ((BuyAbleBuildingsArray select _num) select 0);
//if (_name in BuildingsOwnerArray) exitWith {player groupChat "someone owns this shop already";};
if (_geld < _cost)                exitWith {player groupChat localize "STRS_kein_geld";};
['geld', -(_cost)] call INV_AddInvItem;	
player groupChat format[localize "STRS_gotshop", rolestring, (_cost call ISSE_str_IntToStr)];
BuildingsOwnerArray = BuildingsOwnerArray + [_name];
["BuildingsOwnerArray", BuildingsOwnerArray] spawn ClientSaveVar;
workplace_getjobflag_5 setvariable["building5", 5, true];
};

if (_art == "immobilie6") then 
{
_cost = ((BuyAbleBuildingsArray select _num) select 3);
_name = ((BuyAbleBuildingsArray select _num) select 0);
//if (_name in BuildingsOwnerArray) exitWith {player groupChat "someone owns this shop already";};
if (_geld < _cost)                exitWith {player groupChat localize "STRS_kein_geld";};
['geld', -(_cost)] call INV_AddInvItem;	
player groupChat format[localize "STRS_gotshop", rolestring, (_cost call ISSE_str_IntToStr)];
BuildingsOwnerArray = BuildingsOwnerArray + [_name];
["BuildingsOwnerArray", BuildingsOwnerArray] spawn ClientSaveVar;
workplace_getjobflag_6 setvariable["building6", 6, true];
};



if (_art == "sell") then 
{	
_cost = ((BuyAbleBuildingsArray select _num) select 3);
_cost1 = _cost - 2000;
_name = ((BuyAbleBuildingsArray select _num) select 0);
//if (!(_name in BuildingsOwnerArray)) exitWith {player groupChat "noone owns this shop";};
['geld', +(_cost1)] call INV_AddInvItem;
player groupChat format[localize "STRS_sellshop", rolestring, (_cost1 call ISSE_str_IntToStr)];
BuildingsOwnerArray = BuildingsOwnerArray - [_name];
["BuildingsOwnerArray", BuildingsOwnerArray] spawn ClientSaveVar;
workplace_getjobflag_1 setvariable["building1", 11, true];

};


if (_art == "sell2") then 
{	
_cost = ((BuyAbleBuildingsArray select _num) select 3);
_cost1 = _cost - 2000;
_name = ((BuyAbleBuildingsArray select _num) select 0);
//if (!(_name in BuildingsOwnerArray)) exitWith {player groupChat "noone owns this shop";};
['geld', +(_cost1)] call INV_AddInvItem;
player groupChat format[localize "STRS_sellshop", rolestring, (_cost1 call ISSE_str_IntToStr)];
BuildingsOwnerArray = BuildingsOwnerArray - [_name];
["BuildingsOwnerArray", BuildingsOwnerArray] spawn ClientSaveVar;
workplace_getjobflag_2 setvariable["building2", 12, true];
};


if (_art == "sell3") then 
{	
_cost = ((BuyAbleBuildingsArray select _num) select 3);
_cost1 = _cost - 2000;
_name = ((BuyAbleBuildingsArray select _num) select 0);
//if (!(_name in BuildingsOwnerArray)) exitWith {player groupChat "noone owns this shop";};
['geld', +(_cost1)] call INV_AddInvItem;
player groupChat format[localize "STRS_sellshop", rolestring, (_cost1 call ISSE_str_IntToStr)];
BuildingsOwnerArray = BuildingsOwnerArray - [_name];
["BuildingsOwnerArray", BuildingsOwnerArray] spawn ClientSaveVar;
workplace_getjobflag_3 setvariable["building3", 13, true];
};


if (_art == "sell4") then 
{	
_cost = ((BuyAbleBuildingsArray select _num) select 3);
_cost1 = _cost - 2000;
_name = ((BuyAbleBuildingsArray select _num) select 0);
//if (!(_name in BuildingsOwnerArray)) exitWith {player groupChat "noone owns this shop";};
['geld', +(_cost1)] call INV_AddInvItem;
player groupChat format[localize "STRS_sellshop", rolestring, (_cost1 call ISSE_str_IntToStr)];
BuildingsOwnerArray = BuildingsOwnerArray - [_name];
["BuildingsOwnerArray", BuildingsOwnerArray] spawn ClientSaveVar;
workplace_getjobflag_4 setvariable["building4", 14, true];
};


if (_art == "sell5") then 
{	
_cost = ((BuyAbleBuildingsArray select _num) select 3);
_cost1 = _cost - 2000;
_name = ((BuyAbleBuildingsArray select _num) select 0);
//if (!(_name in BuildingsOwnerArray)) exitWith {player groupChat "noone owns this shop";};
['geld', +(_cost1)] call INV_AddInvItem;
player groupChat format[localize "STRS_sellshop", rolestring, (_cost1 call ISSE_str_IntToStr)];
BuildingsOwnerArray = BuildingsOwnerArray - [_name];
["BuildingsOwnerArray", BuildingsOwnerArray] spawn ClientSaveVar;
workplace_getjobflag_5 setvariable["building5", 15, true];
};


if (_art == "sell6") then 
{	
_cost = ((BuyAbleBuildingsArray select _num) select 3);
_cost1 = _cost - 2000;
_name = ((BuyAbleBuildingsArray select _num) select 0);
//if (!(_name in BuildingsOwnerArray)) exitWith {player groupChat "noone owns this shop";};
['geld', +(_cost1)] call INV_AddInvItem;
player groupChat format[localize "STRS_sellshop", rolestring, (_cost1 call ISSE_str_IntToStr)];
BuildingsOwnerArray = BuildingsOwnerArray - [_name];
["BuildingsOwnerArray", BuildingsOwnerArray] spawn ClientSaveVar;
workplace_getjobflag_6 setvariable["building6", 16, true];
};


