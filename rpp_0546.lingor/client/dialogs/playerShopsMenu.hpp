class DlgPlayershopManage
{
	idd = 1701;
	movingEnable = true;
	controlsBackground[] = {DLG_BACK1};	
	objects[] = { };
	controls[] = {Title, setPrices, storageRem, storageAdd, setPeopleCanBuy, setName, closebutton};		
	
	class DLG_BACK1: TNL_Background		
	{
		x = 0.320;
		y = 0.085;
		w = 0.65;
		h = 0.75;	
	};
	
	class Title : TNL_Title2
	{
		idc = 1712;
		x = 0.365;
		y = 0.11;
		w = 0.5;
		h = 0.1;
		Text = "Shop Manage";
	};

	class setPrices : TNL_Button
	{
		idc = 1711;
		x = 0.330;
		y = 0.15;
		w = 0.30;
		text = "Set Prices";
		action = "closeDialog 0; [TNL_gVar_curActiveShop] call TNL_fps_playerShopSetPrices;";
	};
	
	class storageRem : TNL_Button
	{
		idc = 1713;
		x = 0.330; 
		y = 0.20;	
		w = 0.30;
		text = "Remove Stock";	
		action = "closeDialog 0; [TNL_gVar_curActiveShop] call TNL_fps_playerShopRemStock;";
	};
	
	class storageAdd : TNL_Button
	{
		idc = 1715;
		x = 0.330; 
		y = 0.25;	
		w = 0.30;
		text = "Add Stock";	
		action = "closeDialog 0; [TNL_gVar_curActiveShop] spawn TNL_fps_playerShopAddStock;";
	};
	
	class setPeopleCanBuy : TNL_Button
	{			
		idc = 1714;
		x = 0.330;
		y = 0.30;
		w = 0.30;
		text = "Open/Close Shop";
		action = "closeDialog 0; [TNL_gVar_curActiveShop] call TNL_fps_playerShopToggle;";
	};
	
	class setName : TNL_Button
	{			
		idc = 1715;
		x = 0.330;
		y = 0.35;
		w = 0.30;
		text = "Set Name";
		action = "closeDialog 0; (TNL_gVar_curActiveShop) call TNL_fps_playerShopOpenNameDlg;";
	};
	
	
	class closebutton : TNL_Button
	{
		x = 0.330;
		y = 0.40;	
		w = 0.30;
		text = "Close";	
		action = "closedialog 0;";
	};
};