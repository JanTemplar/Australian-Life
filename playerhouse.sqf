////////////////////////////////////
////			         //
//      Copyright © TCG         //
//www.tcgaming.enjin.com       //
////////////////////////////////

_house  = ((_this select 3) select 0);
_housename = ((_this select 3) select 1);
_uid = getPlayerUID vehicle player;


if ((_house == "frontdoor") and (player distance ganghouse4 <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (player distance ganghouse4 <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "frontdoor") and (player distance ganghouse3 <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (player distance ganghouse3 <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "frontdoor") and (player distance ganghouse3_1 <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (player distance ganghouse3_1 <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "backdoor") and (player distance ganghouse3 <= 8)) then
{
_housename animate ["BackDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cbackdoor") and (player distance ganghouse3 <= 8)) then
{
_housename animate ["BackDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "backdoor") and (player distance ganghouse3_1 <= 8)) then
{
_housename animate ["BackDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cbackdoor") and (player distance ganghouse3_1 <= 8)) then
{
_housename animate ["BackDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};


if ((_house == "frontdoor") and (_uid == "1944774") and (player distance radar <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "1944774") and (player distance radar <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "backdoor") and (_uid == "1944774") and (player distance radar <= 8)) then
{
_housename animate ["BackDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cbackdoor") and (_uid == "1944774") and (player distance radar <= 8)) then
{
_housename animate ["BackDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "1944774") and (player distance radarg <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "1944774") and (player distance radarg <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "frontdoor") and (_uid == "1816512") and (player distance deans <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "1816512") and (player distance deans <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "backdoor") and (_uid == "1816512") and (player distance deans <= 8)) then
{
_housename animate ["BackDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cbackdoor") and (_uid == "1816512") and (player distance deans <= 8)) then
{
_housename animate ["BackDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "1816512") and (player distance deansg <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "1816512") and (player distance deansg <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "frontdoor") and (_uid == "6198470") and (player distance dank <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "6198470") and (player distance dank <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "backdoor") and (_uid == "6198470") and (player distance dank <= 8)) then
{
_housename animate ["BackDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cbackdoor") and (_uid == "6198470") and (player distance dank <= 8)) then
{
_housename animate ["BackDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "6198470") and (player distance dankg <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "6198470") and (player distance dankg <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "frontdoor") and (_uid == "7315590") and (player distance Lumin8 <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "7315590") and (player distance Lumin8 <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "backdoor") and (_uid == "7315590") and (player distance Lumin8 <= 8)) then
{
_housename animate ["BackDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cbackdoor") and (_uid == "7315590") and (player distance Lumin8 <= 8)) then
{
_housename animate ["BackDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "7315590") and (player distance Lumin8g <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "7315590") and (player distance Lumin8g <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "fdoor") and (_uid == "7902022") and (player distance legitxcaps1 <= 12)) then
{
_housename animate ["fdoor",1];
sleep 10;
_housename animate ["fdoor",0];
};

if ((_house == "bdoor") and (_uid == "7902022") and (player distance legitxcaps1 <= 12)) then
{
_housename animate ["bdoor",1];
sleep 10;
_housename animate ["bdoor",0];
};

if ((_house == "hdoor") and (_uid == "7902022") and (player distance legitxcaps1 <= 20)) then
{
_housename animate ["hdoor",1];
sleep 10;
_housename animate ["hdoor",0];
};

if ((_house == "fgarage") and (_uid == "7902022") and (player distance legitxcaps1 <= 12)) then
{
_housename animate ["fgarage",1];
sleep 10;
_housename animate ["fgarage",0];
};

if ((_house == "bgarage") and (_uid == "7902022") and (player distance legitxcaps1 <= 12)) then
{
_housename animate ["bgarage",1];
sleep 10;
_housename animate ["bgarage",0];
};

if ((_house == "frontdoor") and (_uid == "641664") and (player distance WrenisPinkle <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "641664") and (player distance WrenisPinkle <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "641664") and (player distance WrenisPinkleg <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "garage") and (_uid == "641664") and (player distance WrenisPinkleg1 <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "641664") and (player distance WrenisPinkleg <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "cgarage") and (_uid == "641664") and (player distance WrenisPinkleg1 <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "frontdoor") and (_uid == "2411654") and (player distance hiro <= 10)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "2411654") and (player distance hiro <= 10)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "frontdoor") and (_uid == "2592262") and (player distance johnny <= 10)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "2592262") and (player distance johnny <= 10)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "frontdoor") and (_uid == "372352") and (player distance johnny <= 10)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "372352") and (player distance johnny <= 10)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "frontdoor") and (_uid == "481090") and (player distance knoll <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "481090") and (player distance knoll <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "481090") and (player distance knollg <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "garage") and (_uid == "481090") and (player distance knollg1 <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "481090") and (player distance knollg <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "cgarage") and (_uid == "481090") and (player distance knollg1 <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "frontdoor") and (_uid == "812161") and (player distance karnax <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "812161") and (player distance karnax <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "812161") and (player distance karnaxg <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "garage") and (_uid == "812161") and (player distance karnaxg1 <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "812161") and (player distance karnaxg <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "cgarage") and (_uid == "812161") and (player distance karnaxg1 <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "frontdoor") and (_uid == "4022278") and (player distance chief <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "4022278") and (player distance chief <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "backdoor") and (_uid == "4022278") and (player distance chief <= 8)) then
{
_housename animate ["BackDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cbackdoor") and (_uid == "4022278") and (player distance chief <= 8)) then
{
_housename animate ["BackDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "4022278") and (player distance chief2 <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "4022278") and (player distance chief2 <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "frontdoor") and (_uid == "5503110") and (player distance xray <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "5503110") and (player distance xray <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "backdoor") and (_uid == "5503110") and (player distance xray <= 8)) then
{
_housename animate ["BackDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cbackdoor") and (_uid == "5503110") and (player distance xray <= 8)) then
{
_housename animate ["BackDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "5503110") and (player distance xrayg <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "5503110") and (player distance xrayg <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "frontdoor") and (_uid == "2592262") and (player distance wulf2 <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "2592262") and (player distance wulf2 <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "2592262") and (player distance wulf2a <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "garage") and (_uid == "2592262") and (player distance wulf3a <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "2592262") and (player distance wulf2a <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "cgarage") and (_uid == "2592262") and (player distance wulf3a <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "frontdoor") and (_uid == "1400192") and (player distance harris <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "frontdoor") and (_uid == "5765894") and (player distance zack <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "5765894") and (player distance zack <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "5765894") and (player distance zackg <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "garage") and (_uid == "5765894") and (player distance zackg1 <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "5765894") and (player distance zackg <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "cgarage") and (_uid == "5765894") and (player distance zackg1 <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "frontdoor") and (_uid == "1400192") and (player distance harris <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "1400192") and (player distance harris <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "1400192") and (player distance harris2 <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "1400192") and (player distance harris2 <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "frontdoor") and (_uid == "2592262") and (player distance Wulfer <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "2592262") and (player distance Wulfer <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "backdoor") and (_uid == "2592262") and (player distance Wulfer <= 8)) then
{
_housename animate ["BackDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cbackdoor") and (_uid == "2592262") and (player distance Wulfer <= 8)) then
{
_housename animate ["BackDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "2592262") and (player distance wulf5 <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "2592262") and (player distance wulf5 <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "fdoor1") and (ismayor)) then
{
_housename animate ["door1",1];
sleep 10;
_housename animate ["door1",0];
};

if ((_house == "garagedoor") and (ismayor)) then
{
_housename animate ["garage1",1];
sleep 10;
_housename animate ["garage1",0];
};

if ((_house == "garagedoor1") and (ismayor)) then
{
_housename animate ["garage2",1];
sleep 10;
_housename animate ["garage2",0];
};

if ((_house == "fdoor1") and (_uid == "2207622") and (player distance playerhouse2a <= 8)) then
{
_housename animate ["door1",1];
sleep 10;
_housename animate ["door1",0];
};

if ((_house == "garagedoor") and (_uid == "2207622") and (player distance playerhouse2a <= 8)) then
{
_housename animate ["garage1",1];
sleep 10;
_housename animate ["garage1",0];
};

if ((_house == "garagedoor1") and (_uid == "2207622") and (player distance playerhouse2a <= 8)) then
{
_housename animate ["garage2",1];
sleep 10;
_housename animate ["garage2",0];
};

if ((_house == "fdoor1") and (_uid == "7102278") and (player distance playerhouse3a <= 8)) then
{
_housename animate ["door1",1];
sleep 10;
_housename animate ["door1",0];
};

if ((_house == "garagedoor") and (_uid == "7102278") and (player distance playerhouse3a <= 8)) then
{
_housename animate ["garage1",1];
sleep 10;
_housename animate ["garage1",0];
};

if ((_house == "garagedoor1") and (_uid == "7102278") and (player distance playerhouse3a <= 8)) then
{
_housename animate ["garage2",1];
sleep 10;
_housename animate ["garage2",0];
};

if ((_house == "fdoor1") and (_uid == "4589270") and (player distance playerhouse5a <= 8)) then
{
_housename animate ["door1",1];
sleep 10;
_housename animate ["door1",0];
};

if ((_house == "garagedoor") and (_uid == "4589270") and (player distance playerhouse5a <= 8)) then
{
_housename animate ["garage1",1];
sleep 10;
_housename animate ["garage1",0];
};

if ((_house == "garagedoor1") and (_uid == "4589270") and (player distance playerhouse5a <= 8)) then
{
_housename animate ["garage2",1];
sleep 10;
_housename animate ["garage2",0];
};

if ((_house == "fdoor") and (_uid == "7102278") and (player distance mansion1a <= 12)) then
{
_housename animate ["fdoor",1];
sleep 10;
_housename animate ["fdoor",0];
};

if ((_house == "bdoor") and (_uid == "7102278") and (player distance mansion1a <= 12)) then
{
_housename animate ["bdoor",1];
sleep 10;
_housename animate ["bdoor",0];
};

if ((_house == "hdoor") and (_uid == "7102278") and (player distance mansion1a <= 20)) then
{
_housename animate ["hdoor",1];
sleep 10;
_housename animate ["hdoor",0];
};

if ((_house == "fgarage") and (_uid == "7102278") and (player distance mansion1a <= 12)) then
{
_housename animate ["fgarage",1];
sleep 10;
_housename animate ["fgarage",0];
};

if ((_house == "bgarage") and (_uid == "7102278") and (player distance mansion1a <= 12)) then
{
_housename animate ["bgarage",1];
sleep 10;
_housename animate ["bgarage",0];
};

if ((_house == "frontdoor") and (_uid == "5035014") and (player distance johnny <= 10)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "5035014") and (player distance johnny <= 10)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "fdoor") and (_uid == "433856") and (player distance mansion2a <= 12)) then
{
_housename animate ["fdoor",1];
sleep 10;
_housename animate ["fdoor",0];
};

if ((_house == "bdoor") and (_uid == "433856") and (player distance mansion2a <= 12)) then
{
_housename animate ["bdoor",1];
sleep 10;
_housename animate ["bdoor",0];
};

if ((_house == "hdoor") and (_uid == "433856") and (player distance mansion2a <= 20)) then
{
_housename animate ["hdoor",1];
sleep 10;
_housename animate ["hdoor",0];
};

if ((_house == "fgarage") and (_uid == "433856") and (player distance mansion2a <= 12)) then
{
_housename animate ["fgarage",1];
sleep 10;
_housename animate ["fgarage",0];
};

if ((_house == "bgarage") and (_uid == "433856") and (player distance mansion2a <= 12)) then
{
_housename animate ["bgarage",1];
sleep 10;
_housename animate ["bgarage",0];
};

if ((_house == "fdoor") and (_uid == "1047169") and (player distance mansion3a <= 12)) then
{
_housename animate ["fdoor",1];
sleep 10;
_housename animate ["fdoor",0];
};

if ((_house == "bdoor") and (_uid == "1047169") and (player distance mansion3a <= 12)) then
{
_housename animate ["bdoor",1];
sleep 10;
_housename animate ["bdoor",0];
};

if ((_house == "hdoor") and (_uid == "1047169") and (player distance mansion3a <= 20)) then
{
_housename animate ["hdoor",1];
sleep 10;
_housename animate ["hdoor",0];
};

if ((_house == "fgarage") and (_uid == "1047169") and (player distance mansion3a <= 12)) then
{
_housename animate ["fgarage",1];
sleep 10;
_housename animate ["fgarage",0];
};

if ((_house == "bgarage") and (_uid == "1047169") and (player distance mansion3a <= 12)) then
{
_housename animate ["bgarage",1];
sleep 10;
_housename animate ["bgarage",0];
};

if ((_house == "fdoor") and (_uid == "") and (player distance ismansiona <= 12)) then
{
_housename animate ["fdoor",1];
sleep 10;
_housename animate ["fdoor",0];
};

if ((_house == "bdoor") and (_uid == "") and (player distance ismansiona <= 12)) then
{
_housename animate ["bdoor",1];
sleep 10;
_housename animate ["bdoor",0];
};

if ((_house == "hdoor") and (_uid == "") and (player distance ismansiona <= 20)) then
{
_housename animate ["hdoor",1];
sleep 10;
_housename animate ["hdoor",0];
};

if ((_house == "fgarage") and (_uid == "") and (player distance ismansiona <= 12)) then
{
_housename animate ["fgarage",1];
sleep 10;
_housename animate ["fgarage",0];
};

if ((_house == "bgarage") and (_uid == "") and (player distance ismansiona <= 12)) then
{
_housename animate ["bgarage",1];
sleep 10;
_housename animate ["bgarage",0];
};

if ((_house == "gate") and (_uid == "") and (player distance ismansiona <= 20)) then
{
_housename animate ["fgate",1];
sleep 10;
_housename animate ["fgate",0];
};

if ((_house == "fdoor") and (_uid == "1935745") and (player distance mansion4a <= 12)) then
{
_housename animate ["fdoor",1];
sleep 10;
_housename animate ["fdoor",0];
};

if ((_house == "bdoor") and (_uid == "1935745") and (player distance mansion4a <= 12)) then
{
_housename animate ["bdoor",1];
sleep 10;
_housename animate ["bdoor",0];
};

if ((_house == "hdoor") and (_uid == "1935745") and (player distance mansion4a <= 20)) then
{
_housename animate ["hdoor",1];
sleep 10;
_housename animate ["hdoor",0];
};

if ((_house == "fgarage") and (_uid == "1935745") and (player distance mansion4a <= 12)) then
{
_housename animate ["fgarage",1];
sleep 10;
_housename animate ["fgarage",0];
};

if ((_house == "bgarage") and (_uid == "1935745") and (player distance mansion4a <= 12)) then
{
_housename animate ["bgarage",1];
sleep 10;
_housename animate ["bgarage",0];
};

if ((_house == "fdoor") and (_uid == "363905") and (player distance mansion5a <= 12)) then
{
_housename animate ["fdoor",1];
sleep 10;
_housename animate ["fdoor",0];
};

if ((_house == "bdoor") and (_uid == "363905") and (player distance mansion5a <= 12)) then
{
_housename animate ["bdoor",1];
sleep 10;
_housename animate ["bdoor",0];
};

if ((_house == "hdoor") and (_uid == "363905") and (player distance mansion5a <= 20)) then
{
_housename animate ["hdoor",1];
sleep 10;
_housename animate ["hdoor",0];
};

if ((_house == "fgarage") and (_uid == "363905") and (player distance mansion5a <= 12)) then
{
_housename animate ["fgarage",1];
sleep 10;
_housename animate ["fgarage",0];
};

if ((_house == "bgarage") and (_uid == "363905") and (player distance mansion5a <= 12)) then
{
_housename animate ["bgarage",1];
sleep 10;
_housename animate ["bgarage",0];
};

if ((_house == "frontdoor") and (_uid == "4859270") and (player distance Ben <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "4859270") and (player distance Ben <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "4859270") and (player distance mansion6a <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "4859270") and (player distance mansion6a <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "frontdoor") and (_uid == "3088262") and (player distance mansiondos <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "3088262") and (player distance mansiondos <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "3088262") and (player distance garagedos <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "3088262") and (player distance garagedos <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "garage") and (_uid == "372352") and (player distance bryceg1 <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "372352") and (player distance bryceg1 <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "garage") and (_uid == "372352") and (player distance bryceg2 <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "372352") and (player distance bryceg2 <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "frontdoor") and (_uid == "372352") and (player distance Bryce <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "frontdoor") and (_uid == "372352") and (player distance Bryce2 <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "372352") and (player distance Bryce2 <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "372352") and (player distance Bryce <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "backdoor") and (_uid == "372352") and (player distance Bryce <= 8)) then
{
_housename animate ["BackDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cbackdoor") and (_uid == "372352") and (player distance Bryce <= 8)) then
{
_housename animate ["BackDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "372352") and (player distance mansion7a <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "372352") and (player distance mansion7a <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "frontdoor") and (_uid == "1198465") and (player distance Jacko <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "1198465") and (player distance Jacko <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "1198465") and (player distance mansion8a <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "1198465") and (player distance mansion8a <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};


if ((_house == "fdoor") and (_uid == "7981446") and (player distance mansion9a <= 12)) then
{
_housename animate ["fdoor",1];
sleep 10;
_housename animate ["fdoor",0];
};

if ((_house == "bdoor") and (_uid == "7981446") and (player distance mansion9a <= 12)) then
{
_housename animate ["bdoor",1];
sleep 10;
_housename animate ["bdoor",0];
};

if ((_house == "hdoor") and (_uid == "7981446") and (player distance mansion9a <= 20)) then
{
_housename animate ["hdoor",1];
sleep 10;
_housename animate ["hdoor",0];
};

if ((_house == "fgarage") and (_uid == "7981446") and (player distance mansion9a <= 12)) then
{
_housename animate ["fgarage",1];
sleep 10;
_housename animate ["fgarage",0];
};

if ((_house == "bgarage") and (_uid == "7981446") and (player distance mansion9a <= 12)) then
{
_housename animate ["bgarage",1];
sleep 10;
_housename animate ["bgarage",0];
};

if ((_house == "fdoor") and (_uid == "5388230") and (player distance mansion10a <= 12)) then
{
_housename animate ["fdoor",1];
sleep 10;
_housename animate ["fdoor",0];
};

if ((_house == "bdoor") and (_uid == "5388230") and (player distance mansion10a <= 12)) then
{
_housename animate ["bdoor",1];
sleep 10;
_housename animate ["bdoor",0];
};

if ((_house == "hdoor") and (_uid == "5388230") and (player distance mansion10a <= 20)) then
{
_housename animate ["hdoor",1];
sleep 10;
_housename animate ["hdoor",0];
};

if ((_house == "fgarage") and (_uid == "5388230") and (player distance mansion10a <= 12)) then
{
_housename animate ["fgarage",1];
sleep 10;
_housename animate ["fgarage",0];
};

if ((_house == "bgarage") and (_uid == "5388230") and (player distance mansion10a <= 12)) then
{
_housename animate ["bgarage",1];
sleep 10;
_housename animate ["bgarage",0];
};

if ((_house == "fdoor") and (_uid == "4769158") and (player distance mansion11a <= 12)) then
{
_housename animate ["fdoor",1];
sleep 10;
_housename animate ["fdoor",0];
};

if ((_house == "bdoor") and (_uid == "4769158") and (player distance mansion11a <= 12)) then
{
_housename animate ["bdoor",1];
sleep 10;
_housename animate ["bdoor",0];
};

if ((_house == "hdoor") and (_uid == "4769158") and (player distance mansion11a <= 20)) then
{
_housename animate ["hdoor",1];
sleep 10;
_housename animate ["hdoor",0];
};

if ((_house == "fgarage") and (_uid == "4769158") and (player distance mansion11a <= 12)) then
{
_housename animate ["fgarage",1];
sleep 10;
_housename animate ["fgarage",0];
};

if ((_house == "bgarage") and (_uid == "4769158") and (player distance mansion11a <= 12)) then
{
_housename animate ["bgarage",1];
sleep 10;
_housename animate ["bgarage",0];
};

if ((_house == "frontdoor") and (_uid == "1386560") and (player distance heckert <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "1386560") and (player distance heckert <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "1386560") and (player distance heckertg <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "1386560") and (player distance heckertg <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "frontdoor") and (_uid == "4107270") and (player distance belosi <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "4107270") and (player distance belosi <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "4107270") and (player distance belosig <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "4107270") and (player distance belosig <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "frontdoor") and (_uid == "6351622") and (player distance hiddenops <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "6351622") and (player distance hiddenops <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "backdoor") and (_uid == "6351622") and (player distance hiddenops <= 8)) then
{
_housename animate ["BackDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cbackdoor") and (_uid == "6351622") and (player distance hiddenops <= 8)) then
{
_housename animate ["BackDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "6351622") and (player distance hiddenopsg <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "6351622") and (player distance hiddenopsg <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "frontdoor") and (_uid == "2411654") and (player distance hiro2 <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "2411654") and (player distance hiro2 <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "backdoor") and (_uid == "2411654") and (player distance hiro2 <= 8)) then
{
_housename animate ["BackDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cbackdoor") and (_uid == "2411654") and (player distance hiro2 <= 8)) then
{
_housename animate ["BackDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "2411654") and (player distance hiro2g <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "2411654") and (player distance hiro2g <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "frontdoor") and (_uid == "2058758") and (player distance hagar <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "2058758") and (player distance hagar <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "backdoor") and (_uid == "2058758") and (player distance hagar <= 8)) then
{
_housename animate ["BackDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cbackdoor") and (_uid == "2058758") and (player distance hagar <= 8)) then
{
_housename animate ["BackDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "2058758") and (player distance hagarg <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "2058758") and (player distance hagarg <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "frontdoor") and (_uid == "2321664") and (player distance cahethel <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "2321664") and (player distance cahethel <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "backdoor") and (_uid == "2321664") and (player distance cahethel <= 8)) then
{
_housename animate ["BackDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cbackdoor") and (_uid == "2321664") and (player distance cahethel <= 8)) then
{
_housename animate ["BackDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "frontdoor") and (_uid == "2321664") and (player distance cahethel2 <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "2321664") and (player distance cahethel2 <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "backdoor") and (_uid == "2321664") and (player distance cahethel2 <= 8)) then
{
_housename animate ["BackDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cbackdoor") and (_uid == "2321664") and (player distance cahethel2 <= 8)) then
{
_housename animate ["BackDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "frontdoor") and (_uid == "2321664") and (player distance cahethel3 <= 8)) then
{
_housename animate ["FrontDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cfrontdoor") and (_uid == "2321664") and (player distance cahethel3 <= 8)) then
{
_housename animate ["FrontDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "backdoor") and (_uid == "2321664") and (player distance cahethel3 <= 8)) then
{
_housename animate ["BackDoor",1];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "cbackdoor") and (_uid == "2321664") and (player distance cahethel3 <= 8)) then
{
_housename animate ["BackDoor",0];
[_housename, 'FrontDoor_AP', 'MBG_B3_OpenDoor',4,(_this)] execvm 'MBG_Buildings_3\MPSound.sqf';
};

if ((_house == "garage") and (_uid == "2321664") and (player distance cahethelg <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "2321664") and (player distance cahethelg <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};

if ((_house == "garage") and (_uid == "2321664") and (player distance cahethelg1 <= 6)) then
{
_housename animate ["Open_Gate_1_Rotate",1];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Slide',1];
};

if ((_house == "cgarage") and (_uid == "2321664") and (player distance cahethelg1 <= 6)) then
{
_housename animate['Open_Gate_1_Slide',0];player say 'MBG_B3_GarageOpen';sleep 1;_housename animate['Open_Gate_1_Rotate',0];
};