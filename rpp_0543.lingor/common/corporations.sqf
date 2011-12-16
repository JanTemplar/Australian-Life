TNL_fcorp_switchFirmOwner = 
{
	private ["_obj", "_newOwner", "_newOwnerName", "_firms"];
	_obj = (_this select 0);
	_newOwner = (_this select 1);
	_newOwnerName = (_this select 2);
	_firms = (corporations getVariable "firms");
	
	{
		if ((str (_obj)) == (str(_x select 0))) then
		{
			(_x select 4) set[1, date];
			(_x select 2) set[0, _newOwnerName select 0];
			(_x select 2) set[1, _newOwnerName select 1];
			(_x) set[3,_newOwner];
		};
	
	} forEach _firms;

	corporations setVariable["firms", _firms, true];
	[TNL_gVar_str_tables_corporations, [corporations], [ [(corporations getVariable "corporations"), "corporations"], [_firms, "firms"] ]] call TNL_fsav_clientRequestSave;
};


TNL_fcorp_getCorpArray = 
{
	private ["_corpName","_return"];
	_corpName = _this;
	_return = [];

	{
		if ((_x select 0) == _corpName) then
		{
				_return = (_x);
		};
	} forEach (corporations getVariable "corporations");

	_return
};

TNL_ffirm_getFirmArray = 
{
	private ["_obj", "_return"];
	_obj = _this;
	_return = [];

	{
		if ((str (_x select 0)) ==  (str _obj)) then
		{
			_return = (_x);
		};
	} forEach (corporations getVariable "firms");

	_return
};

TNL_fcorp_getCorpData =
{
	private ["_corpName", "_index", "_return"];
	_corpName = (_this select 0);
	_index = (_this select 1);
	_return = [];

	{
		if ((_x select 0) == _corpName) then
		{
				_return = (_x select _index);
		};
	} forEach (corporations getVariable "corporations");

	_return
};

TNL_fcorp_getFirmData = 
{
	private ["_obj", "_index", "_return"];
	_obj = (_this select 0);
	_index = (_this select 1);
	_return = [];

	{
		if ((str (_x select 0)) ==  (str _obj)) then
		{
			_return = (_x select _index);
		};
	} forEach (corporations getVariable "firms");

	_return
};

TNL_fcorp_getBankAmount = 
{
	private ["_corpName", "_corpBank", "_accNum", "_bankAmount", "_return"];
	_corpName = (_this select 0);
	_corpBank = (_corpName) call TNL_fcorp_getCorpBank;
	_accNum = (_corpBank select 0);
	_bankAmount = [_accNum, 2] call TNL_fbank_getDetail;
	_return = _bankAmount;

	_return
};

TNL_fcorp_setBankAmount = 
{
	private ["_corpName", "_amount", "_corpBank", "_accNum"];
	_corpName = (_this select 0);
	_amount = (_this select 1);
	_corpBank = (_corpName) call TNL_fcorp_getCorpBank;
	_accNum = (_corpBank select 0);
	
	[_accNum, 2, _amount] call TNL_fbank_setDetail;
};

TNL_fcorp_getOwner = { [(_this),1] call TNL_fcorp_getCorpData };
TNL_fcorp_getCorpBank =  { [(_this),3] call TNL_fcorp_getCorpData };
TNL_fcorp_getCorpIncome = { [(_this),4] call TNL_fcorp_getCorpData };

TNL_fcorp_getCosts = { [(_this), 5] call TNL_fcorp_getFirmData };
TNL_fcorp_getFirmOwner = { [(_this),3] call TNL_fcorp_getFirmData };
TNL_fcorp_getFirmOwnerName = { [(_this),2] call TNL_fcorp_getFirmData };