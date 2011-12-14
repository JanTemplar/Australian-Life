//=================================================================================
INV_smscost		 = 100;
add_civmoney		 = 1000;
add_copmoney		 = 2000;
add_workplace		 = 3000;
copchoprespawntime       = 120;
CopWaffenAvailable       = 0;							
CopIsInPrison            = false;					
CopInPrisonTime          = 300;								
shooting_self            = 0;										
srHinbewegen             = 0;														
deadcam                  = 0;											
isstunned                = false;													
hatGanggebietErobert     = false;												
Antwort                  = 0;           									
CivTimeInPrison          = 0;           			
CopLog                   = [];          														
MayorSteuern             = 0;           						
MayorBekommtSteuern      = 75;          		        	
chiefSteuern             = 0;           						
chiefBekommtSteuern      = 75;				
eigene_zeit              = time;				
money_limit              = 50000000;
bank_limit		 = 50000000; 										
wantedbonus              = 500;         														
StunActiveTime           = 0;  
StunTimePerHit		 = 15; 
MaxStunTime		 = 30;        									 				
GeldStehlenMax           = 200000;
demerits                 = 0;
gtbonus 		 = 10;
gtactive		 = false;
ctactive		 = false;
keyblock		 = false;
maxboars		 = 35;
maxrabbits		 = 35;
maxmanitime		 = 2400;
powerrestorecost	 = 10000;
impoundpay		 = 1000;
noholster		 = false;
MGcost			 = 10000;
PKcost			 = 10000;
SQUADcost		 = 20000;
maxinfai		 = 16;
firestrikes		 = 3;
totalstrikes		 = 3;
facworkercost		 = 3500;
maxfacworkers		 = 25;
firingcaptive		 = false;
pickingup   		 = false;
lockpickchance		 = 20;
planting		 = false;
drugstockinc		 = 900;
druguserate		 = 120;
//========robbing variables===========
stolenfromtime 		 = 900;
stolenfromtimeractive	 = false;  // dont change
TheSafecode = [ceil ((random 12)+0.1),ceil ((random 12)+0.1),ceil ((random 12)+0.1),ceil ((random 12)+0.1),ceil ((random 12)+0.1),ceil ((random 12)+0.1)];
SafecodesCracked = 0;
DreherState = 0;
Processing1 = false;
Safecracked1 = False;
Processing2 = false;
Safecracked2 = False;
Processing3 = false;
Safecracked3 = False;
//===============MOTD==================
motdwaittime = 600;

//===============Cop Patrol==================

pmissionactive = false;
patrolwaittime = false;
patrolmoneyperkm = 3.0;  // 1 would be equal to $3,000 for 1KM
pmissionactive1 = false;
patrolwaittime1 = false;
patrolmoneyperkm1 = 6.0;  // 1 would be equal to $3,000 for 1KM

//=========government convoy=============
govconvoybonus 		 = 45000;
govconvoythiefbonus	 = 45000;
convoyrespawntime        = 60;  //reset to 30 after testing
moneyintruck 		 = true; //dont change

//===== Gas station robbing
maxstationmoney = 40000;
wantedamountforrobbing = 20000;
maxbarmoney = 25000;


