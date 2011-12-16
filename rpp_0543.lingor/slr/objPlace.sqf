//Arma-RPG SLR
//-------------
//Proper object placement script (objPlace.sqf)

//Global vars:
//HAMM_obj_dir
//HAMM_obj_dist
//HAMM_obj_height
//HAMM_obj_placing

_what = _this select 3;
_item = _this select 4;

switch (_what) do
{
	case "rotateleft":
	{
		HAMM_obj_dir = HAMM_obj_dir - 10;
		
	};
	
	case "rotateright":
	{
		HAMM_obj_dir = HAMM_obj_dir + 10;
	};
	
	case "distmore":
	{
		if (HAMM_obj_dist < HAMM_obj_maxDist) then
		{
			HAMM_obj_dist = HAMM_obj_dist + 0.25;
			[format ["Distance: %1m (maximal: %2m)", HAMM_obj_dist, HAMM_obj_maxDist]] call TNL_fextHint_Hint;
		}
		else
		{
			["Cant go any further"] call TNL_fextHint_Hint;
		};
	};
	
	case "distless":
	{
		if (HAMM_obj_dist > HAMM_obj_minDist) then
		{
			HAMM_obj_dist = HAMM_obj_dist - 0.25;
			[format ["Distance: %1m (minimal: %2m)", HAMM_obj_dist, HAMM_obj_minDist]] call TNL_fextHint_Hint;
		}
		else
		{
			["Cant go any closer"] call TNL_fextHint_Hint;
		};
	};
	
	case "heightmore":
	{
		if (HAMM_obj_height < HAMM_obj_maxHeight) then
		{
			HAMM_obj_height = HAMM_obj_height + 0.10;
			[format ["Height: %1m (maximal: %2m)", HAMM_obj_height, HAMM_obj_maxHeight]] call TNL_fextHint_Hint;
		}
		else
		{
			["cant higher"] call TNL_fextHint_Hint;
		};
	};
	
	case "heightless":
	{
		if (HAMM_obj_height > HAMM_obj_minHeight) then
		{
			HAMM_obj_height = HAMM_obj_height - 0.10;
			[format ["Height: %1m (minmal: %2m)", HAMM_obj_height, HAMM_obj_minHeight]] call TNL_fextHint_Hint;
		}
		else
		{
			["cant higher"] call TNL_fextHint_Hint;
		};
	};
	case "bendonoff":
	{
		if (HAMM_obj_bend) then
		{
			HAMM_obj_bend = false;
			["Terrain bending: OFF"] call TNL_fextHint_Hint;
		}
		else
		{
			HAMM_obj_bend = true;
			["Terrain bending: ON"] call TNL_fextHint_Hint;
		};
	};
	
	case "cancel":
	{
		HAMM_obj_placing = 0;
	};
	
	case "done":
	{
		HAMM_obj_placing = 2;
	};

	default
	{
		if (HAMM_obj_placing == 1) then
		{
			["already placing"] call TNL_fextHint_Hint;
		}
		else
		{
			HAMM_obj_placing = 1;	

			["placing started"] call TNL_fextHint_Hint;

			HAMM_obj_bend = true;
			HAMM_obj_dir = (_this select 2) select 0;
			HAMM_obj_dist = (_this select 0) select 0;
			HAMM_obj_height = (_this select 1) select 0;
			
			HAMM_obj_minDist = (_this select 0) select 1;
			HAMM_obj_maxDist = (_this select 0) select 2;
			
			HAMM_obj_minHeight = (_this select 1) select 1;
			HAMM_obj_maxHeight = (_this select 1) select 2;

			private "_object";
			_obj = [_what, position player, (direction player)] call SLR_CreateObject;
			call compile format ["_object = %1", _obj];

			_rotateleft = player addAction ["[Rotate Left]", "slr\objPlace.sqf", "rotateleft"];
			_rotateright = player addAction ["[Rotate Right]", "slr\objPlace.sqf", "rotateright"];
			_distmore = player addAction ["[Further]", "slr\objPlace.sqf", "distmore"];
			_distless = player addAction ["[Closer]", "slr\objPlace.sqf", "distless"];
			_heightmore = player addAction ["[Raise]", "slr\objPlace.sqf", "heightmore"];
			_heightless = player addAction ["[Lower]", "slr\objPlace.sqf", "heightless"];
			_bendonoff = player addAction ["[Terrain bending on/off]", "slr\objPlace.sqf", "bendonoff"];
			_cancel = player addAction ["[Cancel]", "slr\objPlace.sqf", "cancel"];
			_done = player addAction ["[Done!]", "slr\objPlace.sqf", "done"];

			_dummy = "HeliHEmpty" createVehicleLocal position player;

			[_item, (-1)] call TNL_finv_addInventoryItem;

			while {true} do
			{
				if (isNull _object) exitwith
				{
					deleteVehicle _dummy;
					HAMM_obj_placing = 0;
					
					player removeAction _rotateleft;
					player removeAction _rotateright;
					player removeAction _distmore;
					player removeAction _distless;
					player removeAction _heightmore;
					player removeAction _heightless;
					player removeAction _bendonoff;
					player removeAction _cancel;
					player removeAction _done;
				};
				
				_dir = (getDir player) + HAMM_obj_dir;
				_object setDir _dir;
				_pos = player ModelToWorld [0, HAMM_obj_dist, HAMM_obj_height];
				_object setPos [_pos select 0, _pos select 1, HAMM_obj_height];

				if (!HAMM_obj_bend) then
				{
					_object setVectorUp [0,0,1];
				};
				
				if (not (alive player)) exitWith
				{
					HAMM_obj_placing = 0;			

					deleteVehicle _object;
					deleteVehicle _dummy;

					player removeAction _rotateleft;
					player removeAction _rotateright;
					player removeAction _distmore;
					player removeAction _distless;
					player removeAction _heightmore;
					player removeAction _heightless;
					player removeAction _bendonoff;
					player removeAction _cancel;
					player removeAction _done;
				};

				if ((HAMM_obj_placing == 0) || (player distance _dummy > 15)) exitWith
				{
					HAMM_obj_placing = 0;			

					deleteVehicle _object;
					deleteVehicle _dummy;
					[_item, 1] call TNL_finv_addInventoryItem;
					["placing canceled"] call TNL_fextHint_Hint;

					player removeAction _rotateleft;
					player removeAction _rotateright;
					player removeAction _distmore;
					player removeAction _distless;
					player removeAction _heightmore;
					player removeAction _heightless;
					player removeAction _bendonoff;
					player removeAction _cancel;
					player removeAction _done;
				};

				if (HAMM_obj_placing == 2) exitWith
				{
					["building, stay nearby..."] call TNL_fextHint_Hint;

					deleteVehicle _dummy;

					player removeAction _rotateleft;
					player removeAction _rotateright;
					player removeAction _distmore;
					player removeAction _distless;
					player removeAction _heightmore;
					player removeAction _heightless;
					player removeAction _bendonoff;
					player removeAction _cancel;
					player removeAction _done;

					player playMove "AinvPknlMstpSlayWrflDnon_medic";
					
					_pos = getPos player;
					_anim = 0;
					_time = ((_this select 2) select 1) * 10;
					_i = 0;
					_ok = true;
					while {_i < _time} do
					{
						if (!alive player) exitWith
						{
							_ok = false;
						};
						if (player distance _pos > 5) exitWith
						{
							[_item, 1] call TNL_finv_addInventoryItem;
							["moved away"] call TNL_fextHint_Hint;
						};
						if (_anim >= 50) then
						{
							player playMove "AinvPknlMstpSlayWrflDnon_medic";
						};
						
						_i = _i + 1;
						sleep 0.1;
					};
					
					if (_ok) then
					{
						INV_objSpawned = INV_objSpawned + [ _object ];
						[{INV_objServerSpawned = INV_objServerSpawned + [ [(_this select 0), 0] ];}, [_object]] call TNL_fnet_execPublic;		
						["built!"] call TNL_fextHint_Hint;
						sleep 3;
						_object addAction ["Take", "client\useAction.sqf", ["object", ["pack", _object]]];
						
						[{
							if ([player, "COP"] call TNL_fmission_playerIsType) then
							{
								(_this select 0) addAction ["Take", "client\useAction.sqf", ["object", ["pack", (_this select 0)]]];
							};
						}, [_object]] call TNL_fnet_execPublic;
					}
					else
					{
						deleteVehicle _object;
					};
					
					HAMM_obj_placing = 0;
				};
				sleep 0.01;
			};
		};
	};
};