/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

class DlgCorpFirms
{
	idd = 1401;
	movingEnable = false;
	controlsBackground[] = { Background, LeftBG, DescBG, FirmsListBG, InfoBG };
	objects[] = { };
	controls[] = { Title, Manage, Close, DescTitle, Desc, FirmsListTitle, InfoTitle, FirmList, FirmInfo };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	

	class Background : TNL_Background
	{
		x = 0.10;
		y = 0.05;
		w = 1.60;
		h = 1.10;
	};

	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.15;
		y = 0.10;
		w = 0.5;
		h = 0.1;
		Text = "Corporation Firms";
	};

	class LeftBG : TNL_BackgroundFrame
	{
		x = 0.13;
		y = 0.18;
		w = 0.25;
		h = 0.63;
	};

	class DescBG : TNL_BackgroundFrame
	{
		x = 0.14;
		y = 0.19;
		w = 0.23;
		h = 0.48;
	};

	class FirmsListBG : TNL_BackgroundFrame
	{
		x = 0.389;
		y = 0.18;
		w = 0.25;
		h = 0.63;
	};

	class InfoBG : TNL_BackgroundFrame
	{
		x = 0.65;
		y = 0.18;
		w = 0.25;
		h = 0.63;
	};

	class Manage : TNL_Button
	{
		idc = 1401;
		x = 0.16;
		y = 0.65;
		text = "Manage";
		action = "";
	};

	class Close : TNL_Button
	{
		idc = -1;
		x = 0.16;
		y = 0.72;
		text = "Close";
		action = "closeDialog 0;";
	};

	class DescTitle : TNL_StructuredTextBold
	{
		x = 0.15;
		y = 0.195;
		w = 0.25;
		h = 0.3;
		text = "Help and Description";

		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "left";
			shadow = false;
		};
	};

	class Desc : TNL_StructuredText
	{
		idc = 1402;
		x = 0.145;
		y = 0.220;
		w = 0.22;
		h = 0.3;
		text = $STRS_corp_firm_help;
	};

	class FirmsListTitle : DescTitle
	{
		x = 0.399;
		text = "Corporation Firms:";
	};

	class InfoTitle : DescTitle
	{
		x = 0.66;
		text = "Firm Report";
	};

	class FirmList : TNL_List
	{
		idc = 1403;
		x = 0.389;
		y = 0.235;
		w = 0.24;
		h = 0.60;
		sizeEx = 0.0295;
		onLBSelChanged  = "[(lbData[1403,lbCurSel 1403])] call TNL_fcorp_selChangeFirmsDlg;";
	};

	class FirmInfo : Desc
	{
		idc = 1404;
		x = 0.656;
		w = 0.24;
		h = 0.60;
		text = "";
	};

};

class DlgCorpRegister 
{
	idd = 1402;
	movingEnable = true;
	controlsBackground[] = { Background, HelpFrame, selectNameFrame };
	objects[] = { };
	controls[] = { Title, CorpNameEdit, CorpNameText, CreateButton, CloseButton, RegisterHelpTitle, RegisterHelp };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	
	class Background : TNL_Background
	{
		x = 0.25;
		y = 0.1;
		w = 1.0;
		h = 0.75;
	};
	
	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.30;
		y = 0.125;
		w = 0.5;
		h = 0.1;
		Text = "Register Corporation";
	};
	
	class HelpFrame : TNL_BackgroundFrame
	{
		x = 0.27;
		y = 0.18;
		w = 0.48;
		h = 0.26;
	};
	
	class CorpNameText : TNL_StructuredText
	{
		idc = -1;
		x = 0.305;
		y = 0.4620;
		w = 0.405;
		h = 0.04;
		text = "Corporation Name";

		class Attributes
		{
			font  = "Zeppelin32";
			color = "#666666";
			align = "center";
			shadow = false;
		};
	};
	
	class CorpNameEdit : TNL_Edit
	{
		idc = 1401;
		x = 0.305;
		y = 0.4575;
		w = 0.405;
		h = 0.04;
		text = "";
		onKeyDown = "";
		default = true;
	};
	
	class selectNameFrame : TNL_BackgroundFrame
	{
		x = 0.27;
		y = 0.44;
		w = 0.48;
		h = 0.18;
	};
	
	class CreateButton : TNL_Button
	{
		idc = -1;
		x = 0.315;
		y = 0.49;
		text = "Register";
		action = "[(ctrlText 1401)] call TNL_fcorp_clientRegisterCorporation;";
	};
	
	class CloseButton : TNL_Button
	{
		idc = -1;
		x = 0.51;
		y = 0.49;
		text = "Close";
		action = "closeDialog 0;";
	};
	
	class RegisterHelpTitle : TNL_StructuredTextBold
	{
		x = 0.28;
		y = 0.19;
		w = 0.25;
		h = 0.3;
		text = "Register Information";

		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "left";
			shadow = false;
		};
	};
	
	class RegisterHelp : TNL_structuredText
	{
		idc = 2;
		x = 0.282;
		y = 0.22;
		w = 0.470;
		h = 0.3;
		text = $STRS_corp_register_info;
	};
};

