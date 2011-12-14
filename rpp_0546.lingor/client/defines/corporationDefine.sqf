/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

TNL_gVar_int_corporationRegisterCost = 3000; //Temp value 
TNL_gvar_int_corporationStartingStocks = 2000;
TNL_gVar_int_corporationNewCorpStocksOwned = 500;
TNL_gVar_arr_corporationActions = 
[
	["Corporations Reports", "summary"],
	["Firms", "firms"],
	["Stock market", "stockmarket"],
	["Corporate Bank Account", "corpbank"],
	["Purchases and Offers", "purchases"],
	["Employee Management", "employee"]
];


governor setVariable ["corporationRegisterCost", TNL_gVar_int_corporationRegisterCost, true];