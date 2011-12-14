_elev  = ((_this select 3) select 0);

if (_elev == 1) then {
player setpos [getmarkerpos "elevator1" select 0, getmarkerpos "elevator1" select 1, (getmarkerpos "elevator1" select 2) +10];
player groupchat "1st Floor Bobby's Bedroom";
sleep 2;
player setpos [getmarkerpos "elevator1" select 0, getmarkerpos "elevator1" select 1, (getmarkerpos "elevator1" select 2) +20];
player groupchat "2nd Floor Firefighter's Pump Imporium";
sleep 2;
player setpos [getmarkerpos "elevator1" select 0, getmarkerpos "elevator1" select 1, (getmarkerpos "elevator1" select 2) +30];
player groupchat "3rd Floor Parker's Sexpo";
sleep 2;
player setpos [getmarkerpos "elevator1" select 0, getmarkerpos "elevator1" select 1, (getmarkerpos "elevator1" select 2) +40];
player groupchat "Top Floor Roof";
};

if (_elev == 2) then {
player setpos [getmarkerpos "elevator1" select 0, getmarkerpos "elevator1" select 1, (getmarkerpos "elevator1" select 2) +30];
player groupchat "3rd Floor Parker's Sexpo";
sleep 2;
player setpos [getmarkerpos "elevator1" select 0, getmarkerpos "elevator1" select 1, (getmarkerpos "elevator1" select 2) +20];
player groupchat "2nd Floor Firefighter's Pump Imporium";
sleep 2;
player setpos [getmarkerpos "elevator1" select 0, getmarkerpos "elevator1" select 1, (getmarkerpos "elevator1" select 2) +10];
player groupchat "1st Floor Bobby's Bedroom ";
sleep 2;
player setpos [getmarkerpos "elevator1" select 0, getmarkerpos "elevator1" select 1, (getmarkerpos "elevator1" select 2) +.5];
player groupchat "Ground Floor";
};
