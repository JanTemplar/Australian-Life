if (isNil "atBusting") then
{
	atBusting = false;
};

if ((iscop) && (!atBusting)) then 
{
	[{
		if (iscop) then 
		{
			atBusting = true;
		};
	}] call TNL_fnet_execPublic;
	drug_einheit setDamage 1;
	drugvehicle setDamage 1;
	sleep ((random 13) + 5);
	deleteVehicle drug_einheit;
	deleteVehicle drugvehicle;
	[{atBusting = false; hint "Drug dealer busted";}] call TNL_fnet_execPublic;
};