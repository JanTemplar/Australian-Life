TNL_fpShops_placeShop = 
{
	private ["_itemClass"];
	_itemClass = (_this select 0);
	
	if !((player) call TNL_fplayer_inVehicle) then
	{
		{
			_shopClass = (_x select 0);
			_objClass = (_x select 1);
			_needsToBeInArea = (_x select 2);
			_areas = (_x select 3);
			_distanceToOtherObj = (_x select 4);
			_msg = (_x select 5);
			_actionMessage = (_x select 6);
			
			
			if (_shopClass == _itemClass) then
			{
				_obj = nearestObject [player, "STATIC"];
				_canPlace = false;
				
				if (_needsToBeInArea) then
				{
					{
						if (player distance (getMarkerPos (_x select 0)) <= (_x select 1)) then
						{
							_canPlace = true;
						};
					} forEach _areas;
				}
				else
				{
					_canPlace = true;
				};
				
				if (_canPlace) then
				{
					if (player distance (_obj) >= _distanceToOtherObj) then
					{
						_varName = format["PLAYER_SHOP_%1_%2_%3_%4", (round(position player select 0)), (round(position player select 1)), (round(position player select 2)), time];
						_object = _objClass createVehicle position player;			
						_object setPos [position player select 0, position player select 1, position player select 2];
						_object setDir getDir player;
						call compile format['_object setVehicleInit "this setVehicleVarName ""%1""; _object = this; this addAction [""%2"", ""client\useAction.sqf"", [""playerShop"", ""openShop"", this]];";', _varName, _actionMessage];
						processInitCommands;	
						
						
						_shops = playerShops getVariable "playerShops";
						_shops = _shops + [ [_object, _actionMessage, TNL_db_charName, "", false] ];
						playerShops setVariable ["playerShops", _shops, true];
						
						[format["%1", _msg]] call TNL_fextHint_Hint;
					}
					else
					{
						["You are too close to another object"] call TNL_fextHint_Hint;
					};
				}
				else
				{
					["You cannot place this here"] call TNL_fextHint_Hint;
				};
			};
	
		} forEach TNL_gVar_arr_pShops_placeableShops;
	}
	else
	{
		["You cannot place this while you are in a vehicle"] call TNL_fextHint_Hint;
	};

};

