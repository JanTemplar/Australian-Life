RPP_gVar_arr_deliveryLocations = [];
RPP_gVar_boolean_hasDeliveryJob = false;
RPP_gVar_int_deliveryBasePrice = 250;
RPP_gVar_str_deliveryReminder = "";
RPP_gVar_obj_deliveringTo = empty;
RPP_gVar_int_deliveryPenalty = 0.1;
RPP_gVar_int_deliveryPay = 0;


RPP_gVar_arr_deliveryMessages =
[
	["Shop", "A shopkeeper is asking you to delivery these goods to his shop, get there as soon as possible and drop them off the quicker you get there the more money you earn!"],
	["Factory", "A factory owner requires these resources delivered urgently, please deliver them as soon as you can you lose money for how slow you are!"]
];

{
	_obj = (_x select 0);	
	RPP_gVar_arr_deliveryLocations set [(count RPP_gVar_arr_deliveryLocations), [_obj, "Shop", (_x select 2)]];
} forEach TNL_gVar_arr_playerShops;

{
	_obj = (_x select 0);
	RPP_gVar_arr_deliveryLocations set [(count RPP_gVar_arr_deliveryLocations), [_obj, "Factory", ((_x select 1) select 0)]];
} forEach TNL_gVar_arr_fact_factorys;