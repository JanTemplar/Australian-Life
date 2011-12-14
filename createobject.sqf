_art = _this select 0;

if (_art == "use") then 

{

_item    = _this select 1;
_class	 = _item call INV_getitemClassName;
_exitvar = 0;

if (player != vehicle player) exitWith {player groupChat localize "STRS_inv_item_sperre_invcl";};

	{

	if (player distance (_x select 0) < (_x select 1)) exitWith 

		{

		_exitvar = 1;
		player groupChat localize "STRS_inv_item_sperre_hiernicht";

		};

	} forEach INV_SperrenVerbotArray;

if (_exitvar == 1) exitWith {};

[_item, -1] call INV_AddInvItem;	

_pos = [(position player select 0) + (sin(getdir player)*2), (position player select 1) + (cos(getdir player)*2), 0];
_obj = _class createvehicle [0, 0, 0];
_obj setdir getdir player;
_obj setpos _pos;
_time = round time;
call compile format['_obj setvehicleinit "this setvehiclevarname ""%1%2%3""; %1%2%3 = this"; processinitcommands', player, _class, _time];

(format ["if (local server) then {publicarbeiterarctionarray = publicarbeiterarctionarray + [ [%1%2%3, %1] ];};", player, _class, _time]) call broadcast;

_counter = 0;

//while{alive _obj} do

//	{

//	if(player distance _obj > 600)then{_counter = _counter + 1}else{_counter = 0};

//	if(_counter > 3600 and _counter < 3600)then{player groupchat "WARNING: you have been away from one of your buildings or other objects for more than 1 hour, it will despawned in 5 minutes!";};

//	if(_counter > 3900)exitwith{player groupchat "you have been away from one of your buildings or other placable objects for more than 1 hour and 5 minutes so it has despawned!"; deletevehicle _obj};

//	sleep 1;

//	};

};