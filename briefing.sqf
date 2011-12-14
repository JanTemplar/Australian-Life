////////////////////////////////////
////			         //
//      Copyright © TCG         //
//www.tcgaming.enjin.com       //
////////////////////////////////
///-SCRIPT INFORMATION-//
//Initializing Profile Default
//
//-SCRIPT CONDITONS-//
//Script Begins: On Server Initialization
//Script Ends  : On EOF

if(player diarySubjectExists "rules")exitwith{};

player createDiarySubject ["changelog","Changelog"];
player createDiarySubject ["rules","General Rules"];
player createDiarySubject ["controls","Controls"];
player createDiarySubject ["bugs","Official Website/Bugs"];
player createDiarySubject ["credits","TS3/website/credits"];

player createDiaryRecord ["credits", 
[
"", 
"
TS3 Info;<br/>
ts36.gameservers.com:9149<br/>
<br/>
Official website;<br/>
www.fffc.enjin.com<br/>

<br/>
Ported to Lingor and cicada and further Developed by Bryce and Wulfer<br/>
All addons can be found on armaholic or other download sites and credit goes to their creators<br/>  
Please refer to our website for the full list of credits<br/>
Life Missions created by EddieV223, Pogoman, Issetea, Fewo<br/>
"
]
];

player createDiaryRecord ["bugs", 
[
"", 
"
Please report any bugs you find!<br/>
www.fffc.enjin.com<br/>
<br/>
<br/>

Our website:www.fffc.enjin.com<br/>
"
]
];

