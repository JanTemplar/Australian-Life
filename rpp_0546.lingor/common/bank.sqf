/*
Get a detail of a specified bank account
	* Parameters:
		account ID <string>
		index <int OR string>
	* Returns: selected detail <any>
*/
TNL_fbank_getDetail =
{
	private ["_acc", "_index", "_return"];
	_acc   = _this select 0;
	_index = _this select 1;
	
	if (typeName _acc != "STRING") exitWith
	{
		[__thisFile, format ["Bad input in TNL_fbank_getDetail: param1 - expected STRING, provided %1", typeName _acc]] call TNL_fcore_debug;
	};
	if ((typeName _index != "STRING") && (typeName _index != "SCALAR")) exitWith
	{
		[__thisFile, format ["Bad input in TNL_fbank_getDetail: param2 - expected STRING or NUMBER, provided %1 (%2)", typeName _index, _index]] call TNL_fcore_debug;
	};
	
	if (typeName _index == "STRING") then
	{
		switch (toLower _index) do
		{
			case "owners":
			{
				_index = 0;
			};
			case "pin":
			{
				_index = 1;
			};
			case "balance":
			{
				_index = 2;
			};
			case "history":
			{
				_index = 3;
			};
			case "status":
			{
				_index = 4;
			};
			default
			{
				_index = 5;
			};
		};
	};

	if (_index < 0 || _index > 4) exitWith
	{
		[__thisFile, format ["Bad input in TNL_fbank_getDetail: param2 - unknown detail ID: %1", _index]] call TNL_fcore_debug;
	};
	
	if (! (_acc call TNL_fbank_accExists) ) exitWith
	{
		-1
	};

	call compile format ['
		_return = (bank getVariable "TNL_bank_acc_%1") select _index;
	', _acc];

	_return
};

/*
Set a detail of a specified bank account
	* Parameters:
		account ID <int>
		index <int OR string>
		value <any>
	* Returns:
		success/error <bool>
*/
TNL_fbank_setDetail =
{
	try
	{
		private ["_acc", "_index"];
		_acc   = _this select 0;
		_index = _this select 1;
		
		
		
		if (typeName _index == "STRING") then
		{
			switch (toLower _index) do
			{
				case "owners":
				{
					_index = 0;
				};
				case "pin":
				{
					_index = 1;
				};
				case "balance":
				{
					_index = 2;
				};
				case "history":
				{
					_index = 3;
				};
				case "status":
				{
					_index = 4;
				};
			};
		};
		_value = _this select 2;
		
		if (_index == 3) exitWith {true;};
		
		if (! (_acc in TNL_bank_accsArray) ) exitWith
		{
			false;
		};
		
		call compile format ['
			_details = bank getVariable "TNL_bank_acc_%1";
			_details set [_index, _value];
			bank setVariable ["TNL_bank_acc_%1", _details, true];
			[TNL_gVar_str_tables_bankAccounts, [bank, "TNL_bank_acc_%1"], _details] call TNL_fsav_clientRequestSave;
		', _acc];
		
		true;
	}
	catch
	{
		hint format ["Error in %1!\n\n%2", "TNL_fbank_setDetail", _exception];
		
		false;
	};
};