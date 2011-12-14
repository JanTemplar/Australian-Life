_closeVcl   = dummyobj;			
_closest    = -1;	

_closeObjs = nearestObjects [player,["Car","Truck","Motorcycle","Tank","Air","Ship"],7];


{
	if (not(isNull(_x))) then 
	{	
		if ( ((player distance _x) < 7) and ( ((player distance _x) < _closest) or (_closest == -1) ) ) then 
		{																												
			_closest  = (player distance _x);																																				
			_closeVcl = _x;
		};					
	};	
} forEach _closeObjs;	

{
	if (_closeVcl == (_x select 0)) exitWith
	{
		_closest = -1;
	};
} forEach Gvar_arr_inv_ownedVehicles;
		
	
_passengers = crew _closeVcl;
	
if (not(_closest == -1)) then 
{				
	_isRealVehicle = _closeVcl getVariable "storage";		
	if (isNil "_isRealVehicle") then 
	{
		["Vehicle cannot be impounded!"] call TNL_fextHint_Hint;
	} 
	else 
	{
		if (count _passengers > 0) exitWith 
		{
			["You cannot impound the vehicle because people are in it! How rude!"] call TNL_fextHint_Hint;
		};
		
		[{(_this select 0) lock false;}, [_closeVcl]] call TNL_fnet_execPublic;
		_closeVcl setVariable["trunklocked", false, true];
		_closeVcl setpos [(getpos impoundlot select 0)+(random 4)-(random 4), (getpos impoundlot select 1)+(random 4)-(random 4), (getpos impoundlot select 2)];
		_closeVcl setdir 180;
		["Vehicle has been impounded!"] call TNL_fextHint_Hint;																																																																																																	
	};													
} 
else 
{
	["No vehicles nearby"] call TNL_fextHint_Hint;
};
