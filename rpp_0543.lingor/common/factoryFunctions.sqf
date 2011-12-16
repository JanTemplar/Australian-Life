/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

TNL_ffact_getSetting =
{
	private ["_object", "_setting", "_var", "_return"];
	_object = _this select 0;
	_setting = _this select 1;
	_var = _object getVariable "factory_settings";
	_return = -1;
	
	{
		if ((_x select 0) == _setting) then
		{
			_return = (_x);
		};
	} forEach _var;

	_return
};

TNL_ffact_setSetting = 
{
	private ["_object", "_setting", "_var", "_index", "_factorySettings"];
	_object = (_this select 0);
	_setting = (_this select 1);
	_var = (_this select 2);
	_index = (_this select 3);
	_factorySettings = _object getVariable "factory_settings";
	
	{
		if ((_x select 0) == _setting) then
		{
			(_x) set[_index, _var];
		};
	} forEach _factorySettings;
	
	_object setVariable ["factory_settings", _factorySettings, true];
	[TNL_gVar_str_tables_factories_settings, [_object], [ [_factorySettings, "factory_settings"] ] ] call TNL_fsav_clientRequestSave;
};

TNL_ffact_addSetting =
{
	private ["_object", "_setting", "_var", "_factorySettings"];
	_object = (_this select 0);
	_setting = (_this select 1);
	_var = (_this select 2);
	_factorySettings = _object getVariable "factory_settings";
	
	_factorySettings = _factorySettings + [ [_setting, _var] ];
	
	_object setVariable ["factory_settings", _factorySettings, true];
	[TNL_gVar_str_tables_factories_settings, [_object], [ [_factorySettings, "factory_settings"] ] ] call TNL_fsav_clientRequestSave;
};

TNL_ffact_settingExists = 
{
	private ["_object", "_setting", "_facSettings", "_return"];
	_object = (_this select 0);
	_setting = (_this select 1);
	_facSettings = _object getVariable "factory_settings";
	_return = false;
	
	{
		if ((_x select 0) == _setting) then
		{
			_return = true;
		};
	
	} forEach _facSettings;

	_return
};

TNL_ffact_isOwner = 
{
	private ["_object", "_firstName", "_lastName", "_return"];
	_object = (_this select 0);
	_firstName = ((_this select 1) select 0);
	_lastName = ((_this select 1) select 1);
	_return = false;
	
	{
		_factory = (_x select 0);
		_factOwnerFName = ((_x select 2) select 0);
		_factOwnerSName = ((_x select 2) select 1);
		if ((_factory == _object) && (_factOwnerFName == _firstName) && (_factOwnerSName == _lastName)) then
		{
			_return = true;
		};
	} forEach (corporations getVariable "firms");
	
	if (TNL_debug) then { _return = true; };
	
	_return
};


TNL_ffact_openDialog = 
{
	private ["_type", "_object"];
	_type = (_this select 0);
	_object = (_this select 1);
	
	TNL_gVar_obj_curSelFactory = _object;
	
	switch (_type) do
	{
		case "openRepair":
		{
			[_object, _type] spawn TNL_ffact_openFactoryMenu;
		};
		
		case "openComplete":
		{
			[_object, _type] spawn TNL_ffact_openFactoryMenu;
		};
		
		case "select":
		{
			[_object] spawn TNL_ffact_selectFactory;
		};
	};
};

TNL_ffact_selectFactory =
{	
	private ["_object", "_type", "_dialogOpen"];
	_object = (_this select 0);
	_type = (_this select 1);
	

	_dialogOpen = createDialog "TNL_dlg_genNotify";
	((findDisplay 1102) displayCtrl 1) ctrlSetStructuredText parseText "Factory notice";
	((findDisplay 1102) displayCtrl 2) ctrlSetStructuredText parseText "You will shortly be prompted to select the factory type, please choose carefully though because it will be alot harder to change to a different factory type in the future!";
	buttonSetAction [10, 'closeDialog 0;'];
		
	waitUntil {!ctrlVisible 10};
	
	if (!createDialog "DlgFactorySelect") then
	{
		["ERROR in factoryFunctions.sqf, function: TNL_ffact_selectFactory, failed to open dialog DlgFactorySelect!"] call TNL_fextHint_Hint;
	};
	
	_object spawn TNL_ffact_loadSelectFactory;
};

TNL_ffact_loadSelectFactory =
{
	private ["_object"];
	_object = (_this);
	
	lbClear 1;
	lbClear 2;
	
	{
		_class = (_x select 0);
		_type = ((_x select 1) select 0);
		_description = ((_x select 1) select 1);
		
		_index = lbAdd[1, format["%1", _type]];
				lbSetData[1, _index, format["%1", _class]];
	
	} forEach TNL_gVar_arr_fact_types;
	
	lbSetCurSel[1,0];
};

TNL_ffact_TypesListChange =
{
	private ["_class"];
	_class = (_this select 0);
	
	lbClear 2;
	
	{
		_factoryClass = (_x select 0);
		_factoryName = ((_x select 1) select 0);
		_factoryDesc = ((_x select 1) select 1);
		_requiredMaterials = (_x select 2);
		
		if (_factoryClass == _class) then
		{
			((findDisplay 1201) displayCtrl 3) ctrlSetStructuredText parseText _factoryName;
			((findDisplay 1201) displayCtrl 4) ctrlSetStructuredText parseText _factoryDesc;
			
			{
				_itemClass = (_x select 0);
				_itemName = (_itemClass) call TNL_finv_getItemName;
				_amountReq = (_x select 1);
				
				_index = lbAdd[2, format["%1, %2x", _itemName, _amountReq]];
					lbSetData[2, _index, format["%1", _itemClass]];
			
				
			} forEach _requiredMaterials;
			
			lbSetCurSel[2,0];
		};
	
	} forEach TNL_gVar_arr_fact_types;
	
	buttonSetAction[7, format["[""%1""] spawn TNL_ffact_changeFactoryType; closeDialog 0;", _class]];
};

TNL_ffact_ReqMaterialsListChange = 
{
	private ["_itemClass", "_itemName", "_itemDesc"];
	_itemClass = (_this select 0);
	_itemName = (_itemClass) call TNL_finv_getItemName;
	_itemDesc = (_itemClass) call TNL_finv_getItemDescription;
	
	((findDisplay 1201) displayCtrl 5) ctrlSetStructuredText parseText _itemName;
	((findDisplay 1201) displayCtrl 6) ctrlSetStructuredText parseText _itemDesc;
};

