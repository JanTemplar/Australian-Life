/*
Name: db.hpp
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (06/06/2009)
Description: Dialogs for user DB system
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

class TNL_dlg_dbServerRules
{
	idd = 201;
	movingEnable = false;
	controlsBackground[] = {  Background, rulesBG, rulesFrame};
	objects[] = { };
	controls[] = { Title, textInfo, rulesText, agreeBtn, disagreeBtn };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Background : TNL_Background
	{
		x = 0.20;
		y = 0.045;
		w = 1.40;
		h = 1.10;
	};
	class Title : TNL_Title2
	{
		x = 0.25;
		y = 0.09;
		w = 0.5;
		h = 0.1;
		Text = "Server Rules";
	};
	
	class rulesBG : TNL_BackgroundFrame
	{
		x = 0.24;
		y = 0.18;
		w = 0.64;
		h = 0.625;
	};
	class textInfo : TNL_StructuredText
	{
		idc = 23;
		x = 0.25;
		y = 0.20;
		w = 0.62;
		h = 0.315;
		Text = "Before you can play the mission you must agree to the server rules:";
	};
	
	class rulesFrame : TNL_frame
	{
		x = 0.26;
		y = 0.24;
		w = 0.60;
		h = 0.535;
	};
	class rulesText : TNL_StructuredText
	{
		idc = 1;
		x = 0.265;
		y = 0.25;
		w = 0.59;
		h = 0.515;
		size = "0.02";
		text = $STRS_db_loadingRules;
	};
	class agreeBtn : TNL_Button
	{
		idc = 2;
		x = 0.35;
		y = 0.84;
		text = "I agree";
		action = "closeDialog 0; [] call TNL_fdb_welcomeOpen;";
	};
	class disagreeBtn : TNL_Button
	{
		idc = 3;
		x = 0.6;
		y = 0.84;
		text = "I disagree";
		action = "closeDialog 0;";
	};
};

/*class TNL_dlg_dbServerRules
{
	idd = 201;
	movingEnable = false;
	controlsBackground[] = {  Background, rulesBG, rulesFrame};
	objects[] = { };
	controls[] = { Title, textInfo, rulesHTML, agreeBtn, disagreeBtn };
	
	class Background : TNL_Background
	{
		x = 0.20;
		y = 0.045;
		w = 1.40;
		h = 1.10;
	};
	class Title : TNL_Title2
	{
		x = 0.25;
		y = 0.09;
		w = 0.5;
		h = 0.1;
		Text = "Server Rules";
	};
	
	class rulesBG : TNL_BackgroundFrame
	{
		x = 0.24;
		y = 0.18;
		w = 0.64;
		h = 0.62;
	};
	class textInfo : TNL_StructuredText
	{
		idc = 23;
		x = 0.25;
		y = 0.20;
		w = 0.62;
		h = 0.315;
		Text = "Before you can play the mission you must agree to the server rules:";
	};
	
	class rulesFrame : TNL_frame
	{
		idc = -1;
		x = 0.26;
		y = 0.25;
		w = 0.60;
		h = 0.48;
	};
	class rulesHTML : TNL_HTML
	{
		idc = 1;
		x = 0.27;
		y = 0.27;
		w = 0.58;
		h = 0.45;
		filename = "";
	};
	class agreeBtn : TNL_Button
	{
		idc = -1;
		x = 0.35;
		y = 0.71;
		text = "I agree";
		action = "closeDialog 0; [] call TNL_fdb_welcomeOpen;";
	};
	class disagreeBtn : TNL_Button
	{
		idc = -1;
		x = 0.6;
		y = 0.71;
		text = "I disagree";
		action = "closeDialog 0;";
	};
};*/

