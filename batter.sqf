////////////////////////////////////
////			         //
//      Copyright © TCG         //
//www.tcgaming.enjin.com       //
////////////////////////////////

_art = _this select 0;
_pos = getposASL player;
_class = "explosive";

if (_art == "use") then 

{

_item   = _this select 1;
_door = (nearestobjects [getpos player, ["Land_MBG_GER_RHUS_2"], 8] select 0);
_door1 = (nearestobjects [getpos player, ["Land_MBG_GER_ESTATE_1"], 9] select 0);
_door2 = (nearestobjects [getpos player, ["Land_MBG_GER_RHUS_4"], 8] select 0);
_door3 = (nearestobjects [getpos player, ["il_bighouse"], 14] select 0);
_door4 = (nearestobjects [getpos player, ["Land_MBG_GER_HUS_1"], 8] select 0);
_door5 = (nearestobjects [getpos player, ["Land_MBG_GER_HUS_3"], 8] select 0);
_door6 = (nearestobjects [getpos player, ["house2"], 8] select 0);
_door7 = (nearestobjects [getpos player, ["Fence_corrugated_plate"], 3] select 0);
If (iscop) then
{
	if (_door iskindof "Land_MBG_GER_RHUS_2") then {
	(format ['server globalChat "Officer %2 is breaking down the door on %1s house!";', _door, name player]) call broadcast;
	player playmove "AinvPknlMstpSlayWrflDnon";
	_object = _class createvehicle _pos;
	_object setpos [(getPos player select 0),(getPos player select 1),.5];
	player groupchat "Detonation in 9 seconds";
	sleep 5;
	player groupchat "Detonation in 4 seconds";
	sleep 4;
	"R_57mm_HE" createVehicle [(getPos _object select 0),(getPos _object select 1),-40];
	deletevehicle _object;
	
	_door animate ["FrontDoor",1];
	[_door, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
	[_item, -1] call INV_AddInvItem;
	};

	if (_door1 iskindof "Land_MBG_GER_ESTATE_1") then {
	(format ['server globalChat "Officer %2 is breaking down the door on %1s house!";', _door1, name player]) call broadcast;
	player playmove "AinvPknlMstpSlayWrflDnon";
	_object = _class createvehicle _pos;
	_object setpos [(getPos player select 0),(getPos player select 1),.5];
	player groupchat "Detonation in 9 seconds";
	sleep 5;
	player groupchat "Detonation in 4 seconds";
	sleep 4;
	"R_57mm_HE" createVehicle [(getPos _object select 0),(getPos _object select 1),-40];
	deletevehicle _object;
	
	_door1 animate ["FrontDoor",1];
	[_door1, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
	[_item, -1] call INV_AddInvItem;
	};

	if (_door2 iskindof "Land_MBG_GER_RHUS_4") then {
	(format ['server globalChat "Officer %2 is breaking down the door on %1s house!";', _door2, name player]) call broadcast;
	player playmove "AinvPknlMstpSlayWrflDnon";
	_object = _class createvehicle _pos;
	_object setpos [(getPos player select 0),(getPos player select 1),.5];
	player groupchat "Detonation in 9 seconds";
	sleep 5;
	player groupchat "Detonation in 4 seconds";
	sleep 4;
	"R_57mm_HE" createVehicle [(getPos _object select 0),(getPos _object select 1),-40];
	deletevehicle _object;
	
	_door2 animate ["FrontDoor",1];
	[_door2, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
	[_item, -1] call INV_AddInvItem;
	};

	if (_door3 iskindof "il_bighouse" and iscop) then {
	(format ['server globalChat "Officer %2 is breaking down the door on %1s house!";', _door3, name player]) call broadcast;
	player playmove "AinvPknlMstpSlayWrflDnon";
	_object = _class createvehicle _pos;
	_object setpos [(getPos player select 0),(getPos player select 1),.5];
	player groupchat "Detonation in 9 seconds";
	sleep 5;
	player groupchat "Detonation in 4 seconds";
	sleep 4;
	"R_57mm_HE" createVehicle [(getPos _object select 0),(getPos _object select 1),-40];
	deletevehicle _object;
	
	_door3 animate ["fdoor",1];
	[_item, -1] call INV_AddInvItem;
	};

	if (_door4 iskindof "Land_MBG_GER_HUS_1") then {
	(format ['server globalChat "Officer %2 is breaking down the door on %1s house!";', _door4, name player]) call broadcast;
	player playmove "AinvPknlMstpSlayWrflDnon";
	_object = _class createvehicle _pos;
	_object setpos [(getPos player select 0),(getPos player select 1),.5];
	player groupchat "Detonation in 9 seconds";
	sleep 5;
	player groupchat "Detonation in 4 seconds";
	sleep 4;
	"R_57mm_HE" createVehicle [(getPos _object select 0),(getPos _object select 1),-40];
	deletevehicle _object;
	
	_door4 animate ["FrontDoor",1];
	[_door4, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
	[_item, -1] call INV_AddInvItem;
	};

	if (_door5 iskindof "Land_MBG_GER_HUS_3") then {
	(format ['server globalChat "Officer %2 is breaking down the door on %1s house!";', _door5, name player]) call broadcast;
	player playmove "AinvPknlMstpSlayWrflDnon";
	_object = _class createvehicle _pos;
	_object setpos [(getPos player select 0),(getPos player select 1),.5];
	player groupchat "Detonation in 9 seconds";
	sleep 5;
	player groupchat "Detonation in 4 seconds";
	sleep 4;
	"R_57mm_HE" createVehicle [(getPos _object select 0),(getPos _object select 1),-40];
	deletevehicle _object;
	
	_door5 animate ["FrontDoor",1];
	[_door5, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
	[_item, -1] call INV_AddInvItem;
	};

	if (_door6 iskindof "house2") then {
	(format ['server globalChat "Officer %2 is breaking down the door on %1s house!";', _door6, name player]) call broadcast;
	player playmove "AinvPknlMstpSlayWrflDnon";
	_object = _class createvehicle _pos;
	_object setpos [(getPos player select 0),(getPos player select 1),.5];
	player groupchat "Detonation in 9 seconds";
	sleep 5;
	player groupchat "Detonation in 4 seconds";
	sleep 4;
	"R_57mm_HE" createVehicle [(getPos _object select 0),(getPos _object select 1),-40];
	deletevehicle _object;
	
	_door6 animate ["door1",1];
	[_item, -1] call INV_AddInvItem;
	};

	if (_door7 iskindof "Fence_corrugated_plate") then {
	(format ['server globalChat "Officer %2 is breaking down the door on %1s house!";', _door7, name player]) call broadcast;
	player playmove "AinvPknlMstpSlayWrflDnon";
	_object = _class createvehicle _pos;
	_object setpos [(getPos player select 0),(getPos player select 1),.5];
	player groupchat "Detonation in 9 seconds";
	sleep 5;
	player groupchat "Detonation in 4 seconds";
	sleep 4;
	"R_57mm_HE" createVehicle [(getPos _object select 0),(getPos _object select 1),-40];
	deletevehicle _object;
	_door7 setPos [(getPos _door7 select 0),(getPos _door7 select 1),-5];
	sleep 15;
	_door7 setPos [(getPos _door7 select 0),(getPos _door7 select 1),0];
	
	[_item, -1] call INV_AddInvItem;
	};	

}
else
{
(format ['server globalChat "%1 attempted to use an explosive on a house, but neighbors have spotted him!";', name player]) call broadcast;
};	

};