TNL_ffact_changeFactoryType = 
{
	private ["_type", "_object", "_itemsCanMake", "_dialogOpen"];
	_type = (_this select 0);
	_object = TNL_gVar_obj_curSelFactory;
	_itemsCanMake = (_type) call TNL_ffact_getFactoryItemsCanMake;
	[_object, "selectedType", true, 1] call TNL_ffact_setSetting;
	[_object, "repaired", false, 1] call TNL_ffact_setSetting;
	[_object, "factoryType", _type, 1] call TNL_ffact_setSetting;
	[_object, "permissionsPublicStorage", [false,true,false, []], 1] call TNL_ffact_setSetting;
	[_object, "factoryMaterialsRepair", [], 1] call TNL_ffact_setSetting;
	[_object, "itemsCanMake", _itemsCanMake, 1] call TNL_ffact_setSetting;

	TNL_gVar_boolean_removeFactSelectAction = true;
	publicVariable "TNL_gVar_boolean_removeFactSelectAction";
	
	_dialogOpen = createDialog "TNL_dlg_genNotify";
	((findDisplay 1102) displayCtrl 1) ctrlSetStructuredText parseText "Factory notice";
	((findDisplay 1102) displayCtrl 2) ctrlSetStructuredText parseText "You have selected the type of factory you want, after closing this dialog the repair menu will open.";
	buttonSetAction [10, 'closeDialog 0;'];
		
	waitUntil {!ctrlVisible 10};
	
	[_object, "openRepair"] spawn TNL_ffact_openFactoryMenu;
};

TNL_ffact_openFactoryMenu = 
{
	private ["_object", "_type"];
	_object = (_this select 0);
	_type = (_this select 1);
	
	if (!createDialog "DlgFactoryMenu") then
	{
		hint "ERROR: factoryFunctions.sqf failed to open dialog DlgFactoryMenu";
	};
	
	[_object, _type] call TNL_ffact_factoryMenuLoad;
};

TNL_ffact_factoryMenuLoad = 
{
	private ["_object", "_type"];
	_object = (_this select 0);
	_type = (_this select 1);
	_corp = (_object) call TNL_fcorp_getFirmOwner;
	_accessRights = ([_corp, TNL_db_charName] call RPP_fnc_employee_getAccessLevel);

	{
		_text = (_x select 0);
		_data = (_x select 1);
		_typeItShows = (_x select 2);
		_whoCanSee = (_x select 3);
		_show = true;
		
		if (_whoCanSee == "owner") then
		{
			if !([_object, [TNL_db_charName select 0, TNL_db_charName select 1]] call TNL_ffact_isOwner) then
			{
				_show = false;
			};
			
			if (_accessRights >= 1) then
			{
				_show = true;
			};
		};
	
		
		if (_whoCanSee == "none-owner") then
		{
			if ([_object, [TNL_db_charName select 0, TNL_db_charName select 1]] call TNL_ffact_isOwner) then
			{
				_show = false;
			};
		};
		
		if ((_typeItShows != _type) && (_typeItShows != "")) then
		{
			_show = false;
		};
		
		if (_show) then
		{
			_index = lbAdd[1, format["%1", _text]];
			lbSetData[1, _index, format["%1", _data]];
		};

	} forEach TNL_gVar_arr_fact_actions;
};

TNL_ffact_factoryMenuSelect = 
{
	private ["_data", "_factoryLocked"];
	_data = (_this select 0);
	_factoryLocked = (([TNL_gVar_obj_curSelFactory, "factoryLocked"] call TNL_ffact_getSetting) select 1);
	
	if (([TNL_gVar_obj_curSelFactory, [TNL_db_charName select 0, TNL_db_charName select 1]] call TNL_ffact_isOwner) || !(_factoryLocked)) then
	{
		switch (_data) do
		{
			case "repair":
			{
				[TNL_gVar_obj_curSelFactory] call TNL_ffact_repairFactoryDlg;
			};
		
			case "localstorage":
			{	
				[TNL_gVar_obj_curSelFactory, "local"] call TNL_ffact_openStorage;
			};
		
			case "publicstorage":
			{
				[TNL_gVar_obj_curSelFactory, "public"] call TNL_ffact_openStorage;
			};
		
			case "managefactory":
			{
				[TNL_gVar_obj_curSelFactory] call TNL_ffact_openManageFactory;
			};
			
			case "manufacture":
			{
				[TNL_gVar_obj_curSelFactory] call TNL_ffact_openManufactureDialog;
			};
		};
	}
	else
	{
		["The factory is locked to the public"] call TNL_fextHint_Hint;
	};
};

TNL_ffact_openStorage = 
{
	private ["_object", "_type", "_storage", "_canUse", "_permissions", "_requiredToBeOnList", "_locked", "_allowedList"];
	_object = (_this select 0);
	_type = (_this select 1);
	_storage = "";
	_canUse = false;
	_permissions = (([_object, "permissionsPublicStorage"] call TNL_ffact_getSetting) select 1);
	//_GlobalcanUse = (_permissions select 0);
	_requiredToBeOnList = (_permissions select 1);
	_locked = (_permissions select 2);
	_allowedList = (_permissions select 3);
	
	
	if (_type == "local") then
	{
		_storage = [_object, "local"] call TNL_ffact_getFactoryStorage;
	}
	else
	{
		_storage = [_object, "public"] call TNL_ffact_getFactoryStorage;
	};
	
	if (_requiredToBeOnList) then
	{
		{
			_firstName = (_x select 0);
			_lastName = (_x select 1);
			_yourFirstName = (TNL_db_charName select 0);
			_yourLastName = (TNL_db_charName select 1);
			
			if ((_firstName == _yourFirstName) && (_lastName == _yourLastName)) then
			{
				_canUse = true;
			};
		
		} forEach _allowedList;
	};
	
	
	if !(_requiredToBeOnList) then
	{
		if !(_locked) then
		{
			_canUse = true;
		};
	};
	
	if (_locked) then
	{
		_canUse = false;
	};
	

	if ([_object, [TNL_db_charName select 0, TNL_db_charName select 1]] call TNL_ffact_isOwner) then
	{
		_canUse = true;
	};
	
	if (_type == "local") then
	{
		_canUse = true;
	};
	
	if (_canUse) then
	{
		[_storage] call TNL_ftrunk_openTrunk;
	}
	else
	{
		["You are not allowed to use the factory storage"] call TNL_fextHint_Hint;
	};
};

TNL_ffact_repairHasEnoughMaterials = 
{
	private ["_requiredMats", "_storageMats", "_return"];
	_requiredMats = (_this select 0);
	_storageMats = (_this select 1);
	_return = true;

	{
		_reqClass = (_x select 0);
		_reqAmount = (_x select 1);
		_storageItemAmount = 0;
		
		{
			_storageItemClass = (_x select 0);
		
			if (_storageItemClass == _reqClass) then
			{
				_storageItemAmount = (_x select 1);
			};
			
		} forEach _storageMats;
	
		if (_reqAmount > _storageItemAmount) then
		{
			_return = false;
		};
	
	} forEach _requiredMats;
	
	_return
};


TNL_ffact_repairFactoryDlg = 
{
	private ["_object"];
	_object = (_this select 0);

	if (!createDialog "DlgFactoryRepair") then { hint "ERROR: factoryFunctions.sqf failed to open dialog DlgFactoryRepair"; };
	
	[_object] call TNL_ffact_repairFactoryLoad;
};