class TNL_dlg_dbWelcome 
{
	idd = 202;
	movingEnable = false;
	controlsBackground[] = {  Background, infoBG, registerBG, loginBG};
	objects[] = { };
	controls[] = { Title, missionInfo, registerHeader, registerInfo, registerBtn, loginHeader, loginInfo, loginBtn };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Background : TNL_Background
	{
		x = 0.25;
		y = 0.045;
		w = 1.20;
		h = 1.03;
	};

	class Title : TNL_Title2
	{
		x = 0.33;
		y = 0.08;
		w = 0.5;
		h = 0.1;
		Text = $STRS_db_welcomeHeader;
	};
	
	class infoBG : TNL_BackgroundFrame
	{
		x = 0.28;
		y = 0.18;
		w = 0.56;
		h = 0.27;
	};
	class missionInfo : TNL_StructuredText
	{
		x = 0.30;
		y = 0.20;
		w = 0.52;
		h = 0.315;
		text = $STRS_mission_longDesc;
	};

	class registerBG : TNL_BackgroundFrame
	{
		x = 0.28;
		y = 0.46;
		w = 0.27;
		h = 0.30;
	};
	class registerHeader : TNL_StructuredText
	{
		x = 0.28;
		y = 0.48;
		w = 0.27;
		size = 0.032;
		text = $STRS_db_registerHeader;
	
		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "center";
			shadow = true;
			shadowColor="#000000";
		};
	};
	class registerInfo : TNL_StructuredText
	{
		x = 0.30;
		y = 0.52;
		w = 0.235;
		h = 0.315;
		text = $STRS_db_welcomeRegisterInfo;
	};
	class registerBtn : TNL_Button
	{
		x = 0.325;
		y = 0.66;
		text = $STRS_db_register;
		action = "closeDialog 0; [] spawn TNL_fdb_registerOpen";
	};
	
	class loginBG : registerBG
	{
		x = 0.57;
	};
	class loginHeader : registerHeader
	{
		x = 0.57;
		text = $STRS_db_loginHeader;
	};
	class loginInfo : registerInfo
	{
		x = 0.59;
		text = $STRS_db_welcomeLoginInfo;
	};
	class loginBtn : registerBtn
	{
		idc = -1;
		x = 0.62;
		text = $STRS_db_login;
		action = "closeDialog 0; [] spawn TNL_fdb_loginOpen";
	};
};

class TNL_dlg_dbLogin 
{
	idd = 203;
	movingEnable = true;
	controlsBackground[] = {  Background, haveAccBG, warningBG, usernameBG, passwordBG, submitBG };
	objects[] = { };
	controls[] = { Title, haveAccInfo, registerBtn, warningInfo, usernameText, usernameEdit, passwordText, passwordEdit, submitBtn };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Background : TNL_Background
	{
		x = 0.25;
		y = 0.045;
		w = 1.20;
		h = 0.8;
	};

	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.33;
		y = 0.07;
		w = 0.5;
		h = 0.1;
		Text = "Log into an account";
	};
	
	class haveAccBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.28;
		y = 0.18;
		w = 0.56;
		h = 0.08;
	};
	class haveAccInfo : TNL_StructuredText
	{
		idc = 23;
		x = 0.30;
		y = 0.20;
		w = 0.52;
		h = 0.1;
		Text = "<t size='1.4'>Do not have an account yet?</t>";
	};
	class registerBtn : TNL_Button
	{
		idc = -1;
		x = 0.64;
		y = 0.17;
		text = "Register";
		action = "closeDialog 0; [] spawn TNL_fdb_registerOpen";
	};

	class warningBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.28;
		y = 0.27;
		w = 0.56;
		h = 0.11;
	};
	class warningInfo : TNL_StructuredText
	{
		idc = 10;
		x = 0.30;
		y = 0.29;
		w = 0.52;
		h = 0.1;
		Text = $STRS_db_loginInfo;
	};
	
	class usernameBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.35;
		y = 0.39;
		w = 0.4;
		h = 0.07;
	};
	class usernameText : TNL_StructuredText
	{
		idc = 11;
		x = 0.36;
		y = 0.405;
		w = 0.3;
		h = 0.1;
		size = 0.04;
		Text = $STRS_db_username;
	};
	class usernameEdit : TNL_Edit
	{
		idc = 1;
		x = 0.50;
		y = 0.408;
		w = 0.23;
		h = 0.04;
		text = "";
		onKeyDown = "[1, true] call TNL_fdb_handleInput";
	};
	
	class passwordBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.35;
		y = 0.456;
		w = 0.4;
		h = 0.07;
	};
	class passwordText : TNL_StructuredText
	{
		idc = 12;
		x = 0.36;
		y = 0.471;
		w = 0.3;
		h = 0.1;
		size = 0.04;
		Text = $STRS_db_password;
	};
	class passwordEdit : TNL_Edit
	{
		idc = 2;
		x = 0.50;
		y = 0.474;
		w = 0.23;
		h = 0.04;
		text = "";
		onKeyDown = "[2, true] call TNL_fdb_handleInput";
	};
	
	class submitBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.35;
		y = 0.525;
		w = 0.4;
		h = 0.07;
	};
	class submitBtn : TNL_Button
	{
		idc = -1;
		x = 0.4;
		y = 0.511;
		w = 0.3;
		text = "Log into the account";
		action = "[] spawn TNL_fdb_loginCheck";
	};
};

