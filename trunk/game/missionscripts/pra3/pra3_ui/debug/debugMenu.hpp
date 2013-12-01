class Rsc_PRA3_debugMenu
{
	idd      = -1;
	onLoad   = "uiNamespace setVariable ['Rsc_PRA3_debugMenu', _this select 0]; _this select 0 call PRA3_fnc_debugMenu_onLoad";

	class ControlsBackground
	{
	};
	class Controls
	{
		class Debug0 : RscButton
		{
			idc    = 10;
			x      = 0;
			y      = 0;
			w      = 0.4;
			h      = 0.045;
			text   = "";
			action = "0 call PRA3_fnc_debugMenu_toggle";
		};

		#define ADD_BUTTON(num) \
		class Debug##num : Debug0 \
		{ \
			idc    = (num+1)*10; \
			y      = 0.05 * num; \
			action = num call PRA3_fnc_debugMenu_toggle; \
		}

		ADD_BUTTON(1);
		ADD_BUTTON(2);
		ADD_BUTTON(3);
		ADD_BUTTON(4);
	};
};
