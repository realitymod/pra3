class PRA3_respawn_deadScreen
{
	idd      = -1;
	duration = 1e+1000;
	fadeIn   = 1;
	fadeOut  = 0;
	name     = "PRA3_respawn_deadScreen";
	onLoad   = "uiNamespace setVariable [""PRA3_respawn_deadScreen"", _this select 0]";
	
	#define __w1 0.5
	#define __w2 0.5

	#define __spaceX 0.01
	#define __spaceY (__spaceX / (4/3))

	#define __mapX (safeZoneX + __spaceX + __w1 + __spaceX + __spaceX)
	#define __mapW (safeZoneW - __w1 - __spaceX * 3)
	#define __mapH (safeZoneH - __spaceY * 2)
	
	class ControlsBackground
	{
		class Background : RscBackground
		{
			moving = 0;

			colorBackground[] = {0,0,0,1};

			x = safeZoneX + __spaceX;
			y = safeZoneY + __spaceY;
			w = __EVAL(__w1);
			h = safeZoneH;
		};
		class AlphaRelease : RscText 
		{
			colorText[] = {1,1,1,0};
		};
		class MissionText : RscStructuredText
		{
			idc  = 5;
			x    = 0;
			y    = __EVAL(0.9 - 0.02);
			w    = 1;
			h    = 0.04;
			size = 0.04;
			text = "";

			colorBackground[] = {0,0,0,0};

			class Attributes : Attributes
			{
				align = "center";
				valign = "top";
			};
		};
		class StatusText : MissionText
		{
			idc  = 10;
			x    = 0;
			y    = __EVAL(0.35 - 0.09);
			w    = 1;
			text = "<t color='#ff0000'>You are dead.</t>";
			size = 0.08;
			h    = 0.09;

			colorBackground[] = {0,0,0,0};

			class Attributes : Attributes
			{
				align = "center";
			};
		};
		class InstructionsText : StatusText
		{
			idc   = 20;
			x     = 0.38;
			y     = __EVAL(0.35 + 0.05);
			h     = __EVAL(0.05 * 3);
			style = ST_MULTI;
			size  = 0.04;
			text  = "";

			class Attributes : Attributes
			{
				align = "left";
			};
		};
		class CountdownText : StatusText
		{
			idc  = 30;
			x    = 0.375;
			y    = __EVAL(0.35 + 0.05 + 0.05 * 4 + 0.05);
			text = "";
			size = 0.08;

			class Attributes : Attributes
			{
				align = "left";
			};
		};
	};
};
