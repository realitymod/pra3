class PRA3_hud_playerRecognition
{
	idd      = -1;
	duration = 1e+1000;
	fadeIn   = 0;
	fadeOut  = 0;
	name     = "PRA3_hud_playerRecognition";
	onLoad   = "uiNamespace setVariable [""PRA3_hud_playerRecognition"", _this select 0]";

	class Controls
	{
		class PlayerName1 : RscText
		{
			idc  = 10;
			x    = 0;
			y    = 0;
			w    = 1;
			h    = 0.035;
			style = ST_CENTER;
			text = "";
			sizeEx = 0.04;
			shadow = 2;

			colorText[] = {1,1,1,1};
			colorBackground[] = {0,0,0,0};
		};

		#define ADD_NAME(num) \
		class PlayerName##num : PlayerName1 \
		{ \
			idc = __EVAL(10*num); \
		}

		ADD_NAME(2);
		ADD_NAME(3);
		ADD_NAME(4);
		ADD_NAME(5);
		ADD_NAME(6);
		ADD_NAME(7);
		ADD_NAME(8);
		ADD_NAME(9);
		ADD_NAME(10);
	};
};
