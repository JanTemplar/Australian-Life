// rob petrol station script, called on client, the amount u steal is determined by a server loop, in stationrobloop.sqf
// written by eddie vedder


_selection = ((_this select 3) select 0);

if (_selection == "station 1") then
{
if (!(call INV_isArmed)) exitwith
	{
	player groupchat "You need a gun to rob the station!";
	}; 
_sel = "BP Service Station";
(format['if(!("Robbed a petrol station" in %1_reason))then{%1_reason = %1_reason + ["Robbed a petrol station"]}; %1_wanted = 1; kopfgeld_%1 = kopfgeld_%1 + wantedamountforrobbing;', player]) call broadcast;
['geld', station1money] call INV_AddInvItem;
(format ['server globalChat "Someone robbed %1!";', _sel]) call broadcast;
player sidechat format ["You stole $%1 from the petrol station!", station1money];
station1money = 0;
publicvariable "station1money";
};

if (_selection == "station 2") then
{
if (!(call INV_isArmed)) exitwith
	{
	player groupchat "You need a gun to rob the station!";
	};
_sel = "Caltax Service Station";
(format['if(!("Robbed a petrol station" in %1_reason))then{%1_reason = %1_reason + ["Robbed a petrol station"]}; %1_wanted = 1; kopfgeld_%1 = kopfgeld_%1 + wantedamountforrobbing;', player]) call broadcast;
['geld', station2money] call INV_AddInvItem;
(format ['server globalChat "Someone robbed %1!";', _sel]) call broadcast;
player sidechat format ["You stole $%1 from the petrol station!", station2money];
station2money = 0;
publicvariable "station2money";
};

if (_selection == "station 3") then
{
if (!(call INV_isArmed)) exitwith
	{
	player groupchat "You need a gun to rob the station!";
	};
_sel = "Mobil Service Station";
(format['if(!("Robbed a petrol station" in %1_reason))then{%1_reason = %1_reason + ["Robbed a petrol station"]}; %1_wanted = 1; kopfgeld_%1 = kopfgeld_%1 + wantedamountforrobbing;', player]) call broadcast;
['geld', station3money] call INV_AddInvItem;
(format ['server globalChat "Someone robbed %1!";', _sel]) call broadcast;
player sidechat format ["You stole $%1 from the petrol station!", station3money];
station3money = 0;
publicvariable "station3money";
};

if (_selection == "station 4") then
{
if (!(call INV_isArmed)) exitwith
	{
	player groupchat "You need a gun to rob the station!";
	};
_sel = "Shell Service Station";
(format['if(!("Robbed a petrol station" in %1_reason))then{%1_reason = %1_reason + ["Robbed a petrol station"]}; %1_wanted = 1; kopfgeld_%1 = kopfgeld_%1 + wantedamountforrobbing;', player]) call broadcast;
['geld', station4money] call INV_AddInvItem;
(format ['server globalChat "Someone robbed %1!";', _sel]) call broadcast;
player sidechat format ["You stole $%1 from the petrol station!", station4money];
station4money = 0;
publicvariable "station4money";
};