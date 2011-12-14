if(debug)then{['geld', 999999] call INV_AddInvItem};

StartGeld                = 25000; 
maxcopbonus		 = 30000;
maxcivbonus 	 	 = 30000;
robb_timeSperre          = 1200;   
local_useBankPossible    = true;  
maxinsafe                = 50000000;
BankRaubKontoverlust     = 4000;  
ShopRaubKontovershop     = 0;
ShopRaubProzentVershop   = 0;
rblock			 = 0;
stolencash		 = 0;
Maxbankrobpercentlost    = 0.1; 
bank_steuer              = 5;     
zinsen_prozent           = 5;     
zinsen_dauer             = 1200;   
robenable              	 = true;     
Kontostand               = StartGeld; 
shopflagarray            = [shop1,shop2,shop3,shop4];
bankflagarray            = [mainbank,copbank,atm1,atm2,atm3,atm4,atmpf,atm5,atm6,atm7,atm8,atm20,impoundbuy];
speedcamarray            = [speed1,speed2,speed3,speed4,speed5];
drugsellarray		 = [mdrugsell,cdrugsell,ldrugsell,hdrugsell,whalesell,methsell];
TankstellenArray         = 

[
fuelshop1,fuelshop2,fuelshop3,fuelshop4
/*
(nearestobject[getpos fuelshop1,"Land_A_Fuelstation_Feed"]),
(nearestobject[getpos fuelshop2,"Land_A_Fuelstation_Feed"]),
(nearestobject[getpos fuelshop3,"Land_A_Fuelstation_Feed"]),
(nearestobject[getpos fuelshop4,"Land_A_Fuelstation_Feed"]),
(nearestobject[getpos fuelshop5,"Land_A_Fuelstation_Feed","Land_Ind_FuelStation_Feed_EP1","Land_benzina_schnell","Land_fuelstation_army"],20])
*/
];

