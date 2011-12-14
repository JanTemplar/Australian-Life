/*
Name: shops.hpp
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (29/05/2009)
Description: Dialogs for shops
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

class TNL_DlgShop
{
	idd = 801;	
	movingEnable = false;
	controlsBackground[] = { Background, DetailsFrame, PurchaseListBG, InventoryListBG};
	objects[] = { };
	controls[] = { PurchaseList, Title, InventoryList, StatusText, BuyButton, SellButton, ItemName, ItemInfo, CloseButton };
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
		idc = 1;
		x = 0.20;
		y = 0.09;
		w = 0.5;
		h = 0.1;
		Text = "Shop Name";
	};

	class PurchaseList : TNL_List
	{
		idc = 2;
		x = 0.165;
		y = 0.18;
		w = 0.32;
		h = 0.61;
		sizeEx = 0.0295;
		onLBSelChanged  = "[2] call SBAY_fShops_UpdateDescription;";

	};

	class PurchaseListBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.165;
		y = 0.18;
		w = 0.32;
		h = 0.61;
	};

	class InventoryList : TNL_List
	{
		idc = 3;
		x = 0.50;
		y = 0.18;
		w = 0.42;
		h = 0.27;
		sizeEx = 0.0295;

	};

	class InventoryListBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.50;
		y = 0.18;
		w = 0.42;
		h = 0.27;
	};

	class DetailsFrame : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.50;
		y = 0.46;
		w = 0.42;
		h = 0.331;
	};


	class StatusText : TNL_Text
	{
		idc = 4;
		x = 0.18;
		y = 0.86;
		w = 0.900;
		h = 0.05;
		Text = "Money:	|	Weight:		|	Opening Time:	| Closing Time:		|";
		sizeEx = 0.03;
	};

	class BuyButton : TNL_Button
	{
		idc = 25;
		x = 0.515;
		y = 0.71;
		Text = "Purchase";
		Action = "[2] call SBAY_fShops_OpenPurchaseDialog";
	};

	class SellButton : TNL_Button
	{
		idc = 26;
		x = 0.725;
		y = 0.71;
		Text = "Sell";
		Action = "[3] call SBAY_fShops_OpenSellDialog";
	};

	class ItemName : TNL_StructuredHeader
	{
		idc = 6;
		x = 0.5095;
		y = 0.47;
		w = 0.385;
		h = 0.315;
		Text = "";
	};
	class ItemInfo : TNL_StructuredText
	{
		idc = 5;
		x = 0.5095;
		y = 0.51;
		w = 0.385;
		h = 0.315;
		Text = "";
	};

	class CloseButton : TNL_Button
	{
		idc = -1;
		x = 0.75;
		y = 0.06;
		text = "Close";
		action = "closeDialog 0;";
	};
};

class TNL_DlgPurchase 
{
	idd = 802;	
	movingEnable = false;
	controlsBackground[] = { Background, DetailsFrame, BackgroundFade };
	objects[] = { };
	controls[] = { Title, ItemName, AmountBox, PurchaseButton, BackButton, PriceEa, TotalPrice, WeightEa, TotalWeight, Money, MoneyAfter, Weight, WeightAfter, 
	HaveLicense };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";


	class Background : TNL_Background
	{
		x = 0.190;
		y = 0.155;
		w = 1.05;
		h = 0.85;
	};
	
	class BackgroundFade : TNL_Background
	{
		x = 0.125;
		y = 0.045;
		w = 1.60;
		h = 1.10;
		colorText[] = {1, 1, 1, 0.5};
	};

	class Title : TNL_Title2
	{
		idc = 6;
		x = 0.24;
		y = 0.185;
		w = 0.5;
		h = 0.1;
		Text = "";
	};

	class ItemName : TNL_Text
	{
		idc = 7;
		x = 0.24;
		y = 0.24;
		w = 0.4;
		h = 0.1;
		sizeEx = 0.037;
		text = "";
	};

	class AmountBox : TNL_Edit
	{
		idc = 13;
		x = 0.24;
		y = 0.325;
		w = 0.4;
		h = 0.065;
		text = "1";
		onKeyUp  = "[13] call SBAY_fShops_UpdatePurchaseTotals";
	};

	class PurchaseButton : TNL_Button
	{
		idc = 8;
		x = 0.24;
		y = 0.37;
		text = "Buy/Sell";
	};

	class BackButton : TNL_Button
	{
		idc = -1;
		x = 0.445;
		y = 0.37;
		text = "Back";
		action = "closeDialog 0;";
	};

	class DetailsFrame : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.24;
		y = 0.455;
		w = 0.440;
		h = 0.29;
	};

	class PriceEa : TNL_Text
	{
		idc = 9;
		x = 0.25;
		y = 0.455;
		w = 0.4;
		h = 0.1;
		text = "Price ea:";
	};

	class TotalPrice : TNL_Text
	{
		idc = 11;
		x = 0.45;
		y = 0.455;
		w = 0.4;
		h = 0.1;
		text = "Total price: ";
	};

	class WeightEa : TNL_Text
	{
		idc = 10;
		x = 0.25;
		y = 0.480;
		w = 0.4;
		h = 0.1;
		text = "Weight ea:";
	};

	class TotalWeight : TNL_Text
	{
		idc = 12;
		x = 0.45;
		y = 0.480;
		w = 0.4;
		h = 0.1;
		text = "Total weight: ";
	};

	class Money : TNL_Text
	{
		idc = 15;
		x = 0.25;
		y = 0.540;
		w = 0.4;
		h = 0.1;
		text = "Money: ";
	};

	class MoneyAfter : TNL_Text
	{
		idc = 16;
		x = 0.45;
		y = 0.540;
		w = 0.4;
		h = 0.1;
		text = "Money after: ";
	};

	class Weight : TNL_Text
	{
		idc = 17;
		x = 0.25;
		y = 0.565;
		w = 0.4;
		h = 0.1;
		text = "Weight: ";
	};

	class WeightAfter : TNL_Text
	{
		idc = 18;
		x = 0.45;
		y = 0.565;
		w = 0.4;
		h = 0.1;
		text = "Weight after: ";
	};

	class HaveLicense : TNL_Text
	{
		idc = 14;
		x = 0.25;
		y = 0.620;
		w = 0.4;
		h = 0.1;
		text = "Have required license(s): ";
	};
};
