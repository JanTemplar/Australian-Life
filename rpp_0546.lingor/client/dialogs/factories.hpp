/*
Name: factories.hpp
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (13/07/2009)
Description: Dialogs for factorys
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

class DlgFactorySelect 
{
	idd = 1201;
	movingEnable = false;
	controlsBackground[] = { Background, ReqMatsBG, TypesBG, ItemDescBG, FactoryDescBG };
	objects[] = { };
	controls[] = { Title, ReqMats, TypesList, ItemDesc, ItemDescHeader, FactoryDesc, FactoryDescHeader, SelectButton, CloseButton };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Background : TNL_Background
	{
		x = 0.125;
		y = 0.045;
		w = 1.60;
		h = 1.10;
	};

	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.20;
		y = 0.09;
		w = 0.5;
		h = 0.1;
		Text = "Factory type select";
	};

	class ReqMatsBG : TNL_BackgroundFrame
	{
		x = 0.165;
		y = 0.18;
		w = 0.36;
		h = 0.30;
	};

	class TypesBG : TNL_BackgroundFrame
	{
		x = 0.56;
		y = 0.18;
		w = 0.36;
		h = 0.30;
	};

	class ItemDescBG : TNL_BackgroundFrame
	{
		x = 0.165;
		y = 0.48;
		w = 0.36;
		h = 0.32;
	};

	class FactoryDescBG : TNL_BackgroundFrame
	{
		x = 0.56;
		y = 0.48;
		w = 0.36;
		h = 0.32;
	};

	class ReqMats : TNL_List
	{
		idc = 2;
		x = 0.165;
		y = 0.18;
		w = 0.35;
		h = 0.36;
		sizeEx = 0.0295;
		onLBSelChanged  = "[(lbData[2, lbCurSel 2])] call TNL_ffact_ReqMaterialsListChange;";
	};

	class TypesList : TNL_List
	{
		idc = 1;
		x = 0.56;
		y = 0.18;
		w = 0.35;
		h = 0.30;
		sizeEx = 0.0295;
		onLBSelChanged  = "[(lbData[1, lbCurSel 1])] call TNL_ffact_TypesListChange;";
	};

	class ItemDescHeader : TNL_StructuredHeader
	{
		idc = 5;
		x = 0.170;
		y = 0.495;
		w = 0.35;
		h = 0.31;
		text = "";
	};

	class ItemDesc : TNL_StructuredText
	{
		idc = 6;
		x = 0.170;
		y = 0.535;
		w = 0.35;
		h = 0.31;
		text = "";
	};

	class FactoryDescHeader : TNL_StructuredHeader
	{
		idc = 3;
		x = 0.565;
		y = 0.495;
		w = 0.35;
		h = 0.31;
		text = "";
	};

	class FactoryDesc : TNL_StructuredText
	{
		idc = 4;
		x = 0.565;
		y = 0.535;
		w = 0.35;
		h = 0.31;
		text = "";
	};
	
	class SelectButton : TNL_Button
	{
		idc = 7;
		x = 0.170;
		y = 0.84;
		text = "Select";
		action = "";
	};

	class CloseButton : TNL_Button
	{
		idc = -1;
		x = 0.350;
		y = 0.84;
		text = "Close";
		action = "closeDialog 0;";
	};

};

class DlgFactoryMenu
{
	idd = 1202;
	movingEnable = false;
	controlsBackground[] = { Background, ListBG};
	objects[] = { };
	controls[] = { Title, List, UseBtn, CloseBtn };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Background : TNL_Background
	{
		x = 0.320;
		y = 0.085;
		w = 0.65;
		h = 0.75;
	};

	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.360;
		y = 0.1144;
		w = 0.5;
		h = 0.1;
		text = "Factory menu";
	};

	class List : TNL_List
	{
		idc = 1;
		x = 0.325;
		y = 0.16;
		w = 0.3315;
		h = 0.435;
	};
	
	class ListBG : TNL_BackgroundFrame
	{
		x = 0.325;
		y = 0.16;
		w = 0.3315;
		h = 0.450;
	};

	class UseBtn : TNL_SmallButton
	{
		idc = -1;
		x = 0.335;
		y = 0.635;
		text = "Select";
		action = "[(lbData[1,lbcurSel 1])] call TNL_ffact_factoryMenuSelect;";
	};

	class CloseBtn : TNL_SmallButton
	{
		idc = -1;
		x = 0.50;
		y = 0.635;
		text = "Close";
		action = "closeDialog 0;";
	};
};

class DlgFactoryRepair 
{
	idd = 1203;
	controlsBackground[] = { Background, ReqMatsBG, StorageBG, usersBG, RepairBG };
	objects[] = { };
	controls[] = { Title, ReqMats, StorageList, FirstName, LastName, Users, ActionsList, SelectButton, CloseButton, RepairButton, FactoryTypeText, EnoughMatsText, RequiredOnListText, StorageLockedText };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Background : TNL_Background
	{
		x = 0.125;
		y = 0.045;
		w = 1.60;
		h = 1.10;
	};

	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.20;
		y = 0.09;
		w = 0.5;
		h = 0.1;
		Text = "Factory Repair";
	};

	class ReqMatsBG : TNL_BackgroundFrame
	{
		x = 0.165;
		y = 0.18;
		w = 0.36;
		h = 0.30;
	};

	class StorageBG : TNL_BackgroundFrame
	{
		x = 0.56;
		y = 0.18;
		w = 0.36;
		h = 0.30;
	};

	class usersBG : TNL_BackgroundFrame
	{
		x = 0.165;
		y = 0.48;
		w = 0.36;
		h = 0.32;
	};

	class RepairBG : TNL_BackgroundFrame
	{
		x = 0.56;
		y = 0.48;
		w = 0.36;
		h = 0.32;
	};

	class ReqMats : TNL_List
	{
		idc = 2;
		x = 0.165;
		y = 0.18;
		w = 0.35;
		h = 0.29;
		sizeEx = 0.0295;
		onLBSelChanged  = "";
	};

	class StorageList : TNL_List
	{
		idc = 1;
		x = 0.56;
		y = 0.18;
		w = 0.35;
		h = 0.29;
		sizeEx = 0.0295;
		onLBSelChanged  = "";
	};

	class FirstName : TNL_Edit
	{
		idc = 7;
		x = 0.185;
		y = 0.50;
		w = 0.32;
		h = 0.04;
		text = "first name";
	};

	class LastName : TNL_Edit
	{
		idc = 8;
		x = 0.185;
		y = 0.55;
		w = 0.32;
		h = 0.04;
		text = "last name";
	};

	class Users : TNL_ComboBox
	{
		idc = 9;
		x = 0.185;
		y = 0.60;
		w = 0.32;
		h = 0.04;
	};

	class ActionsList : TNL_List
	{
		idc = 10;
		x = 0.185;
		y = 0.65;
		w = 0.32;
		h = 0.15;
		sizeEx = 0.0285;
	};

	class SelectButton : TNL_Button
	{
		idc = 7;
		x = 0.170;
		y = 0.84;
		text = "Select";
		action = "[(lbData[10, lbCurSel 10])] call TNL_ffact_repairFactorySelect;";	
	};

	class CloseButton : TNL_Button
	{
		idc = -1;
		x = 0.350;
		y = 0.84;
		text = "Close";
		action = "closeDialog 0;";
	};
	
	class RepairButton : TNL_Button
	{
		idc = 15;
		x = 0.535;
		y = 0.84;
		text = "Repair";
		action = "[TNL_gVar_obj_curSelFactory] spawn TNL_ffact_repairFactory;";
	};

	class FactoryTypeText : TNL_StructuredText
	{
		idc = 11;
		x = 0.57;
		y = 0.50;
		w = 0.32;
		h = 0.04;
		text = "Factory type:";
	};

	class EnoughMatsText : TNL_StructuredText
	{
		idc = 12;
		x = 0.57;
		y = 0.54;
		w = 0.32;
		h = 0.04;
		text = "Enough materials to repair: ";
	};

	class StorageLockedText : TNL_StructuredText
	{
		idc = 13;
		x = 0.57;
		y = 0.58;
		w = 0.32;
		h = 0.04;
		text = "Factory storage locked: ";
	};

	class RequiredOnListText : TNL_StructuredText
	{
		idc = 14;
		x = 0.57;
		y = 0.62;
		w = 0.32;
		h = 0.04;
		text = "Users required to be on list: ";
	};



};

class DlgFactoryManage 
{
	idd = 1204;
	controlsBackground[] = { Background, TL_Background, TR_Background, B_Background };
	objects[] = { };
	controls[] = { Title, TL_List, FirstName_EditBox, LastName_EditBox, AllowedUsers_Header, AllowedUsers_Combo, Actions_List, Select_Button, ManufactureCost_Text, CostForUsers_Text, Profit_Text, FactoryFunds_Text, Price_EditBox, CanManufacture_Text, Price_Header, B_Text, StorageLocked_Text, RequiredOnList_Text, ItemName_Text, FactoryLocked_Text };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Background : TNL_Background
	{
		x = 0.125;
		y = 0.045;
		w = 1.60;
		h = 1.10;
	};

	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.20;
		y = 0.09;
		w = 0.5;
		h = 0.1;
		Text = "Factory Management";
	};

	class TL_Background : TNL_BackgroundFrame
	{
		x = 0.165;
		y = 0.18;
		w = 0.36;
		h = 0.30;
	};

	class TR_Background : TNL_BackgroundFrame
	{
		x = 0.56;
		y = 0.18;
		w = 0.36;
		h = 0.30;
	};

	class B_Background : TNL_BackgroundFrame
	{
		x = 0.165;
		y = 0.49;
		w = 0.755;
		h = 0.32;
	};

	class TL_List : TNL_List
	{
		idc = 2;
		x = 0.165;
		y = 0.18;
		w = 0.35;
		h = 0.29;
		sizeEx = 0.0295;
		onLBSelChanged  = "[(lbData[2,lbCurSel 2])] call TNL_ffact_managementItemsSelectionChanged;";
	};

	class FirstName_EditBox : TNL_Edit
	{
		idc = 14;
		x = 0.185;
		y = 0.535;
		w = 0.20;
		h = 0.04;
		text = "first name";
	};

	class LastName_EditBox : TNL_Edit
	{
		idc = 15;
		x = 0.405;
		y = 0.535;
		w = 0.20;
		h = 0.04;
		text = "last name";
	};

	class AllowedUsers_Header : TNL_StructuredText 
	{
		idc = -1;
		x = 0.1825;
		y = 0.59;
		w = 0.225;
		h = 0.08;
		text = "<t color='#ffcc00'>Users allowed to access storage:</t> ";
	};

	class AllowedUsers_Combo : TNL_ComboBox
	{
		idc = 5;
		x = 0.405;
		y = 0.60;
		w = 0.20;
		h = 0.04;
	};

	/*
	class Funds_Header : TNL_StructuredText
	{
		idc = -1;
		x = 0.1825;
		y = 0.66;
		w = 0.225;
		h = 0.08;
		text = "<t color='#ffcc00'>Amount of funds to add/remove:</t>";
	};

	class Funds_EditBox : TNL_Edit
	{
		idc = 16;
		x = 0.405;
		y = 0.66;
		w = 0.20;
		h = 0.04;
		text = "0";
	};
	*/

	class Actions_List : TNL_List
	{
		idc = 1;
		x = 0.56;
		y = 0.1875;
		w = 0.35;
		h = 0.215;
		sizeEx = 0.0295;
		onLBSelChanged  = "";
	};

	class Select_Button : TNL_SmallButton
	{
		idc = -1;
		x = 0.57;
		y = 0.425;
		text = "Select";
		action = "[(lbData[1,lbCurSel 1])] call TNL_ffact_managementActionsSelect;";
	};

	class ItemName_Text : TNL_StructuredText
	{
		idc = 12;
		x = 0.62;
		y = 0.505;
		w = 0.50;
		h = 0.08;
		text = "<t color='#ffcc00'>Item name:</t> ";
	};

	class ManufactureCost_Text : TNL_StructuredText
	{
		idc = 6;
		x = 0.62;
		y = 0.535;
		w = 0.50;
		h = 0.08;
		text = "<t color='#ffcc00'>Manufacture Cost:</t> ";
	};

	class CostForUsers_Text : TNL_StructuredText
	{
		idc = 7;
		x = 0.62;
		y = 0.565;
		w = 0.50;
		h = 0.08;
		text = "<t color='#ffcc00'>Cost for users:</t> ";
	};

	class Profit_Text : TNL_structuredText
	{
		idc = 8;
		x = 0.62;
		y = 0.595;
		w = 0.50;
		h = 0.08;
		text = "<t color='#ffcc00'>Profit:</t> ";
	};

	class FactoryFunds_Text : TNL_structuredText
	{
		idc = 3;
		x = 0.62;
		y = 0.625;
		w = 0.50;
		h = 0.08;
		text = "<t color='#ffcc00'>Factory funds:</t> ";
	};

	class CanManufacture_Text : TNL_structuredText
	{
		idc = 9;
		x = 0.62;
		y = 0.655;
		w = 0.50;
		h = 0.08;
		text = "<t color='#ffcc00'>Users can manufacture:</t> ";
	};	
	class StorageLocked_Text : TNL_structuredText
	{
		idc = 10;
		x = 0.62;
		y = 0.685;
		w = 0.50;
		h = 0.08;
		text = "<t color='#ffcc00'>Storage locked:</t> ";
	};

	class RequiredOnList_Text : TNL_structuredText
	{
		idc = 11;
		x = 0.62;
		y = 0.715;
		w = 0.50;
		h = 0.08;
		text = "<t color='#ffcc00'>Required to be on list:</t> ";
	};

	class FactoryLocked_Text : TNL_structuredText
	{
		idc = 17;
		x = 0.62;
		y = 0.745;
		w = 0.50;
		h = 0.08;
		text = "<t color='#ffcc00'>Factory locked:</t> ";
	};



	class Price_EditBox : TNL_edit
	{
		idc = 13;
		x = 0.405;
		y = 0.7275;
		w = 0.20;
		h = 0.04;
		text = "0";
	};

	class Price_Header : TNL_structuredText
	{
		x = 0.1825;
		y = 0.7275;
		w = 0.225;
		h = 0.08;
		text = "<t color='#ffcc00'>Price for the user to manufacture item:</t> ";
	};

	class B_Text : TNL_StructuredText
	{
		idc = 4;
		x = 0.18;
		y = 0.866;
		w = 0.85;
		h = 0.08;
		text = "Factory Type:	|	Factory Funds:	|	Money:";
	};
};

