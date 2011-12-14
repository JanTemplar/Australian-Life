_art = ((_this select 3) select 0);

if (isNil "INV_LocalTaxiKunde") then {INV_LocalTaxiKunde = player; };
if (isNil "workplacejob_taxi_sperre") then {workplacejob_taxi_sperre = false;};
if (isNil "workplacejob_taxi_kundebeginn") then {workplacejob_taxi_kundebeginn = false;};
if (isNil "workplacejob_taxi_kundeactive" ) then {	workplacejob_taxi_kundeactive = false;	};
if (isNil "workplacejob_taxi_active") then { workplacejob_taxi_active = false;};
if (isNil "workplacejob_taxi_serverarray") then { workplacejob_taxi_serverarray = [];};

if (_art == "serverloop") then 
{
	while {true} do 
	{
		for [{_i=0}, {_i < (count workplacejob_taxi_serverarray)}, {_i=_i+1}] do 
		{
			if (isNull ((workplacejob_taxi_serverarray select _i) select 0)) then 
			{
				if (!(isNull ((workplacejob_taxi_serverarray select _i) select 1))) then 
				{
					deleteVehicle ((workplacejob_taxi_serverarray select _i) select 1);
				};
				workplacejob_taxi_serverarray set [_i,""];
				workplacejob_taxi_serverarray = workplacejob_taxi_serverarray - [""];
			};
		};
		sleep 10;
	};
};