class TNL_dlg_dbRegister 
{
	idd = 204;
	movingEnable = true;
	controlsBackground[] = {  Background, haveAccBG, warningBG, usernameBG, passwordBG, submitBG };
	objects[] = { };
	controls[] = { Title, haveAccInfo, loginBtn, warningInfo, usernameText, usernameEdit, passwordText, pw1Edit, pw2Edit, submitBtn };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Background : TNL_Background
	{
		x = 0.25;
		y = 0.045;
		w = 1.20;
		h = 0.87;
	};

	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.33;
		y = 0.08;
		w = 0.5;
		h = 0.1;
		Text = "Register an account";
	};
	
	class haveAccBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.28;
		y = 0.18;
		w = 0.56;
		h = 0.08;
	};
	class haveAccInfo : TNL_StructuredText
	{
		idc = -1;
		x = 0.30;
		y = 0.20;
		w = 0.52;
		h = 0.1;
		Text = "<t size='1.4'>Already have an account?</t>";
	};
	class loginBtn : TNL_Button
	{
		idc = -1;
		x = 0.64;
		y = 0.17;
		text = "Login";
		action = "closeDialog 0; [] spawn TNL_fdb_loginOpen";
	};

	class warningBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.28;
		y = 0.27;
		w = 0.56;
		h = 0.11;
	};
	class warningInfo : TNL_StructuredText
	{
		idc = 10;
		x = 0.30;
		y = 0.29;
		w = 0.52;
		h = 0.1;
		Text = "Please type a desired username and a password twice bellow. Passwords are case sensitive and are not encrypted! Their safety cannot be guaranteed!";
	};
	
	class usernameBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.35;
		y = 0.39;
		w = 0.4;
		h = 0.07;
	};
	class usernameText : TNL_StructuredText
	{
		idc = 11;
		x = 0.36;
		y = 0.405;
		w = 0.3;
		h = 0.1;
		size = 0.04;
		Text = $STRS_db_username;
	};
	class usernameEdit : TNL_Edit
	{
		idc = 1;
		x = 0.50;
		y = 0.408;
		w = 0.23;
		h = 0.04;
		text = "";
		onKeyDown = "[1, true] call TNL_fdb_handleInput";
	};
	
	class passwordBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.35;
		y = 0.456;
		w = 0.4;
		h = 0.125;
	};
	class passwordText : TNL_StructuredText
	{
		idc = 12;
		x = 0.36;
		y = 0.5;
		w = 0.3;
		h = 0.1;
		size = 0.04;
		Text = $STRS_db_password;
	};
	class pw1Edit : TNL_Edit
	{
		idc = 2;
		x = 0.50;
		y = 0.48;
		w = 0.23;
		h = 0.04;
		text = "";
		onKeyDown = "[2, true] call TNL_fdb_handleInput";
	};
	class pw2Edit : TNL_Edit
	{
		idc = 3;
		x = 0.50;
		y = 0.52;
		w = 0.23;
		h = 0.04;
		text = "";
		onKeyDown = "[3, true] call TNL_fdb_handleInput";
	};
	
	class submitBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.35;
		y = 0.58;
		w = 0.4;
		h = 0.07;
	};
	class submitBtn : TNL_Button
	{
		idc = -1;
		x = 0.4;
		y = 0.565;
		w = 0.3;
		text = "Create an account";
		action = "[] spawn TNL_db_registerCheck";
	};
};

