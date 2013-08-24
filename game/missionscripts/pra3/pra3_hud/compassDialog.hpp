class PRA3_hud_compass
{
	idd = -1;
	movingEnable = false;
	enableSimulation = true;
	duration = 1e+100;
	fadeIn = 0;
	fadeOut = 0;
	name = "PRA3_hud_compass";

	onLoad = "uiNamespace setVariable [""PRA3_hud_compass"", _this select 0]";

	class Controls
	{
		class Group : RscControlsGroup
		{
			idc = 1;
			x = 0.27;
			y = safeZoneY + safeZoneH - (2.5/(2048/64)*(4/3));
			w = 0.46;
			h = 2.5/(2048/64)*(4/3);

			class Controls
			{
				class CompassStripe : RscPicture
				{
					idc = 3;
					x = -1.02;
					y = 0;
					w = 2.5;
					h = 2.5/(2048/64)*(4/3);
					text = "pra3\pra3_hud\data\compass_88.paa";
				};
				class ObjectiveMarker : RscPicture
				{
					idc = 4;
					x = 0;
					y = 0;
					w = 0.023;
					h = 0.023 * (4/3);
					text = "pra3\pra3_hud\data\needle_co.paa";
					colorText[] = {1,0,0,1};
				};
			};
		};
		class Needle : RscPicture
		{
			idc = 2;
			x = 0.5 - 0.03/2;
			y = safeZoneY + safeZoneH - (0.023 * (4/3)) + 0.013;
			w = 0.023;
			h = 0.023 * (4/3);
			text = "pra3\pra3_hud\data\needle_co.paa";
		};
	};
};