if (_art == "getajob_taxi") then 
{
	if (workplacejob_taxi_sperre) exitWith 
	{
		[format ["Either you already agreed to the Taxi mission, or you finished it within the last %1 minutes, so you can not agree to them now",workplacejob_taxi_sperrzeit]] call TNL_fextHint_Hint;
	};
	
	if (!("taxi" call TNL_flic_playerHasLicense)) exitwith 
	{
		["No license"] call TNL_fextHint_Hint;
	};
	
	workplacejob_taxi_active = true;
	workplacejob_taxi_sperre = true;
	
	while {true} do 
	{
		_startzahl  = (floor(random(count workplacejob_taxi_zielarray)));
		_start		= (workplacejob_taxi_zielarray select _startzahl);
		_ziel		= (workplacejob_taxi_zielarray select _startzahl);
		_spielerstart	= getPos (vehicle player);
		
		while {true} do 
		{
			_zielzahl = (floor(random(count workplacejob_taxi_zielarray)));
			if (_zielzahl != _startzahl) exitWith {_ziel = (workplacejob_taxi_zielarray select _zielzahl);};
		};
		
		_taxizeit = time;
		call compile format [" ""Functionary1"" createUnit [[(_start select 0),(_start select 1),0], group empty, ""%2taxikunde = this; this setVehicleVarName """"%2taxikunde""""; this disableAI """"MOVE""""; this disableAI """"TARGET"""";""]; [%2taxikunde] join grpNull; ", ((ceil(random(19)))+1), player];
		processInitCommands;
		[{workplacejob_taxi_serverarray + [(_this select 0), (_this select 1)];}, [player, (call compile format["%1taxikunde", player])]] call TNL_fnet_execPublic;
		_markerobj = createMarkerLocal ["taxikundenmarker",[0,0]];
		_markername= "taxikundenmarker";
		_markerobj setMarkerShapeLocal "ICON";
		"taxikundenmarker" setMarkerTypeLocal "Marker";
		"taxikundenmarker" setMarkerColorLocal "ColorYellow";
		"taxikundenmarker" setMarkerTextLocal "Taxi Marker";
		_markername SetMarkerPosLocal _start;
		_action = 0;
		["A Passenger waits for you. You can see his position on the map. Drive around 20 metres near him, then he boards your vehicle automatically."] call TNL_fextHint_Hint;


		while {true} do 
		{
			sleep 1;
			INV_LocalTaxiKunde = player;
			call compile format["INV_LocalTaxiKunde = %1taxikunde", player];

			if ((player != (vehicle player)) and (((vehicle player)) distance INV_LocalTaxiKunde < 30) and ((speed ((vehicle player))) < 2) and (not(workplacejob_taxi_kundeactive))) then 
			{
				["Your passenger wanna get in your car. Stay here and wait until he boarded your vehicle."] call TNL_fextHint_Hint;

				if (((vehicle player) emptyPositions "cargo")>0) then 
				{
					[{(_this select 0) assignAsCargo (_this select 1); [(_this select 0)] orderGetIn true;}, [INV_LocalTaxiKunde, (vehicle player)] ] call TNL_fnet_execPublic;
					workplacejob_taxi_kundeactive = true;
					_warte = time;
					waitUntil {(INV_LocalTaxiKunde in vehicle player) or ((_warte+10)<time) or (INV_LocalTaxiKunde distance (vehicle player) <3)};

					if ((not(INV_LocalTaxiKunde in vehicle player)) and (player != (vehicle player))) then 
					{
						[{(_this select 0) moveInCargo (_this select 1)},[INV_LocalTaxiKunde, vehicle player]] call TNL_fnet_execPublic;
					};
					
					if (not(workplacejob_taxi_kundebeginn)) then 
					{
						["Bring him to the position marked on the map!"] call TNL_fextHint_Hint;
						workplacejob_taxi_kundebeginn = true;
						_markername setMarkerPosLocal _ziel;
						"taxikundenmarker" setMarkerTextLocal "Your passenger wants to get here";
					};
				} 
				else 
				{
					["There is no space in your vehicle!"] call TNL_fextHint_Hint;
				};
				
			};
			
			if ((player == (vehicle player)) and (workplacejob_taxi_kundeactive)) then 
			{
				[{(_this select 0) action ["getOut", (_this select 1)]; unassignVehicle (_this select 0);},[INV_LocalTaxiKunde,(vehicle player)]] call TNL_fnet_execPublic;
				workplacejob_taxi_kundeactive = false;
			};
			
			if ((not(player == (vehicle player))) and (((vehicle player)) distance _ziel < 30) and ((speed ((vehicle player))) < 2) and (workplacejob_taxi_kundeactive) and (INV_LocalTaxiKunde in ((vehicle player)))) exitWith 
			{
				_money = (( 750 max ( round((((_spielerstart distance _start)+(_start distance _ziel))*workplacejob_taxi_multiplikator)-(time-_taxizeit)) ) ) min workplacejob_taxi_maxmoney );
				
				if (_money < 0) then 
				{
					_money = 0;
				};

				TaxiMissionReward = TaxiMissionReward + _money;
				[format ["You successfully took your passenger to the target. For this job you got $%1. You get a new taxi job within a few seconds",_money]] call TNL_fextHint_Hint;

				[{(_this select 0) action ["getOut", (_this select 1)]; unassignVehicle (_this select 0);},[INV_LocalTaxiKunde,(vehicle player)]] call TNL_fnet_execPublic;
				sleep 5;
				[{(_this select 0) doMove [((_this select 1) select 0),((_this select 1) select 1),0];}, [INV_LocalTaxiKunde, _ziel]] call TNL_fnet_execPublic;
				sleep ((random 10)+5);	
			};
		
			if ((not(alive player)) or (not(alive INV_LocalTaxiKunde))) exitWith 
			{
				["You have failed the taxi job!"] call TNL_fextHint_Hint;
				sleep 10;
			};
					
			if (not(workplacejob_taxi_active)) exitWith 
			{
				["You have cancelled the job!"] call TNL_fextHint_Hint;
				sleep 10;
			};
					
			if (!workplacejob_taxi_kundebeginn) then 
			{
				_markername SetMarkerPosLocal getPos INV_LocalTaxiKunde; 
			};

			if ((player distance taxijob <= 5) and (_action == 0))  then 
			{
				workplace_gettaxicancelaction = player addAction ["Cancel job", "slr\taxiJob.sqf", ["canceljob_taxi"]]; 
				_action = 1;
			};
					
			if (((player distance taxijob > 5) and (_action == 1))) then 
			{
				player removeAction workplace_gettaxicancelaction; 
				_action = 0;
			};
		};
				
		deleteVehicle INV_LocalTaxiKunde;
		deleteMarkerLocal _markername;
		workplacejob_taxi_kundeactive = false;
		workplacejob_taxi_kundebeginn = false;
		if (isNull(INV_LocalTaxiKunde)) exitWith {};
		if ((not(alive player)) or (not(alive INV_LocalTaxiKunde)) or (not(workplacejob_taxi_active))) exitWith {};
	};
			
	player removeAction workplace_gettaxicancelaction;
	sleep ((workplacejob_taxi_sperrzeit)*60);
	workplacejob_taxi_active = false;
	workplacejob_taxi_sperre = false;
};
		
if (_art == "canceljob_taxi") then 
{
	player removeAction workplace_gettaxicancelaction;
	workplacejob_taxi_active = false;
};
