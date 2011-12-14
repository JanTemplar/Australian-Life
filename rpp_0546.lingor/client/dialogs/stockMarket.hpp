/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

class DlgSMarketEnter
{
	idd = 1501;
	movingEnable = true;
	controlsBackground[] = { Background, HelpFrame, selectNameFrame };
	objects[] = { };
	controls[] = { Title, AccNumEdit, AccNumText, AccPinEdit, AccPinText, CreateButton, CloseButton, RegisterHelpTitle, RegisterHelp };
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
		Text = "Bank Details";
	};
	
	class HelpFrame : TNL_BackgroundFrame
	{
		x = 0.27;
		y = 0.18;
		w = 0.48;
		h = 0.26;
	};
	
	class AccNumText : TNL_StructuredText
	{
		idc = -1;
		x = 0.20;
		y = 0.4620;
		w = 0.405;
		h = 0.04;
		text = "Account #";

		class Attributes
		{
			font  = "Zeppelin32";
			color = "#666666";
			align = "center";
			shadow = false;
		};
	};
	
	class AccNumEdit : TNL_Edit
	{
		idc = 1;
		x = 0.305;
		y = 0.4575;
		w = 0.205;
		h = 0.04;
		text = "";
		onKeyDown = "";
		default = true;
	};
	
	class AccPinText : AccNumText
	{
		x = 0.415;
		text = "Account Pin";
	};
	
	class AccPinEdit : TNL_Edit
	{
		idc = 3;
		x = 0.515;
		y = 0.4575;
		w = 0.205;
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
		text = "Enter";
		action = "closeDialog 0; [TNL_db_charName, ctrlText 1, ctrlText 3] call TNL_fsmarket_enterStockMarket;";
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
		w = 0.50;
		h = 0.3;
		text = "Stock Market Information";

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
		text = "The stock market is a good source of income if you are good at it, you can purchase/sell stocks from any corporation... TODO..";
	};
};

