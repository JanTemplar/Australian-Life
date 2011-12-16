////////////////////////////////////
////			         //
//      Copyright © TCG         //
//www.tcgaming.enjin.com       //
////////////////////////////////

FailCount = 0;

sleep 0.5;

enableSaving [false, false];
WEST setFriend [EAST, 1];
EAST setFriend [WEST, 1];
Resistance setFriend [East, 0];
east setFriend [Resistance, 0];
version        	= "7.3";
compatible     	= 703;
internDebug    	= false;
debug          	= false;
addonversion   	= false;
dedicatedServer = false;
copscount      	= 15;
civscount      	= 45;
playercount    	= 60;
debugarray     	= [];
StartMoney     	= 25000;
nopop	   	= true;	
canuseshopagain = 1;

///execVM "R3F_revive\revive_init.sqf";

execVM "briefing.sqf";
call compile preprocessfile "triggers.sqf";

if(!debug)then{
//["camera"] execVM "introcam.sqf";
["basicintro"] execVM "introcam.sqf";};

waitUntil { ( (time > 1) and ((alive player) or (local server)) ) };
sleep 3;
if (!(createDialog "rulesdialog")) exitWith {hint "Dialog Error!";};
ctrlSetText[1, localize "STRS_maincivrules"];

//if(local server)then{execVM "targets.sqf";};

_h = [] execVM "playerarrays.sqf";																												

waitUntil{scriptDone  _h};

_h = [60, rolenumber] execVM "initfuncs.sqf";

waitUntil{scriptDone  _h};

_h = [playerarray, playerstringarray, !iscop] execVM "INVvars.sqf";

waituntil{scriptDone  _h};

_h = [] execVM "bankexec.sqf";

waitUntil{scriptDone  _h};

_h = [] execVM "initWPmissions.sqf";

waitUntil{scriptDone  _h};

_h = [] execVM "gfx.sqf";

waitUntil{scriptDone  _h};

_h = [] execVM "animList.sqf";

waitUntil{scriptDone  _h};

_h = []	execVM "miscfunctions.sqf";

waitUntil{scriptDone  _h};

_h = [] execVM "variables.sqf";

waitUntil{scriptDone  _h};

//_h = [] execVM "servermissionfile\sheepman.sqf";

//waitUntil{scriptDone  _h};

execVM "BTK\Cargo Drop\Start.sqf";




[SkipTimeDay, SkipTimeNight, 1] execVM "skiptime.sqf"; 
[] execVM "weather.sqf";
setPitchBank = compile preprocessfile "setPitchBank.sqf";
publicvariable "station1robbed";
publicvariable "station2robbed";
publicvariable "station3robbed";
publicvariable "station4robbed";
["init"] execVM "food.sqf";
["init"] execVM "bombs.sqf";

BIS_Effects_Burn=compile preprocessFile "\ca\Data\ParticleEffects\SCRIPTS\destruction\burn.sqf";

if(!dedicatedserver) then

