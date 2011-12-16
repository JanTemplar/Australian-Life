/*
Name: eventHandlers.sqf
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (2009/05/29)
Description: Executes specified code/script when an action is used
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

#define __thisFile "client\useAction.sqf"

	if (typeName _this != "ARRAY") exitWith {[__thisFile, format ["Bad input in scripts' parameter: expected ARRAY OF PARAMETERS, provided %1", typeName _this]] call TNL_fcore_debug};
	if (count _this < 4) exitWith {[__thisFile, format ["Bad input in scripts' parameters: expected >4 parameters, provided %1", count _this]] call TNL_fcore_debug};

_where = _this select 0;
_who = _this select 1;
_params = _this select 3;


if (typeName _params != "ARRAY") exitWith {[__thisFile, format ["Bad input in scripts' 3rd parameter: expected ARRAY, provided %1", typeName _params]] call TNL_fcore_debug};
if (count _params > 1) then
{
	_params = (_this select 3) select 1;
};
switch ((_this select 3) select 0) do
{
	case "db":
	{
		[] call TNL_fdb_force;
	};
	case "shop":
	{
		[_params] spawn SBAY_fShops_OpenShopDialog;
	};
	case "inventory":
	{
		[] spawn TNL_finv_openInventory;
	};
	case "atm":
	{
		_params call TNL_fatm_open;
	};
	case "license":
	{
		[_params] spawn TNL_flic_openDialog;
	};
	case "vehiclemenu":
	{
		[_params select 0, _params select 1] spawn TNL_fvcl_menu;
	};
	case "gasstationrefuel":
	{
		[vehicle player, _params, 2] call TNL_fgas_refilStationTanks;
	};
	case "trunk":
	{
		[_params] spawn TNL_ftrunk_openTrunk;
	};
	case "locktrunk":
	{
		[_params] spawn TNL_ftrunk_lockTrunk;
	};
	case "interaction":
	{
		[_params] spawn TNL_finteraction_openDialog;
	};
	case "lock":
	{
		_params spawn TNL_fvcl_lockVehicle;
	};
	case "anim":
	{
		[] spawn TNL_fanim_openDialog;
	};
	case "stats":
	{
		[] spawn TNL_fstats_openDialog;
	};
	case "bank":
	{
		_params spawn TNL_fbank_chooseActionOpen;
	};
	case "gather":
	{
		[_params select 0, _params select 1] spawn TNL_fgather_handleAction;
	};
	case "corp_gather":
	{
		[_params select 0, _params select 1, _params select 2] spawn TNL_fwp_handleAction;
	};
	case "corp_wp_prices":
	{
		[_params select 0, _params select 1, _params select 2] spawn TNL_fwp_openPrices;
	};
	case "corp_wp_buystock":
	{	
		[_params select 0, _params select 1, _params select 2] spawn TNL_fwp_purchaseStocks;
	};
	case "factory":
	{
		[_params select 0, _params select 1] spawn TNL_ffact_openDialog;
	};
	case "grabNozzle":
	{
		[_where, _params] spawn TNL_fgas_grabNozzle
	};
	case "dropNozzle":
	{
		[_where, _params] call TNL_fgas_dropNozzle;
	};
	case "refuel":
	{
		_this call TNL_fgas_refuelCar;
	};
	case "forestry_destroy":
	{
		[_params] call TNL_fforestry_destroyPlant;
	};
	case "forestry_picksprout":
	{
		[_params] call TNL_fforestry_pickSprout;
	};
	case "forestry_cutdown":
	{
		[_params] spawn TNL_fforestry_cutTree;
	};
	case "forestry_chopup":
	{
		[_params] spawn TNL_fforestry_chopTreeTrunk;
	};
	case "forestry_checkBush":
	{
		[_params] spawn TNL_fforestry_checkBush;
	};
	case "forestry_harvest":
	{
		[_params] spawn TNL_fforestry_harvestBush;
	};
	case "importexport":
	{
		[] spawn RPP_fnc_export_openDialog;
	};
	case "corporation":
	{
		switch (_params) do
		{
			case "registerDlg":
			{
				[] call TNL_fcorp_openRegisterDlg;
			};
			case "selectDlg":
			{
				[] call TNL_fcorp_openSelectCorpDlg;
			};
		};
	};
	case "stockmarket":
	{
		[] spawn TNL_fsmarket_openEnterDlg;
	};
	case "delivery":
	{
		[] spawn RPP_fdelivery_onAction;
	};
	case "phone":
	{
		(_this select 0) call TNL_fcomms_phoneOpen;
	};
	case "object":
	{
		[(_params select 0), (_params select 1)] execVM "slr\objects.sqf";
	};
	case "playerShop":
	{
		[(_params select 0), (_params select 1)] call TNL_fps_playerShopAction;
	};
	case "playerShopManage":
	{
		(_params select 0) spawn TNL_fps_playerShopCorp;
	};
	case "Milk":
	{
		[_params] call RPP_fnc_getMilk;
	};
	case "Examine":
	{
		[_params] call RPP_fnc_examineAnimal;
	};
	case "Lead":
	{
		[_params] call RPP_fnc_leadAnimal;
	};
	case "Kill":
	{
		_knifeAmount = "ButcheringKnife" call TNL_finv_getItemAmount;
		if (_knifeAmount > 0) then
		{
			["You kill the animal with your butchering knife."] call TNL_fextHint_Hint;
			_params setDamage 1;
		}
		else
		{
			["You need a butchering knife to do this."] call TNL_fextHint_Hint;
		};
	};
	case "Butcher":
	{
		[_params] call RPP_fnc_butcher;
	};
	case "mayorVote":
	{
		if (createDialog "DlgMayor") then
		{
			{
				_unit = _x;
				
			
				if (alive _unit) then
				{
					if ([_unit, "Cop"] call TNL_fmission_playerIsType) then
					{
						_index = lbAdd[101, format["%1", (name _unit) call TNL_fplayer_formatName]];
						lbSetData[101,_index,  format["%1", _x]];
						
					}
					else
					{
						_index = lbAdd[1, format["%1", (name _unit) call TNL_fplayer_formatName]];
						lbSetData[1,_index, format["%1", _x]];
					};
				};			

				lbSetCurSel[1,0];
				lbSetCurSel[101,0];
			} forEach ([] call TNL_cfplayer_activeSlots);
			
			
		}
		else
		{
			hint "Cannot create dialog!";
		};
	};
	
	case "setTaxes":
	{
		_dlg = createDialog "DlgTaxes";
		sliderSetSpeed [12, 1, 25];
		sliderSetRange [12, 1, 500];
		sliderSetPosition [12,((INV_ItemTypenArray select 0) select 2)];
		
		sliderSetSpeed [22, 1, 25];
		sliderSetRange [22, 1, 500];
		sliderSetPosition [22,((INV_ItemTypenArray select 1) select 2)];
		
		sliderSetSpeed [32, 1, 25];
		sliderSetRange [32, 1, 500];
		sliderSetPosition [32,((INV_ItemTypenArray select 2) select 2)];
		
		sliderSetSpeed [42, 1, 25];
		sliderSetRange [42, 1, 500];
		sliderSetPosition [42,((INV_ItemTypenArray select 3) select 2)];
		
		sliderSetSpeed [52, 1, 5];
		sliderSetRange [52, 1, 75];
		sliderSetPosition [52,bank_steuer];
		
		sliderSetRange [62, 1, 500];
		sliderSetPosition [62,GblFuelTaxes];
		
		sliderSetRange [72, 5, 500];
		sliderSetPosition [72,GblFactTax];
		
		sliderSetRange [82, 0, 75];
		sliderSetPosition [82,GblWealthTax];
		
		sliderSetRange [92, 0, 75];
		sliderSetPosition [92,GblIncomeTaxClass1];
		
		sliderSetRange [102, 0, 75];
		sliderSetPosition [102,GblIncomeTaxClass2];
		
		sliderSetRange [112, 0, 75];
		sliderSetPosition [112,GblIncomeTaxClass3];
		
		sliderSetRange [122, 0, 75];
		sliderSetPosition [122,GblIncomeTaxClass4];
		
		sliderSetRange [132, 0, 75];
		sliderSetPosition [132,GblIncomeTaxClass5];
		
		sliderSetRange [142, 100, 10000];
		sliderSetPosition [142,GblWelfareIncomeLimit];
		
		sliderSetRange [152, 1000, 100000];
		sliderSetPosition [152,GblWelfareBankLimit];
		
		sliderSetRange [162, 10, 5000];
		sliderSetPosition [162,add_civmoney];
		
		sliderSetRange [172, 500, 50000];
		sliderSetPosition [172,MayorExtraPay];
		
		sliderSetRange [182, 500, 50000];
		sliderSetPosition [182,PoliceChiefExtraPay];
		
		sliderSetRange [192, 0, 10];
		sliderSetPosition [192,zinsen_prozent];
		
		sliderSetRange [202, 0, 10000];
		sliderSetPosition [202,add_copmoney];
	
		while {(!(isNull findDisplay 5210)) } do 
		{
			ctrlSetText [11, format["Item tax: %1 Percent", (str(round(sliderPosition 12)))]];
			ctrlSetText [21, format["Vehicle tax: %1 Percent", (str (round(sliderPosition 22)))]];
			ctrlSetText [31, format["Magazine tax: %1 Percent", (str (round(sliderPosition 32)))]];
			ctrlSetText [41, format["Weapon tax: %1 Percent", (str (round(sliderPosition 42)))]];
			ctrlSetText [51, format["Bank Transfer tax: %1 Percent", (str(round(sliderPosition 52)))]];
			ctrlSetText [61, format["Fuel tax: %1 Percent", (str(round(sliderPosition 62)))]];
			ctrlSetText [71, format["Wealth-tax BankLimit: %1$", (str(round(sliderPosition 72)))]];
			ctrlSetText [81, format["Manufacturing-tax : %1 Percent", (str(round(sliderPosition 82)))]];
			ctrlSetText [91, format["Income-Tax(0-1000$): %1 Percent", (str(round(sliderPosition 92)))]];
			ctrlSetText [101, format["Income-Tax(1001-4000$): %1 Percent", (str(round(sliderPosition 102)))]];
			ctrlSetText [111, format["Income-Tax(4001-9999$): %1 Percent", (str(round(sliderPosition 112)))]];
			ctrlSetText [121, format["Income-Tax(10000-20000$): %1 Percent", (str(round(sliderPosition 122)))]];
			ctrlSetText [131, format["Income-Tax(>=20001$): %1 Percent", (str(round(sliderPosition 132)))]];
			ctrlSetText [141, format["Welfare Incomelimit: %1$", (str(round(sliderPosition 142)))]];
			ctrlSetText [151, format["Welfare Account-Limit: %1$", (str(round(sliderPosition 152)))]];
			ctrlSetText [161, format["Welfare Amount: %1$", (str(round(sliderPosition 162)))]];
			ctrlSetText [171, format["Mayor Salary: %1$", (str(round(sliderPosition 172)))]];
			ctrlSetText [181, format["Police Chief Salary: %1$", (str(round(sliderPosition 182)))]];
			ctrlSetText [191, format["Bank Interest: %1 Percent", (str(round(sliderPosition 192)))]];
			ctrlSetText [201, format["Police Basic-Salary: %1$", (str(round(sliderPosition 202)))]];
			CtrlSetText [6661, "Money on Government Account:"];
			CtrlSetText [6662, format["%1 $",  str (GovernmentTaxAccount)]];
			
			sleep 0.1;
		};
	
	};
	
	case "setLaws":
	{
		_dlg = createDialog "DlgSetLaws";
		{
			_index = lbAdd [1, _x];
			lbSetData [1, _index, _x];
		} forEach lawsArray;
		
	};
	
	case "MayorResign":
	{
		_dlg = createDialog "TNL_dlg_genYesNo";
		((findDisplay 1101) displayCtrl 2) ctrlSetStructuredText parseText "do you realy want to resign from position as the mayor?";
		buttonSetAction [10, 'isMayor = false; [{hint "The mayor has resigned his post!"; currentMayor = ""; closeDialog 0; player removeAction TNL_gAction_setTaxes; player removeAction TNL_gAction_mayorResign; player removeAction TNL_gAction_setLaws;}, []] call TNL_fnet_execPublic;'];
		buttonSetAction [11, 'closeDialog 0;'];
		
	};
	
	case "paycheck":
	{
		_dlg = createDialog "TNL_dlg_bankInputAcc";
		
		buttonSetAction [10, '
			_acc = ctrlText 1;
			
			if ([_acc, "0123456789"] call TNL_fcvar_hasForbiddenChars) exitWith {};

			if (_acc call TNL_fbank_accExists) then
			{
				closeDialog 0;
				
				TNL_gVar_paycheckAccNum = _acc;
				hint format["Account number set, your paychecks will go in the account: %1 from now on!", _acc];
			}
			else
			{
				["Invalid account number", "The entered account number does not match any of our registered bank accounts.", "closeDialog 0"] spawn TNL_fui_createNotifyDlg;
			};'];
	};
	
	case "wantedrelease":
	{
		["wantedrelease"] execVM "slr\wanted.sqf";
	};
	
	case "speedcam_take":
	{
		["take", _params] execVM "slr\speedcam.sqf";
	};
	
	default
	{
		hint "Errmm... Error?";
	};
};