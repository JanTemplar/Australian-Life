if (!(createDialog "TNL_dlg_genListView")) exitWith {hint "Dialog Error!";};

lbClear 2;
((findDisplay 1104) displayCtrl 1) ctrlSetStructuredText parseText "Crime Log";
((findDisplay 1104) displayCtrl 2) ctrlSetScale 0.01;
{
	_player = _x select 0;
	_text = _x select 1;
	_date = _x select 2;
	_time = _x select 3;
	
	lbAdd[2, format["%1: %3 %4", _time, _date, _player, _text]];
} forEach CopLog;
