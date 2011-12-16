/*
Name: bank.hpp
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (06/07/2009)
Description: Dialogs for bank
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/


class TNL_dlg_bankChooseAction 
{
	idd = 501;
	movingEnable = false;
	controlsBackground[] = {  Background, createBG, manageBG};
	objects[] = { };
	controls[] = { Title, createInfo, createBtn, manageInfo, manageBtn, CloseButton };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";

	class Background : TNL_Background0
	{
		x = 0.25;
		y = 0.3;
		w = 0.66;
		h = 0.5;
	};

	class Title : TNL_Title2
	{
		idc = 1;
		x = 0.33;
		y = 0.31;
		Text = "idc 1";
	};

	class createBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.28;
		y = 0.38;
		w = 0.27;
		h = 0.25;
	};
	class createInfo : TNL_StructuredText
	{
		idc = 11;
		x = 0.30;
		y = 0.4;
		w = 0.235;
		h = 0.315;
		text = "<t align='center' size='1.2' color='#ffcc00' font='Zeppelin33' shadow='true' shadowColor='#000000'>Create an account</t><br/>Would you like to create a new bank account?";
	};
	class createBtn : TNL_Button
	{
		idc = -1;
		x = 0.325;
		y = 0.53;
		text = "Create";
		action = "closeDialog 0; [0] call TNL_fbank_actionCreate";
	};
	
	class manageBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.57;
		y = 0.38;
		w = 0.27;
		h = 0.25;
	};
	class manageInfo : TNL_StructuredText
	{
		idc = 12;
		x = 0.59;
		y = 0.4;
		w = 0.235;
		h = 0.315;
		text = "<t align='center' size='1.2' color='#ffcc00' font='Zeppelin33' shadow='true' shadowColor='#000000'>Manage an account</t><br/>Would you like to withdraw, deposit or transfer money to/from your existing account?";
	};
	class manageBtn : TNL_Button
	{
		idc = -1;
		x = 0.62;
		y = 0.53;
		text = "Manage";
		action = "closeDialog 0; [0] call TNL_fbank_actionManage";
	};
	
	class CloseButton : TNL_Button
	{
		idc = -1;
		x = 0.65;
		y = 0.28;
		text = $STRS_gen_btnClose;
		action = "closeDialog 0;";
	};
};

class TNL_dlg_bankInputAcc
{
	idd = 502;
	movingEnable = false;
	controlsBackground[] = {  Background, ActionsBG};
	objects[] = { };
	controls[] = { Title, CloseButton, infoText, accText, UseButton, accEdit };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";

	class Background : TNL_Background0
	{
		x = 0.30;
		y = 0.22;
		w = 0.50;
		h = 0.50;
	};
	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.375;
		y = 0.23;
		text = $STRS_bank_inputAccNum;
	};
	class ActionsBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.325;
		y = 0.29;
		w = 0.42;
		h = 0.27;
	};
	class infoText : TNL_StructuredText
	{
		x = 0.345;
		y = 0.32;
		w = 0.39;
		h = 0.3;
		size = 0.033;
		text = "Please enter the account number.";
	};
	class accText : TNL_StructuredText
	{
		idc = 2;
		x = 0.40;
		y = 0.37;
		w = 0.39;
		h = 0.3;
		size = 0.05;
		text = "# xxx-xxx-xxx-xxx";
	};
	class accEdit : TNL_Edit
	{
		idc = 1;
		x = 0.44;
		y = 0.43;
		w = 0.20;
		h = 0.05;
		text = "";
		onKeyDown = "[1, ctrlText 1] call TNL_fbank_actionManage;";
		default = true;
	};
	class UseButton : TNL_Button
	{
		idc = 10;
		x = 0.45;
		y = 0.47;
		text = $STRS_atm_btnConfirm;
		action = "[2] call TNL_fbank_actionManage";
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

class TNL_dlg_bankSelectID
{
	idd = 503;
	movingEnable = false;
	controlsBackground[] = {  Background, cardsListBG, ActionsBG};
	objects[] = { };
	controls[] = { Title, cardsList, cardsText, UseButton, CloseButton, ItemName, infoText };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Background : TNL_Background0
	{
		x = 0.125;
		y = 0.155;
		w = 0.885;
		h = 0.85;
	};

	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.20;
		y = 0.185;
		text = $STRS_bank_selectID;
	};

	class cardsList : TNL_List
	{
		idc = 1;
		x = 0.165;
		y = 0.34;
		w = 0.31;
		h = 0.30;
		sizeEx = 0.0295;
		onLBSelChanged  = "[lbCurSel 1] call TNL_fbank_updateId;";
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
		x = 0.165;
		y = 0.30;
		w = 0.39;
		h = 0.3;
		size = 0.035;
		text = $STRS_bank_idCards;
		
		class Attributes
		{
			font  = "Zeppelin32";
			color = "#ffcc00";
			align = "left";
			shadow = false;
		};
	};
	
	class ActionsBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.50;
		y = 0.29;
		w = 0.42;
		h = 0.44;
	};

	class UseButton : TNL_Button
	{
		idc = 4;
		x = 0.19;
		y = 0.65;
		w = 0.26;
		text = $STRS_bank_useID;
		action = "closeDialog 0; [3, lbCurSel 1] call TNL_fbank_actionManage;";
		shortcuts[] = {0x00050000 + 0, 28, 57, 156};
	};

	class ItemName : TNL_StructuredHeader
	{
		idc = 2;
		x = 0.52;
		y = 0.31;
		w = 0.385;
		h = 0.32;
		size = 0.035;
	};	
	class infoText : TNL_StructuredText
	{
		idc = 3;
		x = 0.52;
		y = 0.35;
		w = 0.39;
		h = 0.5;
		size = 0.030;
	};

	class CloseButton : TNL_Button
	{
		idc = -1;
		x = 0.75;
		y = 0.155;
		text = $STRS_gen_btnClose;
		action = "closeDialog 0;";
	};
};

class TNL_dlg_bankManage
{
	idd = 504;
	movingEnable = false;
	controlsBackground[] = {  Background, accessBG, usersListBG, userDetailBG, historyBG, dateListBG, entriesListBG, entryDetailBG, balanceBG, cashBG, transferBG};
	objects[] = { };
	controls[] =
	{
		Title, CloseButton, accessText, mainOwnerText, mainOwnerName,
		usersText, usersList, manageButton, userRight1Text, userRight1Value,
		userRight2Text, userRight2Value, userRight3Text, userRight3Value,
		userRight4Text, userRight4Value,
		historyText, dateList, entriesList, entryDetailText,
		balanceText, balanceValue,
		cashText, cashAmountText, cashAmountEdit, cashWithdrawButton, cashDepositButton,
		transferText, transferAmountText, transferAmountEdit, transferAccText, transferAccEdit,
		transferButton, cashNowText
	};
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";

	class Background : TNL_Background0
	{
		x = 0.10;
		y = 0.05;
		w = 0.88;
		h = 1.10;
	};
	class Title : TNL_Title2
	{
		idc = 1;
		x = 0.15;
		y = 0.10;
		text = "Account #...";
	};
	
//########################################
//ACCESS part starts bellow
	class accessBG : TNL_BackgroundFrame
	{
		x = 0.12;
		y = 0.18;
		w = 0.26;
		h = 0.63;
	};
	class accessText : TNL_StructuredHeader
	{
		x = 0.13;
		y = 0.20;
		w = 0.25;
		h = 0.3;
		size = 0.033;
		text = $STRS_bank_access;
		
		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "center";
			shadow = true;
			shadowColor = "#000000";
			underline = true;
		};
	};
	
	class mainOwnerText : TNL_StructuredTextBold
	{
		x = 0.14;
		y = 0.25;
		w = 0.50;
		h = 0.3;
		text = $STRS_bank_mainOwner;
		
		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "left";
			shadow = false;
		};
	};
	class mainOwnerName : TNL_StructuredText
	{
		idc = 11;
		x = 0.15;
		y = 0.275;
		w = 0.22;
		h = 0.3;
		text = "John Doe";
	};
	
	class usersText : mainOwnerText
	{
		y = 0.31;
		text = "Users:";
	};
	class usersList : TNL_List
	{
		idc = 12;
		x = 0.14;
		y = 0.35;
		w = 0.22;
		h = 0.12;
		sizeEx = 0.0295;
		onLBSelChanged  = "[4, lbCurSel 12] call TNL_fbank_actionManage";
		default = true;
	};
	class usersListBG : TNL_BackgroundFrame
	{
		x = 0.135;
		y = 0.34;
		w = 0.23;
		h = 0.14;
	};
	
	class userDetailBG : usersListBG
	{
		y = 0.48;
		h = 0.26;
	};
	
	class userRight1Text : mainOwnerText
	{
		idc = 131;
		x = 0.14;
		y = 0.49;
		size = 0.028;
		text = $STRS_bank_canWithdraw;
		show = false;
		
		class Attributes
		{
			font  = "Zeppelin32";
			color = "#ffcc00";
			align = "left";
			shadow = false;
		};
	};
	class userRight1Value : mainOwnerName
	{
		idc = 132;
		x = 0.145;
		y = 0.515;
		text = $STRS_bank_selectUser;
	};
	class userRight2Text : userRight1Text
	{
		idc = 141;
		y = 0.55;
		text = $STRS_bank_withdrawLimit;
	};
	class userRight2Value : userRight1Value
	{
		idc = 142;
		y = 0.575;
		text = "";
	};
	class userRight3Text : userRight1Text
	{
		idc = 151;
		y = 0.61;
		text = $STRS_bank_canWire;
	};
	class userRight3Value : userRight2Value
	{
		idc = 152;
		y = 0.635;
	};
	class userRight4Text : userRight1Text
	{
		idc = 161;
		y = 0.67;
		text = $STRS_bank_wireLimit;
	};
	class userRight4Value : userRight2Value
	{
		idc = 162;
		y = 0.695;
	};
	
	class manageButton : TNL_Button
	{
		idc = 17;
		x = 0.15;
		y = 0.72;
		w = 0.21;
		text = "Management";
		action = "closeDialog 0; [] spawn TNL_fbank_accessManageOpen";
	};
	
//########################################
//HISTORY part bellow:
	class historyBG : accessBG
	{
		x = 0.65;
	};
	
	class historyText : accessText
	{
		x = 0.65;
		text = $STRS_bank_history;
	};
	class dateList : usersList
	{
		idc = 21;
		x = 0.67;
		y = 0.26;
		//w = 0.20;
		h = 0.12;
		onLBSelChanged  = "[5, lbCurSel 21] call TNL_fbank_actionManage";
	};
	class dateListBG : usersListBG
	{
		x = 0.665;
		y = 0.25;
		//w = 0.21;
		h = 0.14;
	};
	
	class entriesList : dateList
	{
		idc = 22;
		y = 0.395;
		onLBSelChanged  = "[6, lbCurSel 22] call TNL_fbank_actionManage";
	};
	class entriesListBG : dateListBG
	{
		y = 0.385;
	};
	
	class entryDetailBG : entriesListBG
	{
		y = 0.525;
		h = 0.265;
	};
	class entryDetailText : mainOwnerName
	{
		idc = 23;
		x = 0.68;
		y = 0.54;
		w = 0.20;
		h = 0.3;
		text = $STRS_bank_selectHistEntry;
	};
	
	/*class deleteEntryButton : manageButton
	{
		idc = 24;
		x = 0.67;
		y = 0.67;
		text = "Delete entry";
		action = "[7, lbCurSel 21, lbCurSel 22] call TNL_fbank_actionManage";
	};
	class deleteAllButton : deleteEntryButton
	{
		idc = 25;
		y = 0.72;
		text = "<t color='#ff0000'>Delete all</t>";
		action = "[8] call TNL_fbank_actionManage";
	};*/
	
