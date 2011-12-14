// server keeps track of cash in gas stations, and makes the variable public
// written by eddie vedder
while {true} do
{
_randomamount = ceil ((random 250) + 250);
if (station3money < maxstationmoney) then
	{	
	station1money = station1money + _randomamount;
	if (station1money > maxstationmoney) then {station1money = maxstationmoney;};
	};

if (station3money < maxstationmoney) then
	{
	station2money = station2money + _randomamount;
	if (station2money > maxstationmoney) then {station2money = maxstationmoney;};
	};
if (station3money < maxstationmoney) then
	{
	station3money = station3money + _randomamount;
	if (station3money > maxstationmoney) then {station3money = maxstationmoney;};
	};
if (station4money < maxstationmoney) then
	{
	station4money = station4money + _randomamount;
	if (station4money > maxstationmoney) then {station4money = maxstationmoney;};
	};
if (station5money < maxstationmoney) then
	{
	station5money = station5money + _randomamount;
	if (station5money > maxstationmoney) then {station5money = maxstationmoney;};
	};
if (barmoney < maxbarmoney) then
	{
	barmoney = barmoney + _randomamount;
	if (barmoney > maxbarmoney) then {barmoney = maxbarmoney;};
	};
if (barmoney1 < maxbarmoney) then
	{
	barmoney1 = barmoney1 + _randomamount;
	if (barmoney1 > maxbarmoney) then {barmoney1 = maxbarmoney;};
	};
if (barmoney2 < maxbarmoney) then
	{
	barmoney2 = barmoney2 + _randomamount;
	if (barmoney2 > maxbarmoney) then {barmoney2 = maxbarmoney;};
	};
if (barmoney3 < maxbarmoney) then
	{
	barmoney3 = barmoney3 + _randomamount;
	if (barmoney3 > maxbarmoney) then {barmoney3 = maxbarmoney;};
	};


publicvariable "station1money";
publicvariable "station2money";
publicvariable "station3money";
publicvariable "station4money";
publicvariable "station5money";
publicvariable "barmoney";
publicvariable "barmoney1";
publicvariable "barmoney2";
publicvariable "barmoney3";
sleep 30;
};




//eddie vedder