//The New Life (RPG Mission)
//Copyright (C) 2009  Matthew Simms & Petr Klíma

TNL_fres_killed = 
{
	private ["_unit", "_killed"];
	_victim = (_this select 0);
	_killer = (_this select 1);
	
	closeDialog 0;
	
	if (_victim == _killer) then
	{
		if (player == _victim) then
		{
			TNL_gVar_int_nKilledSelf = TNL_gVar_int_nKilledSelf + 1;
		};
	};
	
	

	if (player == _victim) then
	{
		if (isNil "TNL_gVar_hasRespawned") then
		{
			TNL_gVar_hasRespawned = false;
		};
		
		if (isNil "TNL_gVar_beenKilled") then
		{
			TNL_gVar_beenKilled = false;
		};
		
		[{
			if (isServer) then
			{
				[(_this select 0)] spawn
				{
					_victim = (_this select 0);
					sleep 600;
					deleteVehicle _victim;
				};
			};
		}, [_victim]] call TNL_fnet_execPublic;
		
		if (!TNL_gVar_beenKilled) then
		{
			[] execVM "slr\dropweapons.sqf";
			TNL_gVar_beenKilled = true;
			TNL_gVar_int_nDeaths = TNL_gVar_int_nDeaths + 1;
			TNL_gVar_int_respawnTime = TNL_gVar_int_respawnTime + TNL_gVar_int_respawnTimeIncreasePerDeath;
			if (TNL_gVar_int_respawnTime >= TNL_gVar_int_maxRespawnTime) then { TNL_gVar_int_respawnTime = TNL_gVar_int_maxRespawnTime; };
			[player] spawn TNL_fres_respawnCam;
			[] spawn TNL_fres_respawnDropItems;
		};
	};
	
	if ((player == _killer) && (_victim != _killer)) then
	{
		TNL_gVar_int_nKills = TNL_gVar_int_nKills + 1;
	};
	
};

TNL_fres_respawn =
{
	private ["_respawnPoint"];
	
	waitUntil {alive player};
	
	TNL_gVar_beenKilled = false;
	holmenu = 0;
	unholmenu = 0;
	holstervar = false;
	unholstervar = false;
	phasweapon  = false;
	HandWeapon = false;
		
	TNL_gVar_hasRespawned = true;
	_respawnPoint = [player] call TNL_fplayer_getRespawn;
	player setPos getMarkerpos (_respawnPoint);
	[player, ([] call TNL_fdb_getCharData) select 0] call TNL_fdb_setFace; //Need to re-assign char's face to the newly spawned body
	[] spawn TNL_fres_respawnEffect;
	//player addEventHandler ["killed", "[_this select 0, _this select 1] call TNL_fres_killed;"];
	//player addEventHandler ["fired",  {["fired", (_this select 4)] execVM "slr\stun.sqf" }];
};

TNL_fres_respawnEffect = 
{
	titleCut ["","WHITE IN",1];
	titleText ["", "WHITE IN", 1];
	
	["You have woken up from the hospital, You seem to have lost all your money and items you were carrying."] call TNL_fextHint_Hint;
	
	"dynamicBlur" ppEffectEnable true;
	_i = 10;
	while {_i != -1} do
	{
		"dynamicBlur" ppEffectAdjust[_i];
		"dynamicBlur" ppEffectCommit 2;
		
		_i = _i - 1;
		sleep 2;
	};
	
	sleep 1;
	[100] call TNL_fhunger_increaseHunger;
	[100] call TNL_fthirst_increaseThirst;

	"dynamicBlur" ppEffectEnable false;
	
	
};

TNL_fres_respawnCam = 
{
	private ["_player"];
	_player = _this select 0;
	_respawnTime = (time + TNL_gVar_int_respawnTime);
	_time = time;
	TNL_gVar_hasRespawned = false;
	
	Gvar_int_player_hunger = 75;
	Gvar_int_player_thirst = 75;
	
	{
		[(_x select 0), 0.25] call TNL_fskills_decreaseSkill;
	} forEach TNL_gVar_arr_skills;

	playMusic "Ambient02_Vague_Shapes";
	2 fadeSound 0;
	10 fadeMusic 1;
	
	_camera = "camera" camcreate [(getpos vehicle player select 0), (getpos vehicle player select 1), (getpos vehicle player select 2)+5];
	_camera camSetPos [(getpos vehicle player select 0), (getpos vehicle player select 1), (getpos vehicle player select 2)+5];
	_camera cameraEffect ["internal", "back"];
	_camera camSetTarget player;
	_camera camSetFOV 0.700;
	_camera camCommit 0;
	waitUntil {camCommitted _camera};
	_camera camSetPos [(getpos vehicle player select 0), (getpos vehicle player select 1), (getpos vehicle player select 2)+20];
	_camera camSetTarget (player);
	_camera camSetFOV 0.700;
	_camera camCommit 10;
	waitUntil {camCommitted _camera};
	camera camPreload 5;
	waitUntil {camPreloaded _camera};
	

	_i = 0;
	while {_respawnTime >= _time} do 
	{	
		_cameraTarget = ((TNL_gVar_arr_respawnCamPositions select _i) select 0);
		_cameraPos = ((TNL_gVar_arr_respawnCamPositions select _i) select 1);
		_cameraFov = ((TNL_gVar_arr_respawnCamPositions select _i) select 2);
		
		_camera camSetPos _cameraPos;							
		_camera camSetTarget _cameraTarget;											
		_camera camSetFOV _cameraFov;				
		_camera camCommit 10;		
		
		
		if (_i >= (count TNL_gVar_arr_respawnCamPositions)) then
		{
			_i = 0;
		};
	
		waitUntil {camCommitted _camera};
		_i = _i + 1;
		_time = time;
	};

	2 fadeSound 1;
	10 fadeMusic 0;
	_camera cameraEffect ["terminate","back"];
	titleCut [" ","Black in",1];
	camDestroy _camera;
	[] spawn TNL_fres_respawn;
};

TNL_fres_respawnDropItems = 
{
	private ["_dropItems"];
	_dropItems = [];
	{
		_itemClass = (_x select 0);
		_itemAmount = (_x select 1);
		_itemDropsOnDeath = (_itemClass) call TNL_finv_isDroppedOnDeath;
		
		if (_itemDropsOnDeath) then
		{	
			_dropItems = _dropItems + [ [_itemClass, _itemAmount] ];
			[_itemClass, 0] call TNL_finv_setItemAmount;
		};
	} forEach Gvar_arr_inv_inventory;
	
	_dropItems execVM "slr\dropItem.sqf";
};