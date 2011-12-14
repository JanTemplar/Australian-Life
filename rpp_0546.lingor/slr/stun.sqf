_event = _this select 0;
_unit = "";
_anim = "";



if (_event == "fired") then 
{	
	_ammo   = _this select 1;
	_bullet = nearestObject  [player, _ammo];
	_playerList = [] call TNL_cfplayer_activeSlots;

	// TAZER XREP
	_tazerAmmo = 
	[
		//Stone
		//["GrenadeHand_Stone", 8, "tazer_hit"], 
		//Makarov
		["8Rnd_9x18_Makarov", 8, "tazer_hit"] 
	];
	{
		_range = (_x select 1);
		_tazerBul = (_x select 0);
		_typeScript = (_x select 2);
		
		if (_ammo == (_tazerBul)) then
		{
			while {(not(isNull _bullet))} do 
			{
				_ObjectArray = nearestObjects [_bullet, ["MAN"], _range];
				{
					if ((player != (_this select 2)) and (_x in _playerList)) then	
					{
						[{if (player == (_this select 0)) then {[(_this select 1)] execVM "slr\stun.sqf";};}, [_x,_typeScript,player]] call TNL_fnet_execPublic;
					};
				} forEach _ObjectArray;
			sleep 0.001;
			};
		};
	} forEach _tazerAmmo;

	
};

// Tazer XREP hit
if (_event == "tazer_hit") then 
{
	private ["_anim","_unit"];
	if ((isstunned) or (not (alive player)) or ((not(vehicle player == player)) and ((speed (vehicle player)) > 1))) exitWith {};
	_inflictedpain = (random 0.13);
	
	if (_inflictedpain <= 0.06) then 
	{
		_inflictedpain = 0.06
	};
	
	isstunned = true;
	closeDialog 0;

	[{(_this select 0) switchmove (_this select 1);}, [player, "AdthPercMstpSnonWnonDnon_3"]] call TNL_fnet_execPublic;
	titleText ["You have been stunned...","plain"];
	call compile format ["%1", "disableUserInput true"]; //Why call compile format.....
	
	[] execVM "slr\dropweapons.sqf";
	
	_stunLength = 20;
	for [{_x=1},{_x<=_stunLength},{_x=_x+1}] do 
	{
		0 fadesound 0;
		cutText ["","WHITE OUT",0.4];
		0.1 fadesound 0.2;
		cutText ["","WHITE IN",0.4];
		sleep 1;
	};

	cutText ["","WHITE OUT", 0.60];
	sleep (4+(random 8));
	player setdamage ((getdammage player) + (random 0.20));
	cutText ["","WHITE IN", 0.1];
	40 fadesound 1;
	[{(_this select 0) switchmove (_this select 1)}, [player, "AmovPpneMstpSnonWnonDnon"]] call TNL_fnet_execPublic;
	call compile format ["%1", "disableUserInput false"];
	sleep 1;
	isstunned = false;
};
