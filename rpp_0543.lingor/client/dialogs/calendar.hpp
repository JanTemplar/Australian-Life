class TNL_dlg_calendar
{
	idd = 161;
	movingEnable = true;
	controlsBackground[] = { background, daysBG, dayLine1, dayLine2, dayLine3, dayLine4, dayLine5, dayLine6, dayLine7, weekLine1, weekLine2, weekLine3, weekLine4, weekLine5, hLine, hLine2, vLine, vLine2 };
	objects[] = { };
	controls[] = { Title, date, weekNum1, weekInfo, sundayInfo, mondayInfo, tuesdayInfo, wednesdayInfo, thursdayInfo, fridayInfo, saturdayInfo };
	
	class Background : TNL_Background0
	{
		x = 0.20;
		y = 0.05;
		w = 0.65;
		h = 1.00;
	};
	class Title : TNL_Title2
	{
		idc = 1;
		x = 0.25;
		y = 0.085;
		text = "Calendar";
	};
	
	class date : TNL_Title2
	{
		x = 0.2;
		y = 0.17;
		w = 0.6;
		size = 0.038;
		
		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffcc00";
			align = "center";
			shadow = true;
		};
		text = "May 2001";
	};
	class daysBG : TNL_BackgroundFrame
	{
		x = 0.23;
		y = 0.22;
		w = 0.50;
		h = 0.46;
	};
	class weekInfo : TNL_StructuredText
	{
		x = 0.24;
		y = 0.235;
		w = 0.06;
		size = 0.024;
		text = "Week";
		
		class Attributes
		{
			font  = "Zeppelin32";
			color = "#ffffff";
			align = "center";
			shadow = true;
		};
	};
	class hLine : TNL_Frame
	{
		x = 0.245;
		y = 0.27;
		w = 0.475;
		h = 0.003;
	};
	class hLine2 : hLine
	{
		y = 0.271;
		h = 0.0;
	};
	class vLine : hLine
	{
		x = 0.3;
		y = 0.23;
		w = 0.003;
		h = 0.44;
	};
	class vLine2 : vLine
	{
		x = 0.302;
		w = 0.0;
	};
	class sundayInfo : weekInfo
	{
		x = 0.30;
		y = 0.23;
		text = "Su";
		size = 0.033;
		
		class Attributes
		{
			font  = "Zeppelin33";
			color = "#ffffff";
			align = "center";
			shadow = true;
		};
	};
	class mondayInfo : sundayInfo
	{
		x = 0.36;
		text = "Mo";
	};
	class tuesdayInfo : sundayInfo
	{
		x = 0.42;
		text = "Tu";
	};
	class wednesdayInfo : sundayInfo
	{
		x = 0.48;
		text = "W";
	};
	class thursdayInfo : sundayInfo
	{
		x = 0.54;
		text = "Th";
	};
	class fridayInfo : sundayInfo
	{
		x = 0.60;
		text = "Fr";
	};
	class saturdayInfo : sundayInfo
	{
		x = 0.66;
		text = "Sa";
	};
	
	class dayLine1 : vLine
	{
		x = 0.36;
		y = 0.235;
		w = 0.0;
		h = 0.435;
		colorText[]	= {0.3, 0.3, 0.3, 0.7};
	};
	class dayLine2 : dayLine1
	{
		x = 0.42;
	};
	class dayLine3 : dayLine1
	{
		x = 0.48;
	};
	class dayLine4 : dayLine1
	{
		x = 0.54;
	};
	class dayLine5 : dayLine1
	{
		x = 0.60;
	};
	class dayLine6 : dayLine1
	{
		x = 0.66;
	};
	class dayLine7 : dayLine1
	{
		x = 0.72;
	};
	
	class weekLine1 : hLine
	{
		y = 0.35;
		h = 0.0;
		colorText[]	= {0.3, 0.3, 0.3, 0.7};
	};
	class weekLine2 : weekLine1
	{
		y = 0.43;
	};
	class weekLine3 : weekLine1
	{
		y = 0.51;
	};
	class weekLine4 : weekLine1
	{
		y = 0.59;
	};
	class weekLine5 : weekLine1
	{
		y = 0.67;
	};
	class weekNum1 : TNL_StructuredText
	{
		x = 0.1;
		y = 0.28;
		text = "#1";
	};
};