if(pickingup)exitwith{};

pickingup=true;

_this 		= _this select 3;
_gangarea 	= _this select 0;
_type		= _this select 1;
_gangarea1 	= [];

if (_gangarea==gangarea1) then {_gangarea1 = "Mountain Stronghold";};
if (_gangarea==gangarea2) then {_gangarea1 = "Cuba";};
if (_gangarea==gangarea3) then {_gangarea1 = "Southern Coast";};
if (_gangarea==gangarea4) then {_gangarea1 = "Island Refuge";};

player playmove "AinvPknlMstpSlayWrflDnon_medic";
waituntil {animationstate player != "AinvPknlMstpSlayWrflDnon_medic"};
sleep 5;

if(_type == "neutralise")then

{

_gangarea setpos [getpos _gangarea select 0, getpos _gangarea select 1, -3];
sleep 1;


	_mygang  = call INV_mygang;
	//_control = _gangarea getvariable "control";
	
	if(_mygang != "")then

		{

		//_gangarea setvariable["control", nil, true];
		format["hint ""%1 has been neutralised by %2!"";", _gangarea1, _mygang] call broadcast_civ;

		}; 


};

if(_type == "capture")then

{
_gangarea setpos [getpos _gangarea select 0, getpos _gangarea select 1, 0];

sleep 1;




	_mygang  = call INV_mygang;
	//_control = _gangarea getvariable "control";
	
	if(_mygang != "")then

		{

		_gangarea setvariable["control", _mygang, true];
		format["hint ""%1 has been captured by %2!"";", _gangarea1, _mygang] call broadcast_civ;

		}; 

	

};

pickingup=false;