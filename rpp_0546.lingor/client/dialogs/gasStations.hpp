/*
Name: db.hpp
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (06/06/2009)
Description: Dialogs for user DB system
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

class TNL_dlg_gasSelectType
{
	idd = 1301;
	movingEnable = false;
	controlsBackground[] = {  Background, leadedBG, unleadedBG, dieselBG };
	objects[] = { };
	controls[] = { Title, leadedBtn, leadedInfo, unleadedBtn, unleadedInfo, dieselBtn, dieselInfo, cancelBtn };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";	
	
	class Background : TNL_Background
	{
		x = 0.20;
		y = 0.25;
		w = 1.0;
		h = 0.54;
	};
	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.25;
		y = 0.26;
		w = 0.5;
		h = 0.1;
		Text = "Select fuel type";
	};
	
	class leadedBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.23;
		y = 0.32;
		w = 0.46;
		h = 0.09;
	};
	class leadedBtn : TNL_Button
	{
		idc = -1;
		x = 0.25;
		y = 0.31;
		text = "Leaded";
		action = "closeDialog 0; [0] spawn TNL_fgas_hasNozzle;";
	};
	class leadedInfo : TNL_StructuredText
	{
		idc = 11;
		x = 0.45;
		y = 0.35;
		w = 0.62;
		h = 0.315;
		Text = "x U per liter";
	};
	
	class unleadedBG : leadedBG
	{
		y = 0.42;
	};
	class unleadedBtn : leadedBtn
	{
		y = 0.41;
		text = "Unleaded";
		action = "closeDialog 0; [1] spawn TNL_fgas_hasNozzle;";
	};
	class unleadedInfo : leadedInfo
	{
		idc = 21;
		y = 0.45;
	};
	
	class dieselBG : leadedBG
	{
		y = 0.52;
	};
	class dieselBtn : leadedBtn
	{
		y = 0.51;
		text = "Diesel";
		action = "closeDialog 0; [2] spawn TNL_fgas_hasNozzle;";
	};
	class dieselInfo : leadedInfo
	{
		idc = 31;
		y = 0.55;
	};
	
	class cancelBtn : TNL_Button
	{
		idc = -1;
		x = 0.35;
		y = 0.615;
		text = $STRS_gen_btnCancel;
		action = "closeDialog 0;";
	};
};

class TNL_dlg_gasTanked
{
	idd = 1302;
	movingEnable = false;
	controlsBackground[] = {  Background, costUnitBG, tankedBG, costAllBG };
	objects[] = { };
	controls[] = { Title, costUnitInfo, costUnitValue, tankedInfo, tankedValue, costAllInfo, costAllValue, cancelBtn };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";	
	
	class Background : TNL_Background
	{
		x = 0.30;
		y = 0.25;
		w = 0.7;
		h = 0.54;
	};
	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.35;
		y = 0.26;
		w = 0.5;
		h = 0.1;
		Text = "Refueling...";
	};
	
	class costUnitBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.33;
		y = 0.32;
		w = 0.30;
		h = 0.09;
	};
	class costUnitInfo : TNL_StructuredTextBold
	{
		idc = 11;
		x = 0.35;
		y = 0.35;
		w = 0.62;
		h = 0.315;
		Text = "Cost per liter:";
		
		class Attributes
		{
			font  = "Zeppelin32";
			color = "#ffcc00";
			align = "left";
			shadow = false;
		};
	};
	class costUnitValue : TNL_StructuredText
	{
		idc = 12;
		x = 0.50;
		y = 0.35;
		w = 0.62;
		h = 0.315;
		text = "23 UPK";
	};
	class tankedBG : costUnitBG
	{
		y = 0.42;
	};
	class tankedInfo : costUnitInfo
	{
		idc = 21;
		y = 0.45;
		Text = "Liters tanked:";
	};
	class tankedValue : costUnitValue
	{
		idc = 22;
		y = 0.45;
		text = "31 L";
	};
	
	class costAllBG : costUnitBG
	{
		y = 0.52;
	};
	class costAllInfo : costUnitInfo
	{
		idc = 31;
		y = 0.55;
		Text = "Overall price:";
	};
	class costAllValue : costUnitValue
	{
		idc = 22;
		y = 0.55;
		text = "541 UPK";
	};
	
	class cancelBtn : TNL_Button
	{
		idc = -1;
		x = 0.4;
		y = 0.615;
		text = "Stop";
		action = "closeDialog 0;";
	};
};

class TNL_dlg_gasRefilTanks
{
	idd = 1303;
	movingEnable = false;
	controlsBackground[] = {  Background, fuelTypeBG, tankingBG };
	objects[] = { };
	controls[] = { Title, fuelTypeInfo, fuelTypeValue, cisternInfo, cisternValue, tankInfo, tankValue, startBtn, stopBtn, closeBtn };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";	
	
	class Background : TNL_Background
	{
		x = 0.30;
		y = 0.25;
		w = 0.7;
		h = 0.54;
	};
	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.35;
		y = 0.26;
		w = 0.5;
		h = 0.1;
		Text = "Refilling...";
	};
	
	class fuelTypeBG : TNL_BackgroundFrame
	{
		x = 0.33;
		y = 0.32;
		w = 0.30;
		h = 0.09;
	};
	class fuelTypeInfo : TNL_StructuredTextBold
	{
		x = 0.35;
		y = 0.35;
		w = 0.62;
		h = 0.315;
		Text = "Fuel type:";
		
		class Attributes
		{
			font  = "Zeppelin32";
			color = "#ffcc00";
			align = "left";
			shadow = false;
		};
	};
	class fuelTypeValue : TNL_StructuredText
	{
		idc = 1;
		x = 0.50;
		y = 0.35;
		w = 0.62;
		h = 0.315;
		text = "...";
	};
	class tankingBG : fuelTypeBG
	{
		y = 0.42;
		h = 0.19;
	};
	class cisternInfo : fuelTypeInfo
	{
		y = 0.45;
		Text = "Cistern:";
	};
	class cisternValue : fuelTypeValue
	{
		idc = 2;
		y = 0.45;
		text = "... L";
	};
	class tankInfo : fuelTypeInfo
	{
		y = 0.50;
		Text = "Station's tank:";
	};
	class tankValue : fuelTypeValue
	{
		idc = 3;
		y = 0.50;
		text = ".../... L";
	};
	
	class startBtn : TNL_Button
	{
		idc = 4;
		x = 0.4;
		y = 0.52;
		text = "Start";
		action = "TNL_gas_doTankFromCistern = true";
	};
	class stopBtn : startBtn
	{
		idc = 5;
		text = "Stop";
		action = "TNL_gas_doTankFromCistern = false";
	};
	
	class closeBtn : startBtn
	{
		idc = 6;
		y = 0.615;
		text = "Close";
		action = "closeDialog 0;";
	};
};

class TNL_dlg_gasRefilCar
{
	idd = 1304;
	movingEnable = false;
	controlsBackground[] = {  Background, fuelTypeBG, tankingBG };
	objects[] = { };
	controls[] = { Title, fuelTypeInfo, fuelTypeValue, fuelPriceInfo, fuelPriceValue, tankedInfo, tankedValue, totalInfo, totalValue, startBtn, stopBtn, closeBtn };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";	
	
	class Background : TNL_Background
	{
		x = 0.30;
		y = 0.25;
		w = 0.7;
		h = 0.59;
	};
	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.35;
		y = 0.26;
		w = 0.5;
		h = 0.1;
		Text = "Refilling...";
	};
	
	class fuelTypeBG : TNL_BackgroundFrame
	{
		x = 0.33;
		y = 0.32;
		w = 0.30;
		h = 0.14;
	};
	class fuelTypeInfo : TNL_StructuredTextBold
	{
		x = 0.35;
		y = 0.35;
		w = 0.62;
		h = 0.315;
		Text = "Fuel type:";
		
		class Attributes
		{
			font  = "Zeppelin32";
			color = "#ffcc00";
			align = "left";
			shadow = false;
		};
	};
	class fuelTypeValue : TNL_StructuredText
	{
		idc = 1;
		x = 0.50;
		y = 0.35;
		w = 0.62;
		h = 0.315;
		text = "...";
	};
	class fuelPriceInfo : fuelTypeInfo
	{
		y = 0.4;
		Text = "Fuel price:";
	};
	class fuelPriceValue : fuelTypeValue
	{
		idc = 2;
		y = 0.4;
		text = "... UPK/L";
	};

	class tankingBG : fuelTypeBG
	{
		y = 0.47;
		h = 0.19;
	};
	class tankedInfo : fuelTypeInfo
	{
		y = 0.50;
		Text = "Litres tanked:";
	};
	class tankedValue : fuelTypeValue
	{
		idc = 3;
		y = 0.50;
		text = "... L";
	};
	class totalInfo : fuelTypeInfo
	{
		y = 0.55;
		Text = "Total price:";
	};
	class totalValue : fuelTypeValue
	{
		idc = 3;
		y = 0.55;
		text = "... UPK";
	};
	
	class startBtn : TNL_Button
	{
		idc = 4;
		x = 0.4;
		y = 0.57;
		text = "Start";
		action = "TNL_gas_doTankFromCistern = true";
	};
	class stopBtn : startBtn
	{
		idc = 5;
		text = "Stop";
		action = "TNL_gas_doTankFromCistern = false";
	};
	
	class closeBtn : startBtn
	{
		idc = 6;
		y = 0.655;
		text = "Close";
		action = "closeDialog 0;";
	};
};