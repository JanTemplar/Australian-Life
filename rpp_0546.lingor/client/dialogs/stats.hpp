/*
Name: stats.hpp
Author: The New Life team (thenewlife-rpg.com)
Version: 0.1.0 (26/06/2009)
Description: Dialogs for stats
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

class DlgStats
{
	idd = 4;
	movingEnable = true;
	controlsBackground[] = { Background, FilterBG, StatsBG  };
	objects[] = { };
	controls[] = { Title, StatsList, StatsInfo, FilterList, StatsTitle };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class Background : TNL_Background
	{
		x = 0.125;
		y = 0.045;
		w = 1.60;
		h = 1.10;
	};

	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.20;
		y = 0.0885;
		w = 0.5;
		h = 0.1;
		Text = "Player stats menu";
	};

	class FilterBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.165;
		y = 0.18;
		w = 0.32;
		h = 0.61;
	};

	class StatsBG : TNL_BackgroundFrame
	{
		idc = -1;
		x = 0.50;
		y = 0.18;
		w = 0.43;
		h = 0.61;
	};

	class StatsList : TNL_List
	{
		idc = 1;
		x = 0.50;
		y = 0.22;
		w = 0.42;
		h = 0.54;
		onLBSelChanged  = "";
		sizeEx = 0.027;
		rowHeight  = 0.025;
		colorSelectBackground[] = {0, 0, 0, 0};
		colorSelectBackground2[] = {0, 0, 0, 0};
	};

	class StatsTitle : TNL_Title2
	{
		idc = 4;
		x = 0.56;
		y = 0.195;
		w = 0.30;
		h = 0.20;
		text = "";
		sizeEx = 0.034;

		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "center";
			shadow = true;
		};
	};

	class StatsInfo : TNL_StructuredText
	{
		idc = 2;
		x = 0.1662;
		y = 0.185;
		w = 0.30;
		h = 0.27;
		Text = "";
	};

	class FilterList : TNL_List
	{
		idc = 3;
		x = 0.165;
		y = 0.49;
		w = 0.32;
		h = 0.27;
		rowHeight = 0.05;
		colorText[] = {0.8, 0.8, 0.8, 0.8};
		onLBSelChanged  = "[((findDisplay 4) displayCtrl 2)] call TNL_fstats_updateInfo; [] call TNL_fstats_viewStats;";
	};

};
