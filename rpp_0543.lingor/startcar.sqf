_car = _this select 0;

if ( !(_this select 1) ) exitWith {hint "NO!";};
if (_car getVariable "TNL_veh_starting") exitWith {};

_car setVariable ["TNL_veh_starting", true];

_fuel = fuel _car;
_car setFuel 0;

sleep 2;

_car setFuel _fuel;
_car action ["ENGINEON", _car];

sleep 2;

_car setVariable ["TNL_veh_starting", false];