class DlgFactoryManufacture 
{
	idd = 1205;
	controlsBackground[] = { Background, TL_Background, TR_Background, BL_Background, BR_Background };
	objects[] = { };
	controls[] = { Title, AmountEdit, ManufactureBtn, LocalStorageBtn, FactStorageBtn, TL_List, TR_List, ManufactureText, PriceEa, TotalPrice,
	WeightEa, TotalWeight, CanManufacture, EnoughFundsManufacture, ItemName, TotalRequired, AmountInStorage, BText };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
		
	class Background : TNL_Background
	{
		x = 0.125;
		y = 0.045;
		w = 1.60;
		h = 1.10;
	};

	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.20;
		y = 0.09;
		w = 0.5;
		h = 0.1;
		text = "Factory Manufacture";
	};

	class TL_Background : TNL_BackgroundFrame
	{
		x = 0.165;
		y = 0.18;
		w = 0.36;
		h = 0.30;
	};

	class TR_Background : TNL_BackgroundFrame
	{
		x = 0.56;
		y = 0.18;
		w = 0.36;
		h = 0.30;
	};

	class BL_Background : TNL_BackgroundFrame
	{
		x = 0.165;
		y = 0.49;
		w = 0.50;
		h = 0.32;
	};

	class BR_Background : TNL_BackgroundFrame
	{
		x = 0.675;
		y = 0.49;
		w = 0.2465;
		h = 0.32;
	};

	class AmountEdit : TNL_Edit
	{
		idc = 14;
		x = 0.6875;
		y = 0.515;
		w = 0.22;
		h = 0.04;
		text = "1";
		onKeyUp  = "[(lbData[1,lbCurSel 1])] call TNL_ffact_manufactureUpdateReqMats;";
	};

	class ManufactureBtn : TNL_SmallButton
	{
		idc = -1;
		x = 0.6875;
		y = 0.58;
		w = 0.216825;
		text = "Manufacture";
		action = "[TNL_gVar_obj_curSelFactory, (lbData[1,lbCurSel 1])] call TNL_ffact_manufacture;";
	};

	class LocalStorageBtn : TNL_SmallButton
	{
		idc = -1;
		x = 0.6875;
		y = 0.63;
		w = 0.216825;
		text = "Private Storage";
		action = "TNL_gVar_fact_curStorage = ""local""; [TNL_gVar_obj_curSelFactory] call TNL_ffact_loadManufacture; [(lbData[1,lbCurSel 1])] call TNL_ffact_manufactureUpdateReqMats;";
	};

	class FactStorageBtn : TNL_SmallButton
	{
		idc = -1;
		x = 0.6875;
		y = 0.68;
		w = 0.216825;
		text = "Factory Storage";
		action = "TNL_gVar_fact_curStorage = ""public""; [TNL_gVar_obj_curSelFactory] call TNL_ffact_loadManufacture; [(lbData[1,lbCurSel 1])] call TNL_ffact_manufactureUpdateReqMats;";
	};

	class TL_List : TNL_List
	{
		idc = 1;
		x = 0.165;
		y = 0.18;
		w = 0.35;
		h = 0.29;
		sizeEx = 0.0295;
		onLBSelChanged  = "[(lbData[1,lbCurSel 1])] call TNL_ffact_manufactureUpdateReqMats;";
	};

	class TR_List : TNL_List
	{
		idc = 2;
		x = 0.56;
		y = 0.18;
		w = 0.35;
		h = 0.29;
		sizeEx = 0.0295;
		onLBSelChanged  = "[(call compile (lbData[2,lbCurSel 2]))] call TNL_ffact_manufactureUpdate;";
	};


	class ItemName : TNL_structuredText
	{
		idc = 4;
		x = 0.18;
		y = 0.50;
		w = 0.85;
		h = 0.08;
		text = "Item name:";
	}

	class TotalRequired : TNL_structuredText
	{
		idc = 5;
		x = 0.18;
		y = 0.530;
		w = 0.85;
		h = 0.08;
		text = "Total required:";
	}

	class AmountInStorage : TNL_structuredText
	{
		idc = 6;
		x = 0.18;
		y = 0.560;
		w = 0.85;
		h = 0.08;
		text = "Amount in storage:";
	}
	
	class ManufactureText : TNL_structuredText
	{
		idc = 7;
		x = 0.18;
		y = 0.590;
		w = 0.85;
		h = 0.08;
		text = "Manufacture cost:";
	};

	class PriceEa : TNL_structuredText
	{
		idc = 8;
		x = 0.18;
		y = 0.620;
		w = 0.85;
		h = 0.08;
		text = "Price each:";
	};

	class TotalPrice : TNL_StructuredText
	{
		idc = 9;
		x = 0.18;
		y = 0.650;
		w = 0.85;
		h = 0.08;
		text = "Total price:";
	};

	class WeightEa : TNL_structuredText
	{
		idc = 10;
		x = 0.18;
		y = 0.680;
		w = 0.85;
		h = 0.08;
		text = "Weight each:";
	};

	class TotalWeight : TNL_structuredText
	{
		idc = 11;
		x = 0.18;
		y = 0.710;
		w = 0.85;
		h = 0.08;
		text = "Total weight:";
	};

	class CanManufacture : TNL_StructuredText
	{
		idc = 12;
		x = 0.18;
		y = 0.740;
		w = 0.85;
		h = 0.08;
		text = "Can manufacture:";
	};

	class EnoughFundsManufacture : TNL_structuredText
	{
		idc = 13;
		x = 0.18;
		y = 0.770;
		w = 0.85;
		h = 0.08;
		text = "Enough funds to manufacture:";
	};

	class BText : TNL_structuredText
	{
		idc = 3;
		x = 0.18;
		y = 0.866;
		w = 0.55;
		h = 0.08;
		text = "Factory Type:	|	Current Storage:	|	Factory Funds:	|	Money:";
	};
};