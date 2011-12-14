_coparrest = (nearestobjects [getpos cop1, ["FOX_US_SFMRW_OFFD","policeman","vilas_sira_sheriffoff","DU_Characters","VIL_ctl_policeman_rd","vilas_sira_swat_m416","VIL_ctl_policeman"], 3] select 0);

player groupchat format["Restraining %1!", _coparrest];

//=====================================UNRESTRAIN=========================================

if(animationstate _coparrest == "civillying01") exitwith

{

(format ["%1 switchmove ""%2"";", _coparrest, "amovppnemstpsnonwnondnon"]) call broadcast;
player groupchat "You uncuffed the cop!";

};

//==================================RESTRAIN=========================================



if(vehicle _coparrest != _coparrest) exitwith {player groupchat "the cop is in a vehicle!"};

if (player distance _coparrest <=5) then

{ 

(format ["%1 switchmove ""%2"";", _coparrest, "civillying01"]) call broadcast;

(format['server globalchat "%3 was restrained by %2";if (rolestring == "%1") then {execVM "Unrestrain.sqf";}', _coparrest, name player, name _coparrest]) call broadcast;
};


