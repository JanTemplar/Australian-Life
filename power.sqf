_types = ["ASC_EU_LHVSidl3","LAND_ASC_Wall_Lamp_New"];

while {true} do

{

waituntil{!alive power1 and !alive power2};

hint "The reactors at the Chernarus Power Plant have been destroyed, it'll be a dark night!";

for [{_i=0},{_i < (count _types)},{_i=_i+1}] do

{

_lamps = getmarkerpos "powerarea" nearObjects [_types select _i, 4000];
Sleep 1;
{_x setdamage .4;} forEach _lamps;

};

waituntil{alive power1 and alive power2};

hint "The Chernarus power plant has been repaired and power has been restored!";

for [{_i=0},{_i < (count _types)},{_i=_i+1}] do

{

_lamps = getmarkerpos "powerarea" nearObjects [_types select _i, 4000];
Sleep 1;
{	_x setdamage 0;
	_light = "#lightpoint" createVehicleLocal getPos _x;

	_light setLightBrightness 0.1;

	_light setLightAmbient[0.1, 0.1, 0.1];

	_light setLightColor[0.5,0.5 , 0.5];

	_light lightAttachObject [_x, [0,0,4]];} forEach _lamps;

};

};


_types = ["Land_PowLines_WoodL", "Land_PowLines_ConcL", "Land_lampa_ind_zebr", "Land_lampa_sidl_3", "Land_lampa_vysoka", "Land_lampa_ind", "Land_lampa_ind_b", "Land_lampa_sidl"];

while {true} do

{

waituntil{!alive power1 and !alive power2};

hint "The reactors at the Chernarus Power Plant have been destroyed, it'll be a dark night!";

for [{_i=0},{_i < (count _types)},{_i=_i+1}] do

{

_lamps = getmarkerpos "powercoverage" nearObjects [_types select _i, 4000];
Sleep 1;
{_x switchLight "OFF";} forEach _lamps;

};

waituntil{alive power1 and alive power2};

hint "The Chernarus power plant has been repaired and power has been restored!";

for [{_i=0},{_i < (count _types)},{_i=_i+1}] do

{

_lamps = getmarkerpos "powercoverage" nearObjects [_types select _i, 4000];
Sleep 1;
{_x switchLight "ON";} forEach _lamps;

};

};