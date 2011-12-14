
While {Processing1} do {
	_toCrack = (TheSafecode select SafecodesCracked);

	If ((Safe_Cur_Number > (_toCrack - 0.3)) and (Safe_Cur_Number < (_toCrack + 0.3))) then {
		sleep 0.5;
		If ((Safe_Cur_Number > (_toCrack - 0.3)) and (Safe_Cur_Number < (_toCrack + 0.3))) then {
			SafecodesCracked = SafecodesCracked + 1;
			Playsound "Thingie";
			If (SafecodesCracked >= 5) then {
				sleep 0.4;
				Playsound "Unlock";
				Processing1 = false;
				Safecracked1 = TRUE;
				closedialog 0;
				
				
			};
		};
	};
	sleep 0.05;
};



While {Processing2} do {
	_toCrack = (TheSafecode select SafecodesCracked);

	If ((Safe_Cur_Number > (_toCrack - 0.3)) and (Safe_Cur_Number < (_toCrack + 0.3))) then {
		sleep 0.5;
		If ((Safe_Cur_Number > (_toCrack - 0.3)) and (Safe_Cur_Number < (_toCrack + 0.3))) then {
			SafecodesCracked = SafecodesCracked + 1;
			Playsound "Thingie";
			If (SafecodesCracked >= 5) then {
				sleep 0.4;
				Playsound "Unlock";
				Processing2 = false;
				Safecracked2 = TRUE;
				closedialog 0;
				
				
			};
		};
	};
	sleep 0.05;
};


While {Processing3} do {
	_toCrack = (TheSafecode select SafecodesCracked);

	If ((Safe_Cur_Number > (_toCrack - 0.3)) and (Safe_Cur_Number < (_toCrack + 0.3))) then {
		sleep 0.5;
		If ((Safe_Cur_Number > (_toCrack - 0.3)) and (Safe_Cur_Number < (_toCrack + 0.3))) then {
			SafecodesCracked = SafecodesCracked + 1;
			Playsound "Thingie";
			If (SafecodesCracked >= 5) then {
				sleep 0.4;
				Playsound "Unlock";
				Processing3 = false;
				Safecracked3 = TRUE;
				closedialog 0;
				
				
			};
		};
	};
	sleep 0.05;
};