//########################################
//BALANCE part bellow:
	class balanceBG : historyBG
	{
		x = 0.39;
		h = 0.13;
		w = 0.25;
	};
	class balanceText : accessText
	{
		x = 0.39;
		text = $STRS_bank_accBalance;
	};
	class balanceValue : balanceText
	{
		idc = 31;
		x = 0.39;
		y = 0.25;
		size = 0.03;
		text = "1,000,000 UPK";
		
		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffffff";
			align = "center";
			shadow = false;
		};
	};
	
//########################################
//CASH OPERATIONS part bellow:
	class cashBG : balanceBG
	{
		y = 0.325;
		h = 0.24;
	};
	class cashText : balanceText
	{
		idc = 501;
		y = 0.345;
		text = $STRS_bank_cashOps;
	};
	class cashAmountText : mainOwnerName
	{
		idc = 411;
		x = 0.415;
		y = 0.40;
		w = 0.20;
		text = $STRS_bank_amountUpk;
		
		class Attributes
		{
			font  = "Zeppelin32";
			color = "#666666";
			align = "center";
			shadow = false;
		};
	};
	class cashAmountEdit : TNL_Edit
	{
		idc = 412;
		x = 0.415;
		y = 0.395;
		w = 0.20;
		h = 0.04;
		text = "";
		onKeyDown = "[12, 412] call TNL_fbank_actionManage";
		default = true;
	};
	class cashWithdrawButton : manageButton
	{
		idc = 42;
		x = 0.415;
		y = 0.42;
		text = "Withdraw";
		action = "[0, ctrlText 412] call TNL_fbank_operationProccess";
	};
	class cashDepositButton : cashWithdrawButton
	{
		idc = 43;
		y = 0.47;
		text = "Deposit";
		action = "[1, ctrlText 412] call TNL_fbank_operationProccess";
	};
	
