// Paychecks for Cop, Civ, Mayor and active Terrorists salaries.sqf
// Completely recoded with Taxation Mr.G-C Feb. 2009

// Zero the variable shit or get scalar bool error
call compile format ["FinalTax_%1 = 0", player];
_completeincome = 0;
_finalIncome = 0;
_IncomeTax = 0;
_taxclass = 0;
_taxpercentage = 0;
_MissionsReward = 0;
_WorkersIncome = 0;
TaxiMissionReward = 0;
WorkplaceReward = 0;
_OverviewMissionsMsg = "";
_OverviewWelfareMsg = "";
_OverviewWorkPlaceMsg = "";
_OverviewWorkersMsg = "";
_OverviewBusinessAssetsMsg = "";
_OverviewTrainedJobMsg = "";
_OverviewMayorMsg = "";
_OverviewTaxiMsg = "";
_undercovermsg  = "";
_patrolmsg = "";
_cromsg = "";
_swatmsg = "";
_borderpmsg = "";
_defaultCopIncomemsg = "";
_OverviewChiefPolMsg = "";
_zusatzgeld_under = 0;
_zusatzgeld_patrol = 0;
_zusatzgeld_cro = 0;
_zusatzgeld_swat = 0;
_zusatzgeld_border = 0;
_tempTaxAccMonAvail = 0;
_bodyguardsalary = 0;
_ambulancesalary = 0;
_taxidriversalary = 0;
_governmentOutgoing = 0;
_AFK = false;


