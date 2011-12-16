/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/


TNL_fmarkers_revealCheck = 
{
	{
		_markerName = (_x select 0);
		_markerArray = _markerName call TNL_fmarkers_getMarkerArray;
		_markerText = _markerArray select 1;
		_distanceToFind = _markerArray select 5;
		_markerPos = _markerArray select 6;
		
		if (TNL_gVar_arr_foundMarkers find _markerName == -1) then
		{
			if (vehicle player distance _markerPos <= _distanceToFind) then
			{
				[format[localize "STRS_markers_discover", _markerText]] call TNL_fextHint_Hint;
				[_markerName] call TNL_fmarkers_revealMarker;
			};
		};
	} foreach TNL_gVar_arr_markers;
	
};

TNL_fmarkers_revealMarker =
{
	private ["_markerName", "_markerText", "_markerType", "_markerColor", "_markerPos"];
	_markerName = _this select 0;
	_markerArray = _markerName call TNL_fmarkers_getMarkerArray;
	_markerText = _markerArray select 1;
	_markerType = _markerArray select 2;
	_markerColor = _markerArray select 3;
	_markerPos = _markerArray select 6;
	
	TNL_gVar_arr_foundMarkers = TNL_gVar_arr_foundMarkers + [ _markerName ];

	_markerName setMarkerPosLocal _markerPos;
	_markerName setMarkerTypeLocal _markerType;
	_markerName setMarkerTextLocal _markerText;
	_markerName setMarkerColorLocal _markerColor;
	_markerName setMarkerSizeLocal [0.25, 0.25];
};

TNL_fmarkers_revealAllMarkers = 
{
	{
		_markerName = (_x select 0);
		[_markerName] call TNL_fmarkers_revealMarker;
	} foreach TNL_gVar_arr_markers;
}; 

TNL_fmarkers_revealFoundMarkers =
{
	{
		[_x] call TNL_fmarkers_revealMarker;
	} forEach TNL_gVar_arr_foundMarkers;
};

TNL_fmarkers_getMarkerArray = 
{
	private ["_markerName", "_return"];
	_markerName = _this;
	_return = "";
	
	{	
		if ((_x select 0) == _markerName) then
		{
			_return = (_x);
		};
	} foreach TNL_gVar_arr_markers;
	
	_return
};

TNL_fmarkers_getMarkerText = 
{
	private ["_markerName", "_return"];
	_markerName = _this;
	_return = "";
	
	{	
		if ((_x select 0) == _markerName) then
		{
			_return = (_x select 1);
		};
	} foreach TNL_gVar_arr_markers;
	
	_return
	
};

TNL_fmarkers_getMarkerType = 
{
	private ["_markerName", "_return"];
	_markerName = _this;
	_return = "";
	
	{	
		if ((_x select 0) == _markerName) then
		{
			_return = (_x select 2);
		};
	} foreach TNL_gVar_arr_markers;
	
	_return
	
};

TNL_fmarkers_getMarkerColor = 
{
	private ["_markerName", "_return"];
	_markerName = _this;
	_return = "";
	
	{	
		if ((_x select 0) == _markerName) then
		{
			_return = (_x select 3);
		};
	} foreach TNL_gVar_arr_markers;
	
	_return
	
};

TNL_fmarkers_getNeedToFind = 
{
	private ["_markerName", "_return"];
	_markerName = _this;
	_return = false;
	
	{	
		if ((_x select 0) == _markerName) then
		{
			_return = (_x select 4);
		};
	} foreach TNL_gVar_arr_markers;
	
	_return
};


TNL_fmarkers_getDistanceToFind =
{
	private ["_markerName", "_return"];
	_markerName = _this;
	_return = 0;
	
	{	
		if ((_x select 0) == _markerName) then
		{
			_return = (_x select 5);
		};
	} foreach TNL_gVar_arr_markers;
	
	_return
};

TNL_fmarkers_getMarkerPos =
{
	private ["_markerName", "_return"];
	_markerName = _this;
	_return = 0;
	
	{	
		if ((_x select 0) == _markerName) then
		{
			_return = (_x select 6);
		};
	} foreach TNL_gVar_arr_markers;
	
	_return
};
