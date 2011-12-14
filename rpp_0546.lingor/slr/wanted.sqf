_type = (_this select 0);

if (_type == "wantedrelease") then
{	
	if (!(createDialog "DlgWantedRelease")) exitWith {hint "Dialog Error!";};
	
	{
		_index = lbAdd[1, format["%1", name _x call TNL_fplayer_formatName]];
		lbSetData[1, _index, format["%1", _x]];
		
		_index = lbAdd[11, format["%1", name _x call TNL_fplayer_formatName]];
		lbSetData[11, _index, format["%1", _x]];
		
	} forEach ([] call TNL_cfplayer_activeSlots);
	
	
	lbSetCurSel [1, 0];
	lbSetCurSel [11, 0];
	while {(!(isNull (findDisplay 1800)))} do 
	{
		sleep 0.3;
	};
};

/* Sets the bounty on the selected players head */
// Parameter: Selected civ object
if (_type == "setBounty") then
{	
	_civ = _this select 1;

	if (player == _civ) exitWith 
	{
		["Cannot put a bounty on yourself"] call TNL_fextHint_Hint;
	};

	if (isNull _civ) exitWith
	{
		["Player not in game"] call TNL_fextHint_Hint;
	};

	_deletebounty = _this select 3;

	if (_deletebounty == 1) exitWith 
	{												
		if (call compile format ["%1_wanted == 0", _civ]) exitWith 
		{
			["Has no bounty!"] call TNL_fextHint_Hint;
		};		

		call compile format ["bounty_%1 = 0; publicVariable ""bounty_%1""; %1_wanted = 0; publicVariable ""%1_wanted"";", _civ];													
		
		[format ["Removed the bounty from %1", name _civ call TNL_fplayer_formatName]] call TNL_fextHint_Hint;
	};

	_bounty = parseNumber (_this select 2);                
	if (_bounty < 0) exitWith {};
 
	call compile format ["_bountycivvar = bounty_%1; _civvar = %1;",_civ];
	call compile format ["_civarrestedvar = %1_arrest;", _civ];
 
	if ((!(alive _civvar)) or (_civarrestedvar == 1)) exitWith 
	{
		[format["Civilian is either dead or in prison", _civ]] call TNL_fextHint_Hint;
	};
 
	_money = 'money' call TNL_finv_getItemAmount;
 
	if (_money < _bounty) exitWith 
	{
		["You dont have enough money to set the bounty!"] call TNL_fextHint_Hint;
	};
 
	['money', -(_bounty)] call TNL_finv_AddInventoryItem;
 
	[format ["You have set the bounty on %1 of $%2", _civ, _bounty]] call TNL_fextHint_Hint;
	[{
		_civie = (_this select 2);
		_civBounty = (_this select 1);
		call compile format ["%1_wanted = 1; bounty_%1 = bounty_%1 + %2;", _civie, _civBounty];
		[format["A bounty has been placed on %3 of the amount $%2 by %1", (_this select 0), _civBounty, _civie]] call TNL_fextHint_Hint;
	}, [player, _bounty, _civ]] call TNL_fnet_execPublic;

};

