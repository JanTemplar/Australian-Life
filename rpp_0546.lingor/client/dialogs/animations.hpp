/*
Name: animations.hpp
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (25/06/2009)
Description: Dialogs for animations
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

class DlgAnimations
{
	idd = -1;
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
		text = "Animations";
	};

	class List : TNL_List
	{
		idc = 1;
		x = 0.325;
		y = 0.16;
		w = 0.32;
		h = 0.44;
		sizeEx = 0.028;
	};
	
	class ListBG : TNL_BackgroundFrame
	{
		x = 0.325;
		y = 0.16;
		w = 0.3315;
		h = 0.4675;
	};

	class UseBtn : TNL_SmallButton
	{
		idc = -1;
		x = 0.335;
		y = 0.635;
		text = "Select";
		action = "[call compile (lbData[1,lbCurSel 1])] call TNL_fanim_selectAnimation;";
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