class TNL_dlg_dbSelectChar 
{
	idd = 205;
	movingEnable = true;
	controlsBackground[] = {  Background, listBG, actionsBG };
	objects[] = { };
	controls[] = { Title, charList, selectBtn, deleteBtn, newBtn };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Background : TNL_Background
	{
		x = 0.25;
		y = 0.045;
		w = 1.20;
		h = 0.8;
	};

	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.33;
		y = 0.07;
		w = 0.5;
		h = 0.1;
		Text = "Select a character";
	};
	
	class listBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.28;
		y = 0.15;
		w = 0.56;
		h = 0.3;
	};
	class charList : TNL_List
	{
		idc = 10;
		x = 0.29;
		y = 0.16;
		w = 0.53;
		h = 0.28;
	};
	
	class actionsBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.36;
		y = 0.46;
		w = 0.41;
		h = 0.13;
	};
	class selectBtn : TNL_Button
	{
		idc = -1;
		x = 0.38;
		y = 0.45;
		w = 0.37;
		text = "        Select";
		action = "closeDialog 0; [lbCurSel 10, call compile (lbData[10,(lbCurSel 10)])] spawn TNL_fdb_finalize;";
	};
	class deleteBtn : TNL_Button
	{
		idc = -1;
		x = 0.38;
		y = 0.50;
		text = "<t color='#ff0000'>Delete</t>";
		action = "[lbCurSel 10] call TNL_fdb_deleteCharOpen";
	};
	class newBtn : TNL_Button
	{
		idc = -1;
		x = 0.565;
		y = 0.50;
		text = "New";
		action = "closeDialog 0; [] call TNL_fdb_makeCharOpen;";
	};
};

