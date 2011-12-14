_art         = _this select 0;
_stunbullets = ["B_12Gauge_74Slug","B_12Gauge_74Slug","F_40mm_White",1,"B_9x18_SD","8Rnd_9x18_MakarovSD","1Rnd_SMOKEGREEN_GP25","FlareWhite_GP25","x26_mag","stuncharge"];


if (_art == "fired") then 

{
			
_ammo   = _this select 1;
_wep	= _this select 2;  
_bullet = nearestObject  [getpos player, _ammo];

if(isciv and !firingcaptive) then

	{

	_bullet spawn

		{

		while{alive _this} do

			{

			if(_this distance militarybase < 200) exitwith

				{

				firingcaptive=true;
				format['%1 setcaptive false;%1 call reveal;', player] call broadcast;
				sleep 60;
				firingcaptive=false;

				};

			sleep 0.01;

			};

		};

	};


if(player distance civspawn1 < 125 and _wep != "M1014" and _wep != "X26" and isciv) exitwith																																																		
			
	{
		(hintsilent['hint "Someone is shooting in the SW Corner of San Milovitz, police should respond !";']) call broadcast;
		
	};
if(player distance civspawn2 < 125 and _wep != "M1014" and _wep != "X26" and isciv) exitwith																																																		
			
	{
		(hintsilent['hint "Someone is shooting in the SE Corner of San Milovitz, police should respond !";']) call broadcast;
		
	};
if(player distance civspawn3 < 125 and _wep != "M1014" and _wep != "X26" and isciv) exitwith																																																		
			
	{
		(hintsilent['hint "Someone is shooting in the NE Corner of San Milovitz, police should respond !";']) call broadcast;
		
	};
if(player distance civspawn4 < 125 and _wep != "M1014" and _wep != "X26" and isciv) exitwith																																																		
			
	{
		(hintsilent['hint "Someone is shooting in the NW Corner of San Milovitz, police should respond !";']) call broadcast;
		
	};
if(player distance civspawn5 < 300 and _wep != "M1014" and _wep != "X26" and isciv) exitwith																																																		
			
	{
		(hintsilent['hint "Someone is shooting in the town of Nanchuk, police should respond !";']) call broadcast;
		
	};


if(_wep == "Saiga12K")exitwith{};

if (not(_ammo == (_stunbullets select 0))and(not(_ammo == (_stunbullets select 4)))) exitWith {};
																					
_vel   = velocity _bullet;										
_pos   = getpos   _bullet;										
_teiler = (_stunbullets select 3);					
_bullet = (_stunbullets select 2) createVehicle _pos;
_bullet setVelocity [(_vel select 0)/_teiler, (_vel select 1)/_teiler, (_vel select 2)/_teiler];																																		

};


if (_art == "hit") then 

{

_shooter   = _this select 1;
_selection = _this select 2;
_damage    = _this select 3;

if(_damage < 0.01 or _selection == "")exitwith{};
if(_selection == "Legs")exitwith{if(!canstand player)exitwith{};player setHit["Legs", 1];};
if(_selection == "Hands")exitwith{if(handshit player == 1)exitwith{};player setHit["Hands", 1];};																													
/*
if(isstunned) exitwith

	{

	StunActiveTime = StunActiveTime + StunTimePerHit;
	(format["server globalchat ""%1 was tazed by %2"";", name player, name _shooter]) call broadcast;																																																								
	"dynamicBlur" ppEffectEnable true; 
	"dynamicBlur" ppEffectAdjust [10]; 
	"dynamicBlur" ppEffectCommit 0; 
	waitUntil {ppEffectCommitted "dynamicBlur"}; 
	"dynamicBlur" ppEffectEnable true; 
	"dynamicBlur" ppEffectAdjust [0]; 
	"dynamicBlur" ppEffectCommit StunActiveTime;
	
	};
*/
isstunned = true;
StunActiveTime = StunActiveTime + StunTimePerHit;

if(vehicle player != player)then{player Action ["eject", vehicle player]};

"dynamicBlur" ppEffectEnable true; 
"dynamicBlur" ppEffectAdjust [10]; 
"dynamicBlur" ppEffectCommit 0; 
waitUntil {ppEffectCommitted "dynamicBlur"}; 
"dynamicBlur" ppEffectEnable true; 
"dynamicBlur" ppEffectAdjust [0]; 
"dynamicBlur" ppEffectCommit StunActiveTime;

if(_selection != "Melee")then{(format["server globalchat ""%1 was tased by %2"";", name player, name _shooter]) call broadcast};																																																								
			
if(!(call isprone)) then

	{

	(format ["%1 switchmove ""%2"";", player, "adthpercmstpslowwrfldnon_4"]) call broadcast;
	
	}
	else
	{

	(format ["%1 switchmove ""%2"";", player, "adthppnemstpsraswpstdnon_2"]) call broadcast;

	};

_weapons = weapons player - nonlethalweapons;

if (count _weapons > 0) then 

	{
												
	{player removeWeapon _x} forEach _weapons;																														
	call compile format ['waffenhalter%1 = "weaponholder" createVehicle getpos player; waffenhalter%1 setVehicleInit "this setVehicleVarName ""waffenhalter%1""; waffenhalter%1 = this;"; processInitCommands;', rolenumber];
	sleep 0.5;																		
	(format ["{waffenhalter%2 ADDWEAPONCARGO [_x, 1];} forEach %3; waffenhalter%2 setpos %4; if (isServer) then {[waffenhalter%2, 300] spawn ISSE_DeleteVehicle;};", player, rolenumber, _weapons, (getpos player)]) call broadcast;			
	sleep 0.5;	

	};

while{StunActiveTime > 0} do {if(StunActiveTime > MaxStunTime)then{StunActiveTime = MaxStunTime}; StunActiveTime = StunActiveTime - 1; sleep 1;};

StunActiveTime = 0;

if (animationstate player != "civillying01") then 

	{
	
	isstunned = false;	
	if(player call ISSE_IsVictim)then{(format ["%1 switchmove ""%2"";", player, "amovppnemstpsnonwnondnon"]) call broadcast};																						
			
	};
																							
};
