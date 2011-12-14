class DlgMobilePhone
{
	idd = -1;
	movingEnable = true;
	controlsBackground[] = {DLG_BACK1};
	objects[] = { };
	controls[] = { message, cost, submit, cancel, playerList};

	class DLG_BACK1: TNL_Background0
	{
		x = 0.04; 
		y = 0.30;
		w = 0.91; 
		h = 0.25;
	};		

	class message :  TNL_Edit
	{
		idc = 1;
		x = 0.08; 
		y = 0.33;
		w = 0.75;
		h = 0.04;
		onChar = "";
		text = "";
	};
	
	class cost : TNL_Text
	{
		idc = 4;
		x = 0.07; 
		y = 0.42;
		w = 0.20; 
		h = 0.04;
		text = "Text cost";
	};
	class submit : TNL_Button
	{
		idc = 3;
		x = 0.28; 
		y = 0.35;
		text = "Submit";
	};
	
	class cancel : TNL_Button
	{
		idc = 5;
		x = 0.45; 
		y = 0.35;
		text = "Cancel";
		action = "closedialog 0;";
	};
	
	class playerList : TNL_ComboBox
	{
		idc = 2;
		x = 0.07; 
		y = 0.38;
		w = 0.20; 
		h = 0.04;
	};
};

/*
// PhoneCallDescriptionmenu
class Phonecalldescriptiondialog
{
	idd = -1;
	movingEnable = true;
	controlsBackground[] = {DLG_BACK1, background};
	objects[] = { };
	controls[] = {eingabefeld, submit, cancel, dummybutton};

	class DLG_BACK1: RscBackground
	{
		x = 0.04; y = 0.30;
		w = 0.91; h = 0.13;
	};														
	class background : RscBgRahmen
	{
		x = 0.04; y = 0.30;
		w = 0.91; h = 0.13;
		text = $STRD_phone_descriptionfield;
	};
	class eingabefeld : RscEdit
	{
		idc = 1;
		x = 0.05; y = 0.33;
		w = 0.89; h = 0.04;
		onChar = "[_this, 1] call TastenDruck;";
	};
	class submit : RscButton
	{
		idc = 3;
		x = 0.05; y = 0.38;
		w = 0.20; h = 0.04;
		text = $STRD_description_handy_submit;
	};
	class cancel : RscButton
	{
		idc = 5;
		x = 0.74; y = 0.38;
		w = 0.20; h = 0.04;
		text = $STRD_description_cancel;
		action = "closedialog 0; ";
	};
	class dummybutton : RscDummy
	{
		idc = 1066;
	};
};
*/