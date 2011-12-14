_civnumber = _this select 0;

//==============================================CONVOY MARKER=======================================

if (_civnumber == 1) then 

{
						
_markerobj = createMarker["konvoy_marker",[0,0]];								
_markername= "konvoy_marker";			
_markerobj setMarkerShape "ICON";						
"konvoy_marker" setMarkerType "Marker";										
"konvoy_marker" setMarkerColor "Colorgreen";						
"konvoy_marker" setMarkerText "Supply Truck";															

while {true} do 

	{
												
	_markername SetMarkerPos [(getMarkerPos "marker_dead" select 0)-1000,(getMarkerPos "marker_dead" select 1)-1000];																						
	waitUntil {(konvoy_marker_active == 1)};			
		
	while {konvoy_marker_active == 1} do 

		{	
																																						
		_markername SetMarkerPos getpos konvoytruck;	
		sleep 5;

		};

	};
	sleep 1;

};

//===================================COP MARKERS==========================================

if (_civnumber == 2) then 

{
														
if (not(iscop)) exitWith {};
				
_copnumber = 1; 
_copmarkerarray = []; 
_copmarkernamearray = [];
					
while {_copnumber <= copscount} do 

	{
								
	_copmarker       = createMarkerLocal[format["cop%1_marker", _copnumber], [-100, -100]];																								
	_copmarkerarray       = _copmarkerarray + [_copmarker];										
	_markername           = format["cop%1_marker", _copnumber];														
	_copmarkernamearray   = _copmarkernamearray + [_markername];																						
	_copmarker setMarkerShapeLocal  "ICON";				
	_markername setMarkerTypeLocal  "Dot";				
	_markername setMarkerColorLocal "ColorBlue";																										
	_markername setMarkerSizeLocal  [1.2, 1.2];			
	format["cop%1_marker", _copnumber] 
	setMarkerTextLocal format["Cop%1" , _copnumber];												
	_copnumber = _copnumber + 1;														

	};
										
{_x SetMarkerPosLocal [(getMarkerPos "marker_dead" select 0)-1000,(getMarkerPos "marker_dead" select 1)-1000]} forEach _copmarkernamearray;				

while {true} do 

	{
								
	_counter = 0;		

	while {_counter < count coparray} do 

		{
		
		_cop = coparray select _counter;																																													
		if (isnull _cop or !isPlayer _cop or copmarker_on == 0) then 

			{
																																
			(_copmarkernamearray select _counter) SetMarkerPosLocal (getmarkerpos "marker_dead");												

			} 
			else 
			{
								
			if (alive _cop) then {(_copmarkernamearray select _counter) SetMarkerPosLocal [position _cop select 0, position _cop select 1];};																																													
			sleep 1;

			};
																											
		_counter = _counter + 1;

		};

	sleep 1;			

	};

};
