/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

TNL_fanim_openDialog = 
{	
	if (!createDialog "DlgAnimations") then
	{
		hint "ERROR in AnimationFunctions.sqf, failed to open dialog";
	};
	
	
	{
		_index = lbAdd[1, format["%1", (_x select 0)]];
		lbSetData[1,_index,format['["%1","%2", %3]',(_x select 1),(_x select 2),(_x select 3)]];
	
	
	} foreach TNL_gVar_arr_animations;

	lbSetcurSel[1,0];
};

TNL_fanim_selectAnimation =
{	
	private ["_data"];
	_data = _this select 0;
	_type = _data select 0;
	_anim = _data select 1;
	_animCode = _data select 2;
	
	_code = compile format['%1 %2 "%3"', player, _type, _anim];
	
	if (Gvar_bool_player_ableToUseAnimation) then
	{
		[] spawn _animCode;
		[{[] call (_this select 0);}, [_code]] call TNL_fnet_execPublic;
	};

	closeDialog 0;
};