////////////////////////////////////
////			         //
//      Copyright © TCG         //
//www.tcgaming.enjin.com       //
////////////////////////////////



copent1 setPos [(getPos copent1 select 0),(getPos copent1 select 1),-5];
copent2 setPos [(getPos copent2 select 0),(getPos copent2 select 1),-5];
copent3 setPos [(getPos copent3 select 0),(getPos copent3 select 1),-5];
player groupchat "Closing Gate in 15 seconds";
sleep 15;
copent1 setPos [(getPos copent1 select 0),(getPos copent1 select 1),0];
copent2 setPos [(getPos copent2 select 0),(getPos copent2 select 1),0];
copent3 setPos [(getPos copent3 select 0),(getPos copent3 select 1),0];