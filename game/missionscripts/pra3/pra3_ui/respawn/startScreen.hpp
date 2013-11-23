class PRA3_respawn_startScreen : PRA3_respawn_deadScreen
{
	name = "PRA3_respawn_startScreen";
	onLoad = "uiNamespace setVariable [""PRA3_respawn_startScreen"", _this select 0]";
	
	#define __w1 0.5
	#define __w2 0.5

	#define __spaceX 0.01
	#define __spaceY (__spaceX / (4/3))

	#define __mapX (safeZoneX + __spaceX + __w1 + __spaceX + __spaceX)
	#define __mapW (safeZoneW - __w1 - __spaceX * 3)
	#define __mapH (safeZoneH - __spaceY * 2)

	class ControlsBackground : ControlsBackground
	{
		class AlphaRelease : AlphaRelease 
		{
			x = safeZoneX + __spaceX;
			y = safeZoneY + __spaceY + 0.01;
			w = __EVAL(0.3);
			h = 0.05;
			sizeEx = 0.05;
			text = "ALPHA RELEASE";
			font = "PuristaBold";
			colorText[] = {1,1,1,1};
			style = ST_CENTER;
			colorBackground[] = {0,0,0,0};
		};
		class StartBackground : StartBackground 
		{
			colorBackground[] = {0,0,0,1};
			style = ST_FRAME;
		};
		class StartBackground2 : StartBackground2 
		{
			colorBackground[] = {0,0,0,0.5};
		};
		class MissionText : MissionText
		{
			text = "";
		};
		class StatusText : StatusText
		{
			text = "The mission will begin shortly...";
		};
		class InstructionsText : InstructionsText
		{
			h = __EVAL(0.05 * 5);
		};
		class CountdownText : CountdownText
		{
			y = __EVAL(0.35 + 0.05 + 0.05 * 5 + 0.05);
		};
	};
};
