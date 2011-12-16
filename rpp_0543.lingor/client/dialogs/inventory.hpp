/*
Name: inventory.hpp
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (06/06/2009)
Description: Dialogs for inventory
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

class DlgInventory 
{
	idd = 001;
	movingEnable = true;
	controlsBackground[] = {  Background, ItemListBG, ActionsBG, ItemInfoBG};
	objects[] = { };
	controls[] = { invButton, Title, ItemList, StatusText, StatusItemInfo, ItemName, ItemInfo, UseButton, DropButton, CloseButton, AmountEdit };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	
	class Background : TNL_Background0
	{
		x = 0.125;
		y = 0.045;
		w = 0.88;
		h = 1.10;
	};
	class invButton : TNL_Button
	{
		idc = -1;
		x = 0.13;
		y = 0.02;
		h = 0.19;
		w = 0.30;
		text = "Inventory";
		action = "closeDialog 0;";
		
		class TextPos
		{
			left = 0.05;
			top = 0.07;
			right = 0.005;
			bottom = 0.005;
		};
		size = 0.043;
		font = "Zeppelin33";
		color[] = {0.6, 0.5, 0, 1};
		color2[] = {0.6, 0.5, 0, 1};
		colorDisabled[] = {1, 0.8, 0, 1};
		class Attributes 
		{
			font = "Zeppelin33";
			color = "#ffcc00";
			align = "left";
			shadow = "true";
		};
	};
	
	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.720;
		y = 0.09;
		w = 0.5;
		h = 0.1;
		Text = "Inventory";
	};

	
	class ItemList : TNL_List
	{
		idc = 20;
		x = 0.165;
		y = 0.18;
		w = 0.32;
		h = 0.61;
		sizeEx = 0.0295;
		onLBSelChanged  = "[20, (findDisplay 001) displayCtrl 23] call TNL_finv_updateDisplay;";
	};

	class ItemListBG : TNL_BackgroundFrame
	{
		x = 0.165;
		y = 0.18;
		w = 0.32;
		h = 0.61;
	};

	class ActionsBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.50;
		y = 0.18;
		w = 0.42;
		h = 0.27;
	};

	class ItemInfoBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.50;
		y = 0.46;
		w = 0.42;
		h = 0.331;
	};

	class StatusText : TNL_Text
	{
		idc = 21;
		x = 0.18;
		y = 0.84;
		w = 0.640;
		h = 0.05;
		Text = "Money: 0Ц |  Weight: 0kg	";
		sizeEx = 0.028;
	};

	class StatusItemInfo : TNL_Text
	{
		idc = 22;
		x = 0.18;
		y = 0.88;
		w = 0.640;
		h = 0.05;
		text = "Item name: NoName  |  Item amount: 0  |  Item weight: 0/0kg";
		sizeEx = 0.028;
	};

	class ItemName : TNL_StructuredHeader
	{
		idc = 23;
		x = 0.5095;
		y = 0.49;
		w = 0.385;
		h = 0.315;
		Text = "";
	};
	class ItemInfo : TNL_StructuredText
	{
		idc = 25;
		x = 0.5095;
		y = 0.53;
		w = 0.385;
		h = 0.315;
		Text = "";
	};

	class UseButton : TNL_Button
	{
		idc = -1;
		x = 0.52;
		y = 0.19;
		text = "Use";
		action = "[((call compile (lbData[20,(lbCurSel 20)])) select 0),[(parseNumber ctrlText 24)]] call TNL_finv_useItem;";
	};

	class DropButton : TNL_Button
	{
		idc = -1;
		x = 0.72;
		y = 0.19;
		text = "Drop";
		action = "[((call compile (lbData[20,(lbCurSel 20)])) select 0), [(parseNumber ctrlText 24)]] call TNL_finv_dropItem;";
	};

	class CloseButton : TNL_Button
	{
		idc = -1;
		x = 0.52;
		y = 0.26;
		text = "Close";
		action = "closeDialog 0;";
	};

	class AmountEdit : TNL_Edit
	{
		idc = 24;
		x = 0.52;
		y = 0.355;
		w = 0.25;
		h = 0.0565;
		text = "1";
	};
};