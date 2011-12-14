//////////// script by Jonzie

_selection = ((_this select 3)select 0);

_moneyearned = 0;
_distance = 0;


if (_selection == "start") then
{

pmissionactive = true;
deleteMarkerLocal "patrolmarker";


_newmarker = (floor(random(count coppatrolarray)));
_markerlocation = (coppatrolarray select _newmarker);
		
_markerobj = createmarkerlocal ["patrolmarker",[0,0]];
_markername = "patrolmarker";
_markerojb setmarkershapelocal "Icon";
//"patrolmarker" setMarkerBrushLocal "solid";
"patrolmarker" setmarkertypelocal "warning";
"patrolmarker" setmarkercolorlocal "colorred";
"patrolmarker" setmarkersizelocal [1, 1];
"patrolmarker" setmarkertextlocal "Fire point";
_markername Setmarkerposlocal _markerlocation;
      
player sidechat "Your Fire mission will be available shortly, simply get to the Fire and Put it out.";
sleep 1;
_Object="hiluxWreck" createVehicleLocal getMarkerPos "patrolmarker";
_VarName="carfire";
_Object SetVehicleVarName _VarName;
_Object Call Compile Format ["%1=_This ; PublicVariable ""%1""",_VarName];
		
		
sleep 1;
_BIS_Effects_Burn = compile preprocessFile "\ca\Data\ParticleEffects\SCRIPTS\destruction\burn.sqf";
_burnit =[carfire, 5, 750, false, true] spawn BIS_Effects_Burn;
sleep 2;
_plocation = getpos player;
_distance = _plocation distance _markerlocation;

while {pmissionactive} do

	{

	if (player distance _markerlocation <= 5) then 
		{
		
		deleteMarkerLocal "patrolmarker";
		_moneyearned = (ceil(_distance * patrolmoneyperkm));
		Kontostand = Kontostand + _moneyearned;
		player sidechat "please wait putting out fire";
		sleep 5;
		deletevehicle carfire;
		player sidechat format["You earned $%1 for puting out the fire", _moneyearned];		
		player sidechat "please wait a moment for a new Fire";
		sleep 5;
	
		_newmarker = (floor(random(count coppatrolarray)));
		_markerlocation = (coppatrolarray select _newmarker);
	
		_markerobj = createmarkerlocal ["patrolmarker",[0,0]];
		_markername = "patrolmarker";
		_markerojb setmarkershapelocal "icon";
		//"patrolmarker" setMarkerBrushLocal "solid";
		"patrolmarker" setmarkertypelocal "warning";
		"patrolmarker" setmarkercolorlocal "colorred";
		"patrolmarker" setmarkersizelocal [1, 1];
		"patrolmarker" setmarkertextlocal "Fire point";
		_markername Setmarkerposlocal _markerlocation;
		player sidechat "New Fire point added";
		
		_plocation = getpos player;
		_distance = _plocation distance _markerlocation;
		
		sleep 1;
		 _Object="hiluxWreck" createVehicleLocal getMarkerPos "patrolmarker";
         _VarName="carfire";
         _Object SetVehicleVarName _VarName;
         _Object Call Compile Format ["%1=_This ; PublicVariable ""%1""",_VarName];
		
		
		sleep 1;
		_BIS_Effects_Burn = compile preprocessFile "\ca\Data\ParticleEffects\SCRIPTS\destruction\burn.sqf";
		_burnit =[carfire, 5, 750, false, true] spawn BIS_Effects_Burn;
		};

	
	

	
	
	
	
	
	
	
	sleep 5;
	};
deleteMarkerLocal "patrolmarker";
deletevehicle carfire;


};

if (_selection == "end") then
{
pmissionactive = false;	
deleteMarkerLocal "patrolmarker";
player sidechat "Fire mission ended you must wait 60s to get a new one";
patrolwaittime = true;
sleep 60;
patrolwaittime = false;
deletevehicle carfire;
};