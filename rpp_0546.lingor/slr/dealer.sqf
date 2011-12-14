if ((!isServer) and (!Server_Client)) exitWith {};
while {true} do 
{
	_locations = 11;
	_randomVehicle = ["SUV_TK_CIV_EP1", "VWGolf", "VolhaLimo_TK_CIV_EP1"];
	_vclClass = _randomVehicle select (ceil random ((count _randomVehicle)-1));
    _spawn_pos = call compile format ["getMarkerPos 'drugstop%1';", (ceil random _locations)];
    drugvehicle = _vclClass createVehicle _spawn_pos;
    drugvehicle setVehicleInit
      "drugvehicle = this;
      this setVehicleVarName ""drugvehicle"";
      this setVehicleLock ""LOCKED"";
      this setAmmoCargo 0;
	  ";
	publicvariable "drugvehicle";
    drggrp = createGroup civilian;
	
	"Functionary1" createUnit [_spawn_pos, drggrp, "this setVehicleVarName ""drug_einheit""; drug_einheit = this;"];
	[drug_einheit] join drggrp;

	removeallweapons drug_einheit;
    drug_einheit assignAsDriver drugvehicle;
	drug_einheit moveindriver drugvehicle;
	drug_einheit setCaptive true;
	drug_einheit setBehaviour "careless";
	publicvariable "drug_einheit";
    processInitCommands;
    _old_random_val = -1;
    while {alive drug_einheit && alive drugvehicle} do 
	{
        _random_val = (ceil random _locations);
        while {_random_val == _old_random_val} do 
		{
            _random_val = (ceil random _locations);
        };
		
		// Place the Driver in the Car	
		if ((!(drug_einheit in drugvehicle)) and (alive drug_einheit)) then
		{
			drug_einheit moveInDriver drugvehicle;
			drug_einheit assignAsDriver drugvehicle;
		};

		if (alive drug_einheit) then 
		{
			drugvehicle setDamage 0;
		};
		
		drug_einheit doMove getpos player;

        _old_random_val = _random_val;
        call compile format ["
            drug_einheit doMove (MarkerPos 'drugstop%1');
			drugvehicle forceSpeed 150;
			drug_einheit forceSpeed 150;
            while {drugvehicle distance MarkerPos 'drugstop%1' > 20 && alive drug_einheit && alive drugvehicle} do 
			{
                sleep 5;
            };
        ", _random_val];
        if (!alive drugvehicle || !alive drug_einheit) exitWith {};
		drugvehicle setfuel 1;
        sleep (random 2500);
        drugvehicle setfuel 1;
    };
	deleteVehicle drugvehicle;
	deleteVehicle drug_einheit;
	deleteGroup drggrp;
	sleep 1000 + random 500;
};