_art  = ((_this select 3) select 0);
_geld = 'geld' call INV_GetItemAmount;
_uid = getPlayerUID vehicle  player;
if(_art == "buydog" and !(_uid in allowedwar) and isciv) exitWith { player groupChat "Restriced to Admins"};

if (_geld <= dog_cost)    exitWith {role groupChat "You dont have enough money";};
['geld', -(dog_cost)] call INV_AddInvItem;
player groupChat format["%1 bought a dog for %2", rolestring, (dog_cost call ISSE_str_IntToStr)];																						
/*_arbeiternummer   = localdogcounter; 																						
localdogcounter = localdogcounter + 1; 															
localdog        = localdog + 1;																									
_dognumber        = localdogcounter;																				
_cop 		  = dogarray select round random(count dogarray - 1);																																																																										

call compile format ['"%3" createUnit [getpos dogspawn, group player, "%dog%2 = this;this setVehicleVarName ""%1dog%2"";"];', rolestring, _dognumber, _cop];
(format ["if (local server) then {publicarbeiterarctionarray = publicarbeiterarctionarray + [ [%1dog%2, %3] ];};", rolestring, _dognumber, player]) call broadcast;
*/processInitCommands;



	If (isciv) Then
	{
		private "_type";
		If (!(isNil {player getVariable "CLAY_DogType"})) Then
		{
			_type = player getVariable "CLAY_DogType";
		}
		Else
		{
			_type = "CLAY_Dog2";
		};

		_grp = group player;
//createGroup (side player);
		_name = format ["CLAY_tmpDog%1", round (random 1000)];
		call compile format ["_type createUnit [[(getPos player select 0) + (1 * sin (getDir player)), (getPos player select 1) + (0.3 * cos (getDir player)), 0], _grp, '%1 = this']", _name];
		_dog = call compile format ["%1", _name];
		_dog setDir getDir player;
		
		player setVariable ["CLAY_DogUnit", _dog];
		player setVariable ["CLAY_DogStatus", "Waiting"];
		(format ["if (local server) then {publicarbeiterarctionarray = publicarbeiterarctionarray + [%1];};", _dog]) call broadcast;
		If (isNil "BIS_MENU_GroupCommunication") Then
		{
			BIS_MENU_GroupCommunication = [[localize "STR_SOM_COMMUNICATIONS", false]];
		};

		DOGCTRL_MENU =
		[
			["Dog Control", true],
			["Follow", [2], "", -5, [["expression", "nul = [1] execVM '\CLAY_Dogs\handler\dogMove.sqf'"]], "1", "1", "\ca\ui\data\cursor_tactical_ca.paa"],
			["Wait", [3], "", -5, [["expression", "nul = [2] execVM '\CLAY_Dogs\handler\dogMove.sqf'"]], "1", "0"],
			["", [], "", -1, [], "0", "0"],
			["Attack Target", [5], "", -5, [["expression", "nul = [cursorTarget] execVM 'dogAttack.sqf'"]], "1", "1", "\ca\ui\data\cursor_attack_ca.paa"],
			["", [], "", -1, [], "0", "0"],
			["Bark", [10], "", -5, [["expression", "Hint 'Wuff!'"]], "1", "1"]
		];
		BIS_MENU_GroupCommunication set [1, ["Dog Control", [0], "#USER:DOGCTRL_MENU", -5, [["expression", ""]], "1", "1", "\ca\ui\data\cursor_tactical_ca.paa"]];
	};




