_coparrest = (nearestobjects [getpos cop1, ["policeman","VIL_ctl_policeman","vilas_sira_sheriffoff","VIL_ctl_policeman_rd","DU_Characters","vilas_sira_swat_m416","VIL_ctl_policeman","FOX_US_SFMRW_OFFD"], 3] select 0);

if((animationstate _coparrest == "civillying01") and (player distance prisonflag <= 50)) then

{

player groupchat format["Arresting %1!", _coparrest];
(format ["%1 switchmove ""%2"";", _coparrest, "amovppnemstpsnonwnondnon"]) call broadcast;
_coparrest setPos getPos CopPrison;

};

