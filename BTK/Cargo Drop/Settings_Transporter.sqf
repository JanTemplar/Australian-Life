 /******************************************************************************
 *                        ,1             ,-===========.
 *                       /,| _____________________\\_                _
 *    ,========.________//_|/===========._#############L_Y_....-----====//
 *   (#######(==========\################\=======.______ --############((
 *    `=======`"        ` ===============|::::.___|[ ))[JW]#############\\
 *                                       |####|     ""\###|   :##########\\
 *                                      /####/         \##\     ```"""=,,,))
 *     C R E A T E D   B Y   B T K     /####/           \##\
 *                                    '===='             `=`
 *******************************************************************************
 *
 *  The supported transporter types.
 *	Edit below.
 *
 *	You can use the whole class tree:
 *	http://community.bistudio.com/wiki/ArmA_2:_CfgVehicles
 *	http://community.bistudio.com/wiki/ArmA_2_OA:_CfgVehicles
 *
 ******************************************************************************/
_civ = player;	
 
//// Small
if (
(_Transporter isKindOf "qantas_C130") // No OR || after the last entry!!
) then { _SelectedTransporterTypeS = true; };

//// Medium
if (
(_Transporter isKindOf "il_silverado_black") || 
(_Transporter isKindOf "hilux1_civil_1_open") || 
(_Transporter isKindOf "datsun1_civil_3_open") || 
(_Transporter isKindOf "datsun1_civil_1_open") || 
(_Transporter isKindOf "oltruc3")  // No OR || after the last entry!!
) then { _SelectedTransporterTypeM = true; };

//// Large
if (
(_Transporter isKindOf "Su25_base")
//((_Transporter isKindOf "il_towtruck") and (_civ == civ40)) // No OR || after the last entry!!
) then { _SelectedTransporterTypeL = true; };

//// XTRA Large
if (
(_Transporter isKindOf "lcu") // No OR || after the last entry!!
) then { _SelectedTransporterTypeXL = true; };

