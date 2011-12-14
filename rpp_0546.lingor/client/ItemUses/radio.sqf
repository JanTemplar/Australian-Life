_item = (_this select 0);
_amount = 0;

_dlg = createDialog "TNL_dlg_genSlider";

sliderSetPosition[13, RPP_var_curRadioChan];
sliderSetRange[13, 1, 250];

RPP_var_radioResult = 0;
	
((findDisplay 1107) displayCtrl 1) ctrlSetStructuredText parseText "Radio Channel";
((findDisplay 1107) displayCtrl 2) ctrlSetStructuredText parseText "Select a radio channel you want to join.";
((findDisplay 1107) displayCtrl 10) buttonSetAction "RPP_var_radioResult = 1; closeDialog 0;";
	
_chan = RPP_var_curRadioChan;
while {!(isNull(findDisplay 1107))} do
{
	((findDisplay 1107) displayCtrl 12) ctrlSetText format["Channel: %1", round(sliderPosition 13)];
	_chan = round(sliderPosition 13);
	sleep 0.2;
};

if (RPP_var_radioResult == 1) then
{
	RPP_var_curRadioChan = _chan;
	
	[format["You have connected to channel: %1", _chan]] call TNL_fextHint_Hint;
	
	_chan call RPP_fnc_radioJoinChannel;
};

