/*
Name: dialogBase.hpp
Auhor: Unforgiven
Version: 0.1.0 (29/05/2009)
Description: Base framework for the dialogs
Notes: Only temp until i feel like doing purdy dialogs :D
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

#define CT_STATIC 0
#define CT_BUTTON 1
#define CT_EDIT 2
#define CT_SLIDER 3
#define CT_COMBO 4
#define CT_LISTBOX 5
#define CT_TOOLBOX 6
#define CT_CHECKBOXES 7
#define CT_PROGRESS 8
#define CT_HTML 9
#define CT_STATIC_SKEW 10
#define CT_ACTIVETEXT 11
#define CT_TREE 12
#define CT_STRUCTURED_TEXT 13
#define CT_CONTEXT_MENU 14
#define CT_CONTROLS_GROUP 15
#define CT_XKEYDESC 40
#define CT_XBUTTON 41
#define CT_XLISTBOX 42
#define CT_XSLIDER 43
#define CT_XCOMBO 44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT 80
#define CT_OBJECT_ZOOM 81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK 98
#define CT_USER 99
#define CT_MAP 100
#define CT_MAP_MAIN 101

#define ST_POS 0x0F
#define ST_HPOS 0x03
#define ST_VPOS 0x0C
#define ST_LEFT 0x00
#define ST_RIGHT 0x01
#define ST_CENTER 0x02
#define ST_DOWN 0x04
#define ST_UP 0x08
#define ST_VCENTER 0x0c
#define ST_TYPE 0xF0
#define ST_SINGLE 0
#define ST_MULTI 16
#define ST_TITLE_BAR 32
#define ST_PICTURE 48
#define ST_FRAME 64
#define ST_BACKGROUND 80
#define ST_GROUP_BOX 96
#define ST_GROUP_BOX2 112
#define ST_HUD_BACKGROUND 128
#define ST_TILE_PICTURE 144
#define ST_WITH_RECT 160
#define ST_LINE 176
#define ST_SHADOW 0x100
#define ST_NO_RECT 0x200
#define ST_KEEP_ASPECT_RATIO 0x800
#define ST_TITLE ST_TITLE_BAR + ST_CENTER

//Shades of gray
#define COLOR_Gray_1 0.1, 0.1, 0.1 //Dark gray
#define COLOR_Gray_2 0.2, 0.2, 0.2
#define COLOR_Gray_3 0.3, 0.3, 0.3
#define COLOR_Gray_4 0.4, 0.4, 0.4
#define COLOR_Gray_5 0.5, 0.5, 0.5 //Gray
#define COLOR_Gray_6 0.6, 0.6, 0.6
#define COLOR_Gray_7 0.7, 0.7, 0.7
#define COLOR_Gray_8 0.75, 0.75, 0.75 //Silver
#define COLOR_Gray_9 0.8, 0.8, 0.8 
#define COLOR_Gray_10 0.9, 0.9, 0.9 //Light gray




class TNL_BackgroundSmall
{
	idc = -1;
	type = CT_STATIC;
	style = ST_PICTURE;
	x = 0.13;
	y = 0.24;
	w = 1.2549;
	h = 0.418301;
	colorText[] = {1, 1, 1, 1};
	colorBackground[] = {0,0,0,0};
	text = "\ca\ui\data\ui_background_messagebox_ca.paa";
	font = "Zeppelin32";
	sizeEx = 0.032;
};

class TNL_Background0
{
	idc = -1;
	type = CT_STATIC;
	style = ST_PICTURE;
	x = 0.138;
	y = 0.17;
	w = 0.627451;
	h = 0.836601;
	colorText[] = {1, 1, 1, 1};
	colorBackground[] = {0,0,0,0};
	//text = "\ca\ui\data\ui_mainmenu_background_ca.paa";
	text = "\ca\ui\data\ui_gameoptions_background_ca.paa";
	font = "Zeppelin32";
	sizeEx = 0.032;
};

//Background
class TNL_Background
{
	idc = -1;
	type = CT_STATIC;
	style = ST_PICTURE;
	x = 0.045;
	y = 0.17;
	w = 0.627451;
	h = 0.836601;
	colorText[] = {1, 1, 1, 1};
	colorBackground[] = {0,0,0,0};
	text = "\ca\ui\data\ui_mainmenu_background_ca.paa";
	font = "Zeppelin32";
	sizeEx = 0.032;
};

//Background 2
class TNL_Background2
{
	idc = -1;
	type = CT_STATIC;
	style = ST_PICTURE;
	x = 0.045;
	y = 0.17;
	w = 0.627451;
	h = 0.836601;
	colorText[] = {1, 1, 1, 1};
	colorBackground[] = {0,0,0,0};
	text = "\ca\ui\data\ui_selectisland_background_ca.paa";
	font = "Zeppelin32";
	sizeEx = 0.032;
};

class TNL_Background3
{
	idc = -1;
	type = CT_STATIC;
	style = ST_PICTURE;
	x = 0.045;
	y = 0.17;
	w = 0.627451;
	h = 0.836601;
	colorText[] = {0.8, 0.8, 0.8, 0.8};
	colorBackground[] = {0,0,0,0};
	text = "\ca\ui\data\ui_border_frame_ca.paa";
	font = "Zeppelin32";
	sizeEx = 0.032;
};

class TNL_Title2
{
	access = ReadAndWrite;
	type = CT_STRUCTURED_TEXT;
	idc = -1;
	style = ST_LEFT;

	x = 0.1;
	y = 0.1;
	w = 1.0;
	h = 0.1;
	size = 0.043;
	lineSpacing = 1;

	colorBackground[] = {0,0,0,0};
	colorText[] = {0.6, 0.8392, 0.4706, 0};

	text = "";

	class Attributes
	{
		font  = "Zeppelin33";
		color = "#ffcc00";
		align = "left";
		shadow = true;
	};
};

class TNL_Title
{
	idc = -1;
	type = CT_STATIC;
	x = 0.014706;
	y = 0.182;
	w = 0.950743;
	h = 0.058824;
	font = "Zeppelin32";
	colorBackground[]	= {0,0,0,0};
	colorText[] = {0.6, 0.8392, 0.4706, 1.0};
	sizeEx = 0.04321;
	style = 0;
};

//Frames
class TNL_Frame
{
	idc					= -1;
	type				= CT_STATIC;
	style				= ST_FRAME;
	colorBackground[]	= {1,1,1,1};
	text				= "";
	ColorText[]			= {0.9, 0.8, 0, 1};
	font				= "Zeppelin32";
	sizeEx				= 0.032;
};


//Background frames
class TNL_BackgroundFrame
{
	idc					= -1;
	type				= 0;
	style				= 128;
	colorBackground[]	= {0.1, 0.1, 0.1, 0.55};
	text				= "";
	font				= "EtelkaMonospaceProBold";
	sizeEx = 0.0506536;
	colorText[] = {0.95, 0.95, 0.95, 1};
};


//List control
class TNL_List
{
	idc = -1;
	type = 5;
	style = 0x10;
	font = "Zeppelin32";
	maxHistoryDelay = 1.0;
	autoScrollSpeed = -1;
	autoScrollDelay = 5;
	autoScrollRewind = 0;
	color[] = {1, 1, 1, 1};
	colorText[] = {0.6, 0.8392, 0.4706, 1.0};
	colorScrollbar[] = {0.95, 0.95, 0.95, 1};
	colorSelect[] = {0.95, 0.95, 0.95, 1};
	colorSelect2[] = {0.95, 0.95, 0.95, 1};
	colorSelectBackground[] = {0.424, 0.651, 0.247, 0.3};
	colorSelectBackground2[] = {0.424, 0.651, 0.247, 1};
	period = 0;
	colorBackground[] = {0, 0, 0, 1};
	//sizeEx = 0.026;
	sizeEx = 0.0295;
	//sizeEx = 0.034;
	columns[] = {0.1, 0.7, 0.1, 0.1};

	soundSelect[]			= {"", 0.15, 1};
	soundExpand[]			= {"", 0.15, 1};
	soundCollapse[]			= {"", 0.15, 1};

	rowHeight               = 0.03;

	class ScrollBar
	{
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
		arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
		border = "\ca\ui\data\ui_border_scroll_ca.paa";
	};
};



//Button
class TNL_Button
{
	type = 16;
	idc = -1;
	style = 0;
	default = 0;
	x = 0.1;
	y = 0.1;
	w = 0.183825;
	h = 0.104575;
	color[] = {0.543, 0.5742, 0.4102, 1.0};
	color2[] = {0.95, 0.95, 0.95, 1};
	colorBackground[] = {1, 1, 1, 1};
	colorbackground2[] = {1, 1, 1, 0.4};
	colorDisabled[] = {1, 1, 1, 0.25};
	periodFocus = 1.2;
	periodOver = 0.8;

	class HitZone
	{
		left = 0.004;
		top = 0.029;
		right = 0.004;
		bottom = 0.029;
	};

	class ShortcutPos
	{
		left = 0.0145;
		top = 0.026;
		w = 0.0392157;
		h = 0.0522876;
	};

	class TextPos
	{
		left = 0.05;
		top = 0.034;
		right = 0.005;
		bottom = 0.005;
	};


	textureNoShortcut = "";
	animTextureNormal = "\ca\ui\data\ui_button_normal_ca.paa";
	animTextureDisabled = "\ca\ui\data\ui_button_disabled_ca.paa";
	animTextureOver = "\ca\ui\data\ui_button_over_ca.paa";
	animTextureFocused = "\ca\ui\data\ui_button_focus_ca.paa";
	animTexturePressed = "\ca\ui\data\ui_button_down_ca.paa";
	animTextureDefault = "\ca\ui\data\ui_button_default_ca.paa";
	period = 0.4;
	font = "Zeppelin32";
	size = 0.03921;
	sizeEx = 0.03921;
	text = "";
	soundEnter[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
	soundPush[] = {"\ca\ui\data\sound\new1", 0.09, 1};
	soundClick[] = {"\ca\ui\data\sound\mouse3", 0.07, 1};
	soundEscape[] = {"\ca\ui\data\sound\mouse1", 0.09, 1};
	action = "";
	toolTip = "";

	class Attributes
	{
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};

	class AttributesImage
	{
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "left";
		shadow = "true";
	};
};

class TNL_Button2
{
	type = 16;
	idc = -1;
	style = 0;
	default = 0;
	w = 0.313726;
	h = 0.104575;
	color[] = {0.543, 0.5742, 0.4102, 1.0};
	color2[] = {0.95, 0.95, 0.95, 1};
	colorDisabled[] = {1, 1, 1, 0.25};
	colorBackground[] = {1, 1, 1, 1};
	colorbackground2[] = {1, 1, 1, 0.4};
	
	class HitZone {
		left = 0.0;
		top = 0.0;
		right = 0.0;
		bottom = 0.0;
	};
	
	class ShortcutPos {
		left = 0.0204;
		top = 0.026;
		w = 0.0392157;
		h = 0.0522876;
	};
	
	class TextPos {
		left = 0.08;
		top = 0.034;
		right = 0.005;
		bottom = 0.005;
	};
	textureNoShortcut = "";
	animTextureNormal = "\ca\ui\data\ui_button_main_normal_ca.paa";
	animTextureDisabled = "\ca\ui\data\ui_button_main_disabled_ca.paa";
	animTextureOver = "\ca\ui\data\ui_button_main_over_ca.paa";
	animTextureFocused = "\ca\ui\data\ui_button_main_focus_ca.paa";
	animTexturePressed = "\ca\ui\data\ui_button_main_down_ca.paa";
	animTextureDefault = "\ca\ui\data\ui_button_main_normal_ca.paa";
	period = 0.5;
	font = "Zeppelin32";
	size = 0.03921;
	sizeEx = 0.03921;
	text = "";
	soundEnter[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
	soundPush[] = {"\ca\ui\data\sound\new1", 0.09, 1};
	soundClick[] = {"\ca\ui\data\sound\mouse3", 0.07, 1};
	soundEscape[] = {"\ca\ui\data\sound\mouse1", 0.09, 1};
	action = "";
	toolTip = "";
	
	class Attributes 
	{
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "left";
		shadow = "false";
	};
	
	class AttributesImage 
	{
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "false";
	};
};

class TNL_SmallButton
{
	type = 16;
	idc = -1;
	x = 0.1;
	y = 0.1;
	w = 0.123825;
	h = 0.0522876;
	style = 2;
	color[] = {1, 1, 1, 1};
	color2[] = {1, 1, 1, 0.85};
	colorBackground[] = {1, 1, 1, 1};
	colorbackground2[] = {1, 1, 1, 0.85};
	colorDisabled[] = {1, 1, 1, 0.4};

	textureNoShortcut = "";
	period = 0.4;
	font = "Zeppelin32";
	size = 0.035;
	sizeEx = 0.035;
	text = "";
	soundEnter[] = {"\ca\ui\data\sound\mouse2", 0.09, 1};
	soundPush[] = {"\ca\ui\data\sound\new1", 0.09, 1};
	soundClick[] = {"\ca\ui\data\sound\mouse3", 0.07, 1};
	soundEscape[] = {"\ca\ui\data\sound\mouse1", 0.09, 1};
	action = "";
	toolTip = "";

	class HitZone
	{
		left = 0.002;
		top = 0.003;
		right = 0.002;
		bottom = 0.016;
	};

	class ShortcutPos
	{
		left = -0.006;
		top = -0.007;
		w = 0.0392157;
		h = 0.0522876;
	};

	class TextPos
	{
		left = 0.0;
		top = 0.003;
		right = 0.0;
		bottom = 0.0;
	};
	animTextureNormal = "\ca\ui\data\igui_button_normal_ca.paa";
	animTextureDisabled = "\ca\ui\data\igui_button_disabled_ca.paa";
	animTextureOver = "\ca\ui\data\igui_button_over_ca.paa";
	animTextureFocused = "\ca\ui\data\igui_button_focus_ca.paa";
	animTexturePressed = "\ca\ui\data\igui_button_down_ca.paa";
	animTextureDefault = "\ca\ui\data\igui_button_normal_ca.paa";

	class Attributes
	{
		font = "Zeppelin32";
		color = "#E5E5E5";
		align = "center";
		shadow = "true";
	};
};

//Edit box
class TNL_Edit
{
	idc = -1;
	x = 0.1;
	y = 0.1;
	w = 0.5;
	h = 0.1;
	autocomplete = false;
	type = CT_EDIT;
	style = 0x00 + 0x40;
	font = "Zeppelin32";
	sizeEx = 0.03921;
	colorBackground[] = {0, 0, 0, 1};
	colorText[] = {0.80, 0.80, 0.80, 1};
	colorSelection[] = {0.543, 0.5742, 0.4102, 1.0};
	text = "";
};

//Static text
class TNL_Text
{
	idc = -1;
	type = CT_STATIC;
	x = 0.014706;
	y = 0.182;
	w = 0.950743;
	h = 0.058824;
	font = "Zeppelin32";
	colorBackground[]	= {0,0,0,0};
	colorText[] = {0.6, 0.8392, 0.4706, 1.0};
	sizeEx = 0.031;
	style = 0;
	text = "";
};

//Combo box
class TNL_ComboBox
{
	idc = -1;
	x = 0.1;
	y = 0.1;
	w = 0.12;
	h = 0.035;
	type = CT_COMBO;
	style = ST_LEFT;
	colorSelect[] = {0.023529, 0, 0.0313725, 1};
	colorText[] = {0.023529, 0, 0.0313725, 1};
	colorBackground[] = {0.5, 0.5, 0.5, 1};
	colorSelectBackground[] = {0.543, 0.5742, 0.4102, 1.0};
	colorScrollbar[] = {0.023529, 0, 0.0313725, 1};
	arrowEmpty = "\ca\ui\data\ui_arrow_combo_ca.paa";
	arrowFull = "\ca\ui\data\ui_arrow_combo_active_ca.paa";
	wholeHeight = 0.45;
	color[] = {0, 0, 0, 0.6};
	colorActive[] = {0, 0, 0, 1};
	colorDisabled[] = {0, 0, 0, 0.3};
	font = "Zeppelin32";
	sizeEx = 0.03921;

	soundSelect[] = {"", 0.1, 1};
	soundexpand[] = { "", 0,1};
	soundcollapse[] = { "", 0,1};
	maxHistoryDelay = 1;
	class ScrollBar
	{
		color[] = {1, 1, 1, 0.6};
		colorActive[] = {1, 1, 1, 1};
		colorDisabled[] = {1, 1, 1, 0.3};
		thumb = "\ca\ui\data\ui_scrollbar_thumb_ca.paa";
		arrowFull = "\ca\ui\data\ui_arrow_top_active_ca.paa";
		arrowEmpty = "\ca\ui\data\ui_arrow_top_ca.paa";
		border = "\ca\ui\data\ui_border_scroll_ca.paa";
	};
};

//Structured text
class TNL_StructuredText
{
	access = ReadAndWrite;
	type = CT_STRUCTURED_TEXT;
	idc = -1;
	style = ST_LEFT;

	x = 0.1;
	y = 0.1;
	w = 0.2;
	h = 0.2;
	sizeEx = 0.027;
	size = 0.027;
	lineSpacing = 1;

	colorBackground[] = {0,0,0,0};
	colorText[] = {0.6, 0.8392, 0.4706, 0};

	text = "";

	class Attributes
	{
		font  = "Zeppelin32";
		color = "#E5E5E5";
		align = "left";
		shadow = false;
	};
};
class TNL_StructuredTextBold : TNL_StructuredText
{
	size = 0.028;

	class Attributes
	{
		font  = "Zeppelin33";
		color = "#E5E5E5";
		align = "left";
		shadow = false;
	};
};
class TNL_StructuredHeader
{
	access = ReadAndWrite;
	type = CT_STRUCTURED_TEXT;
	idc = -1;
	style = ST_LEFT;

	x = 0.1;
	y = 0.1;
	w = 0.1;
	h = 0.05;
	sizeEx = 0.027;
	size = 0.035;
	lineSpacing = 1;

	colorBackground[] = {0,0,0,0};
	colorText[] = {0.6, 0.8392, 0.4706, 0};

	text = "";

	class Attributes
	{
		font  = "Zeppelin33";
		color = "#ffcc00";
		align = "left";
		shadow = true;
		shadowColor = "#000000";
	};
};

class TNL_HTML
{
  idc = -1;
  type = CT_HTML; // defined constant (9)
  style = ST_LEFT; // defined constant (0)

  x = 0.1;
  y = 0.1;
  w = 0.6;
  h = 0.5;

  text="";

  colorBackground[] = {0,0,0,0};
  colorBold[] = {1, 1, 1, 1};
  colorLink[] = {0, 0, 1, 1};
  colorLinkActive[] = {1, 0, 0, 1};
  colorPicture[] = {1, 1, 1, 1};
  colorPictureBorder[] = {1, 0, 0, 1};
  colorPictureLink[] = {0, 0, 1, 1};
  colorPictureSelected[] = {0, 1, 0, 1};
  colorText[] = {1, 1, 1, 1};

  prevPage = "\ca\ui\data\arrow_left_ca.paa";
  nextPage = "\ca\ui\data\arrow_right_ca.paa";

	class H1 {
		font = "Zeppelin32";
		fontBold = "Zeppelin33";
		sizeEx = 0.02474;
	};

	class H2 {
		font = "Zeppelin32";
		fontBold = "Zeppelin33";
		sizeEx = 0.0286458;
	};

	class H3 {
		font = "Zeppelin32";
		fontBold = "Zeppelin33";
		sizeEx = 0.0286458;
	};

	class H4 {
		font = "Zeppelin33Italic";
		fontBold = "Zeppelin33";
		sizeEx = 0.0208333;
	};

	class H5 {
		font = "Zeppelin32";
		fontBold = "Zeppelin33";
		sizeEx = 0.0208333;
	};

	class H6 {
		font = "Zeppelin32";
		fontBold = "Zeppelin33";
		sizeEx = 0.0208333;
	};

	class P {
		font = "Zeppelin32";
		fontBold = "Zeppelin33";
		sizeEx = 0.0208333;
	};
};

class TNL_activeText
{
	idc = -1;
	type = CT_ACTIVETEXT;
	style = ST_LEFT;
	x = 0.75;
	y = 0.5;
	w = 0.07;
	h = 0.027;
	font = "Zeppelin32";
	sizeEx = 0.027;
	color[] = {0.6, 0.8392, 0.4706, 1};
	colorActive[] = { 1, 0.2, 0.2, 1 };
	soundEnter[] = { "", 0, 1 };   // no sound
	soundPush[] = { "", 0, 1 };
	soundClick[] = {"\ca\ui\data\sound\mouse3", 0.07, 1};
	soundEscape[] = { "", 0, 1 };
	text = "activetext";
	default = true;
};

class TNL_SliderH
{
	access  = ReadandWrite;
	type    = CT_SLIDER;
	idc     = -1;
	sizeEx  = 0.025;
	style   = 1024;
	color[] = {0.6, 0.8392, 0.4706, 1};
	colorActive[] = {1, 1, 1, 1};
};

class TNL_SliderV
{
	access  = ReadandWrite;
	type    = CT_SLIDER;
	idc     = -1;
	sizeEx  = 0.025;
	style   = 0;
	color[] = {0.6, 0.8392, 0.4706, 1};
	colorActive[] = {1, 1, 1, 1};
};
