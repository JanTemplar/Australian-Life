
_dog = player getVariable "CLAY_DogUnit";
switch (_this select 0) do
{
	case 1:
	{
		
		player setVariable ["CLAY_DogStatus", "Boarding"];
		_vehicle = _this select 1;
		_index = [CLAY_DogVehicles];
		If (_vehicle iskindof "patrol") Then
		{
			//_i = _index select 0;
			_pos = [0,-1.8,-.5];
			_dir = 0;

			while {alive _dog && _dog distance _vehicle > 10 && player getVariable "CLAY_DogStatus" == "Boarding"} do
			{
				_dog doMove getPos _vehicle;
				sleep 2;
			};
			If (alive _dog && _dog distance _vehicle <= 10 && player getVariable "CLAY_DogStatus" == "Boarding") Then
			{
				_dog attachTo [_vehicle, _pos];
				_dog setDir _dir;
				_dog switchMove "Dog_Stop";
				_dog disableAI "ANIM";
				sleep 1;
				player setVariable ["CLAY_DogStatus", "InVehicle"];
				_dog setVariable ["CLAY_DogVehicle", _vehicle];
				(DOGCTRL_MENU select 1) set [6, "0"];
				(DOGCTRL_MENU select 2) set [6, "0"];
				(DOGCTRL_MENU select 3) set [6, "0"];
				(DOGCTRL_MENU select 6) set [6, "0"];
				(DOGCTRL_MENU select 7) set [6, "0"];
				(DOGCTRL_MENU select 10) set [6, "1"];
			};
		}
		Else
		{
			Hint "Invalid Vehicle Type!";
			_dog doMove getPos _dog;
			sleep 1;
			//_dog playMove "Dog_Siting";
			player setVariable ["CLAY_DogStatus", "Waiting"];
		};
	};
	case 2:
	{
		_vehicle = _dog getVariable "CLAY_DogVehicle";
		detach _dog;
		_dog setPos [(getPos _vehicle select 0) + (-5 * sin (getDir _vehicle)), (getPos _vehicle select 1) + (-5 * cos (getDir _vehicle)), 0.5];
		_dog setDir (getDir _vehicle + 180);
		_dog enableAI "ANIM";
		_dog playMove "Dog_Run";
		sleep 1;
		player setVariable ["CLAY_DogStatus", "Waiting"];
		(DOGCTRL_MENU select 1) set [6, "1"];
		(DOGCTRL_MENU select 3) set [6, "1"];
		(DOGCTRL_MENU select 6) set [6, "1"];
		(DOGCTRL_MENU select 7) set [6, "1"];
		(DOGCTRL_MENU select 10) set [6, "0"];
	};
};