//########################################
//CREDIT TRANSFER part bellow:
	class transferBG : cashBG
	{
		y = 0.58;
		h = 0.23;
	};
	class transferText : cashText
	{
		idc = 502;
		y = 0.60;
		text = $STRS_bank_creditTransf;
	};
	class transferAmountText : cashAmountText
	{
		idc = 511;
		y = 0.655;
		text = $STRS_bank_amountUpk;
	};
	class transferAmountEdit : cashAmountEdit
	{
		idc = 512;
		y = 0.65;
		text = "";
		onKeyDown = "[12, 511] call TNL_fbank_actionManage";
	};
	class transferAccText : cashAmountText
	{
		idc = 521;
		y = 0.695;
		text = $STRS_bank_destinationAcc;
	};
	class transferAccEdit : cashAmountEdit
	{
		idc = 522;
		y = 0.69;
		text = "";
		onKeyDown = "[12, 521] call TNL_fbank_actionManage";
	};
	class transferButton : cashDepositButton
	{
		idc = 530;
		y = 0.72;
		text = "Transfer";
		action = "[2, [ctrlText 512, ctrlText 522]] call TNL_fbank_operationProccess";
	};
	class cashNowText : mainOwnerText
	{
		idc = 100;
		y = 0.88;
		text = "Cash: 555517452";
		//size = 0.030;
	};
	
	class CloseButton : TNL_Button
	{
		x = 0.70;
		y = 0.07;
		text = $STRS_gen_btnClose;
		action = "closeDialog 0;";
	};
};

