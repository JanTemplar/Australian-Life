class DlgWorkplaceManage
{
	idd = 2100;
	movingEnable = true;
	controlsBackground[] = {DLG_BACK1};	
	objects[] = { };
	controls[] = {Title, setPrices, storage, setPeopleCanBuy, setStocks, closebutton};		
	
	class DLG_BACK1: TNL_Background		
	{
		x = 0.320;
		y = 0.085;
		w = 0.65;
		h = 0.75;	
	};
	
	class Title : TNL_Title2
	{
		idc = 2100;
		x = 0.365;
		y = 0.11;
		w = 0.5;
		h = 0.1;
		Text = "Workplace Manage";
	};

	class setPrices : TNL_Button
	{
		idc = 2101;
		x = 0.330;
		y = 0.15;
		w = 0.30;
		text = "Set Prices";
		action = "(TNL_gVar_curActiveWorkplace) spawn TNL_fwp_setPrices;";
	};
	
	class storage : TNL_Button
	{
		idc = 2102;
		x = 0.330; 
		y = 0.20;	
		w = 0.30;
		text = "Storage";	
		action = "(TNL_gVar_curActiveWorkplace) spawn TNL_fwp_storage;";
	};
	
	class setPeopleCanBuy : TNL_Button
	{			
		idc = 2103;
		x = 0.330;
		y = 0.25;
		w = 0.30;
		text = "Toggle Public Can Buy";
		action = "(TNL_gVar_curActiveWorkplace) spawn TNL_fwp_togglecanbuy;";
	};
	
	class setStocks : TNL_Button
	{			
		idc = 2104;
		x = 0.330;
		y = 0.30;
		w = 0.30;
		text = "Set Stocks";
		action = "(TNL_gVar_curActiveWorkplace) spawn TNL_fwp_setStocks;";
	};
	
	class closebutton : TNL_Button
	{
		x = 0.330;
		y = 0.35;	
		w = 0.30;
		text = "Close";	
		action = "closedialog 0;";
	};
};