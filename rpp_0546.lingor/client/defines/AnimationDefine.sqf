/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

_suicide = 
{
	if (HandWeapon) then
	{
		player action ["handGunOn", player];
	
		player say3D "SndSuicide";
	
		sleep 4.8;
		cutText ["","BLACK OUT",0.5];
		server action["useWeapon", vehicle player, player, 0];
		sleep 0.5;
		cutText ["","BLACK IN",0.4];
		player setDamage 1;
	}
	else
	{
		
	};
};

/*
	TNL_gVar_arr_animations
	*Description: Array of the animations
	* Parameters: 
		(0) Name (string)
		(1) Action (string)
		(2) Animation (string)
*/
TNL_gVar_arr_animations = 
[
	["Handsup", "switchMove", "AmovPercMstpSnonWnonDnon_AmovPercMstpSsurWnonDnon", {}],
	["Normal (Play)", "playMoveNow", "AmovPercMstpSnonWnonDnon", {}],
	["Normal (Switch)", "SwitchMove", "AmovPercMstpSnonWnonDnon", {}],
	["Jump", "switchMove", "AovrPercMstpSnonWnonDf", {}],
	["Idle (Rifle)", "switchMove", "CtsDoktor_Vojak_hulakani1", {}],
	["Cheer", "switchMove", "c7a_bravoTOerc_idle", {}],
	["Cheer 2", "switchMove", "c7a_bravoTOerc_idle8", {}],
	["Clap hands up", "switchMove", "c7a_bravoTOerc_idle24", {}],
	["Exercise (Press-ups)", "switchMove", "AmovPercMstpSnonWnonDnon_idle71kliky", {}],
	["Exercise (Press-ups 2)", "switchMove", "AmovPercMstpSnonWnonDnon_idle56kliky", {}],
	["Exercise (Situps)", "switchMove", "AmovPercMstpSnonWnonDnon_idle72lehSedy", {}],
	["Exercise (Handstands)", "switchMove", "AmovPercMstpSnonWnonDnon_idle70chozeniPoRukou", {}],
	["Exercise (KneeBend)", "switchMove", "AmovPercMstpSnonWnonDnon_idle69drepy", {}],
	["Exercise (Boxing)", "switchMove", "AmovPercMstpSnonWnonDnon_idle68boxing", {}],
	["Exercise (Karate)", "switchMove", "AmovPercMstpSnonWnonDnon_exerciseKata", {}],
	["Suicide", "switchMove", "ActsPercMstpSnonWpstDnon_suicide1B", _suicide],
	["Talking 1", "switchMove", "ActsPercMstpSnonWnonDnon_talking01a", {}],
	["Talking 2", "switchMove", "ActsPercMstpSnonWnonDnon_talking02", {}],
	["Talking 3", "switchMove", "ActsPercMstpSnonWnonDnon_talking03", {}],
	["Talking 4", "switchMove", "ActsPercMstpSnonWnonDnon_talking04", {}],
	["Assemble", "switchMove", "ActsPercSnonWnonDnon_assembling", {}],
	["Fix Car", "switchMove", "ActsPercSnonWnonDnon_carFixing", {}],
	["Fix Car 2", "switchMove", "ActsPercSnonWnonDnon_carFixing2", {}],
	["Dance (1)", "playMoveNow", "ActsPercMstpSnonWnonDnon_DancingDuoIvan", {}],
	["Dance (2)", "playMoveNow", "ActsPercMstpSnonWnonDnon_DancingDuoStefan", {}],
	["Dance (3)", "playMoveNow", "ActsPercMstpSnonWnonDnon_DancingStefan", {}],
	["Stand with hands out", "switchMove", "TowingTractorSupport", {}],
	["Navigate Driver", "switchMove", "NavigationDriverReverse", {}],
	["Navigate Heli", "SwitchMove", "NavigationHeli", {}],
	["Repair Kneel", "switchMove", "RepairingKneel", {}],
	["Wash car", "switchMove", "RepairingErc", {}],
	["Hit with rifle", "playMove", "AmelPercMstpSlowWrflDnon_StrokeGun", {}],
	["Right Punch", "switchMove", "AmelPercMstpSnonWnonDnon_amaterUder1", {}],
	["Left Punch", "switchMove", "AmelPercMstpSnonWnonDnon_amaterUder2", {}],
	["Straight Punch", "switchMove", "AmelPercMstpSnonWnonDnon_amaterUder3", {}]
];