class TNL_dlg_bankAccess
{
	idd = 505;
	movingEnable = false;
	controlsBackground[] = {  Background, manageBG, usersListBG, addBG};
	objects[] = { };
	controls[] =
	{
		Title, CloseButton, manageText,	usersList, selectedName, canWithdrawText,
		canWithdrawActive, withdrawLimitText, withdrawLimitActive, canWireText, canWireActive,
		wireLimitText, wireLimitActive, getCardButton, setOwnerButton, removeUserButton,
		addText, firstnameText, firstnameEdit, surnameText, surnameEdit, addUserButton,
		accBG, accText, newPinButton, freezeButton, deleteAccButton, balanceNowText
	};
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";

	class Background : TNL_Background0
	{
		x = 0.10;
		y = 0.15;
		w = 0.88;
		h = 0.90;
	};
	class Title : TNL_Title2
	{
		idc = 1;
		x = 0.15;
		y = 0.185;
		text = "";
	};
	
//########################################
//MANAGE part starts bellow
	class manageBG : TNL_BackgroundFrame
	{
		x = 0.13;
		y = 0.26;
		w = 0.50;
		h = 0.505;
	};
	class manageText : TNL_StructuredHeader
	{
		x = 0.13;
		y = 0.27;
		w = 0.50;
		h = 0.3;
		size = 0.033;
		text = "Manage";
		
		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "center";
			shadow = true;
			shadowColor = "#000000";
			underline = true;
		};
	};
	class usersList : TNL_List
	{
		idc = 10;
		x = 0.15;
		y = 0.34;
		w = 0.20;
		h = 0.39;
		sizeEx = 0.0295;
		onLBSelChanged  = "[10, lbCurSel 10] call TNL_fbank_actionManage";
		default = true;
	};
	class usersListBG : TNL_BackgroundFrame
	{
		x = 0.15;
		y = 0.33;
		w = 0.21;
		h = 0.41;
	};
	
	class selectedName : TNL_StructuredText
	{
		idc = 11;
		x = 0.38;
		y = 0.33;
		w = 0.24;
		size = 0.031;
		text = "Name Surname";
		
		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffffff";
			align = "center";
			shadow = false;
		};
	};
	
	class canWithdrawText : TNL_StructuredTextBold
	{
		idc = 110;
		x = 0.38;
		y = 0.37;
		w = 0.24;
		h = 0.3;
		size = 0.028;
		text = $STRS_bank_canWithdraw;
		
		class Attributes
		{
			font  = "Zeppelin32";
			color = "#ffcc00";
			align = "left";
			shadow = false;
		};
	};
	class canWithdrawActive : TNL_activeText
	{
		idc = 111;
		x = 0.39;
		y = 0.395;
		w = 0.23;
		text = "Yes";
	};
	class withdrawLimitText : canWithdrawText
	{
		idc = 120;
		y = 0.43;
		text = $STRS_bank_withdrawLimit;
	};
	class withdrawLimitActive : canWithdrawActive
	{
		idc = 121;
		y = 0.46;
		text = "5000";
	};
	
	class canWireText : canWithdrawText
	{
		idc = 210;
		y = 0.495;
		text = $STRS_bank_canWire;
	};
	class canWireActive : canWithdrawActive
	{
		idc = 211;
		y = 0.52;
		text = "Yes";
	};
	class wireLimitText : canWithdrawText
	{
		idc = 220;
		y = 0.555;
		text = $STRS_bank_wireLimit;
	};
	class wireLimitActive : canWithdrawActive
	{
		idc = 221;
		y = 0.58;
		text = "50000";
	};
	class getCardButton : TNL_SmallButton
	{
		idc = 42;
		x = 0.38;
		y = 0.62;
		w = 0.225;
		text = "Request card";
	};
	class setOwnerButton : getCardButton
	{
		idc = 40;
		y = 0.66;
		text = "Set owner";
	};
	class removeUserButton : setOwnerButton
	{
		idc = 41;
		y = 0.70;
		color[] = {0.9, 0, 0, 1};
		text = "Remove";
	};
	
