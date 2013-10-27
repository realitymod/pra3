class PRA3_respawn_deadScreen
{
	idd = -1;
	duration = 1e+1000;
	fadeIn = 0.5;
	fadeOut = 0;
	name = "PRA3_respawn_deadScreen";
	onLoad = "uiNamespace setVariable [""PRA3_respawn_deadScreen"", _this select 0]";

	class ControlsBackground
	{
		class Background : RscBackground
		{
			moving = 0;

			colorBackground[] = {0,0,0,1};

			x = "safeZoneXAbs";
			y = "safeZoneY";
			w = "safeZoneWAbs";
			h = "safeZoneH";
		};
		class StatusText : RscStructuredText
		{
			idc = 10;
			x = 0;
			y = 0.4 - 0.09;
			w = 1;
			text = "<t color='#ff0000'>You are dead.</t>";
			size = 0.09;
			h = 0.09;

			colorBackground[] = {0,0,0,0};

			class Attributes : Attributes
			{
				align = "center";
			};
		};
		class InstructionsText : StatusText
		{
			idc = 20;
			y = 0.5 - 0.05/2;
			h = __EVAL(0.05 * 2);
			style = ST_MULTI;
			size = 0.05;
			text = "Press <t color='#aaaaaa'>ENTER</t> to open the spawn selection screen.";
		};
		class CountdownText : StatusText
		{
			idc = 30;
			x = 0.375;
			y = 0.6;
			text = "00:00.000";

			class Attributes : Attributes
			{
				align = "left";
			};
		};
	};
};
