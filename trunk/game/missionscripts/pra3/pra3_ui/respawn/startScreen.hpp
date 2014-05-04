class PRA3_respawn_startScreen : PRA3_respawn_deadScreen
{
	name   = "PRA3_respawn_startScreen";
	onLoad = "uiNamespace setVariable [""PRA3_respawn_startScreen"", _this select 0]";

	#define __spaceX 0.01
	#define __spaceY (__spaceX / (4/3))

	class ControlsBackground : ControlsBackground
	{
		class ReleaseName : RscText
		{
			x           = safeZoneX + __spaceX;
			y           = safeZoneY + __spaceY;
			w           = 0.4;
			h           = 0.05;
			sizeEx      = 0.05;
			text        = "PR:A3 ALPHA RELEASE";
			font        = "PuristaBold";
			colorText[] = {1,1,1,1};
			style       = ST_LEFT;
			colorBackground[] = {0,0,0,0};
		};
		class Version : ReleaseName
		{
			idc    = 40;
			y      = safeZoneY + safeZoneH - __spaceY - 0.04 * 2;
			h      = 0.04;
			sizeEx = 0.04;
			font   = "PuristaMedium";
			text   = "v1.2.3.4";
		};
		class MissionVersion : Version
		{
			idc    = 50;
			y      = safeZoneY + safeZoneH - __spaceY - 0.04;
			h      = 0.04;
			sizeEx = 0.04;
			text   = "v1.2.3.4";
		};

		class MissionText : MissionText
		{
			text = "";
		};
		class StatusText : StatusText
		{
			text = "The mission will start shortly";
		};
		class InstructionsText : InstructionsText
		{
			h    = __EVAL(0.05 * 5);
		};
		class CountdownText : CountdownText
		{
			y    = __EVAL(0.35 + 0.05 + 0.05 * 5 + 0.05);
			size = 0.08;
		};
	};
};