//########################################
//ADD part starts bellow
	
	class addBG : manageBG
	{
		x = 0.64;
		w = 0.26;
		h = 0.23;
	};
	class addText : manageText
	{
		x = 0.64;
		w = 0.26;
		text = "Add";
	};
	
	class firstnameText : TNL_StructuredText
	{
		x = 0.68;
		y = 0.34;
		w = 0.18;
		text = "First name";
		
		class Attributes
		{
			font  = "Zeppelin32";
			color = "#666666";
			align = "center";
			shadow = false;
		};
	};
	class firstnameEdit : TNL_Edit
	{
		idc = 51;
		x = 0.68;
		y = 0.335;
		w = 0.18;
		h = 0.04;
		text = "";
		onKeyDown = "[16, 51] call TNL_fbank_actionManage;";
		default = true;
	};
	class surnameText : firstnameText
	{
		y = 0.385;
		text = "Surname";
	};
	class surnameEdit : firstnameEdit
	{
		idc = 52;
		y = 0.38;
		text = "";
		onKeyDown = "[16, 52] call TNL_fbank_actionManage;";
		default = true;
	};
	class addUserButton : getCardButton
	{
		idc = 53;
		x = 0.67;
		y = 0.425;
		w = 0.20;
		color[] = {0, 0.9, 0, 1};
		text = "Add user";
		action = "[17] call TNL_fbank_actionManage";
	};
	
