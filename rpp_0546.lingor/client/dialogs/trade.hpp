/*
Name: trade.hpp
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (19/06/2009)
Description: Dialogs for trading
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

class DlgTrade
{
	idd = -1;
	movingEnable = false;
	controlsBackground[] = {  Background, ItemListBG, ActionsBG, PlayerInfoBG };
	objects[] = { };
	controls[] = { Title, ItemList, StatusText, StatusItemInfo, playerName, Weight, WeightAfter, CanAccept, Amount, GiveBtn, CloseBtn };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Title : TNL_Title2
	{
		idc = 1;
		x = 0.20;
		y = 0.0885;
		w = 0.5;
		h = 0.1;
		Text = "Trade Menu";
	};

	class ItemList : TNL_List
	{
		idc = 2;
		x = 0.165;
		y = 0.18;
		w = 0.32;
		h = 0.61;
		sizeEx = 0.0295;
		onLBSelChanged  = "[(call compile (lbData[2,lbcurSel 2]))] call TNL_ftrade_updateDisplay;";
	};

	class Background : TNL_Background
	{
		x = 0.125;
		y = 0.045;
		w = 1.60;
		h = 1.10;
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

	class PlayerInfoBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.50;
		y = 0.46;
		w = 0.42;
		h = 0.331;
	};

	class StatusText : TNL_Text
	{
		idc = 3;
		x = 0.18;
		y = 0.84;
		w = 0.640;
		h = 0.05;
		Text = "Money: 0Ц |  Weight: 0kg	";
		sizeEx = 0.028;
	};

	class StatusItemInfo : TNL_Text
	{
		idc = 4;
		x = 0.18;
		y = 0.88;
		w = 0.640;
		h = 0.05;
		text = "Item name: NoName  |  Item amount: 0  |  Item weight: 0/0kg";
		sizeEx = 0.028;
	};

	class PlayerName : TNL_Text
	{
		idc = 5;
		x = 0.50;
		y = 0.18;
		w = 0.640;
		h = 0.05;
		text = "Trading With: ";
	};

	class Weight : TNL_Text
	{
		idc = 6;
		x = 0.50;
		y = 0.21;
		w = 0.640;
		h = 0.05;
		text = "Weight: ";
	};

	class WeightAfter : TNL_Text
	{
		idc = 7;
		x = 0.50;
		y = 0.24;
		w = 0.640;
		h = 0.05;
		text = "Weight after: ";
	};

	class CanAccept : TNL_Text
	{
		idc = 8;
		x = 0.50;
		y = 0.27;
		w = 0.640;
		h = 0.05;
		text = "Able to receive items: ";
	};

	class Amount : TNL_Edit
	{
		idc = 9;
		x = 0.52;
		y = 0.71;
		w = 0.382;
		h = 0.0565;
		text = "1";
		onKeyUp  = "[(call compile (lbData[2,lbcurSel 2]))] call TNL_ftrade_updateDisplay;";
	};

	class GiveBtn : TNL_Button
	{
		idc = -1;
		x = 0.52;
		y = 0.63;
		text = "Give";
		action = "[(call compile (lbData[2,lbcurSel 2]))] spawn TNL_ftrade_transferItem;";
	};

	class CloseBtn : TNL_Button
	{
		idc = -1;
		x = 0.72;
		y = 0.63;
		text = "Close";
		action = "closeDialog 0;";
	};

};