
//If (player getVariable "CLAY_DogStatus" == "Attacking") exitWith {};
_target = _this select 0;
_dog = player getVariable "CLAY_DogUnit";
player setVariable ["CLAY_DogStatus", "Attacking"];

_sound = createSoundSource ["Sound_BadDog", getpos _dog, [], 0];
_sound attachTo [_dog, [0,0,0]];

while {alive _dog && alive _target && player getVariable "CLAY_DogStatus" == "Attacking"} do
{
	_dog doMove getPos _target;
	If (_dog distance _target < 3 && vehicle _target == _target) Then
	{
		_dog doTarget _target;
		_dog lookAt _target;

		_dog switchMove "CLAY_DogAttack";
		//sleep 0.35; 
		_dog setVelocity [0, 0, 2.5];
		
		_target setHit ["legs", 1];
		_target setHit ["hands", 1];
		_target setDammage 0.8;
		player groupchat "The dog has bitten his target";
		(format ["%1 switchmove ""%2"";", _target, "adthpercmstpslowwrfldnon_4"]) call broadcast;
		player setVariable ["CLAY_DogStatus", ""];
		sleep 12;
		(format ["%1 switchmove ""%2"";", _target, "amovppnemstpsnonwnondnon"]) call broadcast;
		
	};
	sleep 1;
};
deleteVehicle _sound;