class DlgSMarketTrade 
{
	idd = 1503;
	movingEnable = false;
	controlsBackground[] = { Background, TL_Frame, BL_Frame, CT_Frame, TR_Frame, CB_Frame, BR_Frame };
	objects[] = { };
	controls[] = { Title, AcceptBTN, DeclineBTN, CollectBTN, AcceptBTNText, DeclineBTNText, CollectBTNText, ViewBTN, TakeOverBTN, CloseBTN,
	ViewBTNText, TakeOverBTNText, CloseBTNText, Offers, Trade, Owners, PurchaseBTN, SellBTN, AmountEdit, OfferAmountEdit, AmountEditTxt, OfferAmountEditTxt, TradeInfo,
	BankBalanceHeader, BankBalance, Info, DividendCollectHeader, DividendCollect, OwnerOwnsHeader, OwnerName, stockHoldersList, OffersList  };
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
		w = 1;
		h = 0.1;
		text = "Stock Exchange Trade";
	};
	
	class TL_Frame : TNL_BackgroundFrame
	{
		x = 0.13;
		y = 0.18;
		w = 0.25;
		h = 0.40;
	};
	
	class BL_Frame : TNL_BackgroundFrame
	{
		x = 0.13;
		y = 0.580;
		w = 0.25;
		h = 0.24;
	};
	
	class CT_Frame : TNL_BackgroundFrame
	{
		x = 0.38;
		y = 0.18;
		w = 0.275;
		h = 0.40;
	};
	
	class TR_Frame : TNL_BackgroundFrame
	{
		x = 0.655;
		y = 0.18;
		w = 0.25;
		h = 0.40;
	};
	
	class CB_Frame : TNL_BackgroundFrame
	{
		x = 0.38;
		y = 0.580;
		w = 0.275;
		h = 0.24;
	};
	
	class BR_Frame : TNL_BackgroundFrame
	{
		x = 0.655;
		y = 0.580;
		w = 0.25;
		h = 0.24;
	};
	
	class AcceptBTN : TNL_Button2
	{
		idc = 150232;
		x = 0.134;
		y = 0.585;
		w = 0.23;
		h = 0.075;
		text = "";
		action = "";
	};
	
	class DeclineBTN : AcceptBTN
	{
		idc = 150233;
		y = 0.66;
		action = "";
	};
	
	class CollectBTN : AcceptBTN
	{
		idc = -1;
		y = 0.735;
	};
	
	class AcceptBTNText : TNL_StructuredText
	{
		idc = -1;
		x = 0.184;
		y = 0.605;
		w = 0.23;
		h = 0.4;
		text = "<t color='#cccccc'>Accept offer</t>";
		size = 0.03921;
		sizeEx = 0.04221;
	};
	
	class DeclineBTNText : AcceptBTNText
	{
		y = 0.68;
		text = "<t color='#cccccc'>Decline offer</t>";
	};
	
	class CollectBTNText : AcceptBTNText
	{
		y = 0.755;
		text = "<t color='#cccccc'>Collect dividend</t>";
	};
	
	class ViewBTN : TNL_Button2
	{
		idc = 150236;
		//style = 0x03;
		x = 0.660;
		y = 0.585;
		w = 0.23;
		h = 0.075;
		text = "";
		action = "";
	};
	
	class ViewBTNText : TNL_StructuredText
	{
		x = 0.71;
		y = 0.605;
		w = 0.23;
		h = 0.075;
		text = "<t color='#cccccc'>View details</t>";
		action = "";
		size = 0.03921;
		sizeEx = 0.04221;
	};
	
	class TakeOverBTN : ViewBTN
	{
		idc = 150235;
		y = 0.66;
		action = "";
	};
	
	class CloseBTN : ViewBTN
	{
		idc = -1;
		y = 0.735;
		action = "closeDialog 0;";
	};
	
	class TakeOverBTNText : ViewBTNText
	{	
		y = 0.68;
		text = "<t color='#cccccc'>Take over</t>";
	};
	
	class CloseBTNText : ViewBTNText
	{
		y = 0.755;
		text = "<t color='#cccccc'>Close</t>";
	};
	
	class Offers : TNL_structuredTextBold
	{
		x = 0.14;
		y = 0.19;
		w = 0.50;
		h = 0.3;
		text = "Trade Offers";

		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "left";
			shadow = false;
		};
	};
	
	class Trade : TNL_structuredTextBold 
	{
		x = 0.39;
		y = 0.19;
		w = 0.50;
		h = 0.3;
		text = "Trade";

		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "left";
			shadow = false;
		};
	}; 
	
	class Owners : TNL_structuredTextBold 
	{
		x = 0.665;
		y = 0.19;
		w = 0.50;
		h = 0.3;
		text = "Stockholders";

		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "left";
			shadow = false;
		};
	};
	
	class PurchaseBTN : TNL_SmallButton
	{
		idc = 150234;
		x = 0.39;
		y = 0.53;
		text = "Purchase";
	};
	
	class SellBTN : TNL_SmallButton
	{
		idc = 150230;
		x = 0.52;
		y = 0.53;
		text = "Sell";
	};
	
	class AmountEditTxt : TNL_StructuredText
	{
		idc = -1;
		x = 0.245;
		y = 0.465;
		w = 0.405;
		h = 0.04;
		text = "# Stocks";

		class Attributes
		{
			font  = "Zeppelin32";
			color = "#666666";
			align = "center";
			shadow = false;
		};
	};
	
	class OfferAmountEditTxt : AmountEditTxt
	{
		idc = -1;
		x = 0.390;
		text = "Offer (UPK)";
	};
	
	
	class AmountEdit : TNL_Edit
	{
		idc = 150226;
		x = 0.39;
		y = 0.46;
		w = 0.12;
		h = 0.04;
		text = "0";
		onKeyDown = "[(lbData[150222, lbCurSel 150222])] spawn TNL_fsmarket_stockHoldersListChanged;";
		default = true;
	};
	
	class OfferAmountEdit : AmountEdit
	{
		idc = 150227;
		x = 0.52;
		text = "0";
	};
	
	class TradeInfo : TNL_structuredText
	{
		idc = 150225;
		x = 0.390;
		y = 0.22;
		w = 0.26;
		h = 0.25;
		text = "Stock price for Im a little teapot company is xxxU, you own xx%, you are making a offer to Jimmmmy harrrpeeer who owns xxxx (xx%) for xxxx (xx%) stocks for xxxxUea, total xxxxU with a market value of xxxxU ";
	};
	
	class BankBalanceHeader : TNL_structuredTextBold 
	{
		x = 0.39;
		y = 0.64;
		w = 0.50;
		h = 0.3;
		text = "Bank Balance:";

		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "left";
			shadow = false;
		};
	}; 
	
	class BankBalance : TNL_StructuredText
	{
		idc = 150223;
		x = 0.41;
		y = 0.665;
		w = 0.50;
		h = 0.3;
		text = "0";
	};
	
	class Info : TNL_structuredTextBold 
	{
		x = 0.39;
		y = 0.60;
		w = 0.50;
		h = 0.3;
		text = "Information";

		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "left";
			shadow = false;
		};
	}; 
	
	class DividendCollectHeader : BankBalanceHeader
	{
		y = 0.7;
		text = "Dividend to collect:";
	};
	
	class DividendCollect : BankBalance
	{
		idc = -1;
		y = 0.725;
		text = "0";
	};
	
	class OwnerOwnsHeader : BankBalanceHeader
	{	
		y = 0.76;
		text = "Take over details:";
	};
	
	class OwnerName : BankBalance
	{
		idc = 150228;
		y = 0.785;
		text = "Cost: 100000U, Possible: Yes";
	};
	
	class stockHoldersList : TNL_List
	{
		idc = 150222;
		x = 0.665;
		y = 0.23;
		w = 0.225;
		h = 0.33;
		sizeEx = 0.026;
		rowHeight = 0.03;
		onLBSelChanged  = "[(lbData[150222, lbCurSel 150222])] call TNL_fsmarket_stockHoldersListChanged;";
		default = true;
	};
	
	class OffersList : TNL_List
	{
		idc = 150231;
		x = 0.14;
		y = 0.23;
		w = 0.225;
		h = 0.33;
		sizeEx = 0.026;
		rowHeight = 0.03;
		onLBSelChanged  = "[(lbData[150222, lbCurSel 150222])] call TNL_fsmarket_offersListChanged;";
		default = true;
	};
};

