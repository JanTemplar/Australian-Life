/*
Name: licenses.hpp
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (08/06/2009)
Description: Dialog for the flying treesss!!!!!!! just kidding, just licenses..
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

class DlgLicenses 
{
	idd = 901;
	movingEnable = false;
	controlsBackground[] = { Background, LicListBG, LicDescBG };
	objects[] = { };
	controls[] = { Title, LicList, LicName, LicDesc, PurchaseBTN, CloseBTN, StatusText };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Background : TNL_Background
	{
		x = 0.165;
		y = 0.055;
		w = 1.10;
		h = 1.10;
	};

	class Title : TNL_Title2
	{
		idc = 26;
		x = 0.215;
		y = 0.1;
		w = 0.5;
		h = 0.1;
		Text = "Licenses:";
	};

	class LicList : TNL_List
	{
		idc = 25;
		x = 0.195;
		y = 0.185;
		w = 0.5125;
		h = 0.300;
		sizeEx = 0.0295;
		onLBselChanged = "[lbData[25,lbCurSel 25]] call TNL_flic_updateDesc;";
	};

	class LicListBG : TNL_BackgroundFrame
	{
		x = 0.195;
		y = 0.185;
		w = 0.5125;
		h = 0.300;
	};

	class LicDescBG : TNL_BackgroundFrame
	{
		x = 0.195;
		y = 0.4985;
		w = 0.5125;
		h = 0.31715;
	};

	class LicName : TNL_StructuredHeader
	{
		idc = 29;
		x = 0.2;
		y = 0.51;
		w = 0.5275690;
		h = 0.315;
		size = 0.035;
		Text = "";
	};
	class LicDesc : TNL_StructuredText
	{
		idc = 28;
		x = 0.2;
		y = 0.54;
		w = 0.51;
		h = 0.315;
		Text = "";
	};

	class PurchaseBTN : TNL_Button
	{
		idc = -1;
		x = 0.208;
		y = 0.7285;
		text = "Purchase";
		action = "[(lbData[25,lbCurSel 25])] call TNL_flic_purchaseLicense";
	};

	class CloseBTN : TNL_Button
	{
		idc = -1;
		x = 0.515;
		y = 0.7285;
		text = "Close";
		action = "closeDialog 0;";
	};

	class StatusText : TNL_Text
	{
		idc = 27;
		x = 0.18;
		y = 0.85;
		w = 0.640;
		h = 0.05;
		text = "Money:  |  # Owned licenses:  | Available licenses: ";
		sizeEx = 0.029;
	};
};