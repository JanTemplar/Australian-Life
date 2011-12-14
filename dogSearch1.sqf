
_dog = player getVariable "CLAY_DogUnit";
player setVariable ["CLAY_DogStatus", "Searching"];
(DOGCTRL_MENU select 7) set [7, "0"];

		_startPos = getPos _dog;
		_dist = 80;
		while {alive _dog && player getVariable "CLAY_DogStatus" == "Searching"} do
		{
			//_eodObjs = nearestObjects [_dog, CLAY_DogEODs, _dist];
			_eodObjs = [];
			{
				_o = _dog nearObjects [_x, _dist];
				_eodObjs = _eodObjs + _o;
			} forEach CLAY_DogEODs;

			If (count _eodObjs > 0) Then
			{
				_obj = _eodObjs select 0;
				while {alive _dog && _dog distance _obj > 5 && player getVariable "CLAY_DogStatus" == "Searching"} do
				{
					_dog doMove getPos _obj;
					sleep 2;
				};
				player setVariable ["CLAY_DogStatus", "Waiting"];
				
				_dog doMove getPos _obj;
				hint "Suspicious Item Found";
			}
			Else
			{
				_pos = [(_startPos select 0) + (_dist - (random (2 * _dist))), (_startPos select 1) + (_dist - (random (2 * _dist))), 0];
				while {alive _dog && _dog distance _pos > 10 && player getVariable "CLAY_DogStatus" == "Searching"} do
				{
					_dog doMove _pos;
					sleep 2;
				};
			};
			sleep 1;
		};
(DOGCTRL_MENU select 7) set [6, "1"];