class DlgCorpSelect
{
	idd = 1403;
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
		text = "Select Corporation";
	};

	class List : TNL_List
	{
		idc = 1401;
		x = 0.325;
		y = 0.16;
		w = 0.3315;
		h = 0.435;
	};
	
	class ListBG : TNL_BackgroundFrame
	{
		x = 0.325;
		y = 0.16;
		w = 0.3315;
		h = 0.450;
	};

	class UseBtn : TNL_SmallButton
	{
		idc = -1;
		x = 0.335;
		y = 0.635;
		text = "Select";
		action = "closeDialog 0; [(lbData [1401, lbCurSel 1401])] call TNL_fcorp_openSelectCorpOptionDlg;";
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

class DlgCorpSelectOption
{
	idd = 1404;
	movingEnable = false;
	controlsBackground[] = { Background, ListBG};
	objects[] = { };
	controls[] = { Title, List, UseBtn, CloseBtn };

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
		text = "Select Option";
	};

	class List : TNL_List
	{
		idc = 1401;
		x = 0.325;
		y = 0.16;
		w = 0.3315;
		h = 0.435;
	};
	
	class ListBG : TNL_BackgroundFrame
	{
		x = 0.325;
		y = 0.16;
		w = 0.3315;
		h = 0.450;
	};

	class UseBtn : TNL_SmallButton
	{
		idc = -1;
		x = 0.335;
		y = 0.635;
		text = "Select";
		action = "[lbData[1401,lbCurSel 1401]] call TNL_fcorp_selectCorpOption;";
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

class DlgCorpBankAccounts 
{
	idd = 1405;
	movingEnable = false;
	controlsBackground[] = { Background, BalanceBG };
	objects[] = { };
	controls[] = { Title, BalanceHeader, Balance, AccountNumHeader, AccountNum, AccountPinHeader, AccountPin, CloseButton, CopyButton };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	
	
	class Background : TNL_Background
	{
		x = 0.25;
		y = 0.085;
		w = 0.75;
		h = 0.65;
	};
	
	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.30;
		y = 0.1044;
		w = 0.5;
		h = 0.1;
		text = "Corporate Account";
	};
	
	class BalanceBG : TNL_backgroundFrame
	{
		x = 0.26;
		y = 0.17;
		w = 0.3685;
		h = 0.30;
	};
	
	class BalanceHeader : TNL_StructuredTextBold
	{
		x = 0.27;
		y = 0.18;
		w = 0.45;
		h = 0.3;
		text = "Account balance:";

		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "left";
			shadow = true;
		};
	};
	
	class Balance : TNL_StructuredText
	{
		idc = 1401;
		x = 0.27;
		y = 0.21;
		w = 0.45;
		h = 0.3;
		text = "0Ц";
	};
	
	class AccountNumHeader : BalanceHeader
	{
		y = 0.28;
		text = "Account #:";
	};
	
	class AccountNum : Balance
	{
		idc = 1402;
		y = 0.31;
		text = "0";
	};
	
	class AccountPinHeader : BalanceHeader
	{
		y = 0.38;
		text = "Account pin:";
	};
	
	class AccountPin : Balance
	{
		idc = 1403;
		y = 0.41;
		text = "0000";
	};
	
	
	class CopyButton : TNL_Button 
	{
		idc = 1404;
		x = 0.265;
		y = 0.45;
		text = "Access";
		action = "";
	};
	
	
	class CloseButton : TNL_Button
	{
		x = 0.45;
		y = 0.45;
		text = "Close";
		action = "closeDialog 0;";
	};
};

class DlgCorpSummary 
{
	idd = 1406;
	movingEnable = false;
	controlsBackground[] = { Background, ListBG, DescBG };
	objects[] = { };
	controls[] = { Title, List, Name, Desc, CloseBTN };
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
		idc = 1401;
		x = 0.215;
		y = 0.1;
		w = 0.5;
		h = 0.1;
		Text = "Corporations";
	};

	class List : TNL_List
	{
		idc = 1402;
		x = 0.195;
		y = 0.185;
		w = 0.5125;
		h = 0.300;
		sizeEx = 0.0295;
		onLBselChanged = "[(lbData[1402,lbCurSel 1402])] call TNL_fcorp_DlgCorpSummaryChange;";
	};

	class ListBG : TNL_BackgroundFrame
	{
		x = 0.195;
		y = 0.185;
		w = 0.5125;
		h = 0.300;
	};

	class DescBG : TNL_BackgroundFrame
	{
		x = 0.195;
		y = 0.4985;
		w = 0.5125;
		h = 0.31715;
	};

	class Name : TNL_StructuredHeader
	{
		idc = 1403;
		x = 0.2;
		y = 0.51;
		w = 0.5275690;
		h = 0.315;
		size = 0.035;
		Text = "Corporation Report";
	};
	class Desc : TNL_StructuredText
	{
		idc = 1404;
		x = 0.2;
		y = 0.54;
		w = 0.51;
		h = 0.315;
		Text = "";
	};

	class CloseBTN : TNL_Button
	{
		idc = -1;
		x = 0.515;
		y = 0.7285;
		text = "Close";
		action = "closeDialog 0;";
	};

};

