//Fill Mayor Voting Array
voteArray = [];
isMayor = false;

//Holstering Stuff
holmenu = 0;
unholmenu = 0;
holstervar = false;
unholstervar = false;
phasweapon  = false;
HandWeapon = false;

//Drug dealer job 
drugDealerJobLocations = [];
for [{_i=1},{((str getMarkerPos format["DealerJobLocation%1",_i]) != "[0,0,0]")},{_i=_i+1}] do
{
	_obj = format["DealerJobLocation%1", _i];

	drugDealerJobLocations set[(count drugDealerJobLocations), _obj];
};

drugDealerJobSettings =
[
	["mari", [10,1]]
];

if (isNil "drugPriceFlunctuation") then
{
	drugPriceFlunctuation = 
	[
		["mari", 0, 400, 0, 50]
	];
};

drugDealerJobWaitTime = 300;
drugDealerClientChance = 7; //7
drugDealerChanceOfTipOf = 4;
drugAddicts = [ "Hooker1", "Hooker2", "Hooker3", "Hooker4" ];
numDrugAddicts = 30;
isDealer = false;


//Job stuff
workplacejob_taxi_zielarray		= [];
workplacejob_taxi_sperrzeit		= 10;
workplacejob_taxi_multiplikator	= 3;
workplacejob_taxi_maxmoney		= 750;
workplacejob_taxi_numMarkers = 8;

//Create taxi markers
_i = 1;
while {_i <= workplacejob_taxi_numMarkers} do
{
	_markerPos = [0,0,0];
	call compile format['_markerPos = getMarkerPos "taximarker_%1";', _i];
	workplacejob_taxi_zielarray = workplacejob_taxi_zielarray + [_markerPos];
	_i = _i + 1;
};

//Say texts
SLR_gvar_saytexts =
[
	"Holy shit...",
	"O M G",
	"Cheese toasties!!",
	"Fuck"
];

//Objects
HAMM_obj_placing = 0;
INV_objSpawned = [];
INV_objServerSpawned = [];
INV_ObjectsArray = [];
INV_ServerObjArray = [];
INV_PlacingVerbotArray = []; //Object name, distance
INV_objSpawned         = [];
INV_objMaxObject       = 150;
INV_objIdleTime        = (3600 * 60);
INV_objItemScriptNames = 
[
	["Obj_StopLight", "MAP_Stoplight02",[5, 3, 10], [0, -0.5, 0], [0, 5]],
	["Obj_StoneWall", "Fort_StoneWall_EP1",[5, 3, 10], [0, -0.5, 0], [0, 5]]
];

//Phone Stuff
SMS_Cost = 10;

//If player has been stunned
isstunned = false;

if (isNil "currentMayor") then
{
	currentMayor = "";
};


if (isNil "CopLog") then
{
	CopLog = [];
};

wantedBonus  = 500;
{
	call compile format ["bounty_%1 = 0; %1_wanted = 0; %1_arrest = 0; %1_markerjammed = 0; %1_account = 0;", (_x select 3)];
} forEach Gvar_arr_mission_PlayerArray;

if (isNil "INV_ItemTypenArray") then
{
	INV_ItemTypenArray = [ ["Item", "Item", 100], ["Fahrzeug", "Vehicle",100], ["Magazin","Magazine",100], ["Waffe","Weapon",100]];
	lawsArray = 
	[
		"You must follow all road signs and traffic laws",
		"You must own a relevent licence for a gun or car",
		"You could lose your licence if it is abused",
		"Respect and obey the cops orders",
		"Drugs are illegal",
		"Do not break others out from jail",
		"Respect others as you would expect to be yourself",
		"Terrorists will get a large jailtime when caught",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		"",
		""
	]; //End of laws array
	
	//Taxes and stuff...
	GovernmentTaxAccount 	= 10000;
	GblFuelTaxes            = 125;
	GblFactTax		=  25;
	GblWealthTax			= 5;
	GblIncomeTaxClass1      = 25;
	GblIncomeTaxClass2      = 25;
	GblIncomeTaxClass3      = 25;
	GblIncomeTaxClass4      = 25;
	GblIncomeTaxClass5      = 25;
	GblWelfareIncomeLimit   = 1000;
	GblWelfareBankLimit     = 15000;
	PoliceChiefExtraPay		= 1500;
	MayorExtraPay			= 2000;
	add_civmoney 			= 50;
	add_copmoney			= 400;
	add_workplace			= 240;
	uni_training_add		= 750;
	bank_steuer				= 7;
	zinsen_prozent			= 0;    
	taxesPaid = 0;
	Publicvariable "GblFuelTaxes";
	Publicvariable "GblFactTax";
	Publicvariable "GblWealthTax";
	Publicvariable "GblIncomeTaxClass1";
	Publicvariable "GblIncomeTaxClass2";
	Publicvariable "GblIncomeTaxClass3";
	Publicvariable "GblIncomeTaxClass4";
	Publicvariable "GblIncomeTaxClass5";
	Publicvariable "GblWelfareIncomeLimit";
	Publicvariable "GblWelfareBankLimit";
	Publicvariable "add_civmoney";
	Publicvariable "MayorExtraPay";
	Publicvariable "PoliceChiefExtraPay";
	Publicvariable "zinsen_prozent";
	Publicvariable "add_copmoney";
	publicVariable "INV_ItemTypenArray";
	publicVariable "lawsArray";
	publicVariable "zinsen_prozent";
	publicVariable "bank_steuer";
	
};

//Paycheck account number!
if (isNil "TNL_gVar_paycheckAccNum") then
{
	TNL_gVar_paycheckAccNum = "";
};
	
//Respawn 
TNL_gVar_hasRespawned = true;
	
isCop = [player, "COP"] call TNL_fmission_playerIsType;
isCiv = [player, "CIV"] call TNL_fmission_playerIsType;


