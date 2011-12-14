class DlgEmployeeOpen 
{
	idd = 2201;
	movingEnable = true;
	controlsBackground[] = {  Background, Title, EmployeesBG, SelectedEmployeeBG };
	objects[] = { };
	controls[] = {  employeesLabel, firstNameText, firstNameEdit, lastNameText, lastNameEdit, addBtn, delBtn, accessLevel,
		selectedEmployeeLabel, employeesList };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";

	class Background : TNL_Background
	{
		x = 0.10;
		y = 0.05;
		w = 1.60;
		h = 1.10;
	};
	
	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.15;
		y = 0.10;
		w = 0.5;
		h = 0.1;
		Text = "Corporation Employee";
	};
	
	class employeesLabel : TNL_structuredText
	{
		idc = -1;
		x = 0.13;
		y = 0.17;
		w = 0.45;
		h = 0.3;
		text = "Current Employees:";
	};
	
	class EmployeesBG : TNL_BackgroundFrame
	{
		x = 0.13;
		y = 0.19;
		w = 0.30;
		h = 0.65;
	};
	
	class employeesList : TNL_List
	{
		idc = 2203;
		x = 0.14;
		y = 0.21;
		w = 0.24;
		h = 0.60;
		sizeEx = 0.0295;
		onLBSelChanged  = "";
	};
	
	class SelectedEmployeeBG : TNL_BackgroundFrame
	{
		x = 0.45;
		y = 0.35;
		w = 0.45;
		h = 0.45;
	};
	
	class SelectedEmployeeLabel : TNL_structuredText
	{
		idc = -1;
		x = 0.45;
		y = 0.36;
		w = 0.45;
		h = 0.3;
		text = "Selected Employee:";
	};
	
	
	
	class firstNameText : TNL_StructuredText
	{
		idc = -1;
		x = 0.50;
		y = 0.20;
		w = 0.45;
		h = 0.3;
		text = "Forename";
	};
	
	class firstNameEdit :  TNL_Edit
	{
		idc = 2201;
		x = 0.45;
		y = 0.195;
		w = 0.20;
		h = 0.04;
		text = "";
		onKeyDown = "";
		default = true;
	};
	
	class lastNameText : TNL_StructuredText
	{
		idc = -1;
		x = 0.70;
		y = 0.20;
		w = 0.45;
		h = 0.3;
		text = "Surname";
	};
	
	class lastNameEdit :  TNL_Edit
	{
		idc = 2202;
		x = 0.65;
		y = 0.195;
		w = 0.20;
		h = 0.04;
		text = "";
		onKeyDown = "";
		default = true;
	};
	
	class addBtn :  TNL_Button
	{
		idc = 2205;
		x = 0.45;
		y = 0.21;
		text = "Add";
		action = "";
	};
	
	class delBtn : TNL_Button
	{
		idc = 2206;
		x = 0.65;
		y = 0.21;
		text = "Delete";
		action = "";
	};
	
	class accessLevel : TNL_ComboBox
	{
		idc = 2204;
		x = 0.57;
		y = 0.30;
		w = 0.15;
		h = 0.04;
	};
	
};
class DlgEmployeeManage
{
	idd = 2200;
	movingEnable = true;
	controlsBackground[] = { Background, Title, SiteRightsBG, OptionsBG };
	objects[] = { };
	controls[] = { FirstName, LastName, FirstNameEdit, LastNameEdit, PosTitle, PosEdit, BankNumber, BankEdit, Pay, PayEdit, Site, SiteEdit, SiteRights, SiteRightsBtn,
	SiteRightsList, PostNumber, Save, New, Search, EmployeeNumber, nextPost, prevPost, delBtn };
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";

	class Background : TNL_Background
	{
		x = 0.10;
		y = 0.05;
		w = 1.60;
		h = 1.10;
	};

	class Title : TNL_Title2
	{
		idc = -1;
		x = 0.15;
		y = 0.10;
		w = 0.5;
		h = 0.1;
		Text = "Corporation Employee";
	};

	class FirstName : TNL_StructuredText
	{
		idc = -1;
		x = 0.15;
		y = 0.20;
		w = 0.45;
		h = 0.3;
		text = "Forename: ";
	}; 

	class LastName : TNL_StructuredText
	{
		idc = -1;
		x = 0.15;
		y = 0.25;
		w = 0.45;
		h = 0.3;
		text = "Surname: ";
	};

