/*
Name: atm.hpp
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (06/07/2009)
Description: Dialogs for ATMs
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

class atmInsertCard 
{
	idd = 601;
	movingEnable = false;
	controlsBackground[] = {  Background, cardsListBG, ActionsBG};
	objects[] = { };
	controls[] = { Title, cardsList, cardsText, UseButton, CloseButton, bankNameText, infoText };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";

	class Background : TNL_Background0
	{
		x = 0.125;
		y = 0.155;
		w = 0.88;
		h = 0.80;
	};

	class Title : TNL_Title2
	{
		idc = 11;
		x = 0.20;
		y = 0.18;
		w = 0.5;
		h = 0.1;
		text = $STRS_atm_titleInsert;
	};

	class cardsList : TNL_List
	{
		idc = 1;
		x = 0.165;
		y = 0.34;
		w = 0.31;
		h = 0.30;
		sizeEx = 0.0295;
		onLBSelChanged  = "[lbCurSel 1] call TNL_fatm_updateCard;";
		default = true;
	};

	class cardsListBG : TNL_BackgroundFrame
	{
		x = 0.165;
		y = 0.29;
		w = 0.32;
		h = 0.37;
	};
	class cardsText : TNL_StructuredText
	{
		idc = 3;
		x = 0.165;
		y = 0.30;
		w = 0.39;
		h = 0.3;
		size = 0.035;
	};
	
	class ActionsBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.50;
		y = 0.29;
		w = 0.42;
		h = 0.27;
	};

	class UseButton : TNL_Button
	{
		idc = 10;
		x = 0.58;
		y = 0.55;
		w = 0.26;
		text = $STRS_atm_btnInsert;
		action = "closeDialog 0; [lbCurSel 1] spawn TNL_fatm_insertedCard;";
		shortcuts[] = {0x00050000 + 0, 28, 57, 156};
	};

	class bankNameText : TNL_StructuredHeader
	{
		x = 0.50;
		y = 0.32;
		w = 0.42;
		h = 0.3;
		size = 0.033;
		text = "Lingor National Bank<br/>---------------------------------------------";
		
		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "center";
			shadow = true;
			shadowColor = "#000000";
		};
	};
	class infoText : TNL_StructuredText
	{
		idc = 2;
		x = 0.52;
		y = 0.4;
		w = 0.39;
		h = 0.3;
		size = 0.030;
	};

	class CloseButton : TNL_Button
	{
		idc = -1;
		x = 0.75;
		y = 0.15;
		text = $STRS_gen_btnClose;
		action = "closeDialog 0;";
	};
};

class atmInputPin
{
	idd = 602;
	movingEnable = false;
	controlsBackground[] = {  Background, ActionsBG};
	objects[] = { };
	controls[] = { Title, CloseButton, bankNameText, infoText, UseButton, pinEdit };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; TNL_atm_manageLoop = false; ";

	class Background : TNL_Background
	{
		x = 0.30;
		y = 0.22;
		w = 0.90;
		h = 0.50;
	};
	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.375;
		y = 0.23;
		w = 0.5;
		h = 0.1;
		text = $STRS_atm_titlePIN;
	};
	class ActionsBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.325;
		y = 0.29;
		w = 0.42;
		h = 0.27;
	};
	class bankNameText : TNL_StructuredHeader
	{
		x = 0.325;
		y = 0.32;
		w = 0.42;
		h = 0.3;
		size = 0.033;
		text = "Chernarussian National Bank<br/>---------------------------------------------";
		
		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "center";
			shadow = true;
			shadowColor = "#000000";
		};
	};
	class infoText : TNL_StructuredText
	{
		idc = 2;
		x = 0.345;
		y = 0.39;
		w = 0.39;
		h = 0.3;
		size = 0.030;
		text = $STRS_atm_loading;
	};
	class pinEdit : TNL_Edit
	{
		idc = 864;
		x = 0.41;
		y = 0.465;
		w = 0.07;
		h = 0.0565;
		text = "";
		onKeyDown = "[] call TNL_fatm_pinFilter";
		default = true;
	};
	class UseButton : TNL_Button
	{
		idc = 10;
		x = 0.50;
		y = 0.44;
		text = $STRS_atm_btnConfirm;
		action = "[(ctrlText 864)] spawn TNL_fatm_checkPIN;";
		shortcuts[] = {0x00050000 + 0, 28, 57, 156};
	};
	
	class CloseButton : TNL_Button
	{
		idc = -1;
		x = 0.45;
		y = 0.55;
		text = $STRS_gen_btnCancel;
		action = "closeDialog 0;";
	};
};

class atmOperations
{
	idd = 603;
	movingEnable = false;
	controlsBackground[] = {  Background, accInfoBG, infoBG, actionBG};
	objects[] = { };
	controls[] = { Title, accountText, accountVarText, balanceText, balanceVarText, limitText, limitVarText, amountEdit, ckText, UseButton, CloseButton, bankNameText, infoText, cashNowText };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; TNL_atm_manageLoop = false;";
	
	class Background : TNL_Background
	{
		x = 0.225;
		y = 0.155;
		w = 1.38;
		h = 0.63;
	};

	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.30;
		y = 0.17;
		w = 0.5;
		h = 0.1;
		text = $STRS_atm_titleOperations;
	};

	class accInfoBG : TNL_BackgroundFrame
	{
		x = 0.265;
		y = 0.26;
		w = 0.2;
		h = 0.3;
	};
	class accountText : TNL_StructuredText
	{
		idc = 11;
		x = 0.28;
		y = 0.28;
		w = 0.39;
		h = 0.3;
		size = 0.035;
		text = $STRS_atm_operationsAcc;
	};
	class accountVarText : accountText
	{
		idc = 1;
		x = 0.29;
		y = 0.32;
		size = 0.03;
	};
	
	class balanceText : accountText
	{
		idc = 12;
		y = 0.36;
		text = $STRS_atm_operationsBalance;
	};
	class balanceVarText : accountVarText
	{
		idc = 2;
		y = 0.40;
	};
	
	class limitText : accountText
	{
		idc = 13;
		y = 0.44;
		text = $STRS_atm_operationsLimit;
	};
	class limitVarText : accountVarText
	{
		idc = 3;
		y = 0.48;
	};
	
	class infoBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.48;
		y = 0.26;
		w = 0.42;
		h = 0.21;
	};
	class actionBG : infoBG
	{
		idc = -1;
		y = 0.47;
		h = 0.09;
	};

	class amountEdit : TNL_Edit
	{
		idc = 4;
		x = 0.53;
		y = 0.49;
		w = 0.1;
		h = 0.050;
		text = "";
		onKeyDown = "[4] spawn TNL_fatm_updateEntered;";
		default = true;
	};
	class ckText : TNL_StructuredText
	{
		x = 0.63;
		y = 0.495;
		w = 0.39;
		h = 0.3;
		size = 0.04;
		text = "CK";
	};
	class UseButton : TNL_Button
	{
		idc = 10;
		x = 0.68;
		y = 0.465;
		text = $STRS_atm_btnWithdraw;
		action = "[parseNumber ctrlText 4] call TNL_fatm_operationsProcess;";
		shortcuts[] = {0x00050000 + 0, 28, 57, 156};
	};

	class bankNameText : TNL_StructuredHeader
	{
		x = 0.49;
		y = 0.29;
		w = 0.39;
		h = 0.3;
		size = 0.033;
		text = "Chernarussian National Bank<br/>---------------------------------------------";
	};
	class infoText : TNL_StructuredText
	{
		idc = 5;
		x = 0.49;
		y = 0.37;
		w = 0.39;
		h = 0.3;
		size = 0.030;
		text = $STRS_atm_enterAmount;
	};
	class cashNowText : TNL_StructuredTextBold
	{
		idc = 100;
		x = 0.29;
		y = 0.625;
		w = 0.20;
		h = 0.3;
		text = "Cash: x";
		
		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "left";
			shadow = false;
		};
	};
	
	class CloseButton : TNL_Button
	{
		idc = -1;
		x = 0.75;
		y = 0.14;
		text = $STRS_gen_btnClose;
		action = "closeDialog 0;";
	};
};

class atmExitDlg
{
	idd = 604;
	movingEnable = false;
	controlsBackground[] = {  Background, ActionsBG};
	objects[] = { };
	controls[] = { Title, CloseButton, bankNameText, infoText };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Background : TNL_Background
	{
		x = 0.30;
		y = 0.22;
		w = 0.90;
		h = 0.50;
	};
	class Title : TNL_Title2
	{
		idc = 10;
		x = 0.375;
		y = 0.23;
		w = 0.5;
		h = 0.1;
		text = $STRS_atm_thanks;
	};
	class ActionsBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.325;
		y = 0.29;
		w = 0.42;
		h = 0.27;
	};
	class bankNameText : TNL_StructuredHeader
	{
		x = 0.325;
		y = 0.32;
		w = 0.42;
		h = 0.3;
		size = 0.033;
		text = "Chernarussian National Bank<br/>---------------------------------------------";
		
		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "center";
			shadow = true;
			shadowColor = "#000000";
		};
	};
	class infoText : TNL_StructuredText
	{
		idc = 1;
		x = 0.345;
		y = 0.39;
		w = 0.39;
		h = 0.3;
		size = 0.030;
	};
	
	class CloseButton : TNL_Button
	{
		idc = -1;
		x = 0.45;
		y = 0.55;
		text = $STRS_gen_btnClose;
		action = "closeDialog 0;";
		shortcuts[] = {0x00050000 + 0, 28, 57, 156};
	};
};