if(debug)then{drugstockinc = 6;druguserate = 20};
//==============================PETROL/OIL=========================================
petroluse                = 1;
maxpetroluse             = 300; 
oildemand                = 0.25;
oilsellpricedec          = 30;
oilbaseprice		 = 25000;
//==============================MINING=============================================
shoveldur=20;
shovelmax=2;
pickaxedur=50;
pickaxemax=3;
hammerdur=100;
hammermax=4;
working=false;
//===============================GANGS=============================================
gangincome		 = 6000;
gangcreatecost		 = 75000;
gangdeltime		 = 900;
gangsarray		 = [];
gangmember		 = false;
gangleader		 = false;
gangareas		 = [gangarea1,gangarea2,gangarea3,gangarea4];
//=================================================================================	      							
CityLocationArray        = [[CityLogic1, 500], [CityLogic2, 400], [CityLogic4, 500], [CityLogic5, 200], [Militarybase, 200]];
respawnarray		 = [respawn1];
//=========== cop patrol array ==========
coppatrolarray  = 
[
getmarkerpos "patrolpoint1", 
getmarkerpos "patrolpoint2", 
getmarkerpos "patrolpoint3", 
getmarkerpos "patrolpoint4", 
getmarkerpos "patrolpoint5", 
getmarkerpos "patrolpoint6", 
getmarkerpos "patrolpoint7", 
getmarkerpos "patrolpoint8", 
getmarkerpos "patrolpoint9", 
getmarkerpos "patrolpoint10", 
getmarkerpos "patrolpoint11",
getmarkerpos "patrolpoint12",
getmarkerpos "patrolpoint13"

];

coppatrolarray1  = [getmarkerpos "guardpoint1",getmarkerpos "guardpoint2",getmarkerpos "guardpoint3",getmarkerpos "guardpoint4",getmarkerpos "guardpoint5",getmarkerpos "guardpoint6",getmarkerpos "guardpoint7"];

['schluesselbund', 1] call INV_SetItemAmount;

playerWeapons            = [];														
playerMagazines          = [];
weaponsloaded		 = false;
CopStartGear_Mags        = 

[
"x26_mag",
"x26_mag",
"x26_mag",
"x26_mag",
"x26_mag",
"x26_mag",
"x26_mag",
"x26_mag",
"Smokeshell",
"Smokeshell"

];

CopStartGear_Weap        = ["X26","ItemGPS","Binocular","NVGoggles"];

if (iscop) then 

{
						
RadioTextMsg_1 = "Put your fucking hands up!";				
RadioTextMsg_2 = "Pull over and stay in your vehicle!";
RadioTextMsg_3 = "Drop your weapon and put your hands on your head!";
RadioTextMsg_4 = "Your free to go, have a nice day";		

}
else 
{
																				
RadioTextMsg_1 = "Put your fucking hands up now!";
RadioTextMsg_2 = "Step away from the vehicle!";		
RadioTextMsg_3 = "Do it now or your dead!";						
RadioTextMsg_4 = "Dont shoot i give up!";

};
			
RadioTextArt_1 = "direct";												
RadioTextArt_2 = "direct";											
RadioTextArt_3 = "direct";				
RadioTextArt_4 = "direct";																
		
publicarbeiterarctionarray= [];						

for [{_i=1}, {_i <= civscount}, {_i=_i+1}] do 

