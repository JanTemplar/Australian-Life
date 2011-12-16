
_h = [] execVM "slr\definevars.sqf";
waitUntil {scriptDone _h};

_h = [] execVM "slr\functions.sqf";
waitUntil {scriptDone _h};

[] execVM "slr\paycheck.sqf";

if (isServer) then
{
	[] execVM "slr\dealer.sqf";
	[0,0,0,["server"]] execVM "slr\dealerjob.sqf";
	_h = [0,1,2,["ServerMayorLoop"]] execVM "slr\mayor.sqf";
	["serverloop"] execVM "slr\objects.sqf";
	[0,0,0,["serverloop"]] execVM "slr\taxiJob.sqf";
};

