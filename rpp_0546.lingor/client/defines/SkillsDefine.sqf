/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

/*
	TNL_gVar_arr_skills
	* Description: The array of all the skills and there values
	* Parameters:
		(0) Skill class (string)
		(1) Skill name (string)
		(2) Starting value for skill (integer)
		(3) Parameters:
			(0) Normal skill increase value (integer)
			(1) Optimal skill increase value (integer)
			(2) Reduced skill increase value (integer)
			(3) Failure skill increase value (integer)
*/
TNL_gVar_arr_skills = 
[
	["mining", "Mining", 0.0, [0.35, 0.8, 0.05, 0.01]],
	["fishing", "Fishing", 0.0, [0.3, 0.8, 0.05, 0.01]],
	["lockpicking", "Lockpicking", 0.0, [0.4, 0.8, 0.1, 0.05]],
	["woodcutting", "Woodcutting", 0.0, [0.3, 0.8, 0.05, 0.01]],
	["gathering", "Gathering", 0.0, [0.15, 0.4, 0.05, 0.01]],
	["forestry", "Forestry", 0.0, [0.15, 0.4, 0.05, 0.01]],
	["foraging", "Foraging", 0.0, [0.4, 0.15, 0.05, 0.01]],
	["digging", "Digging", 0.0, [0.35, 0.8, 0.05, 0.01]],
	["drugmanu", "Drug Manufacturing", 0.0, [0.275, 0.4, 0.1, 0.05]],
	["drugharvest", "Drug Harvesting", 0.0, [0.4, 0.8, 0.1, 0.05]],
	["repair", "Repairing", 0.0, [0.4, 0.8, 0.1, 0.05]]
];