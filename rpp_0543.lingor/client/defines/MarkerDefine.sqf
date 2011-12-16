/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

/*
	TNL_gVar_arr_markers
	* Description: Array of all the markers and there names etc
	* Parameters: 
		(0) Marker name (string)
		(1) Marker text (string)
		(2) Marker type (string)
		(3) Marker color (string)
		(4) Player is required to find the marker before it is revealed (boolean)
		(5) Distance player is to marker until it is revealed (integer)
		(6) Location of the marker (position)
		(7) Text is  blanked out, use false for factorys etc (boolean)
*/
TNL_gVar_arr_markers = 
[
	["HospitalMarker", "Maruko Hospital", "Flag1", "ColorYellow", true, 50, (getMarkerPos "HospitalMarker"), true],
	["GovernorMarker", "Governors Palace", "Flag1", "ColorBlue", true, 75, (getMarkerPos "GovernorMarker"), true],
	["taximarker", "Taxi and Delivery Jobs", "Flag1", "ColorGreen", true, 25, (getMarkerPos "taximarker"), true],
	["StockExchangeMarker", "Maruko Stockexchange", "Flag1", "ColorGreen", true, 25, (getMarkerPos "StockExchangeMarker"), true],
	["StorageMarker", "Maruko Storage Area", "Flag1", "ColorGreen", true, 75, (getMarkerPos "StorageMarker"), true],
	["marukoNorthStorage", "Maruko Airport Storage", "Flag1", "ColorGreen", true, 75, (getMarkerPos "marukoNorthStorage"), true],
	["sanvigadoStorage", "Sanvigado Storage", "Flag1", "ColorGreen", true, 75, (getMarkerPos "sanvigadoStorage"), true],
	
	["Copbase_Marker", "Police Base", "Flag1", "ColorBlue", true, 100, (getMarkerPos "Copbase_Marker"), true],
	
	/* Export Ship */
	["Export_Marker", "Import/Export Ship", "Flag1", "ColorGreen", true, 25, (getMarkerPos "Export_Marker"), true],
	
	/* Gather & Workplaces */
	["mine_stone1", "Stone Mine (WP)", "Flag1", "ColorOrange", true, 50, (getMarkerPos "mine_stone1"), true],
	["mine_stone2", "Stone Mine", "Flag1", "ColorOrange", true, 50, (getMarkerPos "mine_stone2"), true],
	
	["mine_coal1", "Coal Mine (WP)", "Flag1", "ColorOrange", true, 50, (getMarkerPos "mine_coal1"), true],
	["mine_coal2", "Coal Mine", "Flag1", "ColorOrange", true, 50, (getMarkerPos "mine_coal2"), true],
	
	["mine_iron1", "Iron Mine (WP)", "Flag1", "ColorOrange", true, 50, (getMarkerPos "mine_iron1"), true],
	["mine_iron2", "Iron Mine", "Flag1", "ColorOrange", true, 50, (getMarkerPos "mine_iron2"), true],
	
	["mine_copper1", "Copper Mine (WP)", "Flag1", "ColorOrange", true, 50, (getMarkerPos "mine_copper1"), true],
	["mine_copper2", "Copper Mine", "Flag1", "ColorOrange", true, 50, (getMarkerPos "mine_copper2"), true],
	
	["gather_petrol2", "Petroleum", "Flag1", "ColorOrange", true, 50, (getMarkerPos "gather_petrol2"), true],
	["gather_petrol1", "Petroleum (WP)", "Flag1", "ColorOrange", true, 50, (getMarkerPos "gather_petrol1"), true],
	
	/* Banks */
	["CentralBankMarker", "Maruko Central Bank", "Flag1", "ColorGreen", true, 25, (getMarkerPos "CentralBankMarker"), true],	
	["manteriaBank", "Manteria Bank", "Flag1", "ColorGreen", true, 25, (getMarkerPos "manteriaBank"), true],	
	["Bank_1", "Fernando Bank", "Flag1", "ColorGreen", true, 25, (getMarkerPos "Bank_1"), true],	
	
	/* Petrol stations */
	["PetrolMarker1", "Petrol Station", "Flag1", "ColorWhite", true, 25, (getMarkerPos "PetrolMarker1"), true],
	
	/* Factories */
	["factory_1", "Maruko Factory (North)", "Flag1", "ColorOrange", true, 50, (getMarkerPos "factory_1"), true],
	["factory_2Marker", "Maruko Factory (StoneMine)", "Flag1", "ColorOrange", true, 50, (getMarkerPos "factory_2Marker"), true],
	["factory_3Marker", "Tucos Bridge Factory", "Flag1", "ColorOrange", true, 50, (getMarkerPos "factory_3Marker"), true],
	["factory_4Marker", "Tucos Factory West", "Flag1", "ColorOrange", true, 50, (getMarkerPos "factory_4Marker"), true],
	["factory_5Marker", "Tucos Factory Central", "Flag1", "ColorOrange", true, 50, (getMarkerPos "factory_5Marker"), true],
	["factory_6Marker", "Tucos Factory East", "Flag1", "ColorOrange", true, 50, (getMarkerPos "factory_6Marker"), true],
	["factory_7Marker", "San Isabel Factory East", "Flag1", "ColorOrange", true, 50, (getMarkerPos "factory_7Marker"), true],
	["factory_8Marker", "San Isabel Factory West", "Flag1", "ColorOrange", true, 50, (getMarkerPos "factory_8Marker"), true],
	["factory_9Marker", "Haciendos Factory North", "Flag1", "ColorOrange", true, 50, (getMarkerPos "factory_9Marker"), true],
	["factory_10Marker", "Maruko Factory (South)", "Flag1", "ColorOrange", true, 50, (getMarkerPos "factory_10Marker"), true],
	["factory_11Marker", "Manteria Factory", "Flag1", "ColorOrange", true, 50, (getMarkerPos "factory_11Marker"), true],
	["factory_12Marker", "Calapedro Factory", "Flag1", "ColorOrange", true, 50, (getMarkerPos "factory_12Marker"), true],
	["factory_13Marker", "Calapedro Factory West", "Flag1", "ColorOrange", true, 50, (getMarkerPos "factory_13Marker"), true],
	["factory_14Marker", "Calapedro Factory South", "Flag1", "ColorOrange", true, 50, (getMarkerPos "factory_14Marker"), true],
	["factory_15Marker", "Victorin Factory North", "Flag1", "ColorOrange", true, 50, (getMarkerPos "factory_15Marker"), true],
	["factory_16Marker", "Victorin Factory South", "Flag1", "ColorOrange", true, 50, (getMarkerPos "factory_16Marker"), true],
	["factory_17Marker", "Sanvigado Factory East", "Flag1", "ColorOrange", true, 50, (getMarkerPos "factory_17Marker"), true],
	["factory_18Marker", "Prospero Factory", "Flag1", "ColorOrange", true, 50, (getMarkerPos "factory_18Marker"), true],
	["factory_19Marker", "Marcella Factory", "Flag1", "ColorOrange", true, 50, (getMarkerPos "factory_19Marker"), true],
	["factory_20Marker", "corazon Factory West", "Flag1", "ColorOrange", true, 50, (getMarkerPos "factory_20Marker"), true],
	["factory_21Marker", "Maruko Airport Factory", "Flag1", "ColorOrange", true, 50, (getMarkerPos "factory_21Marker"), true],
	
	/* Licenses */
	["carlicenseMarker", "Vehicle Licenses", "Flag1", "ColorYellow", true, 25, (getMarkerPos "carLicenseMarker"), true],
	["weaponlicenseMarker", "Weapon Licenses", "Flag1", "ColorYellow", true, 25, (getMarkerPos "weaponlicenseMarker"), true],
	["boatlicenseMarker", "Boat Licenses", "Flag1", "ColorYellow", true, 25, (getMarkerPos "boatlicenseMarker"), true],
	["pilotlicenseMarker", "Pilot Licenses", "Flag1", "ColorYellow", true, 25, (getMarkerPos "pilotlicenseMarker"), true],
	
	/* Shops */
	//["carshop1_marker", "Bike Shop", "Flag1", "ColorBlue", true, 25, (getMarkerPos "carshop1_marker"), true],
	//["oldcarshop1_marker", "Old Car Shop", "Flag1", "ColorBlue", true, 25, (getMarkerPos "oldcarshop1_marker"), true],
	["boatbuy1_marker", "Police Boats", "Flag1", "ColorBlue", true, 25, (getMarkerPos "boatbuy1_marker"), true],
	["playerShop1_marker", "Maruko Central Store", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop1_marker"), true],
	["playerShop2_marker", "Maruko Store East", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop2_marker"), true],
	["playerShop3_marker", "Maruko Store South", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop3_marker"), true],
	["playerShop4_marker", "Tucos Store", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop4_marker"), true],
	["playerShop5_marker", "Maruko Airport Store", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop5_marker"), true],
	["playerShop6_marker", "Maruko Boat Store", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop6_marker"), true],
	["playerShop7_marker", "Manteria Store", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop7_marker"), true],
	["playerShop8_marker", "Guayucca Store", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop8_marker"), true],
	["playerShop9_marker", "Fernando Store", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop9_marker"), true],
	["playerShop10_marker", "Calixo Store", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop10_marker"), true],
	["playerShop11_marker", "Aculto Store", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop11_marker"), true],
	["playerShop12_marker", "San Isabel Store", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop12_marker"), true],
	["playerShop13_marker", "Prison Store", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop13_marker"), true],
	["playerShop14_marker", "Corazon Store", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop14_marker"), true],
	["playerShop15_marker", "Sanvigado Store", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop15_marker"), true],
	["playerShop16_marker", "Prospero Store", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop16_marker"), true],
	["playerShop17_marker", "Victorin Store North", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop17_marker"), true],
	["playerShop18_marker", "Victorin Store South", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop18_marker"), true],
	["playerShop19_marker", "Faunaverde Store", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop19_marker"), true],
	["playerShop20_marker", "Marcella Store", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop20_marker"), true],
	["playerShop21_marker", "Calapedro Store", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop21_marker"), true],
	["playerShop22_marker", "Rosalia Store", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop22_marker"), true],
	["playerShop23_marker", "Elcanto Store", "Flag1", "ColorBlue", true, 35, (getMarkerPos "playerShop23_marker"), true]
];

//Make sure to save/load this var later
if (isNil "TNL_gVar_arr_foundMarkers") then
{
	TNL_gVar_arr_foundMarkers = []; //Array of all the markers the player has found
};

//Hide all the markers
{
	_markerName = (_x select 0); //Marker name
	_needToFind = (_x select 4); //Player required to find marker
	_blankOutText = (_x select 7); //Blank out text
	
	if (_needToFind) then //If marker is required to be found then hide marker
	{
		_markerName setMarkerPosLocal [0,0,0]; //Position is hidden
		_markerName setMarkerTypeLocal "Unknown"; //Marker type is unknown (looks like a question mark on map)
		
		if (_blankOutText) then 
		{
			_markerName setMarkerTextLocal "";	//Blank out the text
		};
		_markerName setMarkerColorLocal "ColorBlack"; //Hidden color 
	}
	else //else add marker to the found array
	{
		TNL_gVar_arr_foundMarkers = TNL_gVar_arr_foundMarkers + [_markerName]; //add to found markers
	};

} foreach TNL_gVar_arr_markers; //for each marker



