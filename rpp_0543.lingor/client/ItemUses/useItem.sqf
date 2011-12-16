//Copyright (C) 2009  Matthew Simms & Petr Klíma

_params = _this;

switch (_params select 0) do
{
	
	switch ((((_params select 2) select 1) select 1)) do
	{
		case "SPROUT": { [(_params select 0)] spawn TNL_fforestry_plantSprout; };
		
		case "PLAYER_SHOP": { [(_params select 0)] spawn TNL_fpShops_placeShop; };
		
		case "MOBILE": { ["use"] execVM "slr\phones.sqf";  };
		
		case "OBJECT": { ["use", (_params select 0)] execVM "slr\objects.sqf"; };
		
		case "SPEEDCAM": { closedialog 0; ["use"]execVM "slr\speedcam.sqf"; };
		
		case "DRUGSHED": { closeDialog 0; ["use"] execVM "slr\drugShed.sqf"; };
		
		case "FOOD": { _params execVM "client\ItemUses\eat.sqf"; };
	};
	
};

