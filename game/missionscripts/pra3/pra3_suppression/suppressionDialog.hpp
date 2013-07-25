class PRA3_suppression_HUD
{
	idd = -1;
	duration = 5;
	name = "PRA3_suppression_HUD";
	fadeIn = 0;
	fadeOut = 5;
	onLoad = "uiNamespace setVariable [""PRA3_suppression_HUD"", _this select 0]";
	
	class ControlsBackground
	{
		class Background : RscText
		{
			idc = -1;
			x = "SafeZoneX";
			y = "SafeZoneY";
			w = "SafeZoneW";
			h = "SafeZoneH";
		};
	};
	class Controls
	{
		class suppressionDialog : RscPicture
		{
			idc = -1;
			type = 0;
			text = "pra3\pra3_suppression\suppression_effect_88.paa";
			style = 48;
			sizeEx = 1;
			x = "SafeZoneX";
			y = "SafeZoneY";
			w = "SafeZoneW";
			h = "SafeZoneH";
		};
	};
};