TNL_ffact_repairFactoryLoad =
{
	private ["_object", "_storage", "_factoryType", "_requiredMats", "_matsComplete", "_permissions", "_GlobalcanUse", "_requiredToBeOnList", "_locked", "_allowedList"];
	_object = (_this select 0);
	_storage = (([_object,"public"] call TNL_ffact_getFactoryStorage) getVariable "storage");
	_factoryType = (([_object, "factoryType"] call TNL_ffact_getSetting) select 1);
	_requiredMats = (_factoryType) call TNL_ffact_getFactoryRequiredMaterials;
	//_matsComplete = (([_object, "factoryMaterialsRepair"] call TNL_ffact_getSetting) select 1);
	
	_permissions = (([_object, "permissionsPublicStorage"] call TNL_ffact_getSetting) select 1);
	//_GlobalcanUse = (_permissions select 0);
	_requiredToBeOnList = (_permissions select 1);
	_locked = (_permissions select 2);
	_allowedList = (_permissions select 3);
	_hasRequiredMats = [_requiredMats, _storage] call TNL_ffact_repairHasEnoughMaterials;
	_factoryTypeName = "";
	TNL_gVar_obj_curSelFactory = _object;
	
	lbClear 2;
	lbClear 1;
	lbClear 9;
	lbClear 10;
	
	{
		if ((_x select 0) == _factoryType) then
		{
			_factoryTypeName = ((_x select 1) select 0);
		};
	
	} forEach TNL_gVar_arr_fact_types;
	
	((findDisplay 1203) displayCtrl 11) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Factory type:</t> %1", _factoryTypeName];
	((findDisplay 1203) displayCtrl 12) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Enough materials to repair:</t> %1", _hasRequiredMats];
	//((findDisplay 1203) displayCtrl 13) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Everyone can use:</t> %1", _globalCanUse];
	((findDisplay 1203) displayCtrl 14) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Users required to be on list:</t> %1", _requiredToBeOnList];
	((findDisplay 1203) displayCtrl 13) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Factory storage locked:</t> %1", _locked];
	
	
	{
		_class = (_x select 0);
		_amount = (_x select 1);
		//_matAmount = (_x select 1);
		_itemName = (_class) call TNL_finv_getItemName;
		_weight = (_class) call TNL_finv_getItemWeight;
		_totalWeight = ((_amount) * (_weight));
		
		/*
		{
			if ((_x select 0) == _class) then
			{
				_matAmount = _matAmount - (_x select 1);
			};
		} forEach _matsComplete;
		*/
		
		_index = lbAdd[2, format["%1, %2x, (%3/%4kg) Required", _itemName, _amount, _weight, _totalWeight]];
	
	} forEach _requiredMats;
	
	{
		_class = (_x select 0);
		_amount = (_x select 1);
		_itemName = (_class) call TNL_finv_getItemName;
		
		if (_amount > 0) then
		{
			_index = lbAdd[1, format["%1, %2x", _itemName, _amount]];
		};
	
	
	} forEach _storage;
	
	
	{
		if (((_x select 0) != "") && ((_x select 1) != "")) then
		{
			_index = lbAdd[9, format["%1 %2", (_x select 0), (_x select 1)]];
			lbSetData[9, _index, format['["%1","%2"]', (_x select 0), (_x select 1)]];
		};
	} forEach _allowedList;
	
	{
		_index = lbAdd[10, format["%1", (_x select 0)]];
		lbSetData[10, _index, format["%1", (_x select 1)]];
	
	} forEach TNL_gVar_arr_fact_repairUserActions;
	
	if ((lbCurSel 10) <= 0) then { lbSetCurSel[9,0];};
	
	lbSetCurSel[9,0];
	
	TNL_gVar_obj_curSelFactory = _object;
};

TNL_ffact_repairFactory =
{
	private ["_object", "_storage", "_requiredMats", "_hasRequiredMats", "_factoryType", "_storageName"];
	_object = (_this select 0);
	_storage = (([_object,"public"] call TNL_ffact_getFactoryStorage) getVariable "storage");
	_storageName = ([_object,"public"] call TNL_ffact_getFactoryStorage);
	_factoryType = (([_object, "factoryType"] call TNL_ffact_getSetting) select 1);
	_requiredMats = (_factoryType) call TNL_ffact_getFactoryRequiredMaterials;
	_hasRequiredMats = [_requiredMats, _storage] call TNL_ffact_repairHasEnoughMaterials;
	
	if (_hasRequiredMats) then
	{
		{
			_itemClass = (_x select 0);
			_amount = (_x select 1);
			
			[_storageName,_itemClass,-(_amount)] call TNL_ftrunk_addStorage;
		
		} forEach _requiredMats;
	
		["You have successfully repaired the factory!"] call TNL_fextHint_Hint;
		[_object, "repaired", true, 1] call TNL_ffact_setSetting;
		TNL_gVar_boolean_removeFactSelectAction = true;
		closeDialog 0;
		sleep 0.15;
		closeDialog 0;
	}
	else
	{
		["You don't have the required materials to repair the factory!"] call TNL_fextHint_Hint;
		[_object] call TNL_ffact_repairFactoryLoad;
	};
};

TNL_ffact_repairFactorySelect = 
{
	private ["_actionClass"];
	_actionClass = (_this select 0);

	switch (_actionClass) do
	{
		case "adduser":
		{
			[ctrlText 7, ctrlText 8, TNL_gVar_obj_curSelFactory, "repair"] call TNL_ffact_repairFactoryAddUser;
		};
		
		case "remuser":
		{
			[(call compile(lbData [9, lbCurSel 9])), TNL_gVar_obj_curSelFactory, "repair"] call TNL_ffact_repairFactoryRemUser;
		};
		
		case "lockstorage":
		{
			[TNL_gVar_obj_curSelFactory, "repair"] call TNL_ffact_repairFactoryLockStorage;
		};
		
		case "listenable":
		{
			[TNL_gVar_obj_curSelFactory, "repair"] call TNL_ffact_repairFactoryRequiredOnList;
		};
	};
	
	[TNL_gVar_obj_curSelFactory] call TNL_ffact_repairFactoryLoad;
};

TNL_ffact_repairFactoryRequiredOnList =
{
	private ["_object", "_permissions", "_required", "_type"];
	_object = (_this select 0);
	_permissions = (([_object, "permissionsPublicStorage"] call TNL_ffact_getSetting) select 1);
	_required = (_permissions select 1);
	_type = (_this select 1);
	
	if (_required) then
	{
		["You have disabled that users required to be on the permitted list to access the factory storage"] call TNL_fextHint_Hint;
		_permissions set[1,false];
	}
	else
	{
		["You have enabled that users required to be on the permitted list to access the factory storage"] call TNL_fextHint_Hint;
		_permissions set[1,true];
	};
	
	[_object, "permissionsPublicStorage", _permissions, 1] call TNL_ffact_setSetting;
};

TNL_ffact_repairFactoryLockStorage =
{
	private ["_object", "_permissions", "_locked", "_type"];
	_object = (_this select 0);
	_permissions = (([_object, "permissionsPublicStorage"] call TNL_ffact_getSetting) select 1);
	_locked = (_permissions select 2);
	_type = (_this select 1);
	
	if (_locked) then
	{
		["You have unlocked the factory storage for everyone"] call TNL_fextHint_Hint;
		_permissions set[2,false];
	} 
	else
	{
		["You have locked the factory storage for everyone but yourself"] call TNL_fextHint_Hint;
		_permissions set[2,true];
	};
	
	[_object, "permissionsPublicStorage", _permissions, 1] call TNL_ffact_setSetting;
};

