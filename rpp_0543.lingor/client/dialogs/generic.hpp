/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/


class TNL_dlg_genYesNo
{
	idd = 1101;
	movingEnable = true;
	controlsBackground[] = {  Background, textBG };
	objects[] = { };
	controls[] = { Title, msgText, noBtn, yesBtn };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Background : TNL_Background0
	{
		x = 0.195;
		y = 0.245;
		w = 0.66;
		h = 0.6;
	};

	class Title : TNL_Title2
	{
		idc = 1;
		x = 0.275;
		y = 0.26;
		w = 0.5;
		h = 0.1;
		Text = "";
	};
	
	class textBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.225;
		y = 0.335;
		w = 0.56;
		h = 0.26;
	};
	class msgText : TNL_StructuredText
	{
		idc = 2;
		x = 0.245;
		y = 0.355;
		w = 0.52;
		h = 0.26;
		text = "";
	};
	
	class yesBtn : TNL_Button
	{
		idc = 10;
		x = 0.42;
		y = 0.58;
		text = $STRS_gen_btnYes;
		action = "";
	};
	class noBtn : TNL_Button
	{
		idc = 11;
		x = 0.605;
		y = 0.58;
		text = $STRS_gen_btnNo;
		action = "";
	};
};


class TNL_dlg_genNotify
{
	idd = 1102;
	movingEnable = true;
	controlsBackground[] = {  Background, textBG };
	objects[] = { };
	controls[] = { Title, msgText, okBtn };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Background : TNL_Background0
	{
		x = 0.195;
		y = 0.245;
		w = 0.66;
		h = 0.6;
	};

	class Title : TNL_Title2
	{
		idc = 1;
		x = 0.275;
		y = 0.26;
		w = 0.5;
		h = 0.1;
		Text = "";
	};
	
	class textBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.225;
		y = 0.335;
		w = 0.56;
		h = 0.26;
	};
	class msgText : TNL_StructuredText
	{
		idc = 2;
		x = 0.245;
		y = 0.355;
		w = 0.52;
		h = 0.26;
		text = "";
	};
	
	class okBtn : TNL_Button
	{
		idc = 10;
		x = 0.42;
		y = 0.58;
		text = $STRS_gen_btnOk;
		action = "";
		shortcuts[] = {0x00050000 + 0, 28, 57, 156};
	};
};

class TNL_dlg_genSlider
{
	idd = 1107;
	movingEnable = true;
	controlsBackground[] = {Background};
	controls[] = { Title, msgText, cancelBtn, submitBtn, sliderTxt,  genSlider };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	
	class Background : TNL_Background0
	{
		x = 0.195;
		y = 0.245;
		w = 0.66;
		h = 0.6;
	};

	class Title : TNL_Title2
	{
		idc = 1;
		x = 0.275;
		y = 0.26;
		w = 0.5;
		h = 0.1;
		Text = "";
	};
	
	class textBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.225;
		y = 0.335;
		w = 0.56;
		h = 0.26;
	};
	
	class msgText : TNL_StructuredText
	{
		idc = 2;
		x = 0.245;
		y = 0.355;
		w = 0.52;
		h = 0.26;
		text = "";
	};
	
	class submitBtn : TNL_Button
	{
		idc = 10;
		x = 0.42;
		y = 0.58;
		text = "Submit";
		action = "";
	};
	
	class cancelBtn : TNL_Button
	{
		idc = 11;
		x = 0.605;
		y = 0.58;
		text = "Cancel";
		action = "closeDialog 0;";
	};
	
	class sliderTxt : TNL_Text 
	{
		idc = 12;
		x = 0.25;
		y = 0.51;
		w = 0.26;
		h = 0.04;
		text = "0";
	};
	
	class genSlider : TNL_SliderH
	{
		idc = 13;
		x = 0.21;
		y = 0.5485;
		w = 0.40;
		h = 0.04;
		onSliderPosChanged = "";
	};
};

class TNL_dlg_genSliderInput
{
	idd = 901;
	movingEnable = true;
	controlsBackground[] = {Background};
	controls[] = { Title, msgText, cancelBtn, submitBtn, sliderTxt,  genSlider };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	
	class Background : TNL_Background0
	{
		x = 0.195;
		y = 0.245;
		w = 0.66;
		h = 0.6;
	};

	class Title : TNL_Title2
	{
		idc = 1;
		x = 0.275;
		y = 0.26;
		w = 0.5;
		h = 0.1;
		Text = "";
	};
	
