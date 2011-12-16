/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

TNL_ftime_clientTimeLoop =
{
	setDate[date select 0, date select 1, date select 2, date select 3, ((date select 4)+TNL_gVar_int_clientTimeIncrease)];
};

TNL_ftime_serverTimeLoop = 
{
	[] call TNL_ftime_serverUpdateClients;
};

TNL_ftime_serverUpdateClients = 
{
	[{ setDate[(_this select 0),(_this select 1),(_this select 2),(_this select 3),((_this select 4)+TNL_gVar_int_clientTimeIncrease)]; }, [date select 0, date select 1, date select 2, date select 3, date select 4]] call TNL_fnet_execPublic;
};