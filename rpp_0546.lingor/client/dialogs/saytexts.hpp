class DlgSaytexts
{
	idd = 2000;
	movingEnable = true;
	controlsBackground[] = {DLG_BACK1};
	objects[] = { };
	controls[] = {enterText1, enterText2, enterText3, enterText4, button_save, button_cancel};

	class DLG_BACK1: TNL_Background0
	{
		x = 0.15; 
		y = 0.20;
		w = 0.80; 
		h = 0.50;
	};

	class enterText1 : TNL_Edit
	{
		idc = 1;
		x = 0.20; 
		y = 0.30;
		w = 0.50; 
		h = 0.04;
		onChar = "";
	};
	
	class enterText2 : TNL_Edit
	{
		idc = 2;
		x = 0.20; 
		y = 0.35;
		w = 0.50; 
		h = 0.04;
		onChar = "";
	};

	class enterText3 : TNL_Edit
	{
		idc = 3;
		x = 0.20; 
		y = 0.40;
		w = 0.50; 
		h = 0.04;
		onChar = "";
	};

	class enterText4 : TNL_Edit
	{
		idc = 4;
		x = 0.20; 
		y = 0.45;
		w = 0.50; 
		h = 0.04;
		onChar = "";
	};

	class button_cancel : TNL_Button
	{
		x = 0.52; 
		y = 0.58;
		text = "Back";
		action = "closedialog 0;";
	};
	
	class button_save : TNL_Button
	{
		x = 0.27; 
		y = 0.58;
		text = "Save";
		action = "[""save""] execVM ""slr\saytexts.sqf"";";
	};

};