player createDiaryRecord ["controls", 
[
"", 
"
Civilian:<br/>
#1: Stats<br/>
here is where you will find a great deal of useful information.  Anything from how much money you 
are carrying to who has a bounty and how much that bounty may be.<br/>
#2: Inventory:<br/>
-this will tell you what you are carrying and also provides an interface to use some of those 
items in your inventory.  For example, if your getting the measage, ""You Are Starving"" and you 
have 10 fish in your inventory.  Press the #2, highlight ""fish"", change the number in the box 
to ""10"", then click ""use"".  That will make your charactor eat the fish and you will loose 
some hunger (high hunger is a bad thing).  You may also notice ""key chain"" in your inventory.  
This will hold all your keys to the vehicles you own.  You can give these keys to other players 
via this interface but know that they need to be near you for something like 5 seconds to receive 
the item.<br/>
#3: Hands Up<br/>
This button will make your charactor put his hands up.  This is useful for when you want to show 
the coppers that you are not a threat and are cooperating.  They can then restrain you if they 
feel the need.
<br/>
#4: Hands Down<br/>
this button will return you to a normal pos from ""hands up"".
<br/>
E: Action<br/>
this button is your basic ""action button"".  this is how you will interact with the various 
interfaces around Chern such as shops and ATM's.  This will also allow you to attempt to steal 
from other players.  You can only steal money if the other player has been knocked unconscious or 
is restrained.
<br/>
T: Access Inventory<br/>
when you own a car or other vehicle, you can access that car's inventory by sitting in the drivers seat 
 and pressing ""T"".  You will then be shown two box's.  The left box is what is in the car, 
and the right box is what is in your inventory.  Highlight the object you want to transfer, then 
select the amount and press the button on the side that has the item.  Car's hold a certain 
amount of weight just like your charactor so be aware of what you stash in there.  Also, if your 
vehicle is destroyed then you will loose whatever you place in here.  Coppers can search for 
drugs or other ileagal items.  If they find them in your car it will disappear and the coppers 
gain money equal to the value of the drugs.
<br/>
left shift+F: Stun<br/>
If you have a gun in your hands, you can stand next to another player and perform a stun action.  
Be aware that this will knock all of the other players weapons out onto the ground, so if you 
don't want to piss everyone off, only do this to your enemies.
<br/>
0-0-6, 0-0-7, 0-0-8: shout outs<br/>
Press these buttons to shout out measages on the fly.  For civilians the default says ""Don't 
Shoot, I surrender!"".  For cops, it says a variety of things but mainly says, ""Put up your 
hands or your dead"" kinda thing.
<br/>
0-0: options<br/>
this should give you the options for video settings, shout outs, fix head bug, and even a quick-
brief tutorial on CLR.""
<br/>
Cops:<br/>
`(tilde key (to the left of the 1 key): COPMENU. allows you to set their bounties, set them free 
and more. you have more options if you use the copmenu whilst in a vehicle.
<br/>

"
]
];

player createDiaryRecord ["rules", 
[
"General Rules", 
"
Tactical Combat Gaming<br/>
<br/>
<br/>
---ALL OF OUR SERVER RULES CAN BE FOUND ON OUR SITE WWW.FFFC.ENJIN.COM/RULES---<br/>
No excuses for not reading these rules<br/><br/>
-ALL COPS MUST BE ON OUR TEAMSPEAK WITH A WORKING MIC<br/>


"
]
];

player createDiaryRecord ["rules", 
[
"Animations", 
"
DEFINE Turbo key (suggestion - Mouse thumb button)<br/>
using default key settings, if different, just replace the letter<br/>
Z - prone<br/>
X - crouch<br/>
C - stand<br/>
2xctrl - weapon down/up toggle<br/>
standing: <br/>
	- panic button: sitdown<br/>
	- blind fire left: MTB + Left<br/>
	- blind fire right: MTB + Right<br/>
	- blind fire up: MTB + Back<br/>
	- taunt: MTB + Back + Left (to play it smooth, first use direction keys then turbo)<br/>
	- quick lower your head: MTB + Back + Right<br/>
running forward:<br/>
	- jog pace: 2x ctrl<br/>
	- quick step over: step over<br/>
	- weapon down: C<br/>
sprinting:<br/>
	- slide: X<br/>
	- climb over the wall: C<br/>
crouching:<br/>
	- kneel: X<br/>
	- quick lower your head: MTB + Back + Right<br/>
	- blind fire left: MTB + Left<br/>
	- blind fire right: MTB + Right<br/>
	- blind fire up: MTB + Back<br/>
	- panic move: sitdown<br/>
	- sniper sit: getOver<br/>
	- back to wall: salute<br/>
kneeling: <br/>
	- crouch: X<br/>
other moves apply as in crouching<br/>
proning:<br/>
	- urban prone left: MTB + Left<br/>
	- urban prone right: MTB + Right<br/>
	- launcher proning: Select launcher<br/>

"
]
];
player createDiaryRecord ["rules", 
[
"Animations Cont", 
"
urban prone LEFT:<br/>
	- move left: Left<br/>
	- move right: Right<br/>
	- back to prone: Z<br/>
	- move to urban prone RIGHT: MTB + Right<br/>
	- raise weapon: Forward<br/>
	- Blind fire: MTB + Left<br/>
urban prone Right:<br/>
	- back to prone: Z<br/>
	- raise weapon: Forward<br/>
	- raise weapon higher: MTB + Forward<br/>
	- move to urban prone RIGHT: MTB + Left<br/>
	- Blind fire: MTB + Right<br/>
panic move:<br/>
	- urban prone left: X<br/>
	- prone: Z<br/>
launcher standing:<br/>
        - launcher prone: fast + Backwards<br/>
launcher crouching:<br/>
	- launcher prone: fast + Backwards<br/>
pistol quick stand:<br/>
	- Blindfire left: MTB + Left<br/>
	- Blindfire right: MTB + Right<br/>
	- Blindfire overhead: MTB + Back<br/>
pistol normal hold:<br/>
        - when pistol out, toggle: c<br/>
Back to wall:<br/>
	- move left: Left<br/>
	- move right: Right<br/>
	- weapon round the corner: Forward<br/>
	- turn around and aim weapon forward: backwards<br/>
	- blindfire right: MTB + Right<br/>
	- blindfire overhead: MTB + Backwards<br/>
	- peak around the corner: MTB + Forward<br/>
	- go back to crouch: x<br/>
	- Grenade round the corner: choose grenade and throw<br/>
	- Grenade overhead throw: press salute and then do above<br/>
"
]
];

player createDiaryRecord ["rules", 
[
"Resource Factory", 
"
-Resource factory is new, limited items, but will grow<br/>
You need to take the raw material and process it before putting into your factory<br/>
Diamond: 5 Diamond Rocks<br/>
2x4: 2 Wood<br/>
Steel: 1 Copper 1 Iron<br/>
Glass: 2 Sand<br/>
Plastic: 2 Oil<br/>
Blackpowder: 2 Coal<br/>
Diamondring: 1 Diamonds<br/>
diamondbroach: 3 Diamonds<br/>
diamondnecklace: 2 Diamonds<br/>
woodchair: 2 2x4<br/>
LeeEnfield:: steel 5 copper 1 plastic 1<br/>
x_303: 1 Copper 1 blackpowder<br/>
Huntingrifle: iron 10 copper 10 glass 2<br/>
x_22_LR_17_HMR: 1 Copper 1 Blackpowder<br/>
RH_asvalk: steel 5 copper 1 plastic 1<br/>
RH_asval: steel 5 copper 1 plastic 1<br/>
RH_20Rnd_9x39_val_mag: 1 Copper 1 blackpowder<br/>
RH_PDW: steel 5 copper 1 plastic 1<br/>
RH_PDW_AIM: steel 5 copper 1 plastic 1<br/>
RH_PDW_ACOG: steel 5 copper 1 plastic 1<br/>
RH_30Rnd_6x35_PDW: 1 Copper 1 blackpowder<br/>
RH_anac: steel 5 copper 1 plastic 1<br/>
RH_anacg: steel 5 copper 1 plastic 1<br/>
RH_6Rnd_44_Mag: 1 Copper 1 blackpowder<br/>
wood chair 2 2x4s<br/>

"
]
];

player createDiaryRecord ["changelog", 
[
"Australian Life Changelog", 
"
--AustralianLife 1.3--<br/>
New Fire Station<br/>
Player Housing<br/>
Fixed Some Car Prices<br/>
Daniels Gun Range Added<br/>
New NightClub<br/>
Revive Script For Paramedics<br/>
Exploding Blue When Bank Robbed<br/>
Jans Pornarama Added S<br/>
--AustralianLife 1.2--<br/>
Retextured FireTruck<br/>
Updated Police Cars<br/>
Fixed Gang Price 75k<br/>
New Civ People<br/>
More Guns<br/>
JetSki Seller Changed To Man Instead Of JetSki<br/>
Seaplanes moved to airport<br/>

"
]
];

player selectDiarySubject "changelog";