/*
Name: LicenseDefine.sqf
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (09/06/2009)
Description: License Defines and such
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

/*
	TNL_arr_lic_licensePurchase
	* Description: The array of all the license shops
	* Parameters:
		(0) Object action assigned to (object)
		(1) Action name (string)
		(2) Array of license classes (array)
		(3) requires the player to have the required defined types for the licenses (boolean)
*/
TNL_arr_lic_licensePurchase = 
[
	[carlicenses, localize "STRS_licenseShop_name", ["a_drivers", "b_drivers", "c_drivers", "d_drivers"], true],
	[taxijob, "Taxi Depot Licenses", ["taxi"], true],
	[weaponlicense, "Weapon Licenses", ["pistol", "smg", "rifle"], true],
	[boatlicenses, "Boat Licenses", ["fishing_license", "boat_license"], true],
	[pilotlicense, "Pilot Licenses", ["plane_private_license", "plane_comm_license"], true]
];

/*
	TNL_arr_lic_licenses
	* Description: The array of all the licenses, there names, descriptions, costs and other things
	* Parameters:
		(0) License Class (string)
		(1) Parameters:
			(0) License name (string)
			(1) License description (string)
		(2) Parameters:
			(0) Purchase cost (integer)
		(3) Array of required player types that can purchase it (array)
		(4) Script that gets executed on purchase, if value = "" then it is ignored and purchased normally (string)
*/
TNL_arr_lic_licenses =
[
	["a_drivers", [localize "STRS_license_name_adrivers", localize "STRS_license_desc_adrivers"], [250], [], ""],
	["b_drivers", [localize "STRS_license_name_bdrivers", localize "STRS_license_desc_bdrivers"], [500], [], ""],
	["c_drivers", [localize "STRS_license_name_cdrivers", localize "STRS_license_desc_cdrivers"], [800], [], ""],
	["d_drivers", [localize "STRS_license_name_ddrivers", localize "STRS_license_desc_ddrivers"], [750], [], ""],
	
	["fishing_license", ["Fishing License", "Required to buy the fishing boat and to fish"], [250], [], ""],
	["boat_license", ["Boat License", "Required to buy a boat"], [500], [], ""],
	
	["plane_private_license", ["Private Pilot License", "Required to fly small planes"], [5000], [], ""],
	["plane_comm_license", ["Commercial Pilot License", "Required to fly large planes"], [15000], [], ""],
	
	["stockbroker", ["Stock Broker License", "Required to purchase/sell stocks at the stock market"], [100], [], ""],
	["pistol", ["Pistol License", "For guns..."], [750], ["CIV"], ""],
	["smg", ["Submachine Gun License", "For SMG's."], [1000], ["CIV"], ""],
	["rifle", ["Rifle License", "For Rifles..."], [1500], ["CIV"], ""],
	["taxi", ["Taxi License", "A license so you can do taxi jobs"], [200], ["CIV"], ""]
];