//########################################
//ACCOUNT part starts bellow
	
	class accBG : addBG
	{
		y = 0.505;
		h = 0.26;
	};
	class accText : addText
	{
		y = 0.515;
		text = "Account";
	};
	class newPinButton : addUserButton
	{
		x = 0.66;
		y = 0.57;
		w = 0.22;
		color[] = {1, 1, 1, 1};
		text = "Request new PIN";
	};
	class freezeButton : newPinButton
	{
		y = 0.62;
		text = "Freeze the account";
	};
	class deleteAccButton : freezeButton
	{
		y = 0.70;
		color[] = {1, 0, 0, 1};
		text = "Delete account";
	};
	class balanceNowText : TNL_StructuredTextBold
	{
		idc = 100;
		x = 0.15;
		y = 0.83;
		w = 0.20;
		h = 0.3;
		text = "Balance: xxxx";
		
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
		x = 0.70;
		y = 0.155;
		text = $STRS_gen_btnClose;
		action = "closeDialog 0;";
	};
};


class TNL_dlg_bankEditRights
{
	idd = 506;
	movingEnable = false;
	controlsBackground[] = {  Background};
	objects[] = { };
	controls[] =
	{
		Title, CloseButton, descText, amountEdit, hintText, upkText, infoText, saveButton
	};
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";

	class Background : TNL_BackgroundSmall
	{
		x = 0.25;
		y = 0.24;
		w = 0.8;
		h = 0.5;
	};
	class Title : TNL_Title2
	{
		idc = 1;
		x = 0.26;
		y = 0.28;
		text = "Joe Doe's access";
	};
	class descText : TNL_StructuredTextBold
	{
		idc = 2;
		x = 0.27;
		y = 0.36;
		w = 0.20;
		h = 0.3;
		size = 0.028;
		text = "idc 2";
		
		class Attributes
		{
			font  = "Zeppelin32";
			color = "#ffcc00";
			align = "left";
			shadow = false;
		};
	};
	class hintText : descText
	{
		x = 0.47;
		w = 0.16;
		text = "0 = unlimited";
		
		class Attributes
		{
			font  = "Zeppelin32";
			color = "#666666";
			align = "center";
			shadow = false;
		};
	};
	class amountEdit : TNL_Edit
	{
		idc = 10;
		x = 0.47;
		y = 0.355;
		w = 0.16;
		h = 0.04;
		text = "";
		onKeyDown = "[12, 10] call TNL_fbank_actionManage;";
		default = true;
	};
	class upkText : TNL_StructuredTextBold
	{
		idc = 110;
		x = 0.64;
		y = 0.36;
		text = "UPK";
	};
	class infoText : TNL_StructuredText
	{
		idc = 3;
		x = 0.275;
		y = 0.40;
		w = 0.435;
		h = 0.1;
		size = 0.026;
		text = "idc 3";
	};
	
	class saveButton : TNL_Button
	{
		idc = 20;
		x = 0.41;
		y = 0.495;
		text = $STRS_gen_btnSave;
		shortcuts[] = {0x00050000 + 0, 28, 57, 156};
		action = "";
	};
	class CloseButton : TNL_Button
	{
		x = 0.525;
		y = 0.25;
		text = $STRS_gen_btnClose;
		action = "closeDialog 0;";
	};
};