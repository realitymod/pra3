class PRA3_AAS_captureIndicator
{
	idd = -1;
	duration = 1e+1000;
	fadeIn = 0;
	fadeOut = 0;
	name = "PRA3_AAS_captureIndicator";
	onLoad = "uiNamespace setVariable [""PRA3_AAS_captureIndicator"", _this select 0]";
	
	class ControlsBackground
	{
		class Background : RscBackground
		{
			moving = 0;
			
			colorBackground[] = {0,0,0,0.7};
			
			x = 0.5 - 0.2;
			y = "safeZoneY";
			w = 0.4;
			h = 0.02 + 0.01 / (4/3) * 2;
		};
		class ProgressBackground : Background
		{
			x = 0.5 - 0.195;
			y = "safeZoneY + 0.01 / (4/3)";
			w = 0.39;
			h = 0.02;
		};
		class Progress : ProgressBackground
		{
			idc = 1;
			colorBackground[] = {1,1,1,1};
		};
	};
};
