//WEED WAS HERE!!! So Was Firefighter Edwood never came
// some generic hack detector
// by Darky
_whiteList = ["!NoBody!"];
_hackdetect = false;
_whiteUser = false;
for "_i" from 0 to ((count _whiteList) - 1) do
{
    _curUID = (_whiteList select _i);
    if (getPlayerUID player == _curUID) then
    {
        _whiteUser = true;
    };
};
    
if !(_whiteUser) then
{
    //Global Variable Scanner
    _glHackVars = ["frezok", "tHight"];
    for "_i" from 0 to ((count _glHackVars) - 1) do
    {
        _curVarName = (_glHackVars select _i);
        if !(isnil _curVarName) then 
        {
            _hackdetect = true;
            if (_hackdetect) exitWith {haxorname = name player;
        publicVariable "haxorname";
		format['server globalChat "HackBot: %1 is hacking. Ban this player now.";', haxorname] call broadcast;
		"serverCommand #exec ban (_this select 0);";
		disableUserInput true;
		player enableSimulation false;};
        };    
    };
    
    //Class Scanner
    _glClassesNames = ["carpetbomb_menu","playerhijack_menu","zargabad_menu","joker_menu","endgame_menu",
                        "AlexAdmin_menu","Alexander_menu","ChernoRape_menu","MightyGerk_menu","SpawnSoldier_menu",
                        "AtackPlanes","GrkTeleport","crpbmb_menu","Delete_menu","Verbal_menu","playerhijack_menu"];
    for "_i" from 0 to ((count _glClassesNames) - 1) do
    {
        _curClassName = (_glClassesNames select _i);
        if (isClass (configFile >> _curClassName)) then
        {
            _hackdetect = true;
            if (_hackdetect) exitWith {haxorname = name player;
        publicVariable "haxorname";
		format['server globalChat "HackBot: %1 is hacking. Ban this player now.";', haxorname] call broadcast;
		format['server globalChat "HackBot: %1 has been disabled. This player is no longer a problem.";', haxorname] call broadcast;
		if(isServer)then{"serverCommand #exec ban (_this select 0);";};
		disableUserInput true;
		player enableSimulation false;
		};
        };
    };
    _objConf = configFile >> "CfgPatches";
    _confCount = count _objConf;
    
    if ((_confCount == 467) || (_confCount == 366)) then
    {
    }
    else
    {
        _hackdetect = false;
    };
    
    if (_hackdetect) then
    {
        haxorname = name player;
        publicVariable "haxorname";
		format['server globalChat "HackBot: %1 is hacking.";', haxorname] call broadcast;
		"serverCommand format[""#exec kick %1 "",haxorname];";
		disableUserInput true;
		player enableSimulation false;
		
    };
};