class DlgCorpPurchases 
{
	idd = 1407;
	movingEnable = false;
	controlsBackground[] = { Background, OffersBG, FirmsBG, OfferInfoBG, FirmDescBG };
	objects[] = { };
	controls[] = { Title, Offers, Firms, OfferInfo, OfferInfoHeader, FirmDesc, FirmDescHeader, AcceptButton, DeclineButton, AmountEdit, OfferButton, AmountText, BankAmount };
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
		idc = -1;
		x = 0.20;
		y = 0.09;
		w = 0.9;
		h = 0.1;
		Text = "Corporation offers and purchases";
	};

	class OffersBG : TNL_BackgroundFrame
	{
		x = 0.165;
		y = 0.18;
		w = 0.36;
		h = 0.30;
	};

	class FirmsBG : TNL_BackgroundFrame
	{
		x = 0.56;
		y = 0.18;
		w = 0.36;
		h = 0.30;
	};

	class OfferInfoBG : TNL_BackgroundFrame
	{
		x = 0.165;
		y = 0.48;
		w = 0.36;
		h = 0.32;
	};

	class FirmDescBG : TNL_BackgroundFrame
	{
		x = 0.56;
		y = 0.48;
		w = 0.36;
		h = 0.32;
	};

	class Offers : TNL_List
	{
		idc = 1402;
		x = 0.165;
		y = 0.18;
		w = 0.35;
		h = 0.36;
		sizeEx = 0.0295;
		onLBSelChanged  = "[(lbData[1402, lbCurSel 1402])] call TNL_fcorp_offersListChange;";
	};

	class Firms : TNL_List
	{
		idc = 1401;
		x = 0.56;
		y = 0.18;
		w = 0.35;
		h = 0.30;
		sizeEx = 0.0295;
		onLBSelChanged  = "[(lbData[1401, lbCurSel 1401])] call TNL_fcorp_offersFirmsListChange;";
	};

	class OfferInfoHeader : TNL_StructuredHeader
	{
		idc = 1405;
		x = 0.170;
		y = 0.495;
		w = 0.35;
		h = 0.31;
		text = "Offer Information:";
	};

	class OfferInfo : TNL_StructuredText
	{
		idc = 1406;
		x = 0.170;
		y = 0.535;
		w = 0.35;
		h = 0.31;
		text = "";
	};

	class FirmDescHeader : TNL_StructuredHeader
	{
		idc = 1403;
		x = 0.565;
		y = 0.495;
		w = 0.35;
		h = 0.31;
		text = "Firm Information:";
	};

	class FirmDesc : TNL_StructuredText
	{
		idc = 1404;
		x = 0.565;
		y = 0.535;
		w = 0.35;
		h = 0.31;
		text = "";
	};
	
	class AcceptButton : TNL_SmallButton
	{
		idc = 1407;
		x = 0.170;
		y = 0.76;
		text = "Accept";
		action = "[(lbData[1402, lbCurSel 1402])] call TNL_fcorp_offerAccept;";
	};
	
	class DeclineButton : TNL_SmallButton
	{
		idc = -1;
		x = 0.397;
		y = 0.76;
		text = "Decline";
		action = "[(lbData[1402, lbCurSel 1402])] call TNL_fcorp_offerDecline;";
	};
	
	class AmountEdit : TNL_Edit
	{
		idc = 1408;
		x = 0.575;
		y = 0.74;
		w = 0.155;
		h = 0.04;
		text = "0";
		onKeyDown = "";
		default = true;
	};
	
	class OfferButton : TNL_SmallButton
	{
		idc = 1409;
		x = 0.742;
		y = 0.74;
		text = "Offer";
		action = "closeDialog 0;";
	};
	
	class AmountText : TNL_StructuredText
	{
		idc = -1;
		x = 0.450;
		y = 0.745;
		w = 0.405;
		h = 0.04;
		text = "Offer Amount";

		class Attributes
		{
			font  = "Zeppelin32";
			color = "#666666";
			align = "center";
			shadow = false;
		};
	};
	
	class BankAmount : TNL_StructuredText
	{
		idc = 1410;
		x = 0.18;
		y = 0.866;
		w = 0.85;
		h = 0.08;
		text = "Corporation Bank Balance: ";
	};
	
};