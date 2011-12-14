//Modified Intellectual Property of TCG
 _role = player;

//========================   HOSTAGE  ================================================
action1a = _role addaction ["Put out Fire","ems.sqf",[],1,false,true,"",'_vcl = (nearestobjects [getpos player, ["firetruck"], 40] select 0);player distance _vcl < 40 and (player == civ39 or player == civ40)'];
action1 = _role addaction ["Take Hostage Mission","hostage.sqf",["getajob_hostage"],1,false,true,"","player distance hostage <= 3 and isciv"];
action2 = _role addaction ["Take Hostage", "noscript.sqf", "[hostage1] join (group player); player groupchat ""Keep the hostage close or you will fail!"";",1,false,true,"","player distance hostage1 < 5"];
//==================================== GANG MENU ======================================================
action3 = _role addaction ["Gang Menu","maindialogs.sqf",["gangmenu"],1,false,true,"","player distance rathaus <= 3 and isciv"];
//====================================== BANK ROB =====================================================
action4 = _role addaction ["Open safe","bankrob.sqf", ["ausrauben", safe1, "safe1"],1,false,true,"","Safecracked1 and isciv and player distance Safe1 <= 2"];
actiona4 = _role addaction ["Crack Safe 1", "CrackSafe.sqf",["safe1"],1,false,True,"","not SafeCracked1 and isciv and player distance Safe1 <= 2"];
action5 = _role addaction ["Open safe","bankrob.sqf", ["ausrauben", safe2, "safe2"],1,false,true,"","Safecracked2 and isciv and player distance Safe2 <= 2"];
actiona5 = _role addaction ["Crack Safe 2", "CrackSafe.sqf",["safe2"],1,false,True,"","not SafeCracked2 and isciv and player distance Safe2 <= 2"];
action6 = _role addaction ["Open safe","bankrob.sqf", ["ausrauben", safe3, "safe3"],1,false,true,"","Safecracked3 and isciv and player distance Safe3 <= 2"];
actiona6 = _role addaction ["Crack Safe 3", "CrackSafe.sqf",["safe3"],1,false,True,"","not SafeCracked3 and isciv and player distance Safe3 <= 2"];
//=======================   ADMIN CAMERA ==============================================
action7 = _role addaction ["Camera Console","austcode.sqf",[],1,false,true,"","player distance rubblepile <= 2"];
//===================================== ASSASSINATION =================================================
action8 = _role addaction ["Get Assassination job","assassination.sqf",["getajob_assassin"],1,false,true,"","player distance assassin <= 3 and isciv"];
action9 = _role addaction ["Escort VIP", "noscript.sqf", "[VIPtarget] join (group player); player groupchat ""escort the VIP to the police base before he is assassinated!"";",1,false,true,"","player distance VIPtarget < 5 and iscop"];
//========================================= HUNTING ===================================================
action10 = _role addaction ["Take boar meat","noscript.sqf",'_no = ceil(random 7);if (((call INV_GetOwnWeight) + ("boar" call INV_getitemTypeKg)*_no) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};(nearestobjects [getpos player, ["wildboar"],  3] select 0) setvariable ["inuse", 1, true]; player playmove "AinvPknlMstpSlayWrflDnon_medic";sleep 4;waituntil {animationstate player != "AinvPknlMstpSlayWrflDnon_medic"};deletevehicle (nearestobjects [getpos player, ["wildboar"],  3] select 0);["boar", _no] call INV_AddInvItem;player groupchat format["you got %1 boar meat", _no];',1,true,true,"",'_w = (nearestobjects [getpos player, ["wildboar"],  3] select 0) getvariable "inuse"; isnil "_w" and player distance (nearestobjects [getpos player, ["wildboar"],  3] select 0) < 5 and !alive (nearestobjects [getpos player, ["wildboar"],  3] select 0) and isciv'];
action11 = _role addaction ["Take cow meat","noscript.sqf",'_no = ceil(random 2);if (((call INV_GetOwnWeight) + ("rawcow" call INV_getitemTypeKg)*_no) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};(nearestobjects [getpos player, ["cow01"],  3] select 0) setvariable ["inuse", 1, true]; player playmove "AinvPknlMstpSlayWrflDnon_medic";sleep 4;waituntil {animationstate player != "AinvPknlMstpSlayWrflDnon_medic"};deletevehicle (nearestobjects [getpos player, ["cow01"],  3] select 0);["rawcow", _no] call INV_AddInvItem;player groupchat format["you got %1 raw cow meat", _no];',1,true,true,"",'_w = (nearestobjects [getpos player, ["cow01"],  3] select 0) getvariable "inuse"; isnil "_w" and player distance (nearestobjects [getpos player, ["cow01"],  3] select 0) < 5 and !alive (nearestobjects [getpos player, ["cow01"],  3] select 0) and isciv'];
//===================================== TARGET RESET ==================================================
action12 = _role addaction ["Reset targets","noscript.sqf",'{_x animate["terc",0]} foreach (nearestobjects [getpos player, ["TargetEpopup"],  100])',1,true,true,"",'player distance targetrange1 < 3'];
action110 = _role addaction ["Reset targets","noscript.sqf",'{_x animate["terc",0]} foreach (nearestobjects [getpos player, ["TargetEpopup"],  100])',1,true,true,"",'player distance targetrange2 < 3'];
//===================================== IMPOUND AREA==================================================
action21 = _role addaction ["Impound Lot","maindialogs.sqf",["impound"],1,false,true,"","player distance impoundbuy <= 5"];
action22 = _role addaction ["Impound Lot","maindialogs.sqf",["impound"],1,false,true,"","player distance copcar <= 5"];
//================================== COP DELETE EVIDENCE ================================================
action23 = _role addaction ["Take evidence","noscript.sqf",'player groupchat "evidence removed."; {deletevehicle _x} foreach (nearestobjects [getpos player, ["weaponholder"], 3])',1,true,true,"",'_weps = (nearestobjects [getpos player, ["weaponholder"], 3] select 0); player distance _weps < 5 and iscop'];
//---------------------------------Fire Mission ACTIONS--------------------------------------------------
_role addaction ["Fire Mission","Firemission.sqf",["start"],1,false,true,"","isciv and player distance atm5 <= 4 and !pmissionactive and !patrolwaittime"];
_role addaction ["Cancel Fire Mission","Firemission.sqf",["end"],1,false,true,"","isciv and pmissionactive and player distance atm5 <= 4"];
//================================== COP SLAVE ACTIONS ================================================
//action24 = _role addaction ["Who do you work for?","noscript.sqf",'player groupchat format["this slave works for %1.", leader (nearestobjects [getpos player, civslavearray,  3] select 0)]',1,true,true,"",'_slave = (nearestobjects [getpos player, civslavearray, 3] select 0); !(_slave in playerarray) and player distance _slave < 5 and (leader _slave) in playerarray and iscop'];
//action25 = _role addaction ["Set slave free","noscript.sqf",'_slave = (nearestobjects [getpos player, civslavearray,  3] select 0); _civ = leader _slave; deletevehicle _slave; (format ["[""slave"", %1] spawn Isse_AddCrimeLogEntry; if(!(""being a slaver"" in %1_reason))then{%1_reason = %1_reason + [""being a slaver""]}; %1_wanted = 1; kopfgeld_%1 = kopfgeld_%1 + 20000;", _civ]) call broadcast;player groupchat "the slave has been freed!";',1,true,true,"",'_slave = (nearestobjects [getpos player, civslavearray, 3] select 0); !(_slave in playerarray) and player distance _slave < 5 and (leader _slave) in playerarray and iscop'];
//==================================== OBJECT ACTIONS =================================================
action13 = _role addaction ["Up Elevator","elevator.sqf",[1],1,false,true,"",'player distance getmarkerpos "elevator1" <= 5'];
action13a = _role addaction ["Down Elevator","elevator.sqf",[2],1,false,true,"",'player distance elevator2 <= 5'];
action20 = _role addaction ["Take Scuba Gear","noscript.sqf",'if (((call INV_GetOwnWeight) + ("gnt_scubaw" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [getpos player, ["gnt_scubaw"],  10] select 0);["gnt_scubaw", 1] call INV_AddInvItem;player groupchat "you picked up scuba gear";',1,true,true,"",'player distance (nearestobjects [getpos player, ["gnt_scubaw"],  10] select 0) < 5'];
action16 = _role addaction ["Remove Spike Strip","noscript.sqf",'if (((call INV_GetOwnWeight) + ("spikestrip" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [getpos player, ["spikestrip"],  10] select 0);["spikestrip", 1] call INV_AddInvItem;player groupchat "you picked up a spike strip";',1,true,true,"",'iscop and player distance (nearestobjects [getpos player, ["spikestrip"],  10] select 0) < 7'];
action17 = _role addaction ["Remove Stop Sign","noscript.sqf",'if (((call INV_GetOwnWeight) + ("glt_roadsign_octagon" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [getpos player, ["glt_roadsign_octagon"],  10] select 0);["glt_roadsign_octagon", 1] call INV_AddInvItem;player groupchat "you picked up a stop sign";',1,true,true,"",'iscop and player distance (nearestobjects [getpos player, ["glt_roadsign_octagon"],  10] select 0) < 7'];
action89 = _role addaction ["Remove Searchlight","noscript.sqf",'if (((call INV_GetOwnWeight) + ("SearchLight_UN_EP1" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [getpos player, ["SearchLight_UN_EP1"], 3] select 0);["SearchLight_UN_EP1", 1] call INV_AddInvItem;player groupchat "you picked up a searchlight";',1,true,true,"",'_light = (nearestobjects [getpos player, ["SearchLight_UN_EP1"],  3] select 0); !(_light in speedcamarray) and player distance _light < 5 and iscop'];
action26 = _role addaction ["Remove Roadblock","noscript.sqf",'if (((call INV_GetOwnWeight) + ("roadblock" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [getpos player, ["Land_CncBlock_Stripes"],  3] select 0);["roadblock", 1] call INV_AddInvItem;player groupchat "you picked up a roadblock";',1,true,true,"",'player distance (nearestobjects [getpos player, ["Land_CncBlock_Stripes"],  3] select 0) < 5 and iscop'];
action27 = _role addaction ["Remove Bargate","noscript.sqf",'if (((call INV_GetOwnWeight) + ("Bargate" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [getpos player, ["ZavoraAnim"],  10] select 0);["Bargate", 1] call INV_AddInvItem;player groupchat "you picked up a bargate";',1,true,true,"",'iscop and player distance (nearestobjects [getpos player, ["ZavoraAnim"],  10] select 0) < 7'];
action28 = _role addaction ["Remove Road Cone","noscript.sqf",'if (((call INV_GetOwnWeight) + ("roadcone" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [getpos player, ["Land_coneLight"],  3] select 0);["roadcone", 1] call INV_AddInvItem;player groupchat "you picked up a road cone";',1,true,true,"",'player distance (nearestobjects [getpos player, ["Land_coneLight"],  3] select 0) < 5'];
action91 = _role addaction ["Remove M2 Static","noscript.sqf",'if (((call INV_GetOwnWeight) + ("M2StaticMG_US_EP1" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [getpos player, ["M2StaticMG_US_EP1"],  3] select 0);["M2StaticMG_US_EP1", 1] call INV_AddInvItem;player groupchat "you picked up a M2 Static";',1,true,true,"",'player distance (nearestobjects [getpos player, ["M2StaticMG_US_EP1"],  3] select 0) < 5'];
action29 = _role addaction ["Open/close gate","noscript.sqf",'_gate = (nearestobjects [getpos player, ["ZavoraAnim"],  10] select 0); if(_gate animationPhase "bargate" == 1)then{_gate animate ["bargate", 0]}else{_gate animate ["bargate", 1]};',1,true,true,"",'player distance (nearestobjects [getpos player, ["ZavoraAnim"],  10] select 0) < 7 and iscop'];
action30 = _role addaction ["Open/close gate","noscript.sqf",'_gate = (nearestobjects [getpos player, ["ZavoraAnim"],  10] select 0); if(_gate animationPhase "bargate" == 1)then{_gate animate ["bargate", 0]}else{_gate animate ["bargate", 1]};',1,true,true,"",'player distance (nearestobjects [getpos player, ["ZavoraAnim"],  10] select 0) < 7 and isciv'];
action31 = _role addaction ["Remove Big bag fence (corner)","noscript.sqf",'if (((call INV_GetOwnWeight) + ("BigbagfenceCorner" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [getpos player, ["Land_fort_bagfence_corner"],  3] select 0);["BigbagfenceCorner", 1] call INV_AddInvItem;player groupchat "you picked up a sandbag wall (corner)";',1,true,true,"",'iscop and player distance (nearestobjects [getpos player, ["Land_fort_bagfence_corner"],  3] select 0) < 5'];
action32 = _role addaction ["Remove Big bag fence","noscript.sqf",'if (((call INV_GetOwnWeight) + ("bigbagfence" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [getpos player, ["Land_fort_bagfence_long"],  3] select 0);["bigbagfence", 1] call INV_AddInvItem;player groupchat "you picked up a sandbag wall";',1,true,true,"",'iscop and player distance (nearestobjects [getpos player, ["Land_fort_bagfence_long"],  3] select 0) < 5'];
action33 = _role addaction ["Remove Big bag fence (round)","noscript.sqf",'if (((call INV_GetOwnWeight) + ("bigbagfenceRound" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [getpos player, ["Land_fort_bagfence_round"],  3] select 0);["bigbagfenceRound", 1] call INV_AddInvItem;player groupchat "you picked up a sandbag wall (round)";',1,true,true,"",'iscop and player distance (nearestobjects [getpos player, ["Land_fort_bagfence_round"],  3] select 0) < 5'];
action34 = _role addaction ["Remove Bunker (small)","noscript.sqf",'if (((call INV_GetOwnWeight) + ("bunkersmall" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [getpos player, ["Land_fortified_nest_small"],  3] select 0);["bunkersmall", 1] call INV_AddInvItem;player groupchat "you picked up a bunker (small)";',1,true,true,"",'iscop and player distance (nearestobjects [getpos player, ["Land_fortified_nest_small"],  3] select 0) < 5'];
action35 = _role addaction ["Remove Danger Sign","noscript.sqf",'if (((call INV_GetOwnWeight) + ("danger" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [getpos player, ["Sign_Danger"],  3] select 0);["danger", 1] call INV_AddInvItem;player groupchat "you picked up a danger sign";',1,true,true,"",'player distance (nearestobjects [getpos player, ["Sign_danger"],  3] select 0) < 5'];
action37 = _role addaction ["Remove ladder","noscript.sqf",'if (((call INV_GetOwnWeight) + ("land_ladder_half" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [getpos player, ["land_ladder_half"],  3] select 0);["land_ladder_half", 1] call INV_AddInvItem;player groupchat "you picked up a ladder";',1,true,true,"",'iscop and player distance (nearestobjects [getpos player, ["land_ladder_half"],  3] select 0) < 5'];
action38 = _role addaction ["Remove Road Barrier","noscript.sqf",'if (((call INV_GetOwnWeight) + ("Land_RedWhiteBarrier" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [getpos player, ["Land_RedWhiteBarrier"],  3] select 0);["Land_RedWhiteBarrier", 1] call INV_AddInvItem;player groupchat "you picked up a road barrier";',1,true,true,"",'player distance (nearestobjects [getpos player, ["Land_RedWhiteBarrier"],  3] select 0) < 5'];
action39 = _role addaction ["Remove Road Barrier","noscript.sqf",'if (((call INV_GetOwnWeight) + ("Roadbarrier_long" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [getpos player, ["RoadBarrier_long"],  3] select 0);["RoadBarrier_long", 1] call INV_AddInvItem;player groupchat "you picked up a road barrier";',1,true,true,"",'player distance (nearestobjects [getpos player, ["RoadBarrier_long"],  3] select 0) < 5'];
action40 = _role addaction ["Remove Road Barrier","noscript.sqf",'if (((call INV_GetOwnWeight) + ("RoadBarrier_light" call INV_getitemTypeKg)) > INV_Tragfaehigkeit)exitwith{player groupChat localize "STRS_inv_buyitems_maxgewicht"};deletevehicle (nearestobjects [getpos player, ["RoadBarrier_light"],  3] select 0);["RoadBarrier_light", 1] call INV_AddInvItem;player groupchat "you picked up a road barrier";',1,true,true,"",'player distance (nearestobjects [getpos player, ["RoadBarrier_light"],  3] select 0) < 5'];
action41 = _role addaction ["Restrain Cop","restraincop.sqf",[],1,true,true,"","player == cop1"];
action42 = _role addaction ["Put Cop in Car","preArrestcop.sqf",[],1,true,true,"",'_vcl = (nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0);player distance _vcl < 5 and _vcl in INV_ServerVclArray and player == cop1'];
action42a = _role addaction ["Arrest Cop","arrestcop.sqf",[],1,true,true,"","player == cop1"];
//================================== COP CHIEF ELECTION ===============================================
action43 = _role addaction ["Elect a Chief","maindialogs.sqf",["chief"],1,false,true,"","player distance rathaus <= 3 and iscop"];
//==================================== MAYOR ELECTION =================================================
action44 = _role addaction ["Elect a Prime Minister","maindialogs.sqf",["wahlen"],1,false,true,"","player distance rathaus <= 3"];
//===================================== MAYOR ACTIONS =================================================
action45 = _role addaction ["Change the Law","maindialogs.sqf",["gesetz"],1,false,true,"","player distance rathaus <= 3 and isMayor"];
action46 = _role addaction ["Change taxes","maindialogs.sqf",["steuern"],1,false,true,"","player distance rathaus <= 3 and isMayor"];
//===================================== CONVOY CASH ===================================================
action184 = _role addaction ["Steal Police Payroll","noscript.sqf",'convoyhascash=false; publicvariable "convoyhascash"; _cash = (playersNumber west)*20000; ["geld", _cash] call INV_AddInvItem; player groupchat format["You stole $%1!", _cash];',1,false,true,"","_driver = driver convoytruck; player distance convoytruck <= 7 and convoyhascash and isciv and (!alive _driver or isnull _driver)"];
//===================================== BUY INSURANCE ===================================================
action47 = _role addaction [format["Buy bank insurance ($%1)", ("bankversicherung" call INV_getitemBuyCost)],"noscript.sqf",'if("geld" call INV_GetItemAmount < ("bankversicherung" call INV_getitemBuyCost))exitwith{player groupchat "not enough money"};["geld", -("bankversicherung" call INV_getitemBuyCost)] call INV_AddInvItem;["bankversicherung", 1] call INV_AddInvItem;player groupchat format["you bought bank insurance for $%1", ("bankversicherung" call INV_getitemBuyCost)];',1,false,true,"","player distance mainbank <= 3"];
//======================================= CRIMELOG ====================================================
action48 = _role addaction ["Crime Log","maindialogs.sqf",["coplog"],1,false,true,"","player distance rathaus <= 3"];
//======================================== SLAVES =====================================================
//action49 = _role addaction [format ["Buy Slave ($%1)", slave_cost],"slaves.sqf", ["slave"],1,false,true,"","player distance boatshop3 <= 5 and isciv"];
//==================================== PRIVATE STORAGE ================================================
//action50 = _role addaction ["Private storage (saved)","storage.sqf",["private_storage", "save"],1,false,true,"","player distance storage < 7"];
//========================================= BAIL ======================================================	 
action51 = _role addaction [format ["Pay Bail", slave_cost],"maindialogs.sqf", ["bail"],1,false,true,"","player distance bailflag <= 3 and isciv"];
//===================================== ITEM PROCESS ==================================================	 
action18 = _role addaction ["Process Wood","itemprocess.sqf",["wood", "tbfour", 2, ""],1,false,true,"","player distance wood_1 <= 5 and isciv"];
action19 = _role addaction ["Process Diamond","itemprocess.sqf",["diamond rock", "diamond", 5, ""],1,false,true,"","player distance diamond_1 <= 5 and isciv"];
action19a = _role addaction ["Process Meth","itemprocess1.sqf",["pharm", "meth", 2, ""],1,false,true,"","player distance methlab <= 5 and isciv"];

