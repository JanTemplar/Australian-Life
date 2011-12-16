/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/


TNL_gVar_int_Temperature = 0;
TNL_gVar_int_weatherMinChangeTime = 120; //Minimum weather time change in seconds
TNL_gVar_int_weatherRandomChangeTime = 600; //Maximum weather time until changes in seconds

/*
	TNL_gVar_arr_weatherTypes
	* Description: The different types of weathers
	* Parameters:
		(0) Weather name and class (string)
		(1) Temperature of weather (integer)
		(2) Array of other weather's that get activated at same time (array of strings)
		(3) Weather code (code)

*/

//Weather name, temperature, other weather types to activate with, weather
TNL_gVar_arr_weatherTypes = 
[ 
	["fog_1", 10, [], { 60 setFog 0.1; }],
	["fog_2", 9, [], { 60 setFog 0.2; }],
	["fog_3", 8, [], { 60 setFog 0.3; }],
	["fog_4", 7, [], { 60 setFog 0.4; }],
	["fog_5", 6, [], { 60 setFog 0.5; }],
	["fog_6", 5, [], { 60 setFog 0.6; }],
	["fog_7", 4, [], { 60 setFog 0.7; }],
	["fog_8", 3, [], { 60 setFog 0.8; }],
	["sun_0", 30, [], { 60 setOvercast 0; }],
	["sun_1", 28, [], { 60 setOvercast 0.1; }],
	["sun_2", 26, [], { 60 setOvercast 0.2; }],
	["sun_3", 24, [], { 60 setOvercast 0.3; }],
	["sun_4", 22, [], { 60 setOvercast 0.4; }],
	["sun_5", 20, [], { 60 setOvercast 0.5; }],
	["bad_1", 15, [], { 60 setOvercast 0.6; }],
	["bad_2", 12, [], { 60 setOvercast 0.7; }],
	["bad_3", 10, [], { 60 setOvercast 0.8; }],
	["bad_4", 8, [], { 60 setOvercast 0.9; }],
	["bad_5", 6, [], { 60 setOvercast 1; }]
];