class TNL_dlg_dbMakeChar
{
	idd = 206;
	movingEnable = true;
	controlsBackground[] = {  Background, successBG, warningBG, firstNameBG, surnameBG, submitBG };
	objects[] = { };
	controls[] = { Title, successInfo, detailsInfo, warningInfo, firstNameText, firstNameEdit, surnameText, surnameEdit, submitBtn };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Background : TNL_Background
	{
		x = 0.25;
		y = 0.045;
		w = 1.20;
		h = 0.86;
	};

	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.33;
		y = 0.07;
		w = 0.5;
		h = 0.1;
		Text = "Create a character";
	};
	
	class successBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.28;
		y = 0.15;
		w = 0.56;
		h = 0.16;
	};
	class successInfo : TNL_StructuredText
	{
		idc = 22;
		x = 0.30;
		y = 0.17;
		w = 0.52;
		h = 0.17;
		text = "";
	};
	class detailsInfo : TNL_StructuredText
	{
		idc = 23;
		x = 0.30;
		y = 0.23;
		w = 0.52;
		h = 0.17;
		text = "";
	};

	class warningBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.28;
		y = 0.32;
		w = 0.56;
		h = 0.11;
	};
	class warningInfo : TNL_StructuredText
	{
		idc = 10;
		x = 0.30;
		y = 0.34;
		w = 0.52;
		h = 0.1;
		Text = $STRS_db_characterInfo;
	};
	
	class firstNameBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.35;
		y = 0.44;
		w = 0.4;
		h = 0.07;
	};
	class firstNameText : TNL_StructuredText
	{
		idc = 11;
		x = 0.36;
		y = 0.455;
		w = 0.3;
		h = 0.1;
		size = 0.04;
		Text = $STRS_db_firstName;
	};
	class firstNameEdit : TNL_Edit
	{
		idc = 1;
		x = 0.50;
		y = 0.458;
		w = 0.23;
		h = 0.04;
		text = "";
		onKeyDown = "[1, false] call TNL_fdb_handleInput";
	};
	
	class surnameBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.35;
		y = 0.506;
		w = 0.4;
		h = 0.07;
	};
	class surnameText : TNL_StructuredText
	{
		idc = 12;
		x = 0.36;
		y = 0.521;
		w = 0.3;
		h = 0.1;
		size = 0.04;
		Text = $STRS_db_surname;
	};
	class surnameEdit : TNL_Edit
	{
		idc = 2;
		x = 0.50;
		y = 0.524;
		w = 0.23;
		h = 0.04;
		text = "";
		onKeyDown = "[2, false] call TNL_fdb_handleInput";
	};
	
	class submitBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.35;
		y = 0.575;
		w = 0.4;
		h = 0.07;
	};
	class submitBtn : TNL_Button
	{
		idc = -1;
		x = 0.4;
		y = 0.561;
		w = 0.3;
		text = "Create the character";
		action = "[] spawn TNL_fdb_charCheck";
	};
};

class TNL_dlg_dbSelectFace
{
	idd = 207;
	movingEnable = true;
	controlsBackground[] = {  Background, mainBG, facesBG };
	objects[] = { };
	controls[] = { Title, charName, facesList, randomizeBtn, confirmBtn, hideBtn };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Background : TNL_Background
	{
		x = "1 - safeZoneX - 0.39";
		y = 0.14;
		w = 0.70;
		h = 0.86;
	};
	
	class Title : TNL_Title2
	{
		x = "1 - safeZoneX - 0.34";
		y = 0.17;
		w = 0.5;
		h = 0.1;
		Text = "Select face";
	};
	class mainBG : TNL_BackgroundFrame
	{
		x = "1 - safeZoneX - 0.365";
		y = 0.25;
		w = 0.315;
		h = 0.48;
	};	
	class charName : Title
	{
		idc = 2;
		x = "1 - safeZoneX - 0.365";
		y = 0.27;
		w = 0.315;
		h = 0.5;
		size = 0.033;
		text = "Name Surname";
		
		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffffff";
			align = "center";
			shadow = true;
		};
	};
	class facesBG : TNL_BackgroundFrame
	{
		x = "1 - safeZoneX - 0.337";
		y = 0.32;
		w = 0.26;
		h = 0.31;
	};
	class facesList : TNL_List
	{
		idc = 1;
		x = "1 - safeZoneX - 0.337";
		y = 0.33;
		w = 0.25;
		h = 0.29;
		
		onLBSelChanged = "[lbCurSel 1] call TNL_fdb_faceUpdate";
	};
	class randomizeBtn : TNL_Button
	{
		x = "1 - safeZoneX - 0.305";
		y = 0.625;
		w = 0.2;
		text = "Randomize!";
		action = "lbSetCurSel [1, round (random 106)]";
	};
	class confirmBtn : TNL_Button
	{
		x = "1 - safeZoneX - 0.355";
		y = 0.75;
		w = 0.3;
		text = "Confirm + continue";
		action = "closeDialog 0; [lbCurSel 1] call TNL_fdb_faceSave";
	};
	
	class hideBtn : TNL_Button
	{
		x = 0.40;
		w = 0.22;
		y = "1 - safeZoneY - 0.1";
		text = "Hide dialog";
		action = "closeDialog 0;";
	};
};
