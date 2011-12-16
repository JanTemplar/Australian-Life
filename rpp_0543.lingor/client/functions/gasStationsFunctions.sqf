_i = 0;
while {_i < count TNL_gas_gasStations} do
{
	{
		_x setFuelCargo 0;
		_action = _x addAction ["Grab", "client\useAction.sqf", ["grabNozzle", ((TNL_gas_gasStations select _i) select 0)]];
		_x setVariable ["TNL_gas_inUse", false];
		_x setVariable ["TNL_gas_grabAction", _action];	
	} forEach nearestObjects [((TNL_gas_gasStations select _i) select 0), ["Land_A_FuelStation_Feed", "Land_benzina_schnell", "Land_fuelstation", "Land_fuelstation_army"], 30];
	_i = _i + 1;
};


TNL_fgas_grabNozzle =
{
	_pump = _this select 0;
	_gasStation = _this select 1;
	
	if (_pump getVariable "TNL_gas_inUse") exitWith
	{
		["Somebody is already using this pump"]  call TNL_fextHint_Hint;
	};
	
	["You picked up the nozzle."] call TNL_fextHint_Hint;
	_prices = _gasStation getVariable "TNL_gas_prices";

	TNL_gas_currentPump = [_pump, _gasStation];
	[2] spawn TNL_fgas_hasNozzle;
};

TNL_fgas_hasNozzle =
{
	_fuel = _this select 0;
	
	_pump = TNL_gas_currentPump select 0;
	_gasStation = TNL_gas_currentPump select 1;

	TNL_gas_currentPump set [2, _fuel];
	
	_pump setVariable ["TNL_gas_inUse", true, true];
	_pump removeAction (_pump getVariable "TNL_gas_grabAction");
	_action = _pump addAction ["drop", "client\useAction.sqf", ["dropNozzle", _gasStation]];
	_pump setVariable ["TNL_gas_dropAction", _action];
	
	DFS_gas_hasNozzle = true;
	[_pump, _gasStation] spawn
	{
		_pump = _this select 0;
		while {DFS_gas_hasNozzle} do
		{
			if ( (player distance _pump > 7) || player != vehicle player) exitWith
			{
				_this call TNL_fgas_dropNozzle;
				["You dropped the nozzle."] call TNL_fextHint_Hint;
			};
			sleep 1;
		};
	};
	
	_refuelCars = [];
	while {DFS_gas_hasNozzle} do
	{
		_i = 0;
		{
			if ( (_x distance _pump > 10) || !alive _x ) then
			{
				_x removeAction (_x getVariable "TNL_gas_refuelAction");
				_refuelCars set [_i, ">REMOVE<"];
			};
			_i = _i + 1;
		} forEach _refuelCars;
		_refuelCars = _refuelCars - [">REMOVE<"];
		
		{
			if ( (!(_x in _refuelCars)) && alive _x) then
			{
				if (_x != player) then
				{
					_refuelCars = _refuelCars + [_x];
					_refuelAction = _x addAction ["Refuel", "client\useAction.sqf", ["refuel"]];
					_x setVariable ["TNL_gas_refuelAction", _refuelAction];
				};
			};
		} forEach nearestObjects [_pump, ["AllVehicles"], 10];
		sleep 1;
	};
	
	{
		_x removeAction (_x getVariable "TNL_gas_refuelAction");
	} forEach _refuelCars;
};

TNL_fgas_dropNozzle =
{
	_pump = _this select 0;
	_gasStation = _this select 1;

	DFS_gas_hasNozzle = false;
	_pump removeAction (_pump getVariable "TNL_gas_dropAction");

	_action = _pump addAction ["grab", "client\useAction.sqf", ["grabNozzle", _gasStation]];
	_pump setVariable ["TNL_gas_grabAction", _action];

	_pump setVariable ["TNL_gas_inUse", false, true];
};

