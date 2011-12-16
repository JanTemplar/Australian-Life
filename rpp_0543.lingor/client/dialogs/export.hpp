class DlgImportExport
{
	idd = 2300;
	movingEnable = true;
	controlsBackground[] = {  Background };
	objects[] = { };
	controls[] = { };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Background : TNL_Background0
	{
		x = 0.125;
		y = 0.045;
		w = 0.88;
		h = 1.10;
	};	
};
	
	