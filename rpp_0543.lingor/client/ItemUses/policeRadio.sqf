if (isCop) then
{
	closeDialog 0;
	_dlg = createDialog "DlgCopMenu";
}
else
{
	["You cannot do that on a stolen radio!"] call TNL_fextHint_Hint;
};

251 call RPP_fnc_radioJoinChannel;
["Connected to police radio channel"] call TNL_fextHint_Hint;