	class textBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.225;
		y = 0.335;
		w = 0.56;
		h = 0.26;
	};
	
	class msgText : TNL_StructuredText
	{
		idc = 2;
		x = 0.245;
		y = 0.355;
		w = 0.52;
		h = 0.26;
		text = "";
	};
	
	class submitBtn : TNL_Button
	{
		idc = 10;
		x = 0.42;
		y = 0.58;
		text = "Submit";
		action = "";
	};
	
	class cancelBtn : TNL_Button
	{
		idc = 11;
		x = 0.605;
		y = 0.58;
		text = "Cancel";
		action = "closeDialog 0;";
	};
	
	class sliderTxt : TNL_Text 
	{
		idc = 12;
		x = 0.25;
		y = 0.58;
		w = 0.26;
		h = 0.04;
		text = "0";
	};
	
	class genSlider : TNL_SliderH
	{
		idc = 13;
		x = 0.21;
		y = 0.6285;
		w = 0.20;
		h = 0.04;
		onSliderPosChanged = "";
	};
};

class TNL_dlg_genEditInput
{
	idd = 1103;
	movingEnable = true;
	controlsBackground[] = {Background};
	controls[] = { Title, msgText, cancelBtn, submitBtn, editTxt,  genEditbox };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	
	class Background : TNL_Background0
	{
		x = 0.195;
		y = 0.245;
		w = 0.66;
		h = 0.6;
	};

	class Title : TNL_Title2
	{
		idc = 1;
		x = 0.275;
		y = 0.26;
		w = 0.5;
		h = 0.1;
		Text = "";
	};
	
	class textBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.225;
		y = 0.335;
		w = 0.56;
		h = 0.26;
	};
	
	class msgText : TNL_StructuredText
	{
		idc = 2;
		x = 0.245;
		y = 0.355;
		w = 0.52;
		h = 0.26;
		text = "";
	};
	
	class submitBtn : TNL_Button
	{
		idc = 10;
		x = 0.42;
		y = 0.58;
		text = "Submit";
		action = "";
	};
	
	class cancelBtn : TNL_Button
	{
		idc = 11;
		x = 0.605;
		y = 0.58;
		text = "Cancel";
		action = "closeDialog 0;";
	};
	
	class editTxt : TNL_Text 
	{
		idc = 12;
		x = 0.25;
		y = 0.58;
		w = 0.26;
		h = 0.04;
		text = "0";
	};
	
	class genEditBox : TNL_Edit
	{
		idc = 13;
		x = 0.21;
		y = 0.6285;
		w = 0.20;
		h = 0.04;
		text = "0";
	};
};

class TNL_dlg_genListView 
{
	idd = 1104;
	movingEnable = false;
	controlsBackground[] = { Background, ListBG };
	objects[] = { };
	controls[] = { Title, List, CloseBtn };
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
		idc = 1;
		x = 0.360;
		y = 0.1144;
		w = 0.5;
		h = 0.1;
		text = "";
	};

	class List : TNL_List
	{
		idc = 2;
		x = 0.325;
		y = 0.16;
		w = 0.3315;
		h = 0.4675;
	};
	
	class ListBG : TNL_BackgroundFrame
	{
		x = 0.325;
		y = 0.16;
		w = 0.3315;
		h = 0.4675;
	};

	class CloseBtn : TNL_SmallButton
	{
		idc = 3;
		x = 0.42;
		y = 0.635;
		text = "Close";
		action = "closeDialog 0;";
	};
};

class TNL_dlg_genListSelectAmount
{
	idd = 1105;
	movingEnable = false;
	controlsBackground[] = { Background, ListBG };
	objects[] = { };
	controls[] = { Title, List, CloseBtn, SubmitBtn, EditAmount };
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
		idc = 1;
		x = 0.360;
		y = 0.1144;
		w = 0.5;
		h = 0.1;
		text = "";
	};

	class List : TNL_List
	{
		idc = 2;
		x = 0.325;
		y = 0.16;
		w = 0.3315;
		h = 0.4075;
	};
	
	class ListBG : TNL_BackgroundFrame
	{
		x = 0.325;
		y = 0.16;
		w = 0.3315;
		h = 0.4675;
	};
	
	class SubmitBtn : TNL_SmallButton
	{
		idc = 3;
		x = 0.35;
		y = 0.635;
		text = "Submit";
		action = "closeDialog 0;";
	};
	
	class CloseBtn : TNL_SmallButton
	{
		idc = 4;
		x = 0.50;
		y = 0.635;
		text = "Close";
		action = "closeDialog 0;";
	};
	
	class EditAmount : TNL_Edit
	{
		idc = 5;
		x = 0.40;
		y = 0.60;
		w = 0.15;
		h = 0.04;
		text = "0";
	};
};