TNL_gas_gasStations = 
[
//	["markername", [max capacity]
	[fuel1, [4000,3000,6000], [0,3000,6000], [7,2]],
	[fuel2, [4000,3000,6000], [0,3000,6000], [7,2]],
	[fuel3, [4000,3000,6000], [0,3000,6000], [7,2]],
	[fuel4, [4000,3000,6000], [0,3000,6000], [7,2]]
];

if (isServer) then
{
	{
		(_x select 0) setVariable ["TNL_gas_maxCapacity", (_x select 1), true];
		(_x select 0) setVariable ["TNL_gas_curCapacity", (_x select 2), true];
		(_x select 0) setVariable ["TNL_gas_prices", (_x select 3), true];
	} forEach TNL_gas_gasStations;
};


