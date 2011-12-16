//The New Life (RPG Mission)
//Copyright (C) 2009  Matthew Simms & Petr Klíma

TNL_fext_getReply = 
{	
	private ["_found", "_result"];
	_found = false;
	_result = "";
	//sleep 0.05;
	while {!_found} do
	{
		_result = copyFromClipboard;
		if ((_result != "-waiting for reply-")) then
		{
			//player groupchat format["RESULT %1", copyFromClipboard];
		
			try
			{
			
				_result = call compile _result;
				_found = true;
			} catch { _found = false; };
		};
			
	};

	
	_result
};