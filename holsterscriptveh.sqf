

while {true} do
{
vehicle addaction ["Holster Pistol","noscript.sqf",'["animation", "holsterpistol"] execVM "holsterscript.sqf";',1,false,true,"",'(player hasweapon "m9" or player hasweapon "Colt1911") and !noholster'];
vehicle addaction ["Holster Rifle","noscript.sqf",'["animation", "holsterrifle"] execVM "holsterscript.sqf";',1,false,true,"",'player hasweapon "FN_FAL" or player hasweapon "Huntingrifle"'];

};