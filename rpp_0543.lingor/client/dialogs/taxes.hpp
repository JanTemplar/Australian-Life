class DlgTaxes 
{
	idd = 5210;
	movingEnable = true;
	controlsBackground[] = {DLG_BACK1};
	objects[] = { };
	controls[] = {
	text_itemsteuer,
	slider_itemsteuer,
	fahrzeugsteuer_text,
	backgroundBankValue,
	fahrzeugsteuer_slider,
	magazinsteuer_text,
	magazinsteuer_slider,
	waffesteuer_text,
	waffesteuer_slider,
	banksteuer_text,
	banksteuer_slider,
	fueltaxes_text,
	fueltaxes_slider,
	wealthtaxlimit_text,
	wealthtaxlimit_slider,
	wealthtax_text,
	wealthtax_slider,
	incometaxcl1_text,
	incometaxcl2_text,
	incometaxcl3_text,
	incometaxcl4_text,
	incometaxcl5_text,
	incometaxcl1_slider,
	incometaxcl2_slider,
	incometaxcl3_slider,
	incometaxcl4_slider,
	incometaxcl5_slider,
	welfareIncLimit_text,
	welfareIncLimit_slider,
	welfareBankLimit_text,
	welfareBankLimit_slider,
	welfareAmount_text,
	welfareAmount_slider,
	Mayorpay_text,
	Mayorpay_slider,
	PolChiefPay_text,
	PolChiefPay_slider,
	InterestRate_text,
	InterestRate_slider,
	PoliceSalary_text,
	PoliceSalary_slider,
	bankaccount_text,
	bankaccount_value,
	button_submit,
	button_cancel};
	OnLoad = " ""dynamicBlur"" ppEffectEnable true; ""dynamicBlur"" ppEffectAdjust [1.6]; ""dynamicBlur"" ppEffectCommit 0;";
	OnUnload = " ""dynamicBlur"" ppEffectEnable false; ";
	
	class DLG_BACK1: TNL_Background0
	{
		x = 0.10;
		y = 0.01;
		w = 0.90;
		h = 1.25;
	};
	
	/*
	class background : RscBgRahmen
	{
		x = 0.10;
		y = 0.06;
		w = 0.84;
		h = 0.90;
		text = $STRD_description_steuer_header;
	};
	*/
	
	class text_itemsteuer : TNL_Text 
	{
		x = 0.11;
		y = 0.10;
		w = 0.640;
		h = 0.05;
		idc = 11;

	};
	
	class slider_itemsteuer : TNL_SliderH
	{
		idc = 12;
		x = 0.11;
		y = 0.15;
		w = 0.26;
		h = 0.04;
	};
	
	class fahrzeugsteuer_text : TNL_Text 
	{
		idc = 21;
		x = 0.11;
		y = 0.21;
		w = 0.640;
		h = 0.05;
		//w = 0.26;
		//h = 0.04;
	};
	
	class fahrzeugsteuer_slider : TNL_SliderH
	{
		idc = 22;
		x = 0.11;
		y = 0.26;
		w = 0.26;
		h = 0.04;
	};
	
	class magazinsteuer_text : TNL_Text 
	{
		idc = 31;
		x = 0.11;
		y = 0.32;
		w = 0.640;
		h = 0.05;
	};
	
	class magazinsteuer_slider : TNL_SliderH{
		idc = 32;
		x = 0.11;
		y = 0.37;
		w = 0.26;
		h = 0.04;
	};
	
	class waffesteuer_text : TNL_Text 
	{
		idc = 41;
		x = 0.11;
		y = 0.42;
		w = 0.26;
		h = 0.04;
	};
	
	class waffesteuer_slider : TNL_SliderH
	{
		idc = 42;
		x = 0.11;
		y = 0.48;
		w = 0.26;
		h = 0.04;
	};
	
	class banksteuer_text : TNL_Text 
	{
		idc = 51;
		x = 0.11;
		y = 0.54;
		w = 0.26;
		h = 0.04;
	};
	
	class banksteuer_slider : TNL_SliderH
	{
		idc = 52;
		x = 0.11;
		y = 0.59;
		w = 0.26;
		h = 0.04;
	};
	
	class fueltaxes_text : TNL_Text 
	{
		idc = 61;
		x = 0.11;
		y = 0.65;
		w = 0.26;
		h = 0.04;
	};
	
	class fueltaxes_slider : TNL_SliderH
	{
		idc = 62;
		x = 0.11;
		y = 0.70;
		w = 0.26;
		h = 0.04;
	};
	
	class wealthtaxlimit_text : TNL_Text 
	{
		idc = 71;
		x = 0.11;
		y = 0.76;
		w = 0.27;
		h = 0.04;
	};
	
	class wealthtaxlimit_slider : TNL_SliderH
	{
		idc = 72;
		x = 0.11;
		y = 0.82;
		w = 0.26;
		h = 0.04;
	};
	
	class wealthtax_text : TNL_Text 
	{
		x = 0.39;
		y = 0.10;
		w = 0.26;
		h = 0.04;
		idc = 81;
	};
	
	class wealthtax_slider : TNL_SliderH
	{
		idc = 82;
		x = 0.39;
		y = 0.15;
		w = 0.26;
		h = 0.04;
	};
	
	class incometaxcl1_text : TNL_Text 
	{
		x = 0.39;
		y = 0.21;
		w = 0.26;
		h = 0.04;
		idc = 91;
	};
	
	class incometaxcl1_slider : TNL_SliderH
	{
		idc = 92;
		x = 0.39;
		y = 0.26;
		w = 0.26;
		h = 0.04;
	};
	
	class incometaxcl2_text : TNL_Text 
	{
		x = 0.39;
		y = 0.32;
		w = 0.26;
		h = 0.04;
		idc = 101;
	};
	
	class incometaxcl2_slider : TNL_SliderH
	{
		idc = 102;
		x = 0.39;
		y = 0.37;
		w = 0.26;
		h = 0.04;
	};
	
	class incometaxcl3_text : TNL_Text 
	{
		x = 0.39;
		y = 0.42;
		w = 0.26;
		h = 0.04;
		idc = 111;
	};
	
	class incometaxcl3_slider : TNL_SliderH
	{
		idc = 112;
		x = 0.39;
		y = 0.48;
		w = 0.26;
		h = 0.04;
	};
	
	class incometaxcl4_text : TNL_Text 
	{
		x = 0.39;
		y = 0.54;
		w = 0.26;
		h = 0.04;
		idc = 121;
	};
	
	class incometaxcl4_slider : TNL_SliderH
	{
		idc = 122;
		x = 0.39;
		y = 0.59;
		w = 0.26;
		h = 0.04;
	};
	
	class incometaxcl5_text : TNL_Text 
	{
		x = 0.39;
		y = 0.65;
		w = 0.26;
		h = 0.04;
		idc = 131;
	};
	
	class incometaxcl5_slider : TNL_SliderH
	{
		idc = 132;
		x = 0.39;
		y = 0.70;
		w = 0.26;
		h = 0.04;
	};
	
	class backgroundBankValue : TNL_Background0
	{
		x = 0.39;
		y = 0.75;
		w = 0.26;
		h = 0.12;
	};
	class bankaccount_text : TNL_Text 
	{
		x = 0.39;
		y = 0.76;
		w = 0.26;
		h = 0.04;
		idc = 6661;
		style = ST_CENTER;
		SizeEX = 0.025;
	};
	class bankaccount_value : TNL_Text 
	{
		x = 0.39;
		y = 0.82;
		w = 0.26;
		h = 0.04;
		idc = 6662;
		style = ST_CENTER;
		SizeEX = 0.023;
	};
	
	class welfareIncLimit_text : TNL_Text 
	{
		x = 0.67;
		y = 0.10;
		w = 0.26;
		h = 0.04;
		idc = 141;
	};
	
	class welfareIncLimit_slider : TNL_SliderH
	{
		idc = 142;
		x = 0.67;
		y = 0.15;
		w = 0.26;
		h = 0.04;
	};
	class welfareBankLimit_text : TNL_Text 
	{
		x = 0.67;
		y = 0.21;
		w = 0.26;
		h = 0.04;
		idc = 151;
	};
	
	class welfareBankLimit_slider : TNL_SliderH
	{
		idc = 152;
		x = 0.67;
		y = 0.26;
		w = 0.26;
		h = 0.04;
	};
	class welfareAmount_text : TNL_Text 
	{
		x = 0.67;
		y = 0.32;
		w = 0.26;
		h = 0.04;
		idc = 161;
	};
	
	class welfareAmount_slider : TNL_SliderH
	{
		idc = 162;
		x = 0.67;
		y = 0.37;
		w = 0.26;
		h = 0.04;
	};
	class Mayorpay_text : TNL_Text 
	{
		x = 0.67;
		y = 0.42;
		w = 0.26;
		h = 0.04;
		idc = 171;
	};
	
	class Mayorpay_slider : TNL_SliderH
	{
		idc = 172;
		x = 0.67;
		y = 0.48;
		w = 0.26;
		h = 0.04;
	};
	
	class PolChiefPay_text : TNL_Text 
	{
		x = 0.67;
		y = 0.54;
		w = 0.26;
		h = 0.04;
		idc = 181;
	};
	class PolChiefPay_slider : TNL_SliderH
	{
		idc = 182;
		x = 0.67;
		y = 0.59;
		w = 0.26;
		h = 0.04;
	};
	
	class PoliceSalary_text : TNL_Text 
	{
		x = 0.67;
		y = 0.65;
		w = 0.26;
		h = 0.04;
		idc = 201;
	};
	class PoliceSalary_slider : TNL_SliderH
	{
		idc = 202;
		x = 0.67;
		y = 0.70;
		w = 0.26;
		h = 0.04;
	};
	
	class InterestRate_text : TNL_Text 
	{
		x = 0.67;
		y = 0.76;
		w = 0.26;
		h = 0.04;
		idc = 191;
	};
	class InterestRate_slider : TNL_SliderH
	{
		idc = 192;
		x = 0.67;
		y = 0.82;
		w = 0.26;
		h = 0.04;
	};
	
	class button_submit : TNL_Button
	{
		x = 0.22;
		y = 0.89;
		text = "Submit";
		action = "[0,1,2,[""MayorTax"", (round(sliderPosition 12)), (round(sliderPosition 32)), (round(sliderPosition 42)), (round(sliderPosition 22)), (round(sliderPosition 52)), (round(sliderPosition 62)), (round(sliderPosition 72)), (round(sliderPosition 82)), (round(sliderPosition 92)), (round(sliderPosition 102)), (round(sliderPosition 112)), (round(sliderPosition 122)), (round(sliderPosition 132)), (round(sliderPosition 142)), (round(sliderPosition 152)), (round(sliderPosition 162)), (round(sliderPosition 172)), (round(sliderPosition 182)), (round(sliderPosition 192)), (round(sliderPosition 202))]] execVM ""slr\mayor.sqf""; closedialog 0;";
	};
	
	class button_cancel : TNL_Button
	{
		x = 0.62;
		y = 0.89;
		text = "Close";
		action = "closedialog 0;";
	};
	
};

