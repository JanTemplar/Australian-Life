_player = (_this select 0);

[{
	if (player == (_this select 0)) then
	{
		[] execVM "slr\dropweapons.sqf";
	}
	else
	{
		[format["%1 has been disarmed by %2!", (name _this select 0) call TNL_fplayer_formatName , (name _this select 1) call TNL_fplayer_formatName]] call TNL_fextHint_Hint;
	};
}, [_player, player]] call TNL_fnet_execPublic;

