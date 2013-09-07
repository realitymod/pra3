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
			text = "Press <t color='#aaaaaa'>ENTER</t>, join a squad, select a spawn location and choose a kit.";
		};
		class CountdownText : CountdownText	{};
	};
};
