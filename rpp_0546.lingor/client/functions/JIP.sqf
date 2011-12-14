/*
==============================
TNL_fjip_updateFaces
==============================
Assigns correct faces to all clients who have connected before the player, broadcasts player's new face
	* Parameter: <none>
	
	* Returns: <nothing>
	
	* Example:
		[] call TNL_fjip_updateFaces;
	
	* Note:
		Must be SPAWNED!
*/
TNL_fjip_updateFaces =
{
	diag_log text "TNL>>>calling TNL_fjip_updateFaces";
	private ["_id", "_face"];
	
	//Assign users' respective faces:
	{
		diag_log text format ["TNL>>>retrieving face for %1", _x];
		//Retrieve each user's char ID:
		TNL_net_returned = "";
		[
			compile format ['
			if (player == %1) then
			{ 
				[%2, TNL_db_charListID] call TNL_fnet_returnToClient;
				diag_log text "TNL>>>%1 requested your TNL_db_charListID";
			};
			', _x, player]
		] spawn TNL_fnet_execPublic;
		waitUntil {TNL_net_returned != ""};
		_id = parseNumber TNL_net_returned;
		diag_log text format ["TNL>>>received ID from %1 - %2", _x, _id];
		

		_data = _id call TNL_fdb_getCharData; //Look up for user's face in his char array
		
		if (count _data != 0) then
		{		
			_face = _data select 0;
			_x setFace _face; //Assign the user's face
		};
	} forEach ( ([] call TNL_cfplayer_activeSlots) - [player] );
};
	