//Types who can use, name, action to take, who you can use on
Gvar_arr_mission_playerInteractionActions = 
[	
	[["COP", "CIV"], ["Trade", "trade"], "[(_data select 0)] call TNL_ftrade_openDialog;", ["CIV", "COP"]],
	[["COP"], ["Arrest Civilian", "arrest"], "[""createDlg"", str (_data select 0)] execVM ""slr\arrest.sqf"";", ["CIV"]],
	[["COP"], ["Issue Ticket", "ticket"], "[""createDlg"", (_data select 0)] execVM ""slr\ticket.sqf"";", ["CIV"]],
	[["COP", "CIV"], ["Search Player", "search"], "[""searchCheck"", (_data select 0)] execVM ""slr\searchplayer.sqf""; closeDialog 0;", ["CIV", "COP"]],
	[["COP"], ["Disarm", "disarm"], "[(_data select 0)] execVM ""slr\disarm.sqf"";", ["CIV"]]
];