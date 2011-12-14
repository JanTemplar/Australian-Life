if (count actionkeys "teamswitch" == 0) then {[playerside, "hq"] sidechat "Please bind a key to teamswitch (default T) to use the menus"};
finddisplay 46 displayaddeventhandler ["keyup", "_dummy = _this execvm ""skeet.sqf"""];
"launchskeet" addpublicvariableeventhandler {skeetmachine say "LaunchSkeet"};
