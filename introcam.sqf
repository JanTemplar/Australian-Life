_label = _this select 0;

if (_label == "basicintro") then 

{
titlecut [" ","Black out",0];	
titletext ["Joining Game please wait","plain"];
sleep 5;
titletext [localize "STRS_anfang_02","plain"];
sleep 5;
titletext [localize "STRS_anfang_03","plain"];
sleep 5;			
titletext ["Enjoy your stay","plain"];
//sleep 10;
//titletext [localize "STRS_anfang_05_civ","plain"];
//sleep 10;
//titletext [localize "STRS_anfang_05_cop","plain"];
titlecut [" ","Black in", 20];

};

if (_label == "camera") then 

{

titlecut [" ","Black out",0];										
titletext [localize "STRS_anfang_laden","plain"] ;				
//_camera = "camera" camcreate [(getmarkerpos "cameraview" select 0) - 25,(getmarkerpos "cameraview" select 1) - 100,22];												
//_camera cameraeffect ["internal", "back"];						
sleep 5;														
titlecut [" ","Black in", 20];

//_camera camPrepareTarget _targetciv;
//_camera camPreparePos _posciv;	
//_camera camPrepareFOV _fovciv;
//_camera camCommitPrepared 5;

//WaitUntil {camCommitted _camera};
//_rolepos = position player;
//_roledir = getdir player;
//_pos     = [(_rolepos select 0) + ((sin _roledir) * 100), (_rolepos select 1) + ((cos _roledir) * 100),(_rolepos select 2)];
//_camera camSetTarget _pos;
//_camera camsetpos [(getpos player select 0), (getpos player select 1), 1.5];
//_camera camSetFOV 0.700;
//_camera camCommit 3;
//WaitUntil {camCommitted _camera};
titletext [localize "STRS_anfang_06","plain"];
//_camera cameraeffect ["terminate","back"];
//camDestroy _camera;

};