TNL_fgas_refuelCar =
{	
	_car = _this select 0;
	_pump = TNL_gas_currentPump select 0;
	_gasStation = TNL_gas_currentPump select 1;
	_fuelType = TNL_gas_currentPump select 2;
	
	if (player getVariable "TNL_gas_isRefueling") exitWith
	{
		["You are already refueling a vehicle!"]  call TNL_fextHint_Hint;
	};
	if (_car getVariable "TNL_gas_isRefueled") exitWith
	{
		["Somebody is already refueling this vehicle!"] call TNL_fextHint_Hint;
	};
	if (player distance _car > 4.0) exitWith
	{
		["You are too far away from the vehicle"] call TNL_fextHint_Hint;
	};
	
	player setVariable ["TNL_gas_isRefueling", true, false];
	_car setVariable ["TNL_gas_isRefueled", true, true];
	
	_details = _details + [_gasStation getVariable "TNL_gas_curCapacity"];
	
	_gasLeft = _details select _fuelType;
	

	if (_gasLeft <= 0) exitWith
	{
		["The gas station seems to be out of gas..."] call TNL_fextHint_Hint;
		
		player setVariable ["TNL_gas_isRefueling", false, false];
		_car setVariable ["TNL_gas_isRefueled", false, true];
	};
	
	_tankSize = (typeOf _car) call TNL_finv_getOtherValues select 2;
	_refuelFactor = 1 / _tankSize;
	_gasTanked = 0;
	
	_pos = getPos player;
	_gasPrices = ((_gasStation getVariable "TNL_gas_prices") select 1);
	_origPrice = _gasPrices;
	_tax = GblFuelTaxes;
	_origPrice = _gasPrices;
	_gasPrices = ((_gasPrices/100)*_tax);
	_totalPrice = 0;
	_money = "money" call TNL_finv_getItemAmount;
	_amount = 0;
	
	
	while {DFS_gas_hasNozzle} do
	{
		
		_details = _gasStation getVariable "TNL_gas_curCapacity";
		_gasLeft = _details select _fuelType;
		
		if (fuel _car >= 1) exitWith
		{
			["Car fully refueled"] call TNL_fextHint_Hint;
		};
		if (player distance _pos > 0.05) exitWith
		{
			["You cannot move away from the nozzle!"]  call TNL_fextHint_Hint;
		};
		if (_gasLeft <= 0) exitWith
		{
			["The gas station ran out of gas..."] call TNL_fextHint_Hint;
		};
		_totalPrice = _totalPrice + _gasPrices;
		
		if (_money < _totalPrice) exitWith
		{
			[format["You dont have enough money, total price: $1", _totalPrice]] call TNL_fextHint_Hint;
		};
		
	//	player groupchat format["%1 %2", _gasLeft, _gasLeft - 1];
		_car setFuel (fuel _car + _refuelFactor);
		_details set [_fuelType, (_gasLeft - 1)];
		_amount = _amount + 1;
		_gasStation setVariable ["TNL_gas_curCapacity", _details, true];
		_gasTanked = _gasTanked + 1;
		titleText [format["Refueling...\n\nFuel: %1\nPrice: $%2", fuel _car, _totalPrice], "PLAIN"];
			
		_pos = getPos player;
		
		_car say3D "SndFuelPump";
		sleep 1;
	};
	
	titleText ["", "PLAIN"];
	
	player setVariable ["TNL_gas_isRefueling", false, false];
	_car setVariable ["TNL_gas_isRefueled", false, true];
	["money", -(_totalPrice)] call TNL_finv_addInventoryItem;
	
	if (DFS_gas_hasNozzle) then
	{
		[_pump, _gasStation] call TNL_fgas_dropNozzle;
	};
	
	sleep 5;
	_taxRate = (GblFuelTaxes/100);
	_origPrice = (_origPrice * _amount);
	_price = _origPrice * (_taxRate);
	_taxPaid = (_taxRate * _price);
	_taxPaid = (_price - _taxPaid);
	[{GovernmentTaxAccount = GovernmentTaxAccount + (_this select 0); publicVariable "GovernmentTaxAccount"; }, [abs(_taxPaid)]] call TNL_fnet_execPublic;
	
	[format["Cost to refuel: $%1", _totalPrice]] call TNL_fextHint_Hint;
};
// player setVariable ["TNL_gas_cisternFuel", 500, true]; [player, fuel1, 0] call TNL_fgas_refilStationTanks
//[vehicle player, fuel1] spawn TNL_fgas_refilStationTanks
TNL_fgas_refilStationTanks =
{
	disableSerialization;
	private ["_truck", "_station", "_displ", "_fuelName", "_details", "_cistern"];
	_truck = _this select 0;
	_station = _this select 1;
	
	_fuelType = 2;
	
	TNL_gas_tankFromCistern = true;
	TNL_gas_doTankFromCistern = false;
	
	createDialog "TNL_dlg_gasRefilTanks";
	_displ = findDisplay 1303;
	
	switch (_fuelType) do
	{
		case 0:
		{
			_fuelName = "Diesel";
		};
		case 1:
		{
			_fuelName = "Leaded";
		};
		case 2:
		{
			_fuelName = "Unleaded";
		};
		default
		{
			_fuelName = "ERROR!";
		};
	};
	(_displ displayCtrl 1) ctrlSetStructuredText parseText format["Price per L: $%1", ((_station getVariable "TNL_gas_prices") select 0)];
	(_displ displayCtrl 2) ctrlSetStructuredText parseText format["%1 L", _truck getVariable "TNL_gas_cisternFuel"];
	(_displ displayCtrl 3) ctrlSetStructuredText parseText format["%1/%2 L", (_station getVariable "TNL_gas_curCapacity") select _fuelType, (_station getVariable "TNL_gas_maxCapacity") select _fuelType];
	
	
	_details = (_station getVariable "TNL_gas_curCapacity");
	_cistern = _truck getVariable "TNL_gas_cisternFuel";
	_price = ((_station getVariable "TNL_gas_prices") select 0);
	_amount = 0;
	while {TNL_gas_tankFromCistern} do
	{
		if (TNL_gas_doTankFromCistern) then
		{
			ctrlShow [4, false];
			ctrlShow [5, true];
			ctrlEnable [6, false];
			
			_details = (_station getVariable "TNL_gas_curCapacity");
			_cistern = (_truck getVariable "TNL_gas_cisternFuel");
			
			if ((_details select _fuelType) >= (_station getVariable "TNL_gas_maxCapacity") select _fuelType) exitWith
			{
				["Gas station full!"] call TNL_fextHint_Hint;
				TNL_gas_tankFromCistern = false;
				ctrlShow [4, true];
				ctrlEnable [4, false];
				ctrlShow [5, false];
				ctrlEnable [6, true];
			};
			if (_cistern <= 0) exitWith
			{
				["Truck's cistern empty!"] call TNL_fextHint_Hint;
				TNL_gas_tankFromCistern = false;
				ctrlShow [4, true];
				ctrlEnable [4, false];
				ctrlShow [5, false];
				ctrlEnable [6, true];
			};
			if (!alive _truck || !alive player || !(player in crew _truck)) exitWith
			{
				TNL_gas_tankFromCistern = false;
				closeDialog 0;
			};
			
			_details set [_fuelType, (_details select _fuelType) + 1];
			_station setVariable ["TNL_gas_curCapacity", _details, true];
			_truck setVariable ["TNL_gas_cisternFuel", _cistern - 1, true];
			
			//["money", _price] call TNL_finv_addInventoryItem;
			WorkplaceReward = WorkplaceReward + _price;
			_amount = _amount + 1;
			
			(_displ displayCtrl 2) ctrlSetStructuredText parseText format["%1 L", _cistern - 1];
			(_displ displayCtrl 3) ctrlSetStructuredText parseText format["%1/%2 L", _details select _fuelType, (_station getVariable "TNL_gas_maxCapacity") select _fuelType];
			
			sleep 0.1;
		}
		else
		{
			ctrlShow [4, true];
			ctrlShow [5, false];
			ctrlEnable [6, true];
			sleep 0.5;
		};
	};
	[format["You have sold %1 fuel for $%2", _amount, _price*_amount]] call TNL_fextHint_Hint;
	
	TNL_gas_tankFromCistern = nil;
	TNL_gas_doTankFromCistern = nil;
};