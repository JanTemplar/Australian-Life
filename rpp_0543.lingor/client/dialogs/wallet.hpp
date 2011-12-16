/*
Name: inventory.hpp
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (06/06/2009)
Description: Dialogs for inventory
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

class DlgWallet 
{
	idd = 701;
	movingEnable = false;
	controlsBackground[] = {  Background, ItemListBG, ActionsBG, ItemInfoBG, BackgroundFade};
	objects[] = { };
	controls[] = { Title, ItemList, ItemName, ItemInfo, UseButton, DropButton, CloseButton };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Background : TNL_Background0
	{
		x = 0.125;
		y = 0.155;
		w = 0.88;
		h = 0.9;
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
		idc = -1;
		x = 0.20;
		y = 0.19;
		Text = "Wallet";
	};

	
	class ItemList : TNL_List
	{
		idc = 1;
		x = 0.165;
		y = 0.30;
		w = 0.31;
		h = 0.44;
		sizeEx = 0.0295;
		onLBSelChanged  = "[1] call TNL_fwallet_updateDisplay;";
	};

	class ItemListBG : TNL_BackgroundFrame
	{
		x = 0.165;
		y = 0.29;
		w = 0.32;
		h = 0.46;
	};

	class ItemInfoBG : ItemListBG
	{
		x = 0.50;
		w = 0.42;
		h = 0.35;
	};

	class ItemName : TNL_StructuredHeader
	{
		idc = 2;
		x = 0.5095;
		y = 0.31;
		w = 0.8;
		size = 0.035;
		Text = "";
	};
	
	class ItemInfo : TNL_StructuredText
	{
		idc = 3;
		x = 0.5095;
		y = 0.35;
		w = 0.385;
		h = 0.32;
	};

	class ActionsBG : ItemListBG
	{
		y = 0.65;
		h = 0.10;
	};

	class UseButton : TNL_Button
	{
		idc = -1;
		x = 0.52;
		y = 0.65;
		text = "View";
		action = "[(call compile (lbData[1,(lbCurSel 1)]))] call TNL_fwallet_viewItem;";
	};

	class DropButton : UseButton
	{
		idc = -1;
		x = 0.72;
		text = "Give";
		action = "[(call compile (lbData[1,(lbCurSel 1)]))] call TNL_fwallet_giveItem;";
	};

	class CloseButton : TNL_Button
	{
		idc = -1;
		x = 0.75;
		y = 0.16;
		text = "Close";
		action = "closeDialog 0;";
	};
};