TNL_ffact_repairFactoryAddUser = 
{
	private ["_firstName", "_lastName", "_object", "_type", "_permissions", "_allowedList", "_inList"];
	_firstName = (_this select 0);
	_lastName = (_this select 1);
	_object = (_this select 2);
	_type = (_this select 3);
	
	_permissions = (([_object, "permissionsPublicStorage"] call TNL_ffact_getSetting) select 1);
	_allowedList = (_permissions select 3);
	_inList = false;
	
	{
		_listFirstName = (_x select 0);
		_listLastName = (_x select 1);
		
		if ((_firstName == _listFirstName) && (_lastName == _listLastName)) then
		{
			_inList = true;
		};
	
	} forEach _allowedList;
	
	if !(_inList) then
	{
		_allowedList = _allowedList + [ [_firstname, _lastname] ];
		_permissions set[3, _allowedList];
		[format["Added %1 %2 to the allowed list", _firstname, _lastname]] call TNL_fextHint_Hint;
	}
	else
	{
		[format["%1 %2 is already in the allowed list", _firstname, _lastname]] call TNL_fextHint_Hint;
	};
	
	[_object, "permissionsPublicStorage", _permissions, 1] call TNL_ffact_setSetting;
};

TNL_ffact_repairFactoryRemUser =
{
	private ["_user", "_object"];
	_user = (_this select 0);
	_object = (_this select 1);
	_repair = (_this select 2);
	
	_permissions = (([_object, "permissionsPublicStorage"] call TNL_ffact_getSetting) select 1);
	_allowedList = (_permissions select 3);
		
	
	{
		if (((_x select 0) == (_user select 0)) && ((_x select 1) == (_user select 1))) then
		{
			[format["Removed %1 %2 from the allowed list", (_x select 0), (_x select 1)]] call TNL_fextHint_Hint;
			_x set[0,""];
			_x set[1,""];
		};
	
	} forEach _allowedList;
	
	_permissions set[3, _allowedList];
	
	[_object, "permissionsPublicStorage", _permissions, 1] call TNL_ffact_setSetting;
};

TNL_ffact_openManageFactory =
{
	private ["_object"];
	_object = (_this select 0);

	if (!createDialog "DlgFactoryManage") then
	{
		["Error in factoryFunctions.sqf, function TNL_ffact_openManageFactory, failed to open dialog DlgFactoryManage"] call TNL_fextHint_Hint;
	};
	
	[_object] spawn TNL_ffact_loadManageFactory;
};

TNL_ffact_loadManageFactory =
{
	private ["_object", "_canMake", "_factoryType", "_factoryFunds", "_factoryTypeName", "_money"];
	_object = (_this select 0);
	_canMake = (([_object, "itemsCanMake"] call TNL_ffact_getSetting) select 1);
	_factoryType = (([_object, "factoryType"] call TNL_ffact_getSetting) select 1);
	_factoryFunds = (([_object, "factoryFunds"] call TNL_ffact_getSetting) select 1);
	_factoryLocked = (([_object, "factoryLocked"] call TNL_ffact_getSetting) select 1);
	_permissions = (([_object, "permissionsPublicStorage"] call TNL_ffact_getSetting) select 1);
	_factoryTypeName = (((_factoryType) call TNL_ffact_getFactoryTypeNameAndDescription) select 0);
	_money = "money" call TNL_finv_getItemAmount;
	_requiredToBeOnList = (_permissions select 1);
	_locked = (_permissions select 2);
	_allowedList = (_permissions select 3);
	TNL_gVar_obj_curSelFactory = (_object);
	
	lbClear 2;
	lbClear 1;
	lbClear 5;
	
	{
		_itemClass = (_x select 0);
		_itemName = (_x select 0) call TNL_finv_getItemName;
		_itemManufactureCost = (_x select 1);
		_itemUserCost = (_x select 2);
		_userCanManufacture = (_x select 3);
		
		_itemManufactureCost = ((_itemManufactureCost/100)*GblFactTax);
		
		_index = lbAdd[2, format["%1, %2Ц, %3Ц, %4", _itemName, _itemManufactureCost, _itemUserCost, _userCanManufacture]];
		lbSetData[2,_index,format['["%1", %2, %3, %4]', _itemClass, _itemManufactureCost, _itemUserCost, _usercanManufacture]];

	} forEach _canMake;
	
	{
		_index = lbAdd[1, format["%1", (_x select 0)]];
		lbSetData[1,_index,(_x select 1)];
	} forEach TNL_gVar_arr_fact_managementActions;
	
	{
		_index = lbAdd[5,format["%1 %2", (_x select 0), (_x select 1)]];
		lbSetData[5,_index, format['["%1","%2"]',(_x select 0),(_x select 1)]];
	} forEach _allowedList;
	
	
	((findDisplay 1204) displayCtrl 4) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Factory Type:</t> %1 | <t color='#ffcc00'>Money:</t> %3Ц", _factoryTypeName, _factoryFunds, _money];
	((findDisplay 1204) displayCtrl 3) ctrlSetStructuredText parseText "";
	((findDisplay 1204) displayCtrl 10) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Storage locked:</t> %1", _locked];
	((findDisplay 1204) displayCtrl 11) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Required to be on list:</t> %1", _requiredToBeOnList];
	((findDisplay 1204) displayCtrl 17) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Factory locked:</t> %1", _factoryLocked];
	
	if ((lbCurSel 1) < 0) then { lbSetCurSel[1,0]; };
	if ((lbCurSel 2) < 0) then { lbSetCurSel[2,0]; };
	if ((lbCurSel 5) < 0) then { lbSetCurSel[5,0]; };
	
	[(lbData[2,lbCurSel 2])] call TNL_ffact_managementItemsSelectionChanged;
};

TNL_ffact_managementItemsSelectionChanged =
{
	private ["_data", "_itemClass", "_itemName", "_itemManufactureCost", "_itemUserCost", "_userCanManufacture"];
	_data = call compile (_this select 0);
	_itemClass = (_data select 0);
	_itemName = (_itemClass) call TNL_finv_getItemName;
	_itemManufactureCost = (_data select 1);
	_itemUserCost = (_data select 2);
	_userCanManufacture = (_data select 3);
	
	ctrlSetText[13,format["%1",_itemUserCost]];
	
	((findDisplay 1204) displayCtrl 12) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Item name:</t> %1", _itemName];
	((findDisplay 1204) displayCtrl 6) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Manufacture Cost:</t> %1Ц", _itemManufactureCost];
	((findDisplay 1204) displayCtrl 7) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Cost for users:</t> %1Ц", _itemUserCost];
	((findDisplay 1204) displayCtrl 8) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Profit:</t> %1Ц", ((_itemUserCost) - (_itemManufactureCost)) ];
	((findDisplay 1204) displayctrl 9) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Users can manufacture:</t> %1", _userCanManufacture];
};

