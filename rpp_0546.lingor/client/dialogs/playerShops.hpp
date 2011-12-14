class TNL_DlgPlayerShop
{
	idd = 1702;	
	movingEnable = false;
	controlsBackground[] = { Background, DetailsFrame, PurchaseListBG, InventoryListBG};
	objects[] = { };
	controls[] = { PurchaseList, Title, StatusInfo, StatusText, BuyButton, AmountBox, ItemName, ItemInfo, CloseButton };
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
		Text = "Shop";
	};

	class PurchaseList : TNL_List
	{
		idc = 2;
		x = 0.165;
		y = 0.18;
		w = 0.32;
		h = 0.61;
		sizeEx = 0.0295;
		onLBSelChanged  = "[2] call SBAY_fShops_UpdateDescription;";

	};

	class PurchaseListBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.165;
		y = 0.18;
		w = 0.32;
		h = 0.61;
	};

	class StatusInfo : TNL_StructuredText
	{
		idc = 3;
		x = 0.50;
		y = 0.18;
		w = 0.42;
		h = 0.27;
		sizeEx = 0.0295;

	};

	class InventoryListBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.50;
		y = 0.18;
		w = 0.42;
		h = 0.27;
	};

	class DetailsFrame : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.50;
		y = 0.46;
		w = 0.42;
		h = 0.331;
	};


	class StatusText : TNL_Text
	{
		idc = 4;
		x = 0.18;
		y = 0.86;
		w = 0.900;
		h = 0.05;
		Text = "";
		sizeEx = 0.03;
	};

	class BuyButton : TNL_Button
	{
		idc = 25;
		x = 0.515;
		y = 0.71;
		Text = "Purchase";
		Action = "";
	};

	class AmountBox : TNL_Edit
	{
		idc = 26;
		x = 0.71;
		y = 0.74;
		w = 0.2;
		h = 0.04;
		text = "1";
		onKeyUp  = "";
	};


	class ItemName : TNL_StructuredHeader
	{
		idc = 6;
		x = 0.5095;
		y = 0.47;
		w = 0.385;
		h = 0.315;
		Text = "";
	};
	
	class ItemInfo : TNL_StructuredText
	{
		idc = 5;
		x = 0.5095;
		y = 0.51;
		w = 0.385;
		h = 0.315;
		Text = "";
	};

	class CloseButton : TNL_Button
	{
		idc = -1;
		x = 0.75;
		y = 0.06;
		text = "Close";
		action = "closeDialog 0;";
	};
};