action53 = _role addaction ["Process Oil","itemprocess.sqf",["Oil", "OilBarrel", 10, "oil"],1,false,true,"","player distance Oil_1 <= 5 and isciv"];
action54 = _role addaction ["Process Wheat","itemprocess.sqf",["getreide", "Bread", 2, "Baker"],1,false,true,"","player distance bakery <= 5 and isciv"];
action54a = _role addaction ["Process Strawberries","itemprocess.sqf",["straw", "Frozens", 3, "Baker"],1,false,true,"","player distance bakery <= 5 and isciv"];
//ga1
action55 = _role addaction ["Process LSD","itemprocess.sqf",["Unprocessed_LSD", "lsd", 5, "lsd ga1"],1,false,true,"","_control = gangarea1 getvariable ""control"";!isnil ""_control"" and player distance gangarea1 <= 5 and (_control == (call INV_mygang))"];
action56 = _role addaction ["Process Cocaine","itemprocess.sqf",["Unprocessed_Cocaine", "cocaine", 5, "cocaine ga1"],1,false,true,"","_control = gangarea1 getvariable ""control"";!isnil ""_control"" and player distance gangarea1 <= 5 and (_control == (call INV_mygang))"];
//ga2
action57 = _role addaction ["Process LSD","itemprocess.sqf",["Unprocessed_LSD", "lsd", 5, "lsd ga2"],1,false,true,"","_control = gangarea2 getvariable ""control"";!isnil ""_control"" and player distance gangarea2 <= 5 and (_control == (call INV_mygang))"];
action58 = _role addaction ["Process Heroin","itemprocess.sqf",["Unprocessed_Heroin", "heroin", 5, "heroin ga2"],1,false,true,"","_control = gangarea2 getvariable ""control"";!isnil ""_control"" and player distance gangarea2 <= 5 and (_control == (call INV_mygang))"];
//ga3
action59 = _role addaction ["Process Heroin","itemprocess.sqf",["Unprocessed_Heroin", "heroin", 5, "heroin ga3"],1,false,true,"","_control = gangarea3 getvariable ""control"";!isnil ""_control"" and player distance gangarea3 <= 5 and (_control == (call INV_mygang))"];
action60 = _role addaction ["Process Marijuana","itemprocess.sqf",["Unprocessed_Marijuana", "marijuana", 5, "marijuana ga3"],1,false,true,"","_control = gangarea3 getvariable ""control"";!isnil ""_control"" and player distance gangarea3 <= 5 and (_control == (call INV_mygang))"];
//ga4
action591 = _role addaction ["Process Heroin","itemprocess.sqf",["Unprocessed_Heroin", "heroin", 5, "heroin ga4"],1,false,true,"","_control = gangarea4 getvariable ""control"";!isnil ""_control"" and player distance gangarea4 <= 5 and (_control == (call INV_mygang))"];
action601 = _role addaction ["Process Marijuana","itemprocess.sqf",["Unprocessed_Marijuana", "marijuana", 5, "marijuana ga4"],1,false,true,"","_control = gangarea4 getvariable ""control"";!isnil ""_control"" and player distance gangarea4 <= 5 and (_control == (call INV_mygang))"];
//======================================== WORKERS =====================================================
action14 = _role addaction [format ["Buy Hooker ($%1)", huren_cost],"worker1.sqf", ["holen"],1,false,true,"","(player distance brothela <= 2 or player distance brothel <= 2) and isciv"];
action14a = _role addaction [format ["Buy K9 ($%1)", dog_cost],"copdog.sqf", ["buydog"],1,false,true,"","player distance dogspawn <= 5 and (player == cop1 or player == cop2)"];
action14b = _role addaction [format ["Buy K9 ($%1)", dog_cost],"civdog.sqf", ["buydog"],1,false,true,"","player distance dogspawn1 <= 5"];
action15 = _role addaction ["Who do you work for?","noscript.sqf",'player groupchat format["this hooker works for %1.", leader (nearestobjects [getpos player, civworkerarray,  3] select 0)]',1,true,true,"",'_slave = (nearestobjects [getpos player, civworkerarray, 3] select 0); !(_slave in playerarray) and player distance _slave < 5 and (leader _slave) in playerarray and iscop'];
action16 = _role addaction ["Send Hooker Home","noscript.sqf",'_slave = (nearestobjects [getpos player, civworkerarray,  3] select 0); _civ = leader _slave; deletevehicle _slave; (format ["[""slave"", %1] spawn Isse_AddCrimeLogEntry; if(!(""being a pimp"" in %1_reason))then{%1_reason = %1_reason + [""being a pimp""]}; %1_wanted = 1; kopfgeld_%1 = kopfgeld_%1 + 20000;", _civ]) call broadcast;player groupchat "the hooker has been sent home!";',1,true,true,"",'_slave = (nearestobjects [getpos player, civworkerarray, 3] select 0); !(_slave in playerarray) and player distance _slave < 5 and (leader _slave) in playerarray and iscop'];
//======================================= WORKPLACE ====================================================
action61 = _role addaction ["Get courier job","delivery.sqf", ["getajob_delivery"],1,false,true,"","(player distance workplace_getjobflag_1 <= 5 or player distance workplace_getjobflag_2 <= 5 or player distance workplace_getjobflag_3 <= 5) and isciv"];		
action62 = _role addaction ["Cancel delivery mission","delivery.sqf", ["cancel"],1,false,true,"","(player distance workplace_getjobflag_1 <= 5 or player distance workplace_getjobflag_2 <= 5 or player distance workplace_getjobflag_3 <= 5) and isciv and alreadygotaworkplacejob == 1"];		
action63 = _role addaction ["Get taxi job","taxi.sqf", ["getajob_taxi"],1,false,true,"","player distance taxishop <= 7 and isciv"];
action64 = _role addaction ["Finish taxi mission","taxi.sqf", ["canceljob_taxi"],1,false,true,"","(player distance workplace_getjobflag_1 <= 5 or player distance workplace_getjobflag_2 <= 5 or player distance workplace_getjobflag_3 <= 5) and isciv and workplacejob_taxi_active"];	
action65 = _role addaction [format [localize "STRS_addAction_buy_shop", (BuyAbleBuildingsArray select 0) select 1, (BuyAbleBuildingsArray select 0) select 3],"buyshop.sqf", ["immobilie", 0],1,false,true,"",'_fact = workplace_getjobflag_1 getvariable "building1";player distance ((BuyAbleBuildingsArray select 0) select 2) <= 5 and (_fact==11)'];	
action66 = _role addaction [format [localize "STRS_addAction_buy_shop", (BuyAbleBuildingsArray select 1) select 1, (BuyAbleBuildingsArray select 1) select 3],"buyshop.sqf", ["immobilie2", 1],1,false,true,"",'_fact = workplace_getjobflag_2 getvariable "building2";player distance ((BuyAbleBuildingsArray select 1) select 2) <= 5 and (_fact==12)'];	
action67 = _role addaction [format [localize "STRS_addAction_buy_shop", (BuyAbleBuildingsArray select 2) select 1, (BuyAbleBuildingsArray select 2) select 3],"buyshop.sqf", ["immobilie3", 2],1,false,true,"",'_fact = workplace_getjobflag_3 getvariable "building3";player distance ((BuyAbleBuildingsArray select 2) select 2) <= 5 and (_fact==13)'];	
action651 = _role addaction [format ["Sell shop", (BuyAbleBuildingsArray select 0) select 1, (BuyAbleBuildingsArray select 0) select 3],"buyshop.sqf", ["Sell", 0],1,false,true,"","player distance ((BuyAbleBuildingsArray select 0) select 2) <= 5 and (((BuyAbleBuildingsArray select 0) select 0) in BuildingsOwnerArray)"];	
action661 = _role addaction [format ["Sell shop", (BuyAbleBuildingsArray select 1) select 1, (BuyAbleBuildingsArray select 1) select 3],"buyshop.sqf", ["Sell2", 1],1,false,true,"","player distance ((BuyAbleBuildingsArray select 1) select 2) <= 5 and (((BuyAbleBuildingsArray select 1) select 0) in BuildingsOwnerArray)"];	
action671 = _role addaction [format ["Sell Shop", (BuyAbleBuildingsArray select 2) select 1, (BuyAbleBuildingsArray select 2) select 3],"buyshop.sqf", ["Sell3", 2],1,false,true,"","player distance ((BuyAbleBuildingsArray select 2) select 2) <= 5 and (((BuyAbleBuildingsArray select 2) select 0) in BuildingsOwnerArray)"];	
action652 = _role addaction [format [localize "STRS_addAction_buy_shop", (BuyAbleBuildingsArray select 3) select 1, (BuyAbleBuildingsArray select 3) select 3],"buyshop.sqf", ["immobilie4", 3],1,false,true,"",'_fact = workplace_getjobflag_4 getvariable "building4";player distance ((BuyAbleBuildingsArray select 3) select 2) <= 5 and (_fact==14)'];	
action662 = _role addaction [format [localize "STRS_addAction_buy_shop", (BuyAbleBuildingsArray select 4) select 1, (BuyAbleBuildingsArray select 4) select 3],"buyshop.sqf", ["immobilie5", 4],1,false,true,"",'_fact = workplace_getjobflag_5 getvariable "building5";player distance ((BuyAbleBuildingsArray select 4) select 2) <= 5 and (_fact==15)'];	
action672 = _role addaction [format [localize "STRS_addAction_buy_shop", (BuyAbleBuildingsArray select 5) select 1, (BuyAbleBuildingsArray select 5) select 3],"buyshop.sqf", ["immobilie6", 5],1,false,true,"",'_fact = workplace_getjobflag_6 getvariable "building6";player distance ((BuyAbleBuildingsArray select 5) select 2) <= 5 and (_fact==16)'];	
action653 = _role addaction [format ["Sell shop", (BuyAbleBuildingsArray select 3) select 1, (BuyAbleBuildingsArray select 3) select 3],"buyshop.sqf", ["Sell4", 3],1,false,true,"","player distance ((BuyAbleBuildingsArray select 3) select 2) <= 5 and (((BuyAbleBuildingsArray select 3) select 0) in BuildingsOwnerArray)"];	
action663 = _role addaction [format ["Sell shop", (BuyAbleBuildingsArray select 4) select 1, (BuyAbleBuildingsArray select 4) select 3],"buyshop.sqf", ["Sell5", 4],1,false,true,"","player distance ((BuyAbleBuildingsArray select 4) select 2) <= 5 and (((BuyAbleBuildingsArray select 4) select 0) in BuildingsOwnerArray)"];	
action673 = _role addaction [format ["Sell Shop", (BuyAbleBuildingsArray select 5) select 1, (BuyAbleBuildingsArray select 5) select 3],"buyshop.sqf", ["Sell6", 5],1,false,true,"","player distance ((BuyAbleBuildingsArray select 5) select 2) <= 5 and (((BuyAbleBuildingsArray select 5) select 0) in BuildingsOwnerArray)"];	
//====================================== VEHICLE ACTIONS ================================================
action68 = _role addaction [localize "STRS_addaction_trunk_see","noscript.sqf",'_vcl = (nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0);_str = format["%1_storage", _vcl];[_str] execVM "vehiclecheck.sqf";',1,true,true,"",'_vcl = (nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0);player distance _vcl < 5 and !(_vcl in INV_VehicleArray) and _vcl in INV_ServerVclArray and iscop'];
action69 = _role addaction [localize "STRS_addaction_trunk_check","noscript.sqf",'_vcl = (nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0);_str = format["%1_storage", _vcl];if([_vcl,_str] call INV_RemoveIllegalStorage)then{call compile format["publicvariable ""%1"";", _str]};',1,true,true,"",'_vcl = (nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0);player distance _vcl < 5 and !(_vcl in INV_VehicleArray) and _vcl in INV_ServerVclArray and iscop'];
action70 = _role addaction ["Impound vehicle","noscript.sqf",'_vcl = (nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0);[_vcl, "impound"] execVM "impound.sqf";',1,true,true,"",'_vcl = (nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0);_vcl in INV_ServerVclArray and (player == civ39 or player == civ40) and player distance _vcl < 10'];
action71 = _role addaction ["Pull out","noscript.sqf",'(nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0) execVM "pullout.sqf";',1,true,true,"",'_vcl = (nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0);player distance _vcl < 5 and count (crew _vcl) > 0 and _vcl in INV_ServerVclArray and (call INV_isArmed)'];
action72 = _role addaction [localize "STRS_addAction_vehicleinfo","noscript.sqf",'(nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0) execVM "vehinfo.sqf";',1,true,true,"",'_vcl = (nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0);player distance _vcl < 5 and _vcl in INV_ServerVclArray'];
action36 = _role addaction ["Put Civilain in Car","preArrest.sqf",[],1,true,true,"",'_vcl = (nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0);player distance _vcl < 5 and _vcl in INV_ServerVclArray and iscop'];
//======================================== GANG FLAGS ===================================================
action73 = _role addaction ["Neutralise flag","gangflags.sqf",[gangarea1, "neutralise"],1,false,true,"",'_control = gangarea1 getvariable "control";player distance gangarea1 <= 8 and _control != (call INV_mygang) and gangmember and !pickingup'];
action74 = _role addaction ["Neutralise flag","gangflags.sqf",[gangarea2, "neutralise"],1,false,true,"",'_control = gangarea2 getvariable "control";player distance gangarea2 <= 8 and _control != (call INV_mygang) and gangmember and !pickingup'];
action75 = _role addaction ["Neutralise flag","gangflags.sqf",[gangarea3, "neutralise"],1,false,true,"",'_control = gangarea3 getvariable "control";player distance gangarea3 <= 8 and _control != (call INV_mygang) and gangmember and !pickingup'];
action751 = _role addaction ["Neutralise flag","gangflags.sqf",[gangarea4, "neutralise"],1,false,true,"",'_control = gangarea3 getvariable "control";player distance gangarea4 <= 8 and _control != (call INV_mygang) and gangmember and !pickingup'];
action761 = _role addaction ["Capture flag","gangflags.sqf",[gangarea4, "capture"],1,false,true,"",'player distance gangarea4 <= 10 and gangmember and !pickingup and getpos gangarea4 select 2 < 0'];
action76 = _role addaction ["Capture flag","gangflags.sqf",[gangarea1, "capture"],1,false,true,"",'player distance gangarea1 <= 10 and gangmember and !pickingup and getpos gangarea1 select 2 < 0'];
action77 = _role addaction ["Capture flag","gangflags.sqf",[gangarea2, "capture"],1,false,true,"",'player distance gangarea2 <= 10 and gangmember and !pickingup and getpos gangarea2 select 2 < 0'];
action78 = _role addaction ["Capture flag","gangflags.sqf",[gangarea3, "capture"],1,false,true,"",'player distance gangarea3 <= 10 and gangmember and !pickingup and getpos gangarea3 select 2 < 0'];
//======================================== SHOP EXPORT ==================================================
_num1  = (shop1 call INV_getshopnum);
_num2  = (shop2 call INV_getshopnum);
_num3  = (shop3 call INV_getshopnum);
_num4  = (shop4 call INV_getshopnum);
_num5  = (pdfood call INV_getshopnum);
action79 = _role addaction ["Shop 1 export","shopdialogs.sqf",[_num1],1,false,true,"","player distance shop1export <= 3"];
action80 = _role addaction ["Shop 2 export","shopdialogs.sqf",[_num2],1,false,true,"","player distance shop2export <= 3"];
action81 = _role addaction ["Shop 3 export","shopdialogs.sqf",[_num3],1,false,true,"","player distance shop3export <= 3"];
action82 = _role addaction ["Shop 4 export","shopdialogs.sqf",[_num4],1,false,true,"","player distance shop4export <= 3"];
action821 = _role addaction ["Police Equipment","shopdialogs.sqf",[_coppatrol],1,false,true,"",'player distance (nearestobjects [getpos player, ["cl_f150pd"],  10] select 0) < 3 and iscop'];
//======================================= GANG GUNSHOPS ==================================================
_num11  = (gangarea1 call INV_getshopnum);
_num12  = (gangarea2 call INV_getshopnum);
_num13  = (gangarea3 call INV_getshopnum);
_num14  = (gangarea4 call INV_getshopnum);
action83 = _role addaction ["Gang Shop","shopdialogs.sqf",[_num11],1,false,true,"","_control = gangarea1 getvariable ""control"";!isnil ""_control"" and player distance gangarea1 <= 5 and (_control == (call INV_mygang))"];
action84 = _role addaction ["Gang Shop","shopdialogs.sqf",[_num12],1,false,true,"","_control = gangarea2 getvariable ""control"";!isnil ""_control"" and player distance gangarea2 <= 5 and (_control == (call INV_mygang))"];
action85 = _role addaction ["Gang Shop","shopdialogs.sqf",[_num13],1,false,true,"","_control = gangarea3 getvariable ""control"";!isnil ""_control"" and player distance gangarea3 <= 5 and (_control == (call INV_mygang))"];
action851 = _role addaction ["Gang Shop","shopdialogs.sqf",[_num14],1,false,true,"","_control = gangarea4 getvariable ""control"";!isnil ""_control"" and player distance gangarea4 <= 5 and (_control == (call INV_mygang))"];
//===================================== Gas station Robbing===============================================
_role addaction ["Rob Gas Station","robthestations.sqf",["station 1"],1,false,true,"","isciv and station1money >= 5000 and player distance fuelshop1 <= 2"];
_role addaction ["Rob Gas Station","robthestations.sqf",["station 2"],1,false,true,"","isciv and station2money >= 5000 and player distance fuelshop2 <= 2"];
_role addaction ["Rob Gas Station","robthestations.sqf",["station 3"],1,false,true,"","isciv and station3money >= 5000 and player distance fuelshop3 <= 2"];
_role addaction ["Rob Gas Station","robthestations.sqf",["station 4"],1,false,true,"","isciv and station4money >= 5000 and player distance fuelshop4 <= 2"];
_role addaction ["Rob Pharmacy","robpharmacy.sqf",["pharmacy"],1,false,true,"","isciv and station5money >= 5000 and player distance pharmacy <= 2"];
_role addaction ["Rob Bar","robbar.sqf",["bar"],1,false,true,"","isciv and barmoney >= 5000 and player distance pub1 <= 2"];
_role addaction ["Rob Bar","robbar.sqf",["bar1"],1,false,true,"","isciv and barmoney1 >= 5000 and player distance pub2 <= 2"];
_role addaction ["Rob Bar","robbar.sqf",["bar2"],1,false,true,"","isciv and barmoney2 >= 5000 and player distance pub3 <= 2"];
_role addaction ["Rob Bar","robbar.sqf",["bar3"],1,false,true,"","isciv and barmoney3 >= 5000 and player distance pub4 <= 2"];
//========================   unflip vehicle     ================================
action86 = _role addaction ["Unflip vehicle","unflipvehicle.sqf",["unflip"],1,false,true,"",'_vcl = (nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0);player distance _vcl < 5 and _vcl in INV_VehicleArray'];
//=========================    Cop Patrol actions/BUS   ==============================
action87 = _role addaction ["Get patrol mission","coppatrol.sqf",["start"],1,false,true,"","iscop and player distance copbank <= 4 and !pmissionactive and !patrolwaittime"];
action88 = _role addaction ["Cancel patrol mission","coppatrol.sqf",["end"],1,false,true,"","iscop and pmissionactive and player distance copbank <= 4"];
action871 = _role addaction ["Get Security mission","coppatrol.sqf",["start1"],1,false,true,"","iscop and player distance copbank <= 4 and !pmissionactive1 and !patrolwaittime1"];
action881 = _role addaction ["Cancel Security mission","coppatrol.sqf",["end1"],1,false,true,"","iscop and pmissionactive1 and player distance copbank <= 4"];
//=============== Cop Doors==================
action92 = _role addaction ["Open Door","code.sqf",[],1,false,true,"","player distance swatd1 <= 4"];
action93 = _role addaction ["Repair Jail","jailrepair.sqf",[],1,false,true,"","iscop and player distance jail2 <=4"];
action94 = _role addaction ["Open Cell 1","code.sqf",[1],1,false,true,"","player distance jail2 <=4"];
action95 = _role addaction ["Open Cell 2","code.sqf",[2],1,false,true,"","player distance jail2 <=4"];
//action93 = _role addaction ["Open Armory","code.sqf",[],1,false,true,"","iscop and player distance armorydoor <= 5"];
//ESU
action96 = _role addaction ["Get Oil","oil.sqf",["getoil"],1,false,true,"","player distance oilrig1 < 10 or player distance oilrig2 < 10"];
action97 = _role addaction ["Repair vehicle","noscript.sqf",'_vcl = (nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0);[_vcl] execVM "repairvehicle.sqf";',1,true,true,"",'_vcl = (nearestobjects [getpos player, ["Air", "Ship", "LandVehicle"], 3] select 0);_vcl in INV_ServerVclArray and (player == civ39 or player == civ40) and player distance _vcl < 10'];
//====================================== GUN/Driver LICENSE ==================================================	 
//action110 = _role addaction ["Take Driving test (Learners Drivers license required)","cartest.sqf",["test"],1,false,true,"","player distance atm1 <= 5 and isciv and !ctactive and !(""car"" call INV_HasLicense)"];
//action108 = _role addaction ["Take practical test (probationary license required)","guntest.sqf",["test"],1,false,true,"","player distance Licenseflag2 <= 5 and isciv and !gtactive and !(""semiautomatic"" call INV_HasLicense)"];
//action109 = _role addaction ["Test info","guntest.sqf",["info"],1,false,true,"","player distance Licenseflag2 <= 5 and isciv"];
//action112 = _role addaction ["Get Automatic license (requires pistol license and 40000)","guntest.sqf",["semi"],1,false,true,"","player distance Licenseflag2 <= 5 and isciv and !gtactive"];
//====================================== PLAYER HOUSING ==================================================
action831 = _role addaction ["Open Gang Door","playerhouse.sqf",["frontdoor",ganghouse4],1,false,true,"","_control = gangarea4 getvariable ""control"";!isnil ""_control"" and player distance ganghouse4 <= 8 and (_control == (call INV_mygang))"];
action832 = _role addaction ["Close Gang Door","playerhouse.sqf",["cfrontdoor",ganghouse4],1,false,true,"","_control = gangarea4 getvariable ""control"";!isnil ""_control"" and player distance ganghouse4 <= 8 and (_control == (call INV_mygang))"];
action833 = _role addaction ["Open Gang Door","playerhouse.sqf",["frontdoor",ganghouse3],1,false,true,"","_control = gangarea3 getvariable ""control"";!isnil ""_control"" and player distance ganghouse3 <= 8 and (_control == (call INV_mygang))"];
action834 = _role addaction ["Close Gang Door","playerhouse.sqf",["cfrontdoor",ganghouse3],1,false,true,"","_control = gangarea3 getvariable ""control"";!isnil ""_control"" and player distance ganghouse3 <= 8 and (_control == (call INV_mygang))"];
action835 = _role addaction ["Open Gang Door","playerhouse.sqf",["frontdoor",ganghouse3_1],1,false,true,"","_control = gangarea3 getvariable ""control"";!isnil ""_control"" and player distance ganghouse3_1 <= 8 and (_control == (call INV_mygang))"];
action836 = _role addaction ["Close Gang Door","playerhouse.sqf",["cfrontdoor",ganghouse3_1],1,false,true,"","_control = gangarea3 getvariable ""control"";!isnil ""_control"" and player distance ganghouse3_1 <= 8 and (_control == (call INV_mygang))"];
action837 = _role addaction ["Open Backdoor","playerhouse.sqf",["backdoor",ganghouse3_1],1,false,true,"","_control = gangarea3 getvariable ""control"";!isnil ""_control"" and player distance ganghouse3_1 <= 8 and (_control == (call INV_mygang))"];
action838 = _role addaction ["Close Backdoor","playerhouse.sqf",["cbackdoor",ganghouse3_1],1,false,true,"","_control = gangarea3 getvariable ""control"";!isnil ""_control"" and player distance ganghouse3_1 <= 8 and (_control == (call INV_mygang))"];
action839 = _role addaction ["Open Backdoor","playerhouse.sqf",["backdoor",ganghouse3],1,false,true,"","_control = gangarea3 getvariable ""control"";!isnil ""_control"" and player distance ganghouse3 <= 8 and (_control == (call INV_mygang))"];
action840 = _role addaction ["Close Backdoor","playerhouse.sqf",["cbackdoor",ganghouse3],1,false,true,"","_control = gangarea3 getvariable ""control"";!isnil ""_control"" and player distance ganghouse3 <= 8 and (_control == (call INV_mygang))"];
action113 = _role addaction ["Open Front Door","playerhouse.sqf",["frontdoor",Wulfer],1,false,true,"","player distance Wulfer <= 8"];
action114 = _role addaction ["Close Front Door","playerhouse.sqf",["cfrontdoor",Wulfer],1,false,true,"","player distance Wulfer <= 8"];
action115 = _role addaction ["Open Back Door","playerhouse.sqf",["backdoor",Wulfer],1,false,true,"","player distance Wulfer <= 8"];
action116 = _role addaction ["Close Back Door","playerhouse.sqf",["cbackdoor",Wulfer],1,false,true,"","player distance Wulfer <= 8"];
action117 = _role addaction ["Open Garage","playerhouse.sqf",["garage",wulf5],1,false,true,"","player distance wulf5 <= 6"];
action117a = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",wulf5],1,false,true,"","player distance wulf5 <= 6"];
action118 = _role addaction ["Open Governor Front Door","playerhouse.sqf",["fdoor1",mayorhouse],1,false,true,"","ismayor and player distance mayorhouse2 <= 8"];
action119 = _role addaction ["Open Governor Garage Door","playerhouse.sqf",["garagedoor",mayorhouse],1,false,true,"","ismayor and player distance mayorhouse2 <= 8"];
action120 = _role addaction ["Open Governor Garage Door","playerhouse.sqf",["garagedoor1",mayorhouse],1,false,true,"","ismayor and player distance mayorhouse2 <= 8"];
action121 = _role addaction ["Open Front Door","playerhouse.sqf",["fdoor",mansion1],1,false,true,"","player distance mansion1a <= 12"];
action122 = _role addaction ["Open Back Door","playerhouse.sqf",["bdoor",mansion1],1,false,true,"","player distance mansion1a <= 12"];
action123 = _role addaction ["Open Closet Door","playerhouse.sqf",["hdoor",mansion1],1,false,true,"","player distance mansion1a <= 20"];
action124 = _role addaction ["Open Garage","playerhouse.sqf",["fgarage",mansion1],1,false,true,"","player distance mansion1a <= 12"];
action125 = _role addaction ["Open Back Garage","playerhouse.sqf",["bgarage",mansion1],1,false,true,"","player distance mansion1a <= 12"];
action126 = _role addaction ["Open Door","playerhouse1.sqf",["door1"],1,false,true,"","player distance door1  <= 2"];
action127 = _role addaction ["Open Door","playerhouse1.sqf",["door2"],1,false,true,"","player distance door2  <= 2"];
action128 = _role addaction ["Open Door","playerhouse1.sqf",["door3"],1,false,true,"","player distance door3  <= 2"];
action129 = _role addaction ["Open Door","playerhouse1.sqf",["door4"],1,false,true,"","player distance door4  <= 2"];
action130 = _role addaction ["Open Door","playerhouse1.sqf",["door5"],1,false,true,"","player distance door5  <= 2"];
action131 = _role addaction ["Open Front Garage","playerhouse.sqf",["fgarage",mansion2,1,false,true,"","player distance mansion2a <= 10"];
action132 = _role addaction ["Open Closet Door","playerhouse.sqf",["hdoor",mansion2],1,false,true,"","player distance mansion2a <= 10"];
action134 = _role addaction ["Open Front Door","playerhouse.sqf",["fdoor",mansion2],1,false,true,"","player distance mansion2a <= 6"];
action135 = _role addaction ["Open Back Door","playerhouse.sqf",["bdoor",mansion2],1,false,true,"","player distance mansion2a <= 6"];
action136 = _role addaction ["Open Front Door","playerhouse.sqf",["fdoor",mansion3],1,false,true,"","player distance mansion3a <= 12"];
action137 = _role addaction ["Open Back Door","playerhouse.sqf",["bdoor",mansion3],1,false,true,"","player distance mansion3a <= 12"];
action138 = _role addaction ["Open Closet Door","playerhouse.sqf",["hdoor",mansion3],1,false,true,"","player distance mansion3a <= 20"];
action139 = _role addaction ["Open Garage","playerhouse.sqf",["fgarage",mansion3],1,false,true,"","player distance mansion3a <= 12"];
action140 = _role addaction ["Open Back Garage","playerhouse.sqf",["bgarage",mansion3],1,false,true,"","player distance mansion3a <= 12"];
action141 = _role addaction ["Open Front Door","playerhouse.sqf",["fdoor",ismansion],1,false,true,"","player distance ismansiona <= 12"];
action142 = _role addaction ["Open Back Door","playerhouse.sqf",["bdoor",ismansion],1,false,true,"","player distance ismansiona <= 12"];
action143 = _role addaction ["Open Closet Door","playerhouse.sqf",["hdoor",ismansion],1,false,true,"","player distance ismansiona <= 20"];
action144 = _role addaction ["Open Garage","playerhouse.sqf",["fgarage",ismansion],1,false,true,"","player distance ismansiona <= 12"];
action145 = _role addaction ["Open Back Garage","playerhouse.sqf",["bgarage",ismansion],1,false,true,"","player distance ismansiona <= 12"];
action146 = _role addaction ["Open Gate","playerhouse.sqf",["gate",ismansion],1,false,true,"","player distance ismansiona <= 20"];
action147 = _role addaction ["Open Door","playerhouse1.sqf",["door6"],1,false,true,"","player distance door6  <= 2"];
action148 = _role addaction ["Open Door","playerhouse1.sqf",["door7"],1,false,true,"","player distance door7  <= 2"];
action149 = _role addaction ["Open Door","playerhouse1.sqf",["door8"],1,false,true,"","player distance door8  <= 2"];
action150 = _role addaction ["Open Door","playerhouse1.sqf",["door9"],1,false,true,"","player distance door9  <= 2"];
action151 = _role addaction ["Open Front Door","playerhouse.sqf",["fdoor",mansion4],1,false,true,"","player distance mansion4a <= 12"];
action152 = _role addaction ["Open Back Door","playerhouse.sqf",["bdoor",mansion4],1,false,true,"","player distance mansion4a <= 12"];
action153 = _role addaction ["Open Closet Door","playerhouse.sqf",["hdoor",mansion4],1,false,true,"","player distance mansion4a <= 20"];
action154 = _role addaction ["Open Garage","playerhouse.sqf",["fgarage",mansion4],1,false,true,"","player distance mansion4a <= 12"];
action155 = _role addaction ["Open Back Garage","playerhouse.sqf",["bgarage",mansion4],1,false,true,"","player distance mansion4a <= 12"];
action156 = _role addaction ["Open Front Door","playerhouse.sqf",["fdoor",mansion5],1,false,true,"","player distance mansion5a <= 12"];
action157 = _role addaction ["Open Back Door","playerhouse.sqf",["bdoor",mansion5],1,false,true,"","player distance mansion5a <= 12"];
action158 = _role addaction ["Open Closet Door","playerhouse.sqf",["hdoor",mansion5],1,false,true,"","player distance mansion5a <= 20"];
action159 = _role addaction ["Open Garage","playerhouse.sqf",["fgarage",mansion5],1,false,true,"","player distance mansion5a <= 12"];
action160 = _role addaction ["Open Back Garage","playerhouse.sqf",["bgarage",mansion5],1,false,true,"","player distance mansion5a <= 12"];
action168 = _role addaction ["Open Back Garage","playerhouse.sqf",["bgarage",mansion2],1,false,true,"","player distance mansion2a <= 8"];
action169 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",Ben],1,false,true,"","player distance Ben <= 8"];
action170 = _role addaction ["Open Garage","playerhouse.sqf",["garage",mansion6a],1,false,true,"","player distance mansion6a <= 6"];
action171 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",mansion6a],1,false,true,"","player distance mansion6a <= 6"];
action173 = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",mansiondos],1,false,true,"","player distance mansiondos <= 8"];
action174 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",mansiondos],1,false,true,"","player distance mansiondos <= 8"];
action175 = _role addaction ["Open Garage","playerhouse.sqf",["garage",garagedos],1,false,true,"","player distance garagedos <= 6"];
action176 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",garagedos],1,false,true,"","player distance garagedos <= 6"];
action177 = _role addaction ["Open Gate","playerhouse1.sqf",["walldoor1"],1,false,true,"","player distance walldoor1  <= 6"];
action178 = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",Bryce],1,false,true,"","player distance Bryce <= 8"];
action178a = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",Bryce2],1,false,true,"","player distance Bryce2 <= 8"];
action179 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",Bryce],1,false,true,"","player distance Bryce <= 8"];
action179a = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",Bryce2],1,false,true,"","player distance Bryce2<= 8"];
action115 = _role addaction ["Open Back Door","playerhouse.sqf",["backdoor",Bryce],1,false,true,"","player distance Bryce <= 8"];
action116 = _role addaction ["Close Back Door","playerhouse.sqf",["cbackdoor",Bryce],1,false,true,"","player distance Bryce <= 8"];
action180 = _role addaction ["Open Garage","playerhouse.sqf",["garage",mansion7a],1,false,true,"","player distance mansion7a <= 6"];
action181 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",mansion7a],1,false,true,"","player distance mansion7a <= 6"];
action183 = _role addaction ["Open Door","playerhouse1.sqf",["door10"],1,false,true,"","player distance door10  <= 2"];
action185 = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",Jacko],1,false,true,"","player distance Jacko <= 8"];
action186 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",Jacko],1,false,true,"","player distance Jacko <= 8"];
action187 = _role addaction ["Open Garage","playerhouse.sqf",["garage",mansion8a],1,false,true,"","player distance mansion8a <= 6"];
action188 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",mansion8a],1,false,true,"","player distance mansion8a <= 6"];
action190 = _role addaction ["Open Door","playerhouse1.sqf",["door11"],1,false,true,"","player distance door11  <= 2"];
action191 = _role addaction ["Open Door","playerhouse1.sqf",["door12"],1,false,true,"","player distance door12  <= 2"];
action192 = _role addaction ["Open Front Door","playerhouse.sqf",["fdoor",mansion9],1,false,true,"","player distance mansion9a <= 12"];
action193 = _role addaction ["Open Back Door","playerhouse.sqf",["bdoor",mansion9],1,false,true,"","player distance mansion9a <= 12"];
action194 = _role addaction ["Open Closet Door","playerhouse.sqf",["hdoor",mansion9],1,false,true,"","player distance mansion9a <= 20"];
action195 = _role addaction ["Open Garage","playerhouse.sqf",["fgarage",mansion9],1,false,true,"","player distance mansion9a <= 12"];
action196 = _role addaction ["Open Back Garage","playerhouse.sqf",["bgarage",mansion9],1,false,true,"","player distance mansion9a <= 12"];
action197 = _role addaction ["Open Front Door","playerhouse.sqf",["fdoor",mansion10],1,false,true,"","player distance mansion10a <= 12"];
action198 = _role addaction ["Open Back Door","playerhouse.sqf",["bdoor",mansion10],1,false,true,"","player distance mansion10a <= 12"];
action199 = _role addaction ["Open Closet Door","playerhouse.sqf",["hdoor",mansion10],1,false,true,"","player distance mansion10a <= 20"];
action200 = _role addaction ["Open Garage","playerhouse.sqf",["fgarage",mansion10],1,false,true,"","player distance mansion10a <= 12"];
action201 = _role addaction ["Open Back Garage","playerhouse.sqf",["bgarage",mansion10],1,false,true,"","player distance mansion10a <= 12"];
action202 = _role addaction ["Open Front Door","playerhouse.sqf",["fdoor",mansion11],1,false,true,"","player distance mansion11a <= 12"];
action203 = _role addaction ["Open Back Door","playerhouse.sqf",["bdoor",mansion11],1,false,true,"","player distance mansion11a <= 12"];
action204 = _role addaction ["Open Closet Door","playerhouse.sqf",["hdoor",mansion11],1,false,true,"","player distance mansion11a <= 20"];
action205 = _role addaction ["Open Garage","playerhouse.sqf",["fgarage",mansion11],1,false,true,"","player distance mansion11a <= 12"];
action206 = _role addaction ["Open Back Garage","playerhouse.sqf",["bgarage",mansion11],1,false,true,"","player distance mansion11a <= 12"];
action207 = _role addaction ["Open Fence","playerhouse1.sqf",["bryced"],1,false,true,"","player distance bryced  <= 5"];
action208 = _role addaction ["Open Front Door","playerhouse.sqf",["fdoor1",playerhouse2],1,false,true,"","player distance playerhouse2a <= 5"];
action209 = _role addaction ["Open Garage Door","playerhouse.sqf",["garagedoor",playerhouse2],1,false,true,"","player distance playerhouse2a <= 5"];
action210 = _role addaction ["Open Garage Door","playerhouse.sqf",["garagedoor1",playerhouse2],1,false,true,"","player distance playerhouse2a <= 5"];
action211 = _role addaction ["Open Front Door","playerhouse.sqf",["fdoor1",playerhouse5],1,false,true,"","player distance playerhouse5a <= 5"];
action212 = _role addaction ["Open Garage Door","playerhouse.sqf",["garagedoor",playerhouse5],1,false,true,"","player distance playerhouse5a <= 5"];
action213 = _role addaction ["Open Garage Door","playerhouse.sqf",["garagedoor1",playerhouse5],1,false,true,"","player distance playerhouse5a <= 5"];
action214 = _role addaction ["Open Door","playerhouse1.sqf",["door13"],1,false,true,"","player distance door13  <= 5"];
action215 = _role addaction ["Open Front Door","playerhouse.sqf",["fdoor1",playerhouse3],1,false,true,"","player distance playerhouse3a <= 5"];
action216 = _role addaction ["Open Garage Door","playerhouse.sqf",["garagedoor",playerhouse3],1,false,true,"","player distance playerhouse3a <= 5"];
action217 = _role addaction ["Open Garage Door","playerhouse.sqf",["garagedoor1",playerhouse3],1,false,true,"","player distance playerhouse3a <= 5"];
action218 = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",wulf2],1,false,true,"","player distance wulf2 <= 8"];
action219 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",wulf2],1,false,true,"","player distance wulf2 <= 8"];
action220 = _role addaction ["Open Garage","playerhouse.sqf",["garage",wulf2a],1,false,true,"","player distance wulf2a <= 6"];
action220a = _role addaction ["Open Garage","playerhouse.sqf",["garage",wulf3a],1,false,true,"","player distance wulf3a <= 6"];
action221 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",wulf2a],1,false,true,"","player distance wulf2a <= 6"];
action221a = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",wulf3a],1,false,true,"","player distance wulf3a <= 6"];
action222 = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",chief],1,false,true,"","player distance chief <= 8"];
action223 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",chief],1,false,true,"","player distance chief <= 8"];
action224 = _role addaction ["Open Back Door","playerhouse.sqf",["backdoor",chief],1,false,true,"","player distance chief <= 8"];
action225 = _role addaction ["Close Back Door","playerhouse.sqf",["cbackdoor",chief],1,false,true,"","player distance chief <= 8"];
action226 = _role addaction ["Open Garage","playerhouse.sqf",["garage",bryceg1],1,false,true,"","player distance bryceg1 <= 6"];
action227 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",bryceg1],1,false,true,"","player distance bryceg1 <= 6"];
action228 = _role addaction ["Open Garage","playerhouse.sqf",["garage",bryceg2],1,false,true,"","player distance bryceg2 <= 6"];
action229 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",bryceg2],1,false,true,"","player distance bryceg2 <= 6"];
action230 = _role addaction ["Open Garage","playerhouse.sqf",["garage",chief2],1,false,true,"","player distance chief2 <= 6"];
action231 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",chief2],1,false,true,"","player distance chief2 <= 6"];
action232 = _role addaction ["Open Garage","playerhouse.sqf",["garage",harris2],1,false,true,"","player distance harris2 <= 6"];
action233 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",harris2],1,false,true,"","player distance harris2 <= 6"];
action234 = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",harris],1,false,true,"","player distance harris <= 8"];
action235 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",harris],1,false,true,"","player distance harris <= 8"];
action236 = _role addaction ["Open Front Door","playerhouse.sqf",["frontdoor",xray],1,false,true,"","player distance xray <= 8"];
action237 = _role addaction ["Close Front Door","playerhouse.sqf",["cfrontdoor",xray],1,false,true,"","player distance xray <= 8"];
action238 = _role addaction ["Open Back Door","playerhouse.sqf",["backdoor",xray],1,false,true,"","player distance xray <= 8"];
action239 = _role addaction ["Close Back Door","playerhouse.sqf",["cbackdoor",xray],1,false,true,"","player distance xray <= 8"];
action240 = _role addaction ["Open Garage","playerhouse.sqf",["garage",xrayg],1,false,true,"","player distance xrayg <= 6"];
action241 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",xrayg],1,false,true,"","player distance xrayg <= 6"];
action242 = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",zack],1,false,true,"","player distance zack <= 8"];
action243 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",zack],1,false,true,"","player distance zack <= 8"];
action244 = _role addaction ["Open Garage","playerhouse.sqf",["garage",zackg],1,false,true,"","player distance zackg <= 6"];
action245 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",zackg],1,false,true,"","player distance zackg <= 6"];
action246 = _role addaction ["Open Garage","playerhouse.sqf",["garage",zackg1],1,false,true,"","player distance zackg1 <= 6"];
action247 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",zackg1],1,false,true,"","player distance zackg1 <= 6"];
action249 = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",karnax],1,false,true,"","player distance karnax <= 8"];
action250 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",karnax],1,false,true,"","player distance karnax <= 8"];
action251 = _role addaction ["Open Garage","playerhouse.sqf",["garage",karnaxg],1,false,true,"","player distance karnaxg <= 6"];
action252 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",karnaxg],1,false,true,"","player distance karnaxg <= 6"];
action253 = _role addaction ["Open Garage","playerhouse.sqf",["garage",karnaxg1],1,false,true,"","player distance karnaxg1 <= 6"];
action254 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",karnaxg1],1,false,true,"","player distance karnaxg1 <= 6"];
action255 = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",knoll],1,false,true,"","player distance knoll <= 8"];
action256 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",knoll],1,false,true,"","player distance knoll <= 8"];
action257 = _role addaction ["Open Garage","playerhouse.sqf",["garage",knollg],1,false,true,"","player distance knollg <= 6"];
action258 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",knollg],1,false,true,"","player distance knollg <= 6"];
action259 = _role addaction ["Open Garage","playerhouse.sqf",["garage",knollg1],1,false,true,"","player distance knollg1 <= 6"];
action260 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",knollg1],1,false,true,"","player distance knollg1 <= 6"];
action261 = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",hiro],1,false,true,"","player distance hiro <= 10"];
action262 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",hiro],1,false,true,"","player distance hiro <= 10"];
action263 = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",WrenisPinkle],1,false,true,"","player distance WrenisPinkle <= 8"];
action264 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",WrenisPinkle],1,false,true,"","player distance WrenisPinkle <= 8"];
action265 = _role addaction ["Open Garage","playerhouse.sqf",["garage",WrenisPinkleg],1,false,true,"","player distance WrenisPinkleg <= 6"];
action266 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",WrenisPinkleg],1,false,true,"","player distance WrenisPinkleg <= 6"];
action267 = _role addaction ["Open Garage","playerhouse.sqf",["garage",WrenisPinkleg1],1,false,true,"","player distance WrenisPinkleg1 <= 6"];
action268 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",WrenisPinkleg1],1,false,true,"","player distance WrenisPinkleg1 <= 6"];
action269 = _role addaction ["Open Front Door","playerhouse.sqf",["fdoor",legitxcaps],1,false,true,"","player distance legitxcaps1 <= 12"];
action270 = _role addaction ["Open Back Door","playerhouse.sqf",["bdoor",legitxcaps],1,false,true,"","player distance legitxcaps1 <= 12"];
action271 = _role addaction ["Open Closet Door","playerhouse.sqf",["hdoor",legitxcaps],1,false,true,"","player distance legitxcaps1 <= 20"];
action272 = _role addaction ["Open Garage","playerhouse.sqf",["fgarage",legitxcaps],1,false,true,"","player distance legitxcaps1 <= 12"];
action273 = _role addaction ["Open Back Garage","playerhouse.sqf",["bgarage",legitxcaps],1,false,true,"","player distance legitxcaps1 <= 12"];
action274 = _role addaction ["Open Front Door","playerhouse.sqf",["frontdoor",Lumin8],1,false,true,"","player distance Lumin8 <= 8"];
action275 = _role addaction ["Close Front Door","playerhouse.sqf",["cfrontdoor",Lumin8],1,false,true,"","player distance Lumin8 <= 8"];
action276 = _role addaction ["Open Back Door","playerhouse.sqf",["backdoor",Lumin8],1,false,true,"","player distance Lumin8 <= 8"];
action277 = _role addaction ["Close Back Door","playerhouse.sqf",["cbackdoor",Lumin8],1,false,true,"","player distance Lumin8 <= 8"];
action278 = _role addaction ["Open Garage","playerhouse.sqf",["garage",Lumin8g],1,false,true,"","player distance Lumin8g <= 6"];
action279 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",Lumin8g],1,false,true,"","player distance Lumin8g <= 6"];
action280 = _role addaction ["Open Front Door","playerhouse.sqf",["frontdoor",dank],1,false,true,"","player distance dank <= 8"];
action281 = _role addaction ["Close Front Door","playerhouse.sqf",["cfrontdoor",dank],1,false,true,"","player distance dank <= 8"];
action282 = _role addaction ["Open Back Door","playerhouse.sqf",["backdoor",dank],1,false,true,"","player distance dank <= 8"];
action283 = _role addaction ["Close Back Door","playerhouse.sqf",["cbackdoor",dank],1,false,true,"","player distance dank <= 8"];
action284 = _role addaction ["Open Garage","playerhouse.sqf",["garage",dankg],1,false,true,"","player distance dankg <= 6"];
action285 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",dankg],1,false,true,"","player distance dankg <= 6"];
action286 = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",heckert],1,false,true,"","player distance heckert <= 8"];
action287 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",heckert],1,false,true,"","player distance heckert <= 8"];
action288 = _role addaction ["Open Garage","playerhouse.sqf",["garage",heckertg],1,false,true,"","player distance heckertg <= 6"];
action289 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",heckertg],1,false,true,"","player distance heckertg <= 6"];
action290 = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",belosi],1,false,true,"","player distance belosi <= 8"];
action291 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",belosi],1,false,true,"","player distance belosi <= 8"];
action292 = _role addaction ["Open Garage","playerhouse.sqf",["garage",belosig],1,false,true,"","player distance belosig <= 6"];
action293 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",belosig],1,false,true,"","player distance belosig <= 6"];
action294 = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",hiddenops],1,false,true,"","player distance hiddenops <= 8"];
action295 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",hiddenops],1,false,true,"","player distance hiddenops <= 8"];
action296 = _role addaction ["Open Back Door","playerhouse.sqf",["backdoor",hiddenops],1,false,true,"","player distance hiddenops <= 8"];
action297 = _role addaction ["Close Back Door","playerhouse.sqf",["cbackdoor",hiddenops],1,false,true,"","player distance hiddenops <= 8"];
action298 = _role addaction ["Open Garage","playerhouse.sqf",["garage",hiddenopsg],1,false,true,"","player distance hiddenopsg <= 6"];
action299 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",hiddenopsg],1,false,true,"","player distance hiddenopsg <= 6"];
action300 = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",hiro2],1,false,true,"","player distance hiro2 <= 8"];
action301 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",hiro2],1,false,true,"","player distance hiro2 <= 8"];
action302 = _role addaction ["Open Back Door","playerhouse.sqf",["backdoor",hiro2],1,false,true,"","player distance hiro2 <= 8"];
action303 = _role addaction ["Close Back Door","playerhouse.sqf",["cbackdoor",hiro2],1,false,true,"","player distance hiro2 <= 8"];
action304 = _role addaction ["Open Garage","playerhouse.sqf",["garage",hiro2g],1,false,true,"","player distance hiro2g <= 6"];
action305 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",hiro2g],1,false,true,"","player distance hiro2g <= 6"];
action306 = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",hagar],1,false,true,"","player distance hagar <= 8"];
action307 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",hagar],1,false,true,"","player distance hagar <= 8"];
action308 = _role addaction ["Open Back Door","playerhouse.sqf",["backdoor",hagar],1,false,true,"","player distance hagar <= 8"];
action309 = _role addaction ["Close Back Door","playerhouse.sqf",["cbackdoor",hagar],1,false,true,"","player distance hagar <= 8"];
action310 = _role addaction ["Open Garage","playerhouse.sqf",["garage",hagarg],1,false,true,"","player distance hagarg <= 6"];
action311 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",hagarg],1,false,true,"","player distance hagarg <= 6"];
action312 = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",cahethel],1,false,true,"","player distance cahethel <= 8"];
action313 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",cahethel],1,false,true,"","player distance cahethel <= 8"];
action314 = _role addaction ["Open Back Door","playerhouse.sqf",["backdoor",cahethel],1,false,true,"","player distance cahethel <= 8"];
action315 = _role addaction ["Close Back Door","playerhouse.sqf",["cbackdoor",cahethel],1,false,true,"","player distance cahethel <= 8"];
action316 = _role addaction ["Open Garage","playerhouse.sqf",["garage",cahethelg],1,false,true,"","player distance cahethelg <= 6"];
action317 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",cahethelg],1,false,true,"","player distance cahethelg <= 6"];
action318 = _role addaction ["Open Garage","playerhouse.sqf",["garage",cahethelg1],1,false,true,"","player distance cahethelg1 <= 6"];
action319 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",cahethelg1],1,false,true,"","player distance cahethelg1 <= 6"];
action320 = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",cahethel2],1,false,true,"","player distance cahethel <= 8"];
action321 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",cahethel2],1,false,true,"","player distance cahethel2 <= 8"];
action322 = _role addaction ["Open Back Door","playerhouse.sqf",["backdoor",cahethel2],1,false,true,"","player distance cahethel2 <= 8"];
action323 = _role addaction ["Close Back Door","playerhouse.sqf",["cbackdoor",cahethel2],1,false,true,"","player distance cahethel2 <= 8"];
action324 = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",cahethel3],1,false,true,"","player distance cahethel3 <= 8"];
action325 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",cahethel3],1,false,true,"","player distance cahethel3 <= 8"];
action326 = _role addaction ["Open Back Door","playerhouse.sqf",["backdoor",cahethel3],1,false,true,"","player distance cahethel3 <= 8"];
action327 = _role addaction ["Close Back Door","playerhouse.sqf",["cbackdoor",cahethel3],1,false,true,"","player distance cahethel3 <= 8"];
action328 = _role addaction ["Open Gate","playerhouse1.sqf",["walldoor3"],1,false,true,"","player distance walldoor3  <= 6"];
action329 = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",deans],1,false,true,"","player distance deans <= 8"];
action330 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",deans],1,false,true,"","player distance deans <= 8"];
action331 = _role addaction ["Open Back Door","playerhouse.sqf",["backdoor",deans],1,false,true,"","player distance deans <= 8"];
action332 = _role addaction ["Close Back Door","playerhouse.sqf",["cbackdoor",deans],1,false,true,"","player distance deans <= 8"];
action333 = _role addaction ["Open Garage","playerhouse.sqf",["garage",deansg],1,false,true,"","player distance deansg <= 6"];
action334 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",deansg],1,false,true,"","player distance deansg <= 6"];
action335 = _role addaction ["Open Door","playerhouse.sqf",["frontdoor",radar],1,false,true,"","player distance radar <= 8"];
action336 = _role addaction ["Close Door","playerhouse.sqf",["cfrontdoor",radar],1,false,true,"","player distance radar <= 8"];
action337 = _role addaction ["Open Back Door","playerhouse.sqf",["backdoor",radar],1,false,true,"","player distance radar <= 8"];
action338 = _role addaction ["Close Back Door","playerhouse.sqf",["cbackdoor",radar],1,false,true,"","player distance radar <= 8"];
action339 = _role addaction ["Open Garage","playerhouse.sqf",["garage",radarg],1,false,true,"","player distance radarg <= 6"];
action340 = _role addaction ["Close Garage","playerhouse.sqf",["cgarage",radarg],1,false,true,"","player distance radarg <= 6"];
action341 = _role addaction ["Open Door","playerhouse1.sqf",["door14"],1,false,true,"","player distance door14  <= 2"];