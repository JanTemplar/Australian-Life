sleep 0.5;

(findDisplay 46) displaySetEventHandler ["KeyDown","_this call TNL_fui_keySpoof"];

TNL_fui_keySpoof =
{
	_ctrl = _this select 0;
	_key = _this select 1;
	_shift = _this select 2;
	_ctrl = _this select 3;
	_alt = _this select 4;

	#include "DIKcodes.hpp"
	
	_handled = false;

	//Siren toggle
	if (_key == __spacebar && (player != vehicle player)) then
	{
		(vehicle player) call TNL_fsiren_toggle;
		_handled = true;
	};
	
	if (!_ctrl && !_alt && !_shift) then
	{		
		if (_key == __f) then
		{
			if (typeOf (vehicle player) in ["Fishing_Boat"]) then
			{
				RPP_bool_stopFishing = !RPP_bool_stopFishing;
				
				if (RPP_bool_stopFishing) then
				{
					["You stop fishing"] call TNL_fextHint_Hint;
					
					[] spawn
					{
						sleep 30;
						RPP_bool_isFishing = false;
					};
				}
				else
				{
					["You start fishing"] call TNL_fextHint_Hint;
				};
			};
		
		};
	
	
		//Login system:
		if (!dialog && (TNL_db_stage < 4) && _key != __esc) then
		{
			[] call TNL_fdb_force;
			_handled = true;
		};
		
		
		
		//Camera movement in face selection:
		if (TNL_db_stage == 4) then
		{
			switch (_key) do
			{
				case __up:
				{
					[3] call TNL_fdb_faceMove;
				};
				case __down:
				{
					[4] call TNL_fdb_faceMove;
				};
				case __left:
				{
					[1] call TNL_fdb_faceMove;
				};
				case __right:
				{
					[2] call TNL_fdb_faceMove;
				};
				case __num_0:
				{
					[0] call TNL_fdb_faceMove;
				};
				case __spacebar:
				{
					if (dialog) then
					{
						closeDialog 0;
					}
					else
					{
						[] call TNL_fdb_selectFaceOpen;
					};
				};
			};
			_handled = true;
		};
	};
	
	
	//ALT shortcuts:
	if (!_ctrl && _alt && !_shift) then
	{
		//ALT + I - open inventory
		if (TNL_gAction_inventory == 1 && _key == __i) then
		{
			[] spawn TNL_finv_openInventory;
			_handled = true;
		};
		//ALT + K - open keychain
		if ( _key == __k && (("keychain" call TNL_finv_getItemAmount) > 0) ) then
		{
			[] call TNL_fkeychain_openDialog;
			_handled = true;
		};
		
		if (_key == __key_0) then
		{
			if (count TNL_gVar_arr_copied >= 1) then
			{
				copyToClipboard (TNL_gVar_arr_copied select 0);
				[format["Copied to clipboard: %1", (TNL_gVar_arr_copied select 0)]] call TNL_fextHint_Hint;
			}
			else
			{
				["Nothing in that slot!"] call TNL_fextHint_Hint;
			};
		};
		
		if (_key == __key_1) then
		{
			if (count TNL_gVar_arr_copied >= 2) then
			{
				copyToClipboard (TNL_gVar_arr_copied select 1);
				[format["Copied to clipboard: %1", (TNL_gVar_arr_copied select 1)]] call TNL_fextHint_Hint;
			}
			else
			{
				["Nothing in that slot!"] call TNL_fextHint_Hint;
			};
		};
	};
	
	//CTRL shortcuts
	if (_ctrl && !_alt && !_shift) then
	{
		if (_key == __key_0) then
		{
			["open"] execVM "slr\saytexts.sqf"; 
		};
		
		if (_key == __key_1) then
		{
			["Say", 0] execVM "slr\saytexts.sqf";
		};
		
		if (_key == __key_2) then
		{
			["Say", 1] execVM "slr\saytexts.sqf";
		};
		
		if (_key == __key_3) then
		{
			["Say", 2] execVM "slr\saytexts.sqf";
		};
		
		if (_key == __key_4) then
		{
			["Say", 3] execVM "slr\saytexts.sqf";
		};
	};
	
	if (!_ctrl && !_alt && _shift) then
	{
		if (_key == __key_0) then
		{
			TNL_gVar_miningYourself = !TNL_gVar_miningYourself;
			
			if (TNL_gVar_miningYourself) then
			{
				["You will now start working for yourself and not corporations, move away to get new actions if at workplace"] call TNL_fextHint_Hint;
			}
			else
			{
				["You will now start working for corporations and not yourself, move away to get new actions if at workplace"] call TNL_fextHint_Hint;
			};
		};
	};
	
	_handled;
};