	class FirstNameEdit : TNL_Edit
	{
		idc = 2201;
		x = 0.25;
		y = 0.195;
		w = 0.405;
		h = 0.04;
		text = "";
		onKeyDown = "";
		default = true;
	};

	class LastNameEdit : TNL_Edit
	{
		idc = 2202;
		x = 0.25;
		y = 0.245;
		w = 0.405;
		h = 0.04;
		text = "";
		onKeyDown = "";
		default = true;
	};

	class PosTitle : TNL_StructuredText
	{
		idc = -1;
		x = 0.15;
		y = 0.30;
		w = 0.45;
		h = 0.3;
		text = "Post: ";
	};

	class PosEdit  : TNL_Edit
	{
		idc = 2203;
		x = 0.25;
		y = 0.295;
		w = 0.405;
		h = 0.04;
		text = "";
		onKeyDown = "";
		default = true;
	};

	class BankNumber : TNL_StructuredText
	{
		idc = -1;
		x = 0.15;
		y = 0.35;
		w = 0.45;
		h = 0.3;
		text = "Bank Acc: ";
	};

	class BankEdit : TNL_Edit
	{
		idc = 2204;
		x = 0.25;
		y = 0.345;
		w = 0.405;
		h = 0.04;
		text = "";
		onKeyDown = "";
		default = true;
	};

	class Pay : TNL_StructuredText
	{
		idc = -1;
		x = 0.15;
		y = 0.40;
		w = 0.45;
		h = 0.3;
		text = "Pay: ";
	};

	class PayEdit : TNL_Edit
	{
		idc = 2205;
		x = 0.25;
		y = 0.395;
		w = 0.405;
		h = 0.04;
		text = "";
		onKeyDown = "";
		default = true;
	};

	class Site : TNL_StructuredText
	{
		idc = -1;
		x = 0.15;
		y = 0.45;
		w = 0.45;
		h = 0.3;
		text = "Location: ";
	};

	class SiteEdit : TNL_ComboBox
	{
		idc = 2206;
		x = 0.25;
		y = 0.445;
		w = 0.32;
		h = 0.04;
	};

	class SiteRightsBtn :  TNL_Button
	{
		idc = -1;
		x = 0.25;
		y = 0.47;
		text = "Select";
		action = "";
	};

	class Save : TNL_Button
	{
		idc = 2210;
		x = 0.7;
		y = 0.20;
		text = "Save";
		action = "";
	};

	class New : TNL_Button
	{
		idc = 2211;
		x = 0.7;
		y = 0.25;
		text = "New Post";
		action = "";
	};

	class Search : TNL_Button
	{
		idc = -1;
		x = 0.7;
		y = 0.30;
		text = "Search";
		action = "";
	};
	
	class nextPost : TNL_Button
	{
		idc = -1;
		x = 0.7;
		y = 0.40;
		text = "Next";
		action = "";
	};
	
	class prevPost : TNL_Button
	{
		idc = -1;
		x = 0.7;
		y = 0.45;
		text = "Prev";
		action = "";
	};
	
	class delBtn : TNL_Button
	{
		idc = -1;
		x = 0.7;
		y = 0.55;
		text = "Delete";
		action = "";
	};

	class SiteRights : TNL_StructuredText
	{
		idc = -1;
		x = 0.15;
		y = 0.50;
		w = 0.45;
		h = 0.3;
		text = "Site Rights: ";
	};

	class SiteRightsBG : TNL_BackgroundFrame
	{
		x = 0.15;
		y = 0.55;
		w = 0.50;
		h = 0.25;
	};

	class optionsBG : TNL_BackgroundFrame
	{
		x = 0.6625;
		y = 0.195;
		w = 0.25;
		h = 0.605;
	};

	class SiteRightsList : TNL_List
	{
		idc = 2207;
		x = 0.1505;
		y = 0.5505;
		w = 0.24;
		h = 0.60;
		sizeEx = 0.0295;
		onLBSelChanged  = "";
	};

	class PostNumber : TNL_StructuredText
	{
		idc = 2208;
		x = 0.15;
		y = 0.875;
		w = 0.45;
		h = 0.3;
		text = "Post Number:";
	};

	class EmployeeNumber : TNL_StructuredText
	{
		idc = 2209;
		x = 0.35;
		y = 0.875;
		w = 0.45;
		h = 0.3;
		text = "Employee Number:";
	};

};