TNL_gVar_str_tables_serverVars = "testing_serverVars1";
TNL_gVar_str_tables_licenses = "testing_licenses1";
TNL_gVar_str_tables_trunk_storages = "testing_trunk_storages1";
TNL_gVar_str_tables_trunk_localStorages = "testing_local_trunk_storages1";
TNL_gVar_str_tables_factories_settings = "testing_factories_settings1";
TNL_gVar_str_tables_skills = "testing_skills1";
TNL_gVar_str_tables_bankAccountRef = "testing_bank_ref1";
TNL_gVar_str_tables_bankAccounts = "testing_bank_accounts1";
TNL_gVar_str_tables_markers = "testing_markers1";
TNL_gVar_str_tables_corporations = "testing_corporations1";
TNL_gVar_str_tables_stockmarket = "testing_stockmarket1";
TNL_gVar_str_tables_wallet = "testing_wallet1";
TNL_gVar_str_tables_workplaces = "testing_workplaces1";
TNL_gVar_str_tables_shops = "testing_shops1";
TNL_gVar_str_tables_users = "testing_users1";
TNL_gVar_str_tables_employees = "testing_employees1";

TNL_gVar_arr_tables_serverLoadAll = 
[ 
	TNL_gVar_str_tables_licenses, 
	TNL_gVar_str_tables_trunk_storages,
	TNL_gVar_str_tables_factories_settings,
	TNL_gVar_str_tables_serverVars,
	TNL_gVar_str_tables_skills,
	TNL_gVar_str_tables_bankAccountRef,
	TNL_gVar_str_tables_bankAccounts,
	TNL_gVar_str_tables_markers,
	TNL_gVar_str_tables_trunk_localStorages,
	TNL_gVar_str_tables_corporations,
	TNL_gVar_str_tables_stockmarket,
	TNL_gVar_str_tables_workplaces,
	TNL_gVar_str_tables_shops,
	TNL_gVar_str_tables_wallet,
	TNL_gVar_str_tables_users,
	TNL_gVar_str_tables_employees
];

TNL_gVar_arr_tables_clientLoad = 
[ 
	[TNL_gVar_str_tables_licenses, "Gvar_arr_lic_playerLicenses"],
	[TNL_gVar_str_tables_skills, "TNL_gVar_arr_skills"],
	[TNL_gVar_str_tables_markers, "TNL_gVar_arr_foundMarkers"],
	[TNL_gVar_str_tables_wallet, "TNL_wallet_walletArray"]
];

TNL_gVar_arr_tables_workplacesLoad =
[
	[TNL_gVar_str_tables_workplaces, "price"]
];

TNL_gVar_arr_tables_shopsLoad =
[
	[TNL_gVar_str_tables_shops, "stock"],
	[TNL_gVar_str_tables_shops, "name"]
];

TNL_gVar_arr_tables_storagesLoad = 
[ 
	[TNL_gVar_str_tables_trunk_storages, "storage"],
	[TNL_gVar_str_tables_trunk_storages, "weight"]
];

TNL_gVar_arr_tables_corporationsLoad = 
[
	[TNL_gVar_str_tables_corporations, "corporations"],
	[TNL_gVar_str_tables_corporations, "firms"]
];

TNL_gVar_arr_tables_stockMarketLoad = 
[
	[TNL_gVar_str_tables_stockmarket, "stockmarket"]
];

TNL_gVar_arr_tables_localStoragesLoad =
[
	[TNL_gVar_str_tables_trunk_localStorages, "storage"],
	[TNL_gVar_str_tables_trunk_localStorages, "weight"]
];

TNL_gVar_arr_tables_factoriesLoad =
[
	[TNL_gVar_str_tables_factories_settings, "factory_settings"]
];

TNL_gVar_arr_tables_serverLoad =
[
	[TNL_gVar_str_tables_serverVars, "TNL_db_userArray"]
];

TNL_gVar_arr_tables_usersLoad =
[
	[TNL_gVar_str_tables_users, "TNL_db_charList"]
];

TNL_gVar_arr_tables_bankReferencesLoad = 
[
	[TNL_gVar_str_tables_bankAccountRef, "TNL_bank_accounts"]
];

TNL_gVar_arr_tables_employeesLoad =
[
	[TNL_gVar_str_tables_employees, "employees"]
];

