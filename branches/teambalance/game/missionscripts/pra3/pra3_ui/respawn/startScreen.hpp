class PRA3_respawn_startScreen : PRA3_respawn_deadScreen
{
	name = "PRA3_respawn_startScreen";
	onLoad = "uiNamespace setVariable [""PRA3_respawn_startScreen"", _this select 0]";

	class ControlsBackground : ControlsBackground
	{
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
