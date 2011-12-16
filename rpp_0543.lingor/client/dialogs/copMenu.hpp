class DlgCopMenu
{
	idd = -1;
	movingEnable = true;
	controlsBackground[] = {DLG_BACK1};	
	objects[] = { };
	controls[] = {Title, priswantbutton, crimelog, copmarkers, closebutton, impoundvcl, impoundwep};		
	
	class DLG_BACK1: TNL_Background		
	{
		x = 0.320;
		y = 0.085;
		w = 0.65;
		h = 0.75;	
	};
	
	class Title : TNL_Title2
	{
		idc = 26;
		x = 0.365;
		y = 0.11;
		w = 0.5;
		h = 0.1;
		Text = "Police Menu";
	};

	class priswantbutton : TNL_Button
	{
		x = 0.330;
		y = 0.15;
		w = 0.30;
		text = "Prison/Wanted Menu";
		action = "closedialog 0; [""wantedrelease""] execVM ""slr\wanted.sqf"";";
	};
	
	class crimelog : TNL_Button
	{
		x = 0.330; 
		y = 0.20;	
		w = 0.30;
		text = "Crime log";	
		action = "closedialog 0; [] execVM ""slr\crimelog.sqf"";";
	};
	
	class copmarkers : TNL_Button
	{			
		x = 0.330;
		y = 0.25;
		w = 0.30;
		text = "Panic Button On/Off";
		action = "closedialog 0; [] execVM ""copNeedSupport.sqf"";";
	};
	
	class impoundvcl : TNL_Button
	{			
		x = 0.330;
		y = 0.30;
		w = 0.30;
		text = "Impound Vehicle";
		action = "closedialog 0; [] execVM ""slr\impound.sqf"";";
	};
	
	class impoundwep : TNL_Button
	{			
		x = 0.330;
		y = 0.35;
		w = 0.30;
		text = "Impound Weapons";
		action = "closedialog 0; [] execVM ""slr\impoundweapons.sqf"";";
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

class DlgWantedRelease
{
	idd = 1800;
	movingEnable = true;
	controlsBackground[] = {DLG_BACK1};
	objects[] = { };
	controls[] = {civlist, bounty_amount, cost, header1, submit, header2, cancel, civlist2, submit2, set_unwanted};
	
	class DLG_BACK1: TNL_Background0
	{
		x = 0.16;
		y = 0.25;
		w = 0.74;
		h = 0.35;
	};
	
	class civlist : TNL_ComboBox
	{
		idc = 1;
		x = 0.17;
		y = 0.33;
		w = 0.15;
		h = 0.04;
	};
	class bounty_amount  : TNL_Edit
	{
		idc = 2;
		x = 0.17;
		y = 0.38;
		w = 0.32;
		h = 0.04;
		text = "1";
	};
	class cost : TNL_Text
	{
		idc = 3;
		x = 0.32;
		y = 0.33;
		w = 0.16;
		h = 0.04;
		text = "Bounty:";
	};
	class header1 : TNL_Text
	{
		x = 0.17;
		y = 0.28;
		w = 0.31;
		h = 0.04;
		style = ST_CENTER;
		text = "Wanted Menu";
	};
	
	class submit : TNL_Button
	{
		x = 0.16;
		y = 0.43;
		text = "Set Bounty";
		action = "[""setBounty"", (call compile lbData [1, lbCurSel 1]), (ctrlText 2), 0] execVM ""slr\wanted.sqf""; closeDialog 0";
	};
	class header2 : TNL_Text
	{
		x = 0.52;
		y = 0.28;
		w = 0.30;
		h = 0.04;
		style = ST_CENTER;
		text = "Release Prisoner";
	};

	class cancel : TNL_Button
	{
		x = 0.58;
		y = 0.43;
		text = "Cancel";
		action = "closedialog 0";
	};
	class civlist2 : TNL_ComboBox
	{
		idc = 11;
		x = 0.52;
		y = 0.33;
		w = 0.14;
		h = 0.04;
	};
	class submit2 : TNL_Button
	{
		x = 0.67;
		y = 0.33;
		text = "Submit";
		action = "[(call compile lbData [11, lbCurSel 11])] execVM ""slr\freeprisoner.sqf""; closeDialog 0";
	};
	class set_unwanted : TNL_Button
	{
		x = 0.325;
		y = 0.44;
		text = "Rem Bounty";
		action = "[""setBounty"", (call compile lbData [1, lbCurSel 1]), 0, 1] execVM ""slr\wanted.sqf""; closeDialog 0";
	};
};
