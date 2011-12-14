class DlgSetLaws
{
	idd = 5211;
	movingEnable = true;
	controlsBackground[] = {DLG_BACK1};
	objects[] = { };
	controls[] = {lawsList, editLaws, submit};
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class DLG_BACK1: TNL_Background0
	{
		x = 0.03;
		y = 0.21;
		w = 0.93;
		h = 0.43;
	};

	class lawsList : TNL_List
	{
		idc = 1;
		x = 0.04;
		y = 0.24;
		w = 0.91;
		h = 0.34;
		onLBSelChanged = "ctrlSetText [2, lbText [1, lbCurSel 1]];";
	};
	class editLaws : TNL_Edit
	{
		idc = 2;
		x = 0.04;
		y = 0.58;
		w = 0.71;
		h = 0.04;
		text = "";
		//onChar = "[_this, 1] call TastenDruck;";
	};
	class submit : TNL_Button
	{
		x = 0.75;
		y = 0.58;
		idc = 3;
		text = "Submit!";
		action = "[0,0,0,[""ClientSetLaws"", lbcursel 1, Ctrltext 2]] execVM ""slr\mayor.sqf""; closedialog 0;";
	};

};