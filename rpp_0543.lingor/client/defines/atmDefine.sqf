TNL_gvar_arr_bankatms =
[
	[atm1, "Hospital ATM"],
	[atm2, "ATM"],
	[fuel2, "ATM"],
	[atm3, "ATM"],
	[atm4, "ATM"],
	[atm5, "ATM"],
	[atm6, "ATM"]
];

{
	(_x select 0) addAction ["ATM", "client\useAction.sqf", ["atm", (_x select 1)]];
} forEach TNL_gvar_arr_bankatms;