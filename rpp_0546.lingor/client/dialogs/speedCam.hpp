class DlgSpeedCam
{
	idd = 1900;
	movingEnable = true;
	controlsBackground[] = {DLG_BACK1, Title1};
	objects[] = { };
	controls[] = {slider, text, value, submit, cancel};
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";

	class DLG_BACK1: TNL_Background0
	{
		idc = -1;
		x = 0.04; 
		y = 0.29;
		w = 0.91; 
		h = 0.09;
	};
	class Title1 : TNL_Title2
	{
		idc = -1;
		x = 0.04; 
		y = 0.29;
		w = 0.91; 
		h = 0.09;
		text = Speed Camera Configuration;
	};
	class slider : TNL_SliderH
	{
		idc = 1;
		x = 0.05; y = 0.32;
		w = 0.44; h = 0.04;
	};
	class text : TNL_Text
	{
		idc = 2;
		x = 0.50; y = 0.32;
		w = 0.08; h = 0.04;
		SizeEX = 0.02;
		text = "";
	};
	class value : TNL_Text
	{
		idc = 3;
		x = 0.50; y = 0.32;
		w = 0.08; h = 0.04;
		SizeEX = 0.02;
	};
	class submit : TNL_Button
	{
		idc = 4;
		x = 0.63;
		y = 0.32;
		text = "Ok";
	};
	class cancel : TNL_Button
	{
		idc = 5;
		x = 0.78;
		y = 0.32;
		text = "Cancel";
		action = "closedialog 0";
	};
};