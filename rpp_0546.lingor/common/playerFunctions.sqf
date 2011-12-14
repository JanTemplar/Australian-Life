/*
==============================
TNL_cfplayer_activeSlots
==============================
Return an array of all slots that are currently "in use" by a living player.
	* Parameters: <none>
		
	* Returns:
		List of active slots <bool>
		
	* Example:
		_players = [] call TNL_cfplayer_activeSlots;
*/
TNL_cfplayer_activeSlots =
{
	private ["_players", "_slot"];
	_players = [];
	{
		_slot = call compile (_x select 3);
		if (!isNull _slot) then
		{
			if (isPlayer _slot) then
			{
				_players = _players + [_slot];
			};
		};
	} forEach Gvar_arr_mission_PlayerArray;
	
	_players
};



