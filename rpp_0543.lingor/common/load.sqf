/*
Name: load.sqf
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (2009/07/11)
Description: Key point for loading shared (used by both the server and the client) scripts
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

//Defines:
_h = execVM "common\WeatherDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "common\timeDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "common\playersDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "common\storageDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "common\factoryDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "common\playerShopDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "common\gasStations.sqf"; waitUntil {scriptDone _h};
_h = execVM "common\workplacesDefine.sqf"; waitUntil {scriptDone _h};

//Load functions:
_h = execVM "common\commonFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "common\ExternalFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "common\playerFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "common\WeatherFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "common\timeFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "common\factoryFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "common\JoinInProgress.sqf"; waitUntil {scriptDone _h};
_h = execVM "common\corporations.sqf"; waitUntil {scriptDone _h};
_h = execVM "common\playerShopFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "common\bank.sqf"; waitUntil {scriptDone _h};
_h = execVM "common\workplacesFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "common\radio.sqf"; waitUntil {scriptDone _h};

//Database:
waitUntil {!isNil "dbCodeA"}; _h = [] spawn dbCodeA; waitUntil {scriptDone _h};
waitUntil {!isNil "dbCodeB"}; _h = [] spawn dbCodeB; waitUntil {scriptDone _h};
waitUntil {!isNil "dbCodeC"}; _h = [] spawn dbCodeC; waitUntil {scriptDone _h};
waitUntil {!isNil "dbCodeD"}; _h = [] spawn dbCodeD; waitUntil {scriptDone _h};
