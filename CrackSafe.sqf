_art = (_this select 3) select 0;

if (_art == "safe1") then 

{

_camera = "camera" camCreate getPos bankcam;
_camera camSetTarget bankcam;
_camera cameraEffect ["external", "top"];
_camera camSetFOV .900;
_camera camCommit 0;

_Oii = createdialog "MBG_Safe";
sliderSetRange [5131, 0, 0.91666666666666667];
sliderSetspeed [5131, 0.08333333333333333,0 ];
Processing1 = true;
_O = [] execvm "Safeused.sqf";

While {Dialog} do {
sleep 0.08;
};
_camera cameraEffect ["terminate", "Back"];
camDestroy _camera;
Processing1 = False;

};

if (_art == "safe2") then 

{
_camera = "camera" camCreate getPos bankcam;
_camera camSetTarget bankcam;
_camera cameraEffect ["external", "top"];
_camera camSetFOV .900;
_camera camCommit 0;
_Oii = createdialog "MBG_Safe";
sliderSetRange [5131, 0, 0.91666666666666667];
sliderSetspeed [5131, 0.08333333333333333,0 ];
Processing2 = true;
_O = [] execvm "Safeused.sqf";

While {Dialog} do {
sleep 0.08;
};
_camera cameraEffect ["terminate", "Back"];
camDestroy _camera;
Processing2 = False;

};

if (_art == "safe3") then 

{
_camera = "camera" camCreate getPos bankcam;
_camera camSetTarget bankcam;
_camera cameraEffect ["external", "top"];
_camera camSetFOV .900;
_camera camCommit 0;
_Oii = createdialog "MBG_Safe";
sliderSetRange [5131, 0, 0.91666666666666667];
sliderSetspeed [5131, 0.08333333333333333,0 ];
Processing3 = true;
_O = [] execvm "Safeused.sqf";

While {Dialog} do {
sleep 0.08;
};
_camera cameraEffect ["terminate", "Back"];
camDestroy _camera;
Processing3 = False;

};