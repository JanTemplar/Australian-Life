////////////////////////////////////
////			         //
//      Copyright © TCG         //
//www.tcgaming.enjin.com       //
////////////////////////////////

/*
policehq animate ["bookingG",1]; policehq say "dooropen";
player groupchat "Closing Gate in 15 seconds";
sleep 15;
policehq animate ["bookingG",0]; policehq say "doorclose";
*/
policehq animate ["Gate_L",1];[policehq, "Gate_L_Motor", "MBG_SndSrc_ElectricGate",13.5] execvm "MBG_Killhouses\s\MPSoundV2.sqf";
player groupchat "Closing Gate in 20 seconds";
sleep 20;
policehq animate ["Gate_L",0];[policehq, "Gate_L_Motor", "MBG_SndSrc_ElectricGate",13.5] execvm "MBG_Killhouses\s\MPSoundV2.sqf";
