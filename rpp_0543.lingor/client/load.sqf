/*
Name: load.sqf
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (2009/07/11)
Description: Key point for loading client-side scripts
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

//Defines:
_h = execVM "client\precompile.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\defines\banksDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\defines\atmDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\defines\GoodsArray.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\defines\ShopDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\defines\LicenseDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\defines\GatherDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\defines\AnimationDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\defines\MarkerDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\defines\StatsDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\defines\RespawnDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\defines\SkillsDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\defines\vehicleMenuDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\defines\playerInteractionDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\defines\forestryDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\defines\corporationDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\defines\stockMarketDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\defines\ActionsDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\defines\playerShopDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\defines\fishingDefine.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\defines\deliveryDefine.sqf"; waitUntil {scriptDone _h};


//Load functions:
_h = execVM "client\functions\genericFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\ExtendedHintFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\dbFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\ShopFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\InventoryFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\LicenseFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\walletFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\bankFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\atmFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\trunkFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\vehicleFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\keyChainFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\InteractionFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\TradeFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\PublicFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\MarkerFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\AnimationFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\StatsFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\PlayerFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\HungerFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\ThirstFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\ActionsFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\RespawnFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\SkillsFunctions.sqf";	 waitUntil {scriptDone _h};
_h = execVM "client\functions\GatherFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\gasStationsFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\forestryFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\corporationFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\stockMarketFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\JIP.sqf";  waitUntil {scriptDone _h};
_h = execVM "client\functions\siren.sqf";  waitUntil {scriptDone _h};
_h = execVM "client\functions\playerShopFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\FishingFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\employerFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\animalFunctions.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\DeliveryJob.sqf"; waitUntil {scriptDone _h};
_h = execVM "client\functions\exportFunctions.sqf"; waitUntil {scriptDone _h};

execVM "client\functions\keySpoof.sqf";

//Loops:
execVM "client\ClientLoop.sqf";