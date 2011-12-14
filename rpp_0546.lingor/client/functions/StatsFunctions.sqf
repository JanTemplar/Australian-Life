/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

TNL_fstats_openDialog = 
{	
	if (!createDialog "DlgStats") then
	{
		hint "ERROR! FAILED TO OPEN DIALOG!!!!!!!";
	};
	
	[] call TNL_fstats_loadDialog;
};

TNL_fstats_loadDialog = 
{
	lbClear 3;
	{
		_index = lbAdd[3, format["%1", (_x select 0)]];
			lbSetData[3, _index, format['["%1","%2"]',(_x select 0), (_x select 1)]];
				 
	
	} forEach TNL_gVar_arr_statsFilter;


	lbSetCurSel[3,0];

};

TNL_fstats_viewStats = 
{
	lbClear 1;

	_data = call compile (lbData[3,lbCurSel 3]);

	{
		_text = (_x select 1);
	
			if ((_x select 0) == (_data select 0)) then
			{
				call _text;
			};
	} forEach TNL_gVar_arr_stats;
};

TNL_fstats_updateInfo = 
{
	_data = call compile (lbData[3,lbCurSel 3]);
	_ctrl = (_this select 0);
	_ctrl ctrlSetStructuredText parseText (_data select 1);
};
