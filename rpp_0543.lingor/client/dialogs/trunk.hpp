/*
Name: trunk.hpp
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (12/06/2009)
Description: Dialogs for the vehicle trunks
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

class DlgTrunk
{
	idd = 1001;
	movingEnable = false;
	controlsBackground[] = { Background, LStorageBG, RStorageBG, ControlsBG };
	objects[] = { };
	controls[] = { Title, LStorageList, RStorageList, Amount, TransferTo, TransferFrom, Change, Close, DetailsLeftSide, DetailsRightSide };
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
		Text = "Trunk";
	};

	class LStorageList : TNL_List
	{
		idc = 2;
		x = 0.165;
		y = 0.18;
		w = 0.36;
		h = 0.40;
		sizeEx = 0.0295;
	};

	class LStorageBG : TNL_BackgroundFrame
	{
		x = 0.165;
		y = 0.18;
		w = 0.36;
		h = 0.40;
	};

	class RStorageList : TNL_List
	{
		idc = 3;
		x = 0.56;
		y = 0.18;
		w = 0.36;
		h = 0.40;
		sizeEx = 0.0295;
	};

	class RStorageBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.56;
		y = 0.18;
		w = 0.36;
		h = 0.40;
	};

	class ControlsBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.165;
		y = 0.59;
		w = 0.755;
		h = 0.22;
	};

	class Amount : TNL_Edit
	{
		idc = 4;
		x = 0.440;
		y = 0.61;
		w = 0.2;
		h = 0.057;
		text = "1";
	};

	class TransferTo : TNL_Button
	{
		idc = -1;
		x = 0.2;
		y = 0.595;
		text = "Take";
		action = "[call compile lbData[2, lbCurSel 2],4] call TNL_ftrunk_takeItem;";
	};

	class TransferFrom : TNL_Button
	{
		idc = -1;
		x = 0.7;
		y = 0.595;
		text = "Drop ";
		action = "[call compile lbData[3,lbCurSel 3],4] call TNL_ftrunk_dropItem;";
	};

	class Change : TNL_Button
	{
		idc = -1;
		x = 0.2;
		y = 0.67;
		text = "Change";
		action = "[] call TNL_ftrunk_openChangeDialog;";
	};

	class Close : TNL_Button
	{
		idc = -1;
		x = 0.7;
		y = 0.67;
		text = "Close";
		action = "closeDialog 0;";
	};

	class DetailsLeftSide : TNL_Text
	{
		idc = 5;
		x = 0.18;
		y = 0.84;
		text = "Left Storage Weight: 0/0kg | Weight After: 0/0kg"; 
	};

	class DetailsRightSide : TNL_Text
	{
		idc = 6;
		x = 0.18;
		y = 0.88;
		text = "Right Storage Weight: 0/0kg | Weight After: 0/0kg";
	};

};

class DlgTrunkChange 
{
	idd = 1002;
	movingEnable = false;
	controlsBackground[] = { Background, ListBG };
	objects[] = { };
	controls[] = { Title, Found, List, Change };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Background : TNL_Background
	{
		x = 0.195;
		y = 0.085;
		w = 0.85;
		h = 0.90;
	};

	class Title : TNL_Title
	{
		idc = -1;
		x = 0.240;
		y = 0.086;
		w = 0.5;
		h = 0.1;
		Text = "Change";
	};

	class ListBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.2225;
		y = 0.185;
		w = 0.390;
		h = 0.515;
	};

	class Found : TNL_Text
	{
		idc = 2;
		x = 0.235;
		y = 0.725;
		w = 0.5;
		h = 0.1;
		text = "Found: ";
		sizeEx = 0.034;
	};

	class List : TNL_List
	{
		idc = 1;
		x = 0.2225;
		y = 0.185;
		w = 0.390;
		h = 0.515;
	};

	class Change : TNL_Button
	{
		idc = -1;
		x = 0.4;
		y = 0.725;
		text = "Select";
		action = "[format[""%1"", (lbData[1,lbCurSel 1])]] spawn TNL_ftrunk_changeTrunk;";
	};
};
