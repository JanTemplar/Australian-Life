if (!alive player)exitwith{}; 

isstunned=true;

player groupchat "You have been restrained!"; 

waituntil {count (nearestobjects[getpos player,["policeman","vilas_sira_sheriffoff","DU_Characters","DU_Charactersman","VIL_ctl_policeman_rd","ibr_fea2","ibr_fea","vilas_sira_swat_m416","vilas_sira_policeman","VIL_ctl_policeman","FOX_US_SFMRW_OFFD"],100]) == 0 or (animationstate player != "civillying01")};
	
if(animationstate player == "civillying01")then

	{

	player groupchat "You managed to free yourself!"; 
	(format ["%1 switchmove ""%2"";", player, "amovppnemstpsnonwnondnon"]) call broadcast;

	}else{player groupchat "ROLEPLAY the situation!"};

isstunned=false;
StunActiveTime=0;