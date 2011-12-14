RPP_fdelivery_acceptJob = 
{
	private ["_randomLocation", "_locationObj", "_locationType", "_locationName", "_distanceTo", "_message", "_earning"];
	_randomLocation = RPP_gVar_arr_deliveryLocations select (random ((count RPP_gVar_arr_deliveryLocations)-1));
	_locationObj = _randomLocation select 0;
	_locationType = _randomLocation select 1;
	_locationName = _randomLocation select 2;
	_distanceTo = player distance _locationObj;
	_message = "";
	_earning = ((RPP_gVar_int_deliveryBasePrice * _distanceTo) / (200 + random 100))*1.5;
	
	if (_locationObj == RPP_gVar_obj_deliveringTo) exitWith
	{
		[] call RPP_fdelivery_acceptJob;
	};
	
	RPP_gVar_obj_deliveringTo = _locationObj;
	RPP_gVar_int_deliveryPay = _earning;
	
	{
		if ((_x select 0) == _locationType) exitWith
		{
			_message = (_x select 1);
		};
	} forEach RPP_gVar_arr_deliveryMessages;
	
	RPP_gVar_str_deliveryReminder = format["You must complete your current job first, here is a reminder! \nLocation: %1\nEarning: $%2", _locationName, _earning];
	
	[format["%1\nLocation: %2\nDistance: %3\nEarning: $%4", _message, _locationName, _distanceTo, _earning]] call TNL_fextHint_Hint;
	
	RPP_gVar_boolean_hasDeliveryJob = true;
	
	[] spawn
	{
		_timeStart = time;
		
		while {RPP_gVar_boolean_hasDeliveryJob} do
		{
			if (vehicle player distance RPP_gVar_obj_deliveringTo <= 15) then
			{
				_timeEnd = time;
				
				_totalTime = _timeEnd - _timeStart;
				
				_loss = _totalTime * RPP_gVar_int_deliveryPenalty;
				RPP_gVar_int_deliveryPay = RPP_gVar_int_deliveryPay - _loss;
				

				[format["You have delivered the goods in %3 seconds and received $%2 in cash, you lost $%1 from the time it took you!", _loss, RPP_gVar_int_deliveryPay, _totalTime]] call TNL_fextHint_Hint; 	
				RPP_gVar_boolean_hasDeliveryJob = false;
			};

			sleep 5;
		};
		
		sleep 10;
		[] call RPP_fdelivery_acceptJob;
	};
};

RPP_fdelivery_onAction =
{
	private ["_playerHasJob"];
	_playerHasJob = RPP_gVar_boolean_hasDeliveryJob;
	
	if (_playerHasJob) then
	{
		[RPP_gVar_str_deliveryReminder] call TNL_fextHint_Hint;
	}
	else
	{
		
		[] call RPP_fdelivery_acceptJob;
		
	};
	

};