class DlgSMarketMain
{
	idd = 1502;
	movingEnable = true;
	controlsBackground[] = { Background, TL_Frame, BL_Frame, CT_Frame, TR_Frame, CB_Frame, BR_Frame };
	objects[] = { };
	controls[] = { Title, CorporationDescHeader, CorpIncomeHeader, CorpIncome, CorpExpensesHeader, CorpExpenses, 
					CorpRevenueHeader, CorpRevenue, CorpOwnedHeader, CorpOwned, CorpOwnedFirmsHeader, CorpOwnedFirms, StockHeader,
					StockPriceHeader, StockPrice, StockVolumeHeader, StockVolume, StockIncreasedHeader, IncreasedAmount, IncreasedAmountPercent, StockDividendHeader,
					StockDividend, StocksIssuedHeader, StocksIssued, LActionsHeader, LAction1, LAction2, LAction3, LAction4, LAction5, BankAccountHeader,
					BankAccountNumHeader, BankAccountNum, AccountPinHeader, AccountPin, AccountBalanceHeader, AccountBalance,
					TradeBTN, TradeBTNText, CloseBTN, CloseBTNText, CorporationsList, CorporationsHeader, MarketNewsBTNText, MarketNewsBTN };
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
		w = 1;
		h = 0.1;
		text = "Stock Exchange Floor";
	};
	
	class TL_Frame : TNL_BackgroundFrame
	{
		x = 0.13;
		y = 0.18;
		w = 0.25;
		h = 0.40;
	};
	
	class CorporationDescHeader : TNL_structuredTextBold
	{
		x = 0.14;
		y = 0.19;
		w = 0.50;
		h = 0.3;
		text = "Corporation Info";

		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "left";
			shadow = false;
		};
	};
	
	class CorpIncomeHeader : CorporationDescHeader
	{
		x = 0.14;
		y = 0.23;
		w = 0.50;
		h = 0.3;
		text = "Income:";
	};
	
	class CorpIncome : TNL_structuredText
	{
		idc = 150201;
		x = 0.15;
		y = 0.255;
		w = 0.50;
		h = 0.3;
		text = "0";
	};
	
	class CorpExpensesHeader : CorporationDescHeader
	{
		y = 0.29;
		text = "Expenses:";
	};
	
	class CorpExpenses : CorpIncome
	{
		idc = 150202;
		y = 0.315;
		text = "0";
	};
	
	class CorpRevenueHeader : CorporationDescHeader
	{
		y = 0.35;
		text = "Revenue:";
	};
	
	class CorpRevenue : CorpIncome
	{
		idc = 150203;
		y = 0.375;
		text = "0";
	};
	
	class CorpOwnedHeader : CorporationDescHeader
	{
		y = 0.41;
		text = "Date created:";
	};
	
	class CorpOwned : CorpIncome
	{
		idc = 150204;
		y = 0.435;
		text = "0%";
	};
	
	class CorpOwnedFirmsHeader : CorporationDescHeader
	{
		y = 0.47;
		text = "Owned Firms:";
	};
	
	class CorpOwnedFirms : CorpIncome 
	{
		idc = 150205;
		y = 0.495;
		text = "0";
	};
	
	class BL_Frame : TNL_BackgroundFrame
	{
		x = 0.13;
		y = 0.580;
		w = 0.25;
		h = 0.24;
	};
	
	class CT_Frame : TNL_BackgroundFrame
	{
		x = 0.38;
		y = 0.18;
		w = 0.275;
		h = 0.40;
	};
	
	class TR_Frame : TNL_BackgroundFrame
	{
		x = 0.655;
		y = 0.18;
		w = 0.25;
		h = 0.40;
	};
	
	class CB_Frame : TNL_BackgroundFrame
	{
		x = 0.38;
		y = 0.580;
		w = 0.275;
		h = 0.24;
	};
	
	class BR_Frame : TNL_BackgroundFrame
	{
		x = 0.655;
		y = 0.580;
		w = 0.25;
		h = 0.24;
	};
	
	class StockHeader : TNL_structuredTextBold 
	{
		x = 0.665;
		y = 0.19;
		w = 0.50;
		h = 0.3;
		text = "Stock Information";

		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "left";
			shadow = false;
		};
	};
	
	class StockPriceHeader : StockHeader
	{
		x = 0.665;
		y = 0.23;
		w = 0.50;
		h = 0.3;
		text = "Stock price:";
	};
	
	class StockPrice : TNL_structuredText
	{
		idc = 150206;
		x = 0.675;
		y = 0.255;
		w = 0.50;
		h = 0.3;
		text = "0";
	};
	
	class StockVolumeHeader : StockHeader
	{
		y = 0.29;
		text = "Volume:";
	};
	
	class StockVolume : StockPrice
	{
		idc = 150207;
		y = 0.315;
		text = "0";
	};
	
	class StockIncreasedHeader : StockHeader
	{
		y = 0.35;
		text = "Price increased:";
	};
	
	class IncreasedAmount : StockPrice
	{
		idc = 150208;
		y = 0.375;
		text = "<t color='#00cc44'>+0</t>";
	};
	
	class IncreasedAmountPercent : StockPrice
	{
		idc = 150209;
		y = 0.4;
		text = "<t color='#00cc44'>+0%</t>";
	};
	
	class StockDividendHeader : StockHeader
	{
		y = 0.435;
		text = "Dividend Yield:";
	};
	
	class StockDividend : StockPrice
	{
		idc = 150210;
		y = 0.46;
		text = "0%";
	};
	
	class StocksIssuedHeader : StockHeader
	{
		y = 0.495;
		text = "Stocks issued:";
	};
	
	class StocksIssued : StockPrice
	{
		idc = 150211;
		y = 0.520;
		text = "0";
	};
	
	class LActionsHeader : TNL_structuredTextBold 
	{
		x = 0.14;
		y = 0.60;
		w = 0.50;
		h = 0.3;
		text = "Last 5 Actions";

		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "left";
			shadow = false;
		};
	}; 
	
	class LAction1 : TNL_StructuredText
	{
		idc = 150212;
		x = 0.14;
		y = 0.65;
		w = 0.50;
		h = 0.3;
		text = "";
	};
	
	class LAction2 : LAction1
	{
		idc = 150213;
		y = 0.68;
		text = "";
	};
	
	class LAction3 : LAction1
	{
		idc = 150214;
		y = 0.71;
		text = "";
	};
	
	class LAction4 : LAction1
	{
		idc = 150215;
		y = 0.74;
		text = "";
	};
	
	class LAction5 : LAction1
	{
		idc = 150216;
		y = 0.77;
		text = "";
	};
	
	class BankAccountHeader : TNL_structuredTextBold 
	{
		x = 0.39;
		y = 0.60;
		w = 0.50;
		h = 0.3;
		text = "Bank Account";

		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "left";
			shadow = false;
		};
	}; 
	
	class BankAccountNumHeader : BankAccountHeader
	{
		y = 0.64;
		text = "Account #:";
	};
	
	class BankAccountNum : TNL_StructuredText
	{
		idc = 150217;
		x = 0.41;
		y = 0.665;
		w = 0.50;
		h = 0.3;
		text = "000-000-000";
	};
	
	class AccountPinHeader : BankAccountNumHeader
	{
		y = 0.7;
		text = "Account pin:";
	};
	
	class AccountPin : BankAccountNum
	{
		idc = 150218;
		y = 0.725;
		text = "0000";
	};
	
	class AccountBalanceHeader : BankAccountNumHeader
	{	
		y = 0.76;
		text = "Account balance:";
	};
	
	class AccountBalance : BankAccountNum
	{
		idc = 150219;
		y = 0.785;
		text = "0";
	};
	
	class TradeBTN : TNL_Button2
	{
		idc = 150221;
		//style = 0x03;
		x = 0.660;
		y = 0.585;
		w = 0.23;
		h = 0.075;
		text = "";
		action = "";
	};
	
	class TradeBTNText : TNL_StructuredText
	{
		x = 0.71;
		y = 0.605;
		w = 0.23;
		h = 0.075;
		text = "<t color='#cccccc'>Trade stocks</t>";
		action = "";
		size = 0.03921;
		sizeEx = 0.04221;
	};
	
	
	class MarketNewsBTN : TradeBTN
	{
		idc = -1;
		y = 0.66;
	};
	
	class CloseBTN : TradeBTN
	{
		idc = -1;
		y = 0.735;
		action = "closeDialog 0;";
	};
	
	
	class MarketNewsBTNText : TradeBTNText
	{	
		y = 0.68;
		text = "<t color='#cccccc'>Market News</t>";
	};
	
	
	class CloseBTNText : TradeBTNText
	{
		y = 0.755;
		text = "<t color='#cccccc'>Close</t>";
	};
	
	class CorporationsList : TNL_List
	{
		idc = 150220;
		x = 0.39;
		y = 0.23;
		w = 0.25;
		h = 0.33;
		sizeEx = 0.026;
		rowHeight = 0.03;
		onLBSelChanged  = "[lbData[150220,lbCurSel 150220]] call TNL_fsmarket_corporationSelChanged;";
		default = true;
	};
	
	class CorporationsHeader : TNL_structuredTextBold 
	{
		x = 0.39;
		y = 0.19;
		w = 0.50;
		h = 0.3;
		text = "Corporations";

		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "left";
			shadow = false;
		};
	}; 
};
	