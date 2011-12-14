/*
The New Life (RPG Mission)
Copyright (C) 2009  Matthew Simms & Petr Klíma
*/

TNL_fnet_ClientRequestVar =
{
	private ["_varName", "_target", "_player"];
	_varName = _this select 0;
	_target = _this select 1;
	_player = player;
	TNL_fnet_returnedRequestedVar = null;
	TNL_fnet_returnedVar = false;
	
	[{if  (player == (_this select 0)) then { [(_this select 1),(_this select 2)] call TNL_fnet_ClientReturnVar; };  }, [_target, _player, (call compile _varName)]] call TNL_fnet_execPublic;
};

TNL_fnet_ClientReturnVar = 
{
	private ["_varName", "_target"];
	_target = (_this select 0);
	_varValue = (_this select 1);

	[{if (player == (_this select 0)) then { TNL_fnet_returnedRequestedVar = (_this select 1);}; TNL_fnet_returnedVar = true; }, [_target, _varValue]] call TNL_fnet_execPublic;
};

TNL_fnet_TransferItemsToClient = 
{
	private ["_target", "_itemClass", "_itemAmount"];
	_target = (_this select 0);
	_itemClass = (_this select 1);
	_itemAmount = (_this select 2);

	[{if (player == (_this select 0)) then { [(_this select 1),(_this select 2)] spawn TNL_finv_addInventoryItem; }; }, [_target, _itemClass, _itemAmount]] call TNL_fnet_execPublic;
};

TNL_fnet_ExecuteCodeOnClient = 
{
	private ["_target", "_code"];
	_target = _this select 0;
	_code = _this select 1;

	[{if (player == (_this select 0)) then { call (_this select 1) };}, [_target, _code]] call TNL_fnet_execPublic;
};
	
TNL_fnet_ValueFromClientFunction = 
{
	private ["_target", "_function", "_params"];
	_target = _this select 0;
	_function = _this select 1;
	_params = _this select 2;
	_player = player;
	TNL_fnet_returnedRequestedVar = null;
	TNL_fnet_returnedVar = false;
	

	[{if (player == (_this select 0)) then { _val = (_this select 1) call (_this select 2);  [(_this select 3),_val] call TNL_fnet_ClientReturnVar; };  }, [_target, _params, _function, _player]] call TNL_fnet_execPublic;
};

TNL_fnet_HintToClientsInDistanceOfObject = 
{
	private ["_object", "_distance", "_message", "_params", "_whoWillNotRecieve"];
	_object = (_this select 0);
	_whoWillNotRecieve = (_this select 1);
	_distance = (_this select 2);
	_message = (_this select 3);
	
	[{if ((player distance (_this select 0) <= (_this select 1)) && (!(player in (_this select 3)))) then {  [(_this select 2)] call TNL_fextHint_Hint; }; }, [_object, _distance, _message, _whoWillNotRecieve]] call TNL_fnet_execPublic;
};
