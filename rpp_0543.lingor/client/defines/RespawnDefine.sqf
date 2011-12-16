//The New Life (RPG Mission)
//Copyright (C) 2009  Matthew Simms & Petr Klíma


TNL_gVar_int_respawnTime = 30; //Default time until player respawns
TNL_gVar_int_maxRespawnTime = 300; //Maximum respawn time, respawn time cannot be increased above this value
TNL_gVar_int_respawnTimeIncreasePerDeath = 5; //Amount respawn time increases per death
TNL_gVar_int_nDeaths = 0; //Total number of player deaths 
TNL_gVar_int_nKills = 0; //Total number of killed players
TNL_gVar_int_nKilledSelf = 0; //Total number of suicides
TNL_gVar_int_loseItemsOnRespawn = true; //Player loses items on respawn

/*
	TNL_gVar_arr_respawnCamPositions
	* Description: These are the respawn camera target, position and zoom
	* Parameters:
		(0) Camera target (array)
		(1) Camera position (array)
		(2) Camera fov (integer)
*/
TNL_gVar_arr_respawnCamPositions = 
[
	[[8686.17,-92775.69,-10977.05], [6689.81,6598.87,1.21], 1.251],
	[[8686.17,-92775.69,-10976.83], [6685.51,6598.85,1.21], 1.251],
	[[-55079.15,84475.34,-10977.16], [6682.24,6600.01,1.21], 1.251],
	[[-93061.68,7300.81,-7138.29], [6679.81,6602.51,1.21], 1.251],
	[[4182.15,106541.59,-2432.23], [6665.83,6602.36,1.21], 1.251],
	[[5028.44,106572.78,-2432.95], [6665.14,6645.41,3.34], 1.251],
	[[106664.13,6304.91,1253.26], [6672.57,6686.34,0.78], 1.251],
	[[8006.01,-92524.13,-12459.69], [6681.38,6685.90,1.64], 1.251],
	[[80522.98,72964.66,-12459.69], [6689.65,6686.65,1.64], 1.251],
	[[105910.92,6876.29,-12460.36], [6692.16,6680.78,1.64], 1.251],
	[[11113.05,99395.44,37222.49], [6695.80,6680.91,1.64], 1.251],
	[[5154.01,106672.16,660.30], [6695.72,6686.13,4.06], 1.251],
	[[5155.30,106588.13,-4145.16], [6695.06,6686.63,3.94], 1.251],
	[[-83215.11,50291.77,-4145.40], [6680.42,6685.89,3.94], 1.251],
	[[2220.27,106502.09,-4145.45], [6678.22,6692.28,3.94], 1.251],
	[[-92897.85,606.30,-1400.20], [6925.68,6389.73,3.53], 1.251],
	[[13200.67,-93375.68,2769.78], [6926.39,6389.27,2.93], 1.251],
	[[15367.81,-93248.11,-1082.16],  [6932.97,6389.02,1.39], 1.251],
	[[72305.20,82023.95,2700.82], [6939.30,6392.76,1.59], 1.251],
	[[92036.89,58844.82,2700.44], [6937.46,6394.48,1.59], 1.251],
	[[2159.00,106293.31,908.57], [6952.18,6412.13,1.91], 1.251]
];