TNL_ffact_managementActionsSelect = 
{
	private ["_actionClass"];
	_actionClass = (_this select 0);
	
	_data = (call compile(lbData[2,lbCurSel 2]));
	_itemClass = (_data select 0);
	_itemManufactureCost = (_data select 1);
	_itemUserCost = (_data select 2);
	_userCanManufacture = (_data select 3);
	_corp = (TNL_gVar_obj_curSelFactory) call TNL_fcorp_getFirmOwner;
	_accessRights = ([_corp, TNL_db_charName] call RPP_fnc_employee_getAccessLevel);
	_isOwner = [TNL_gVar_obj_curSelFactory, [TNL_db_charName select 0, TNL_db_charName select 1]] call TNL_ffact_isOwner;
	
	switch (_actionClass) do
	{
		case "adduser":
		{
			if ((_accessRights >= 1) or (_isOwner)) then
			{
				[ctrlText 14, ctrlText 15, TNL_gVar_obj_curSelFactory, "manage"] call TNL_ffact_repairFactoryAddUser;
			};
		};
		
		case "remuser":
		{
			if ((_accessRights >= 1) or (_isOwner)) then
			{
				[(call compile(lbData [5, lbCurSel 5])), TNL_gVar_obj_curSelFactory, "manage"] call TNL_ffact_repairFactoryRemUser;
			};
		};
		
		case "lockstorage":
		{
			if ((_accessRights >= 1) or (_isOwner)) then
			{
				[TNL_gVar_obj_curSelFactory, "manage"] call TNL_ffact_repairFactoryLockStorage;
			};
		};
		
		case "listenable":
		{
			if ((_accessRights >= 1) or (_isOwner)) then
			{
				[TNL_gVar_obj_curSelFactory, "manage"] call TNL_ffact_repairFactoryRequiredOnList;
			};
		};
		
		case "toggleItemCanMake":
		{
			if ((_accessRights >= 1) or (_isOwner)) then
			{
				[TNL_gVar_obj_curSelFactory, (_itemClass), !(_userCanManufacture), 3] call TNL_ffact_setManufactureItemValue;
			};
		};
		
		case "setprice":
		{
			if ((_accessRights >= 1) or (_isOwner)) then
			{
				[TNL_gVar_obj_curSelFactory, (_itemClass), (parseNumber(ctrlText 13)), 2] call TNL_ffact_setManufactureItemValue;
			};
		};
		
		case "addfactfunds":
		{
			[TNL_gVar_obj_curSelFactory, (parseNumber(ctrlText 16))] call TNL_ffact_addFactoryFunds;
		};
		
		case "remfactfunds":
		{
			[TNL_gVar_obj_curSelFactory, (parseNumber(ctrlText 16))] call TNL_ffact_takeFactoryFunds;
		};
		
		case "lockfactory":
		{
			if ((_accessRights >= 0) or (_isOwner)) then
			{
				[TNL_gVar_obj_curSelFactory] call TNL_ffact_lockFactory;
			};
		};
		
		case "changefactorytype":
		{
			if ((_accessRights >= 2) or (_isOwner)) then
			{
				[] spawn TNL_ffact_ChangeFactory;
			};
		};
	};
	
	[TNL_gVar_obj_curSelFactory] call TNL_ffact_loadManageFactory;
};

TNL_ffact_ChangeFactory =
{
	closeDialog 0;
	sleep 0.15;
	closeDialog 0;

	[TNL_gVar_obj_curSelFactory] call TNL_ffact_selectFactory;
};

TNL_ffact_lockFactory =
{
	private ["_object", "_locked"];
	_object = (_this select 0);
	_locked = (([_object, "factoryLocked"] call TNL_ffact_getSetting) select 1);

	[_object, "factoryLocked", !_locked, 1] call TNL_ffact_setSetting;
};

TNL_ffact_addFactoryFunds = 
{
	private ["_object", "_amount"];
	_object = (_this select 0);
	_amount = (_this select 1);
	_factoryFunds = (([_object, "factoryFunds"] call TNL_ffact_getSetting) select 1);
	_old = _factoryFunds;
	_money = "money" call TNL_finv_getItemAmount;
	
	_factoryFunds = _factoryFunds + _amount;
	
	if (_money >= _amount) then
	{
		["money", _amount] call TNL_finv_takeItemAmount;
		[_object, "factoryFunds", _factoryFunds, 1] call TNL_ffact_setSetting;
		[format["You have added %1Ц to the factory funds, the current funds is now %2Ц", _amount, _factoryFunds]] call TNL_fextHint_Hint;
	}
	else
	{
		[format["You don't have enough money to add %1Ц to the factory funds, you only have %2Ц", _amount, _money]] call TNL_fextHint_Hint;
	};
};

TNL_ffact_takeFactoryFunds =
{
	private ["_object", "_amount"];
	_object = (_this select 0);
	_amount = (_this select 1);
	_factoryFunds = (([_object, "factoryFunds"] call TNL_ffact_getSetting) select 1);
	_old = _factoryFunds;
	_money = "money" call TNL_finv_getItemAmount;
	
	_factoryFunds = _factoryFunds - _amount;
	
	if (_factoryFunds >= 0) then
	{
		if (["money", _amount] call TNL_finv_addInventoryItem) then
		{
			[format["You have taken %1Ц from the factory funds, the current funds is now %2Ц", _amount, _factoryFunds]] call TNL_fextHint_Hint;
			[_object, "factoryFunds", _factoryFunds, 1] call TNL_ffact_setSetting;
		};
	}
	else
	{
		[format["You cannot take %1Ц because this is more than the factory has, the maximum you can take is %2Ц", _amount, _old]] call TNL_fextHint_Hint;
	};

};

TNL_ffact_setManufactureItemValue =
{
	private ["_object", "_itemClass", "_value", "_index"];
	_object = (_this select 0);
	_itemClass = (_this select 1);
	_value = (_this select 2);
	_index = (_this select 3);
	_canMake = (([_object, "itemsCanMake"] call TNL_ffact_getSetting) select 1);
	
	{
		_class = (_x select 0);
		
		if (_class == _itemClass) then
		{
			(_x) set[_index,_value];
		};
	
	} forEach _canMake;
	
	[_object, "itemsCanMake", _canMake, 1] call TNL_ffact_setSetting;
};

TNL_ffact_getFactoryTypeNameAndDescription = 
{
	private ["_type", "_return"];
	_type = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _type) then
		{
			_return = (_x select 1);
		};
	} forEach TNL_gVar_arr_fact_types;

	_return
};

TNL_ffact_getFactoryStorage =
{
	private ["_object", "_type", "_return"];
	_object = (_this select 0);
	_type = (_this select 1);
	_return = "";
	
	{
		if ((_x select 0) == _object) then
		{
			if (_type == "local") then
			{
				_return = ((_x select 2) select 1);
			};
			
			if (_type == "public") then
			{
				_return = ((_x select 2) select 0);
			};
		};
	
	} forEach TNL_gVar_arr_fact_factorys;
	
	_return
};

