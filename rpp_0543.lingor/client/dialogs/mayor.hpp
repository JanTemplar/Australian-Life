class DlgMayor
{
	idd = 100;
	movingEnable = true;
	controlsBackground[] = { DLG_BACK1, DLG_BACK2, Title1, Title2 };
	objects[] = { };
	controls[] = {playerlist, submit, cancel, chief_list, chief_submit, chief_cancel };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Title1 : TNL_Title2
	{
		idc = -1;
		x = 0.20;
		y = 0.0885;
		w = 0.5;
		h = 0.1;
		Text = "Mayor";
	};
	
	class Title2 : TNL_Title2
	{
		idc = -1;
		x = 0.60;
		y = 0.0885;
		w = 0.5;
		h = 0.1;
		Text = "Chief";
	};
	
	class DLG_BACK1: TNL_Background0
	{
		x = 0.16;
		y = 0.06;
		w = 0.30;
		h = 0.80;
	};
	
	class DLG_BACK2 : TNL_Background0
	{
		x = 0.56;
		y = 0.06;
		w = 0.30;
		h = 0.80;
	};
	
	class chief_list : TNL_List
	{
		idc = 101;
		x = 0.58;
	    y = 0.16;
	    w = 0.26;
	    h = 0.45;
		sizeEx = 0.0295;
	};
	
	class chief_submit : TNL_Button
	{
		x = 0.62;
		y = 0.60;
		text = "Submit"; //$STRD_description_chief_submit;
		//action = "[0,1,2,[""Clientchief"", lbData [5000, (lbCurSel 5000)]]] execVM ""mayor.sqf""; closedialog 0";
	};
	
	class chief_cancel : TNL_Button
	{
		x = 0.62;
		y = 0.65;
		text = "Cancel"; //$STRD_description_buyitem_close;
		action = "closedialog 0;";
	};
	           
	class playerlist : TNL_List
	{
		x = 0.18;
		y = 0.16;
		w = 0.26;
		h = 0.45;
		idc = 1;
		sizeEx = 0.0295;
	};
	
	class submit : TNL_Button
	{
		x = 0.22;
		y = 0.6;
		text = "Submit"; // $STRD_description_wahl_submit;
		action = "[0,1,2,[""ClientElectMayor"", lbData [1, (lbCurSel 1)]]] execVM ""slr\mayor.sqf"";";
	};
	class cancel : TNL_Button
	{
		x = 0.22;
		y = 0.65;
		text = "Cancel"; //$STRD_description_buyitem_close;
		action = "closedialog 0;";
	};
};