{
["ca\missions_pmc\data\ui_gps_ca.paa",-0.05,0.16] call bis_fnc_customGPS;  
["clientloop"] execVM "clientloop.sqf";
[0,0,0,["clientloop"]] execVM "gangs.sqf";
[] execVM "respawn.sqf";
[] execVM "itemactions.sqf";
[] execVM "petrolactions.sqf";
[] execVM "SpeedCams.sqf";
[] execVM "AntiHacking.sqf";
[] execVM "nametags.sqf";
[] execVM "initplayer.sqf";
//[] execVM "power.sqf";
[2] execVM "markers.sqf";
[] execVM "salaries.sqf";
[] execVM "actions.sqf";
//[] execVM "motd.sqf";
[] execVM "pistolControl.sqf";

CodeBroadcast = [];
"CodeBroadcast" addPublicVariableEventHandler
{
    _params = _this select 1;
    if(local (_params select 0)) then
    {
        (_params select 1) execVM (_params select 2);
    };
};




for [{_i=0}, {_i < (count INV_ItemFabriken)}, {_i=_i+1}] do {_i execVM "facqueue.sqf"};

player addEventHandler ["fired", {["fired", (_this select 4), (_this select 1)] execVM "stun.sqf";}];
player addEventHandler ["handleDamage", {_this call compile preprocessfile "sethit.sqf"}];

waituntil{vehicle player == player};
player addEventHandler ["fired",{_this execVM "fired.sqf"}];
[]spawn {
while{true}do
{
	sleep 1;
	if(player getVariable "flashed" and isciv) then
	{
		
		if (not(alive player)) exitWith {};
		2 cutText ["","WHITE OUT",0];
		sleep 5;
		2 cutText ["","WHITE IN",3];
		sleep 1;
		player setVariable ["flashed",false, true];
		
	};
};
};

player addEventHandler ["fired",{_this execVM "fired1.sqf"}];
[]spawn {
while{true}do
{
	sleep 1;
	if(player getVariable "flashed1") then
	{
		
		if (not(alive player)) exitWith {};
		sleep 2;
		player say ["flash_bang",5];
		2 cutText ["","WHITE OUT",0];
		sleep 10;
		2 cutText ["","WHITE IN",3];
		sleep 1;
		player setVariable ["flashed1",false, true];
		
	};
};
};

onKeyPress = compile preprocessFile "onKeyPress.sqf";
waituntil {!(IsNull (findDisplay 46))};
(findDisplay 46) displaySetEventHandler ["KeyDown", "_this call onKeyPress"];

};

if (isServer) then 

{
workplace_getjobflag_1 setvariable["building1", 11, true];
workplace_getjobflag_2 setvariable["building2", 12, true];
workplace_getjobflag_3 setvariable["building3", 13, true];
workplace_getjobflag_4 setvariable["building4", 14, true];
workplace_getjobflag_5 setvariable["building5", 15, true];
workplace_getjobflag_6 setvariable["building6", 16, true];
["serverloop1"] execVM "servermissionfile\commonloop.sqf";
[0, 0, 0, ["serverloop"]] execVM "mayor.sqf";
[0, 0, 0, ["serverloop"]] execVM "chief.sqf";
//[0, 0, 0, ["Schleife"]] execVM "servermissionfile\mayorserverloop.sqf";
//["Schleife"] execVM "servermissionfile\chiefserverloop.sqf";
//["Schleife"] execVM "servermissionfile\gangsserverloop.sqf";
[0, 0, 0, ["serverloop"]] execVM "gangs.sqf";
[] execVM "servermissionfile\druguse.sqf";
//[] execVM "servermissionfile\drugreplenish.sqf";
[] execVM "servermissionfile\robpool.sqf";
[] execVM "servermissionfile\hunting.sqf";
[] execVM "servermissionfile\governmentconvoy.sqf";
//[] execVM "servermissionfile\sheepman.sqf";
execVM "R3F_revive\revive_init.sqf";
//=======================rob gas station init and variables================
[] execVM "stationrobloop.sqf";

station1money = 5000;
publicvariable "station1money";

station2money = 5000;
publicvariable "station2money";

station3money = 5000;
publicvariable "station3money";

station4money = 5000;
publicvariable "station4money";

station5money = 5000;
publicvariable "station5money";

barmoney = 5000;
publicvariable "barmoney";
barmoney1 = 5000;
publicvariable "barmoney1";
barmoney2 = 5000;
publicvariable "barmoney2";
barmoney3 = 5000;
publicvariable "barmoney3";

["UH1H_TK_GUE_EP1"] execVM "servermissionfile\copchoprespawn.sqf";
["MH6J_EP1"] execVM "servermissionfile\copchoprespawn.sqf";

//for [{_i=0}, {_i < (count INV_ItemShops)}, {_i=_i+1}] do {((INV_ItemShops select _i) select 0) execVM "nomove.sqf"; sleep 0.2;};
//for [{_i=0}, {_i < (count workplacejob_deliveryflagarray)}, {_i=_i+1}] do {(workplacejob_deliveryflagarray select _i) execVM "nomove.sqf"; sleep 0.2;};

};