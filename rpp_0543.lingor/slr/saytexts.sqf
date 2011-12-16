_art = _this select 0;

if (_art == "save") then
{
	for [{_i=1}, {_i <= (count SLR_gvar_saytexts)}, {_i=_i+1}] do
	{
		SLR_gvar_saytexts set[(_i)-1, (ctrlText _i)];
	};
	
	player groupchat "Saved!";
};

if (_art == "Open") then
{
	_dlg = createDialog "DlgSaytexts";
	
	((findDisplay 2000) displayCtrl 1) ctrlSetText (SLR_gvar_saytexts select 0);
	((findDisplay 2000) displayCtrl 2) ctrlSetText (SLR_gvar_saytexts select 1);
	((findDisplay 2000) displayCtrl 3) ctrlSetText (SLR_gvar_saytexts select 2);
	((findDisplay 2000) displayCtrl 4) ctrlSetText (SLR_gvar_saytexts select 3);
};

if (_art == "Say") then
{
	_id = (_this select 1);
	_text = SLR_gvar_saytexts select _id;
	_text = format["%1 shouts: %2", (name player) call TNL_fplayer_formatName, _text];

	_dis  = 50;
	[{
		if ((player distance (_this select 0)) < (_this select 2)) then 
		{
			titleText[(_this select 1), "PLAIN"];
		};
	},[player, _text, _dis]] call TNL_fnet_execPublic;
};