TNL_ffact_getFactoryRequiredMaterials = 
{
	private ["_type", "_return"];
	_type = (_this);
	_return = [];
	
	{
		if ((_x select 0) == _type) then
		{
			_return = (_x select 2);
		};
	} forEach TNL_gVar_arr_fact_types;

	_return
};

TNL_ffact_getFactoryItemsCanMake =
{
	private ["_type", "_return"];
	_type = (_this);
	_return = [];

	{
		if ((_x select 0) == _type) then
		{
			_return = (_x select 3);
		};
	} forEach TNL_gVar_arr_fact_types;

	_return
};

TNL_ffact_openManufactureDialog =
{
	private ["_object"];
	_object = (_this select 0);
	if !(createDialog "DlgFactoryManufacture") then 
	{
		["Error in factoryFunctions.sqf, function TNL_ffact_openManufactureDialog failed to open dialog DlgFactoryManufacture"] call TNL_fextHint_Hint;
	};

	TNL_gVar_fact_curStorage = "local";
	[_object] call TNL_ffact_loadManufacture;
};

TNL_ffact_loadManufacture =
{
	private ["_object", "_storage", "_canMake", "_factoryFunds", "_factoryType", "_factoryTypeName", "_money", "_curStorageText"];
	_object = (_this select 0);
	TNL_gVar_obj_curSelFactory = (_object);
	_storage = (([_object,TNL_gVar_fact_curStorage] call TNL_ffact_getFactoryStorage) getVariable "storage");
	_canMake = (([_object, "itemsCanMake"] call TNL_ffact_getSetting) select 1);
	_factoryFunds = (([_object, "factoryFunds"] call TNL_ffact_getSetting) select 1);
	_factoryType = (([_object, "factoryType"] call TNL_ffact_getSetting) select 1);
	_factoryTypeName = (((_factoryType) call TNL_ffact_getFactoryTypeNameAndDescription) select 0);
	_money = "money" call TNL_finv_getItemAmount;
	_curStorageText = "Private";
	
	lbClear 1;
	
	{
		_itemClass = (_x select 0);
		_manufactureCost = (_x select 1);
		_userPrice = (_x select 2);
		_canMake = (_x select 3);
		_itemName = (_itemClass) call TNL_finv_getItemName;
		
		//if (_canMake) then
		//{
			_index = lbAdd[1,format["%1, %2Ц", _itemName, _userPrice]];
			lbSetData[1,_index,_itemClass];
		//};
	
	
	} forEach _canMake;

	if (TNL_gVar_fact_curStorage == "public") then
	{
		_curStorageText = "Factory";
	};
	
	((findDisplay 1205) displayCtrl 3) ctrlSetStructuredText parseText format
	["<t color='#ffcc00'>Factory Type:</t> %1	|
	<t color='#ffcc00'>Current Storage:</t> %2	|
	<t color='#ffcc00'>Money:</t> %4Ц	|", _factoryTypeName, _curStorageText, _factoryFunds, _money];
	
	if ((lbCurSel 1) < 0) then { lbSetCurSel[1,0]; };
};

TNL_ffact_manufactureUpdateReqMats =
{
	private ["_itemClass", "_reqMats", "_storage", "_canMake", "_factoryFunds", "_userPrice", "_manufactureCost", "_enoughFundsToManufacture", "_itemName", "_itemWeight", "_amount"];
	_itemClass = (_this select 0);
	_reqMats = (_itemClass) call TNL_finv_getItemRequiredMaterials;
	_storage = (([TNL_gVar_obj_curSelFactory,TNL_gVar_fact_curStorage] call TNL_ffact_getFactoryStorage) getVariable "storage");
	_canMake = (([TNL_gVar_obj_curSelFactory, "itemsCanMake"] call TNL_ffact_getSetting) select 1);
	_factoryFunds = (([TNL_gVar_obj_curSelFactory, "factoryFunds"] call TNL_ffact_getSetting) select 1);
	_userPrice = 0;
	_manufactureCost = 0;
	_canManufacture = false;
	_enoughFundsToManufacture = false;
	_itemName = (_itemClass) call TNL_finv_getItemName;
	_itemWeight = (_itemClass) call TNL_finv_getItemWeight;
	_amount = (parseNumber (ctrlText 14));
	
	lbClear 2;
	
	{
		_reqItemClass = (_x select 0);
		_reqItemAmount = (_x select 1);
		_reqItemName = (_reqItemClass) call TNL_finv_getItemName;
		_amountInStorage = 0;
		
		{
			if (_reqItemClass == (_x select 0)) then
			{
				_amountInStorage = (_x select 1);
			};
		
		} forEach _storage;
		
		_index = lbAdd[2, format["%1, %2/%3x", _reqItemName, _amountInStorage, ((_reqItemAmount) * (_amount))]];
		lbSetData[2, _index, format['["%1", %2, %3]', _reqItemClass, _amountInStorage, _reqItemAmount]];
	
	} forEach _reqMats;
	
	{
		if (_itemClass == (_x select 0)) then
		{
			_manufactureCost = (_x select 1);
			_userPrice = (_x select 2);
			_canManufacture = (_x select 3);
		};
	
	} forEach _canMake;
	
	if (_factoryFunds >= (((_manufactureCost) - (_userPrice)) * (_amount))) then { _enoughFundsToManufacture = true; };
	
	if ((lbCurSel 2) < 0) then { lbSetCurSel[2,0]; };
	
	
	((findDisplay 1205) displayCtrl 4) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Item name:</t> %1", _itemName];
	((findDisplay 1205) displayCtrl 7) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Manufacture cost each:</t> %1Ц, <t color='#ffcc00'>Total:</t> %2Ц", _manufactureCost, ((_manufactureCost) * (_amount))];
	((findDisplay 1205) displayCtrl 8) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Price each:</t> %1Ц", _userPrice];
	((findDisplay 1205) displayCtrl 9) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Total price:</t> %1Ц", ((_userPrice) * (_amount))];
	((findDisplay 1205) displayCtrl 10) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Weight each:</t> %1kg", _itemWeight];
	((findDisplay 1205) displayCtrl 11) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Total weight:</t> %1kg", ((_itemWeight) * (_amount))];
	((findDisplay 1205) displayCtrl 12) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Can manufacture:</t> %1", _canManufacture];
	((findDisplay 1205) displayCtrl 13) ctrlSetStructuredText parseText "";
};

TNL_ffact_manufactureUpdate =
{	
	private ["_data", "_itemClass", "_itemName", "_amountInStorage", "_reqItemAmount", "_amount"];
	_data = (_this select 0);
	_itemClass = (_data select 0);
	_itemName = (_itemClass) call TNL_finv_getItemName;
	_amountInStorage = (_data select 1);
	_reqItemAmount = (_data select 2);
	_amount = (parseNumber (ctrlText 14));

	((findDisplay 1205) displayCtrl 5) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Total required of %2:</t> %1x", 	((_reqItemAmount) * (_amount)), _itemName];
	((findDisplay 1205) displayCtrl 6) ctrlSetStructuredText parseText format["<t color='#ffcc00'>Amount of %2 in storage:</t> %1x", _amountInStorage, _itemName];
};

TNL_ffact_manufacture =
{
	private ["_object", "_itemClass", "_permissions", "_requiredToBeOnList", "_locked", "_allowedList", "_canUse", "_enoughFunds"];
	_object = (_this select 0);
	_itemClass = (_this select 1);
	_itemName = (_itemClass) call TNL_finv_getItemName;
	_permissions = (([_object, "permissionsPublicStorage"] call TNL_ffact_getSetting) select 1);
	_requiredToBeOnList = (_permissions select 1);
	_locked = (_permissions select 2);
	_allowedList = (_permissions select 3);
	_canUse = true;
	_amount = (parseNumber (ctrlText 14));
	_money = "money" call TNL_finv_getItemAmount;
	_enoughFunds = false;
	_canMake = (([_object, "itemsCanMake"] call TNL_ffact_getSetting) select 1);
	_corpOwner = (_object) call TNL_fcorp_getFirmOwner;
	_factoryFunds =  [_corpOwner] call TNL_fcorp_getBankAmount;
	_tax = GblFactTax;
	_totalManufactureCost = 0;
	_totalUserCost = 0;
	_result = false;
	_allowedToManufacture = false;

	
	{
		_manufactureCost = (_x select 1);
		_userCost = (_x select 2);
		
		if  ((_x select 0) == _itemClass) then
		{
			_allowedToManufacture = (_x select 3);
			_totalManufactureCost = ((_manufactureCost) * (_amount));
			_totalUserCost = ((_userCost) * (_amount));
		};
	} forEach _canMake;
	
	_origPrice = _totalManufactureCost;
	_totalManufactureCost = ((_totalManufactureCost/100)*_tax);
	
	_taxRate = (_tax/100);
	_price = _origPrice * (_taxRate);
	_taxPaid = (_taxRate * _price);
	_taxPaid = (_price - _taxPaid) * _amount;
	
	if (_requiredToBeOnList) then
	{
		{
			_firstName = (_x select 0);
			_lastName = (_x select 1);
			_yourFirstName = (TNL_db_charName select 0);
			_yourLastName = (TNL_db_charName select 1);
			
			if ((_firstName == _yourFirstName) && (_lastName == _yourLastName)) then
			{
				_allowedToManufacture = true;
			};
		} forEach _allowedList;
	};
	
	
	if (TNL_gVar_fact_curStorage == "public") then
	{
		if (_requiredToBeOnList) then
		{
			{
				_firstName = (_x select 0);
				_lastName = (_x select 1);
				_yourFirstName = (TNL_db_charName select 0);
				_yourLastName = (TNL_db_charName select 1);
			
				if ((_firstName == _yourFirstName) && (_lastName == _yourLastName)) then
				{
					_canUse = true;
				};
			} forEach _allowedList;
		};
	
	
		if !(_requiredToBeOnList) then
		{
			if !(_locked) then
			{
				_canUse = true;
			};
		};

		if ([_object, [TNL_db_charName select 0, TNL_db_charName select 1]] call TNL_ffact_isOwner) then
		{
			_canUse = true;
		};
	
		if (_locked) then
		{
			_canUse = false;
		};
	};
	
	if (_allowedToManufacture) then
	{
		if (_factoryFunds >= ((_totalManufactureCost) - (_totalUserCost))) then
		{
			if (_money >= _totalUserCost) then
			{
				if (_canUse) then
				{
					_itemType = (((_itemClass) call TNL_finv_getItemTypes) select 0);
					switch (_itemType) do
					{
						case "VEHICLE":
						{
							_result = [_object, _itemClass, TNL_gVar_fact_curStorage, _amount] call TNL_ffact_manufactureVehicle;
						};
		
						case "ITEM":
						{
							_result = [_object, _itemClass, TNL_gVar_fact_curStorage, _amount] call TNL_ffact_manufactureItem;
						};
			
						case "WEAPON":
						{
							_result = [_object, _itemClass, TNL_gVar_fact_curStorage, _amount] call TNL_ffact_manufactureWeapon;
						};
			
						case "MAGAZINE":
						{
							_result = [_object, _itemClass, TNL_gVar_fact_curStorage, _amount] call TNL_ffact_manufactureMagazine;
						};
					};	
						if (_result) then
						{
							//Factory Funds - Manufacture Cost - UserCost
							
							//[_object, "factoryFunds", ((_factoryFunds) - (_totalManufactureCost)), 1] call TNL_ffact_setSetting;
							["money", _totalUserCost] call TNL_finv_takeItemAmount;
							[format["Total cost: %1Ц", _totalUserCost]] call TNL_fextHint_Hint;
							
							/* Corporations */
							[_object, _totalManufactureCost] call TNL_fcorp_increaseFirmExpenses;
							[_object, _totalUserCost] call TNL_fcorp_increaseFirmIncome;
							_corpOwner = (_object) call TNL_fcorp_getFirmOwner;
							
							[{GovernmentTaxAccount = GovernmentTaxAccount + (_this select 0); publicVariable "GovernmentTaxAccount"; }, [_taxPaid]] call TNL_fnet_execPublic;
							
							_totalChange = ((_totalUserCost) - (_totalManufactureCost));
							_bankAmount = [_corpOwner] call TNL_fcorp_getBankAmount;
							[_corpOwner, (((_bankAmount) + (_totalChange)))] call TNL_fcorp_setBankAmount;
						};
						
						_object say3D "SndManufacture";
				}
				else
				{
					["You are not allowed to manufacture anything from this storage"] call TNL_fextHint_Hint;
				};
			}
			else
			{
				[format["You do not have enough money to manufacture these items, you require %1Ц but you only have %2Ц", _totalUserCost, _money]] call TNL_fextHint_Hint;
			};
		}
		else
		{	
			[format["The factory does not have enough funds to cover the costs of manufacturing this item\nFunds: %1Ц\nRequired: %2Ц", _factoryFunds, ((_totalManufactureCost) - (_totalUserCost))]] call TNL_fextHint_Hint; 
		};
	}
	else
	{
		["You are not allowed to manufacture this item"] call TNL_fextHint_Hint;
	};
	
	[_object] call TNL_ffact_loadManufacture; 
	[(lbData[1,lbCurSel 1])] call TNL_ffact_manufactureUpdateReqMats;
};

TNL_ffact_manufactureVehicle =
{
	private ["_object", "_itemClass", "_type", "_reqMats", "_storage", "_amount", "_enoughMats", "_vclSpawn", "_storageName", "_itemName", "_result"];
	_object = (_this select 0);
	_itemClass = (_this select 1);
	_type = (_this select 2);
	_amount = (_this select 3);
	_reqMats = (_itemClass) call TNL_finv_getItemRequiredMaterials;
	_storage = (([_object,_type] call TNL_ffact_getFactoryStorage) getVariable "storage");
	_vclSpawn = [_object] call TNL_ffact_getFactoryVehicleSpawn;
	_storageName = ([_object,_type] call TNL_ffact_getFactoryStorage);
	_itemName = (_itemClass) call TNL_finv_getItemName;
	_enoughMats = [_reqMats, _storage, _amount] call TNL_ffact_hasRequiredMaterials;
	_result = false;
	
	if (_enoughMats) then
	{
		[_reqMats, _storageName, _amount] call TNL_ffact_removeRequiredMaterials;
		
		_i = 0;
		while {_i < _amount} do
		{
			if (_vclSpawn != empty) then
			{
				[_itemClass, _vclSpawn] call TNL_fmission_createVehicle; 
			}
			else
			{
				[_itemClass, player] call TNL_fmission_createVehicle;
			};
			
			_i = _i + 1;
		};
			[format["You have manufactured %1 %2(s)", _amount, _itemName]] call TNL_fextHint_Hint;
			_result = true;
	}
	else
	{
		["You do not have enough materials to produce this"] call TNL_fextHint_Hint;
	};
	
	_result
};

TNL_ffact_manufactureItem =
{
	private ["_object", "_itemClass", "_type", "_reqMats", "_storage", "_amount", "_enoughMats", "_storageName", "_itemName", "_result"];
	_object = (_this select 0);
	_itemClass = (_this select 1);
	_type = (_this select 2);
	_amount = (_this select 3);
	_reqMats = (_itemClass) call TNL_finv_getItemRequiredMaterials;
	_storage = (([_object,_type] call TNL_ffact_getFactoryStorage) getVariable "storage");
	_storageName = ([_object,_type] call TNL_ffact_getFactoryStorage);
	_itemName = (_itemClass) call TNL_finv_getItemName;
	_enoughMats = [_reqMats, _storage, _amount] call TNL_ffact_hasRequiredMaterials;
	_result = false;
	
	if (_enoughMats) then
	{
		if ([_storageName, _itemClass, _amount] call TNL_ftrunk_addStorage) then
		{
			[_reqMats, _storageName, _amount] call TNL_ffact_removeRequiredMaterials;
			[format["You have manufactured %1 %2(s)", _amount, _itemName]] call TNL_fextHint_Hint;
			_result = true;
		}
		else
		{
			["This will exceed the max weight of your storage"] call TNL_fextHint_Hint;
		};
	}
	else
	{
		["You do not have enough materials to produce this"] call TNL_fextHint_Hint;
	};

	_result
};	

TNL_ffact_manufactureWeapon =
{	
	private ["_object", "_itemClass", "_type", "_reqMats", "_storage", "_amount", "_enoughMats", "_storageName", "_itemName", "_result", "_spawn"];
	_object = (_this select 0);
	_itemClass = (_this select 1);
	_type = (_this select 2);
	_amount = (_this select 3);
	_reqMats = (_itemClass) call TNL_finv_getItemRequiredMaterials;
	_storage = (([_object,_type] call TNL_ffact_getFactoryStorage) getVariable "storage");
	_storageName = ([_object,_type] call TNL_ffact_getFactoryStorage);
	_itemName = (_itemClass) call TNL_finv_getItemName;
	_enoughMats = [_reqMats, _storage, _amount] call TNL_ffact_hasRequiredMaterials;
	_result = false;
	_spawn = [_object] call TNL_ffact_getFactoryWeaponSpawn;

	if (_enoughMats) then
	{
		[_reqMats, _storageName, _amount] call TNL_ffact_removeRequiredMaterials;
		_spawn addWeaponCargo[_itemClass, _amount];
		[format["You have manufactured %1 %2(s)", _amount, _itemName]] call TNL_fextHint_Hint;
		_result = true;
	}
	else
	{
		["You do not have enough materials to produce this"] call TNL_fextHint_Hint;
	};

	_result
};

TNL_ffact_manufactureMagazine =
{
	private ["_object", "_itemClass", "_type", "_reqMats", "_storage", "_amount", "_enoughMats", "_storageName", "_itemName", "_result", "_spawn"];
	_object = (_this select 0);
	_itemClass = (_this select 1);
	_type = (_this select 2);
	_amount = (_this select 3);
	_reqMats = (_itemClass) call TNL_finv_getItemRequiredMaterials;
	_storage = (([_object,_type] call TNL_ffact_getFactoryStorage) getVariable "storage");
	_storageName = ([_object,_type] call TNL_ffact_getFactoryStorage);
	_itemName = (_itemClass) call TNL_finv_getItemName;
	_enoughMats = [_reqMats, _storage, _amount] call TNL_ffact_hasRequiredMaterials;
	_result = false;
	_spawn = [_object] call TNL_ffact_getFactoryWeaponSpawn;
	
	if (_enoughMats) then
	{
		[_reqMats, _storageName, _amount] call TNL_ffact_removeRequiredMaterials;
		_spawn addMagazineCargo[_itemClass, _amount];
		[format["You have manufactured %1 %2(s)", _amount, _itemName]] call TNL_fextHint_Hint;
		_result = true;
	}
	else
	{
		["You do not have enough materials to produce this"] call TNL_fextHint_Hint;
	};

	_result
};

TNL_ffact_removeRequiredMaterials =
{
	private ["_requiredMaterials", "_storageName", "_amount"];
	_requiredMaterials = (_this select 0);
	_storageName = (_this select 1);
	_amount = (_this select 2);
	
	{
		_reqClass = (_x select 0);
		_reqAmount = (_x select 1);
		_totalAmount = ((_reqAmount) * (_amount));
				
		[_storageName,_reqClass,-(_totalAmount)] call TNL_ftrunk_addStorage;

	} forEach _requiredMaterials;

};

TNL_ffact_hasRequiredMaterials = 
{
	private ["_requiredMaterials", "_storageArray", "_return", "_amount"];
	_requiredMaterials = (_this select 0);
	_storageArray = (_this select 1);
	_amount = (_this select 2);
	_return = true;
	
	{
		_found = false;
		_sufficientMats = false; 
		_itemAmount = (_x select 1);
		_class = (_x select 0);
	
		{
			if ((_x select 0) == _class) then
			{
				if ((_x select 1) >= ((_itemAmount) * (_amount))) then
				{
					_sufficientMats = true;
				};
				
				_found = true;
			};
		} forEach _storageArray;
		
		if !(_found) then { _return = false; };
		if !(_sufficientMats) then { _return = false; };
	
	} forEach _requiredMaterials;

	_return
};

TNL_ffact_getFactoryVehicleSpawn =
{	
	private ["_object", "_return"];
	_object = (_this select 0);
	_return = empty;
	
	{
		if ((_x select 0) == _object) then
		{
			_return = (_x select 3);
		};
	
	} forEach TNL_gVar_arr_fact_factorys;

	_return
};

TNL_ffact_getFactoryWeaponSpawn =
{	
	private ["_object", "_return"];
	_object = (_this select 0);
	_return = empty;
	
	{
		if ((_x select 0) == _object) then
		{
			_return = call compile format["%1_factory_crate", (_x select 4)];
		};
	
	} forEach TNL_gVar_arr_fact_factorys;

	_return
};

TNL_ffact_getFactoryName = 
{
	private ["_object", "_return"];
	_object = (_this select 0);
	_return = "";
	
	{
		if ((_x select 0) == _object) then
		{
			_return = ((_x select 1) select 0);
		};
	
	} forEach TNL_gVar_arr_fact_factorys;

	_return
};
