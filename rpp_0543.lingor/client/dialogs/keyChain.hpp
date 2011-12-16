/*
Name: keyChain.hpp
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (16/06/2009)
Description: Dialogs for the keychain
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

class DlgKeyChain 
{
	idd = -1;
	movingEnable = false;
	controlsBackground[] = { Background, KeyListBG, ButtonBG, BackgroundFade };
	objects[] = { };
	controls[] = { Title, KeyList, ActionList, SelectBtn, DropBtn, CloseBtn };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Background : TNL_Background
	{
		x = 0.125;
		y = 0.155;
		w = 1.475;
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
		y = 0.1885;
		w = 0.5;
		h = 0.1;
		Text = "Key chain";
	};

	class KeyList : TNL_List 
	{
		idc = 1;
		x = 0.165;
		y = 0.30;
		w = 0.31;
		h = 0.44;
		sizeEx = 0.0295;
		onLBSelChanged  = "[] spawn TNL_fkeychain_updateDisplay;";
	};

	class KeyListBG : TNL_BackgroundFrame
	{
		x = 0.165;
		y = 0.29;
		w = 0.32;
		h = 0.46;
	};

	class ButtonBG : TNL_BackgroundFrame
	{
		x = 0.525;
		y = 0.29;
		w = 0.32;
		h = 0.46;
	};

	class ActionList : TNL_List
	{
		idc = 2;
		x = 0.525;
		y = 0.30;
		w = 0.31;
		h = 0.43;
		sizeEx = 0.0295;
	};

	class SelectBTN : TNL_Button
	{
		idc = -1;
		x = 0.165;
		y = 0.80;
		text = "Select";
		action = "[call compile (lbData[1,lbCurSel 1]), call compile (lbData[2,lbCurSel 2])] call TNL_fkeychain_select;";
	};

	class DropBtn : TNL_Button
	{
		idc = -1;
		x = 0.365;
		y = 0.80;
		text = "Drop";
		action = "[(call compile (lbData[1,lbCurSel 1]) select 2)] call TNL_fkeychain_dropKey;";
	};

	class CloseBtn : TNL_Button
	{
		idc = -1;
		x = 0.565;
		y = 0.80;
		text = "Close";
		action = "closeDialog 0;";
	};

};