{
		
call compile format ["
kopfgeld_civ%1      = 0;	
civ%1_wanted        = 0;
civ%1_mayor         = 0;
civ%1_reason        = [];	
civ%1_arrest        = 0;		
civ%1_markerjammed  = 0;
", _i];		

};

if(isnil "param1")then{param1 = 0};
if(isnil "param2")then{param2 = 1024};

SkipTimeDay	   	 = (floor(param2/100)); 	
SkipTimeNight  	   	 = (param2 mod 100); 

isdead			 = 0;			
local_arrest             = 0;
inv_items		 = 0;
extradeadtime		 = 10;
respawntimeinc		 = 15;
killedplayerinc          = 30;          												
respawnzeit              = 10;          										
DeadWaitSec              = respawnzeit; 							
DeadTimeMax              = 300;         								
deadtimebonus            = 0.001;       															
deadtimes                = 0;
suicidepenalty		 = 90; 
CopsKilled               = 0;           									
CivsKilled               = 0;           												
SelfKilled               = 0;
killstrafe               = 20000;			
copteamkillstrafe	 = 20000;		
GesetzAnzahl             = 10;         				
GesetzArray              = ["Always Drive on the LEFT side of the road", "Do not put hideouts on ANY road, bannable", "Always Holster weapons in Towns.","Speed limits 50 in town 100 out", "", "","", "", "", ""];
									
if(debug)then{suicidepenalty = 0;respawntimeinc = 0;killedplayerinc = 0};  

isMayor                  = false;      	
WahlArray                = [];         
MayorNumber              = -1;         	
MayorExtraPay            = 3000;       							

for [{_i=0}, {_i < playercount}, {_i=_i+1}] do {WahlArray = WahlArray + [ [] ];};												

ischief                  = false;	
WahlArrayc               = [];		
chiefNumber              = -1;		
chiefExtraPay            = 5000;	

for [{_i=0}, {_i < playercount}, {_i=_i+1}] do {WahlArrayc = WahlArrayc + [ [] ];};

deadcam_target_array     = 

[
	
[17205.75,99198.17,-49454.65],	
[114238.47,12719.49,3040.26],										
[114238.47,12719.49,3040.28]		

];
					
deadcam_position_array   = 

[
					
[6573.78,2365.67,19.16],										
[6563.33,2409.16,3.60],										
[6598.98,2409.17,3.60]

];

atmscriptrunning = 0;
shopactivescript = 0;							
deadcam_wechsel_dauer    = 5;													
deadcam_kameraposition   = round(random (count deadcam_position_array - 1));	
slave_cost               = 40000;
slavemoneyprosekunde	 = 5000;
maxslave                 = 2;
copslaveallowed          = 0;
localslave               = 0;
localslavecounter        = 0;
huren_cost               = 20000;  								
hoemoneyprosekunde       = 8000;   							
maxhuren                 = 2;     			
copworkerallowed         = 0;     										
pimpactive               = 0;			
localhuren               = 0;									
localhurencounter        = 0;
localdog		 = 0;
maxdog			 = 1;
dog_cost                 = 1000;
speedbomb_minspeed       = 1;												
speedbomb_maxspeed       = 100;									
speedbomb_mindur         = 10; 							
speedbomb_maxdur         = 300;	
zeitbombe_mintime        = 10;				
zeitbombe_maxtime        = 0;	
HideoutLocationArray     = CityLocationArray;
publichideoutarray       = [];
hideoutcost		 = 20000;
marker_ausserhalb        = param1; 														
marker_innerhalb         = 5;      			
marker_CopDistance       = 50;   //controls distance cops need to be to make civ dots appear outside of towns. 					
CivMarkerUngenau         = 20;     								
copmarker_on             = 1; 
despawnarray	 	 = [["EvMoney", 300], ["Suitcase", 300]];
workplacearray           = [[workplace1, 80], [workplace2, 80], [workplace3, 60]];
huntingarray             = [["hunting1", 250]];
nonlethalweapons	 = ["Binocular", "NVGoggles", "ItemMap", "ItemCompass", "ItemRadio", "ItemWatch", "ItemGPS"];
slavearray               = workplacearray;
hurenarray               = [[brothel1, 15], [brothel2, 15], [brothel3, 15]];
timeinworkplace          = 0;
wpcapacity               = 10;
INV_hasitemshop          = 0;
INV_haswepshop           = 0;
gunlicensetargets	 = [t11,t12,t21,t22,t31,t32,t41,t42,t51,t52,t61,t62,t71,t72,t81,t82,t91,t92,t101,t111,t112,t121,t131,t132,t133,t134,t135];
BuildingsOwnerArray 	 = [];

if(isciv) then

{

BuyAbleBuildingsArray    = 

[

["wp1", "Ship Component Factory", workplace_getjobflag_1, 100000, 10000, "wp", "WpAblage_1"],							
["wp2", "Poor Man's Factory", workplace_getjobflag_2, 100000, 10000, "wp", "WpAblage_2"],							
["wp3", "Coopers Factor", workplace_getjobflag_3, 50000, 5000, "wp", "WpAblage_3"],
["wp4", "Aussie Imporium", workplace_getjobflag_4, 60000, 6000, "wp", "WpAblage_4"],
["wp5", "XMart", workplace_getjobflag_5, 70000, 7000, "wp", "WpAblage_5"],
["wp6", "TimTams", workplace_getjobflag_6, 80000, 8000, "wp", "WpAblage_6"]

];
//===============Fire Mission==================
pmissionactive = false;
patrolwaittime = false;
patrolmoneyperkm = 3;  // 1 would be equal to $3,000 for 1KM
//=========== Fire Mission array ==========
firemissionarray  =
[
getmarkerpos "firepoint_1", 
getmarkerpos "firepoint_2", 
getmarkerpos "firepoint_3", 
getmarkerpos "firepoint_4", 
getmarkerpos "firepoint_5", 
getmarkerpos "firepoint_6", 
getmarkerpos "firepoint_7", 
getmarkerpos "firepoint_8", 
getmarkerpos "firepoint_9", 
getmarkerpos "firepoint_10", 
getmarkerpos "firepoint_11",
getmarkerpos "firepoint_12",
getmarkerpos "firepoint_13",
getmarkerpos "firepoint_14",
getmarkerpos "firepoint_15",
getmarkerpos "firepoint_16",
getmarkerpos "firepoint_17",
getmarkerpos "firepoint_18",
getmarkerpos "firepoint_19",
getmarkerpos "firepoint_20",
getmarkerpos "firepoint_21",
getmarkerpos "firepoint_22",
getmarkerpos "firepoint_23",
getmarkerpos "firepoint_24",
getmarkerpos "firepoint_25"

];
};
// array used in taxi missions
civclassarray		 = 

[

"TK_CIV_Takistani01_EP1",
"TK_CIV_Takistani02_EP1",
"TK_CIV_Takistani03_EP1",
"TK_CIV_Takistani04_EP1",
"TK_CIV_Takistani05_EP1",
"TK_CIV_Takistani06_EP1",
"TK_CIV_Woman01_EP1",
"TK_CIV_Woman02_EP1",
"TK_CIV_Woman03_EP1",
"TK_CIV_Worker01_EP1",
"TK_CIV_Worker02_EP1",
"Citizen2_EP1",
"Citizen3_EP1",
"CIV_EuroMan01_EP1",
"CIV_EuroMan02_EP1",
"Dr_Hladik_EP1",
"Functionary1_EP1",
"Functionary2_EP1",
"Haris_Press_EP1",
"Profiteer2_EP1"

];
CLAY_DogEODs = ["PipeBomb","Mine","BAF_ied_v1","BAF_ied_v2","BAF_ied_v3","BAF_ied_v4","suitcase"];
CLAY_DogVehicles = ["dhi_cvpi_p71_gpd_k9"];
civslavearray		 = ["Worker1","Worker2","Worker3","Worker4"];
civworkerarray		 = ["Hooker1","Hooker2","Hooker3","Hooker4"];
terroristarray		 = ["GUE_Soldier_1", "GUE_Soldier_2", "GUE_Soldier_3"];

if(isServer)then

{
greenlt = false; publicvariable "greenlt";
yellowlt = false; publicvariable "yellowlt";
redlt = false; publicvariable "redlt";
greenlt1 = false; publicvariable "greenlt1";
yellowlt1 = false; publicvariable "yellowlt1";
redlt1 = false; publicvariable "redlt1";
TankenCost = 100; publicvariable "TankenCost";
bombactive = false; publicvariable "bombactive";
fireactive = true; publicvariable "fireactive";
fireactive2 = false; publicvariable "fireactive2";
onplayerconnected '

//publicvariable "BuildingsOwnerArray";
publicVariable "GesetzArray";
publicVariable "allowedcamera";
publicVariable "allowedwar";
publicVariable "allowedcarrier";
publicVariable "INV_ItemTypenArray";
publicvariable "INV_itemstocks";
currentTime = daytime; publicvariable "currentTime";

//format["if(%1)then{power1 setdamage 0};if(%2)then{power2 setdamage 0};", alive power1, alive power2] call broadcast;

';

};
