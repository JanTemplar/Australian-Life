//Speed camera script by MAD T
_art = _this select 0;

if (_art == "use") then 
{
	if (!isCop) exitWith 
	{
		player groupChat "Only cops have the ability to use a speed camera";
	};
	
	if (!(createDialog "DlgSpeedCam")) exitWith {hint "Dialog Error!";};
		sliderSetRange [1, 10, 125];
		sliderSetSpeed [1, 1, 10];
		((findDisplay 1900) displayCtrl 4) buttonSetAction "[""place"", sliderPosition 1] execVM ""slr\speedcam.sqf""; closedialog 0;";
	
	while {!(isNull(findDisplay 1900))} do
	{
		((findDisplay 1900) displayCtrl 3) ctrlSetText format["%1 KM/H", (round(sliderPosition 1))];
		sleep 0.3;
	};
};

if (_art == "place") then 
{
	if (player != vehicle player) exitWith 
	{
		player groupChat "You have to be on foot";
	};
	
	player groupChat "You have placed a speed camera. If you previously had one before it has now been deactivated.";
	
	['speedCam', -1] call TNL_finv_addInventoryItem;
	speedcam_speedlimit = round(_this select 1);
	speedcam_triggered = false;
	speedcam_active = false;
	deleteVehicle speedcam_trigger;
	_pos_cam = [0,1,0];
	speedcam = "Satelit" createVehicle (player modelToWorld _pos_cam);
	
	call compile format['
	speedcam setVehicleInit "
		this setVehicleVarName ""%1"";
		speedcam = this;
		this addaction [""Take Speed Camera"", ""client\useAction.sqf"", [""speedcam_take"", speedcam]];
		";
		', format["%1_%2", player, (round(time))]];
	processInitCommands;
	
	speedcam setDir (getDir player - 180);
	speedcam setPos (player modelToWorld _pos_cam);
	_pos_trigger = [0,6,0];
	speedcam_trigger = createTrigger["EmptyDetector", player modelToWorld _pos_trigger];
	speedcam_trigger setPos (player modelToWorld _pos_trigger);
	speedcam_trigger setDir (getDir player);
	speedcam_trigger setTriggerArea[5,10,0,false];
	speedcam_trigger setTriggerActivation["ANY","PRESENT",true];
	speedcam_trigger setTriggerStatements["call {if (count thislist > 0) then {{if (speed vehicle _x > speedcam_speedlimit) then {_car = vehicle _x; _speed_car = speed vehicle _x; [""trigger"", _speed_car, _car] execVM ""slr\speedcam.sqf"";}} forEach thislist};false};", "", ""];
	speedcam_active = true;
	
	while {speedcam_active} do 
	{
		if (!(alive speedcam)) then 
		{
			deleteVehicle speedcam_trigger;
			speedcam_active = false;
		};
		sleep 1;
	};
	
	deleteVehicle speedcam_trigger;
	speedcam_active = false;
};

if (_art == "trigger") then 
{
	if (speedcam_triggered) exitWith {};
	_speed = round (_this select 1);
	_vehicle = _this select 2;
	_driver = driver (_this select 2);
	
	if ((_driver != vehicle _driver) and (side _driver != west) and ((getpos _vehicle select 2) < 2)) then
	{
		[{
			server globalChat format ["A speed camera caught %1 doing %2 KM/H in a %3 Zone", (_this select 0), (_this select 1), (_this select 2)]; 
			if (player in (_this select 3)) then 
			{
				["speeder"] execVM "slr\speedcam.sqf"
			};
		}, [(name _driver) call TNL_fplayer_formatName, _speed, speedcam_speedlimit, _vehicle]] call TNL_fnet_execPublic;
		
		speedcam_triggered = true;
		sleep 10;
		speedcam_triggered = false;
	};
};

if (_art == "speeder") then 
{
	cutText ["","WHITE IN",1];
};

if (_art == "take") then 
{
	_speedCamObj = _this select 1;
	if (isNil "speedcam_take") then 
	{
		speedcam_take = false;
	};
	
	if (!speedcam_take) then
	{
		speedcam_take = true;
		//_speedcam = nearestObject [player, "Satelit"];
		clearVehicleInit _speedCamObj;
		deleteVehicle _speedCamObj;
		deleteVehicle speedcam_trigger;
		['speedCam', 1] call TNL_finv_addInventoryItem;
		sleep 5;
		speedcam_take = false;
		speedcam_active = false;
	};
};