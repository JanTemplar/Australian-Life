/*
Name: vehicleMenu.hpp.hpp
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (15/06/2009)
Description: Dialogs for the vehicle menu
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

class DlgVclMenu
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

	class Title : TNL_Title
	{
		idc = -1;
		x = 0.360;
		y = 0.0844;
		w = 0.5;
		h = 0.1;
		text = "Vehicle menu";
	};

	class List : TNL_List
	{
		idc = 1;
		x = 0.325;
		y = 0.16;
		w = 0.3315;
		h = 0.4675;
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
		action = "[(call compile lbData[1,lbCurSel 1])] call TNL_fvcl_menuSelect;";
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