while {true} do 
{
	waitUntil {TNL_gVar_paycheckAccNum != ""};
	_pos1_1 = getPos player select 0;
	_pos1_2 = getPos player select 1;
	TNL_gVar_pay_doneAction = false;
	_dir1 = getDir player;
	_paycheckTime = 60;
	sleep _paycheckTime;
	[format["Paycheck will arrive in: %1 minutes", "4"]] call TNL_fextHint_Hint;
	sleep _paycheckTime;
	[format["Paycheck will arrive in: %1 minutes", "3"]] call TNL_fextHint_Hint;
	sleep _paycheckTime;
	[format["Paycheck will arrive in: %1 minutes", "2"]] call TNL_fextHint_Hint;
	sleep _paycheckTime;
	[format["Paycheck will arrive in: %1 minutes", "1"]] call TNL_fextHint_Hint;
	sleep _paycheckTime;
	_pos2_1 = getPos player select 0;
	_pos2_2 = getPos player select 1;
	_dir2 = getDir player;
	if ((_pos1_1 == _pos2_1) and (_pos1_2 == _pos2_2)) then {_AFK = true} 
	else {_AFK = false};
	
	if (TNL_gVar_pay_doneAction) then
	{
		_AFK = false;
	};
	
	waitUntil {TNL_gVar_paycheckAccNum != ""};

	if (_AFK) then 
	{
		player groupChat "You dont receive paychecks while being AFK";
	}
	else 
	{
		if ((alive player) and (TNL_gVar_hasRespawned)) then 
		{
			// Cop Pay
			if (iscop) then 
			{
				_tempTaxAccMonAvail = GovernmentTaxAccount;

				// Add default cop money
				if (_tempTaxAccMonAvail >= add_copmoney) then
				{
					_completeincome = _completeincome + add_copmoney;
					_tempTaxAccMonAvail = _tempTaxAccMonAvail - add_copmoney;
					call compile format ["FinalTax_%1 = FinalTax_%1 - add_copmoney", player];
					_defaultCopIncomemsg = format["Default Income: %1$", add_copmoney];
					_governmentOutgoing = _governmentOutgoing - add_copmoney;
				} 
				else 
				{
					_defaultCopIncomemsg = "Default Income: Not enough Tax-Money available!!!";
				};

				// COP SPECIFIC PART ENDS HERE
			} 
			else 
			{
				//******* CIVILLIAN PAY STARTS HERE ********
				// Zero Vars
				_workplacepaycheck = 0;
				_uniPaycheck       = 0;
				_TrainedJobReward = 0;
				_zusatzgeld_bodyguard = 0;
				_zusatzgeld_ambulance = 0;
				_zusatzgeld_taxidriver = 0;
					
				// Adds MAYOR pay bonus *IF* there is enough money on the Governements Account. Has always one round paycheque delay - not other possible, but we know the governemnts are slow.... :p
				if (isMayor) then 
				{
					if (GovernmentTaxAccount >= MayorExtraPay) then 
					{
						_completeincome = _completeincome + MayorExtraPay;
						_mayorPayVar = MayorExtraPay;
						call compile format ["FinalTax_%1 = FinalTax_%1 - MayorExtraPay", player];
						_OverviewMayorMsg = format["Income Mayor: %1$", _mayorPayVar];
						_governmentOutgoing = _governmentOutgoing - _mayorPayVar;
					} 
					else 
					{
						_OverviewMayorMsg = "Income Mayor: Not enough Tax-Money available!!!";
					};
				};
				
				//Taxi mission money
				_completeincome = _completeincome + TaxiMissionReward;
				
				//Workplaces 
				_completeincome = _completeincome + WorkplaceReward;
				
				
				if (TaxiMissionReward > 0) then 
				{
					_OverviewTaxiMsg = format["Income Taxi Job: %1$", TaxiMissionReward];
				};
				
				if (WorkplaceReward > 0) then
				{
					_OverviewWorkPlaceMsg = format["Income Workplaces: %1$", WorkplaceReward];
				};
					
				// Adds basic welfare salaray *IF* Enough money is on governements account
				if (GovernmentTaxAccount >= add_civmoney) then 
				{
					_acc = TNL_gVar_paycheckAccNum;
					_balance = [_acc, 2] call TNL_fbank_getDetail; 
					if ((_completeincome >= GblWelfareIncomeLimit) || (_balance > GblWelfareBankLimit)) then 
					{ 
						_OverviewWelfareMsg = "Income Welfare: Not Entitled to claim!";
					} 
					else 
					{
						_completeincome = _completeincome + add_civmoney;
						call compile format ["FinalTax_%1 = FinalTax_%1 - add_civmoney", player];
						_OverviewWelfareMsg = format["Income Welfare: %1$", add_civmoney];
						_governmentOutgoing = _governmentOutgoing - add_civmoney;
					};
				} 
				else 
				{
					_OverviewWelfareMsg = "Income Welfare: Not enough Tax-Money available";
				};
					
			 }; // CIV-Specific part ends
			 
			 
			//****************************TAXATION STARTS HERE*************************************//
			// Basic Income Taxation starts here. Incometax is fixed here, but can later be changed by Mayor hopefully.
			// Tax classes starting from 1 t0 5. Values: 1=10%, 2=19%, 3=26%, 4=33%, 5=41%
			// Issetea if you steal this unique feature also from us, i know where you Live........
					
			// For tax-class 1
			if (_completeincome < 1000) then 
			{
				_taxclass = 1;
				_taxpercentage = GblIncomeTaxClass1;
				_IncomeTax = round((_completeincome / 100) * GblIncomeTaxClass1);
				_finalIncome = _completeincome - _IncomeTax;							
			};
			
			// For tax-class 2
			if ((_completeincome >= 1000) && (_completeincome <= 4000)) then 
			{
				_taxclass = 2;
				_taxpercentage = GblIncomeTaxClass2;
				_IncomeTax = round((_completeincome / 100) * GblIncomeTaxClass2);
				_finalIncome = _completeincome - _IncomeTax;						
			};
			
			
			// For tax-class 3
			if ((_completeincome >= 4001) && (_completeincome <= 9999)) then 
			{
				_taxclass = 3;
				_taxpercentage = GblIncomeTaxClass3;
				_IncomeTax = round((_completeincome / 100) * GblIncomeTaxClass3);
				_finalIncome = _completeincome - _IncomeTax;						
			};
			
			// For tax-class 4
			if ((_completeincome >= 10000) && (_completeincome <= 20000)) then 
			{
				_taxclass = 4;
				_taxpercentage = GblIncomeTaxClass4;
				_IncomeTax = round((_completeincome / 100) * GblIncomeTaxClass4);
				_finalIncome = _completeincome - _IncomeTax;						
			};
			
			// For tax-class 5
			if (_completeincome >= 20001) then 
			{
				_taxclass = 5;
				_taxpercentage = GblIncomeTaxClass5;
				_IncomeTax = round((_completeincome / 100) * GblIncomeTaxClass5);
				_finalIncome = _completeincome - _IncomeTax;						
			};
			_governmentOutgoing = _governmentOutgoing + _IncomeTax;
			_governmentOutgoing = _governmentOutgoing + taxesPaid;		
			
			call compile format ["FinalTax_%1 = FinalTax_%1 + _IncomeTax + taxesPaid; PublicVariable ""FinalTax_%1""; ", player];
			TaxationServerStart = str player;
			publicvariable "TaxationServerStart";
					
			// What finally arrives at your account
			if (_finalIncome > 0) then
			{
				_acc = TNL_gVar_paycheckAccNum;
				_balance = [_acc, 2] call TNL_fbank_getDetail; //get the current account balance
				[_acc, 2, (_balance + _finalIncome)] call TNL_fbank_setDetail; //add the money to the acc.
				[_acc, date, 6, [[] call TNL_fcenv_time, _finalIncome, "Paycheck"]] call TNL_fbank_historyAdd;
			};
			// New Mesasge for Brief Overview of Income, both Civs and Cops
			[format["The Paycheque arrived! Gross-Income: %1$, Net-Income: %2$, Income-Tax Payed: %3$, Income-Tax-Class: %4 (%5 percent)", _completeincome, _finalIncome, _IncomeTax, _taxclass, _taxpercentage]] call TNL_fextHint_Hint;
					
			[{if (isServer) then { GovernmentTaxAccount = GovernmentTaxAccount + (_this select 0); publicVariable "GovernmentTaxAccount";}; }, [_governmentOutgoing]] call TNL_fnet_execPublic;
				
			sleep 5;
			
			// New Detailed-Income Message CIV
			if (!isCop) then 
			{
				[format["Detailed Overview (Gross-Values): %1%2%3%4", _OverviewWelfareMsg,_OverviewMayorMsg,_OverviewTaxiMsg,_OverviewWorkPlaceMsg]] call TNL_fextHint_Hint;
			} 
			else 
			{
				// New Detailed-Income Message COP
				[format["Detailed Overview (Gross-Values): %1", _defaultCopIncomemsg]] call TNL_fextHint_Hint;
			};
			
			

			//****** RESET ALL VARIABLES AND/OR MESSAGE_VARS (which can have different stages) AT THE END OF EACH PAYCHEQUE ROUND ********	
			_governmentOutgoing = 0;
			taxesPaid = 0;  //VAT
			_IncomeTax = 0; // Income Tax
			call compile format ["FinalTax_%1 = 0", player];
			if (TaxiMissionReward > 0) then {TaxiMissionReward = 0;}; 
			if (Deliverymissionreward > 0) then {Deliverymissionreward = 0;};
			if (SearchjobMissionReward > 0) then {SearchjobMissionReward = 0;};
			if (WorkerHoeEarnings > 0) then {WorkerHoeEarnings = 0;};
			_MissionsReward = 0;
			_WorkersIncome = 0;
			_TrainedJobReward = 0;
			_finalIncome = 0;
			_completeincome = 0;
			_taxclass = 0;
			_taxpercentage = 0;
			WorkplaceReward  = 0;
			_bodyguardsalary = 0;
			_OverviewMayorMsg = "";
			_OverviewChiefPolMsg = "";
			_OverviewWelfareMsg = "";
			_OverviewMissionsMsg = "";
			_OverviewWorkPlaceMsg = "";
			_OverviewWorkersMsg = "";
			_OverviewBusinessAssetsMsg = "";
			_OverviewTrainedJobMsg = "";
			_defaultCopIncomemsg = "";		
			_undercovermsg = "";
			_OverviewTaxiMsg = "";
			_patrolmsg = "";
			_cromsg = "";
			_swatmsg = "";
			_borderpmsg = ""
			
		} 
		else 
		{
			// No paycheck when dead:
			["No paycheck when dead :("] call TNL_fextHint_Hint;
		};
};
};