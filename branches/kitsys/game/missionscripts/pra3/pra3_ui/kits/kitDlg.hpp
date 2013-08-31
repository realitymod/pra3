class Rsc_PRA3_kits_kitDlg : Rsc_PRA3_kits_kitDlgRespawn
{
	idd = -1;
	onLoad = "uiNamespace setVariable [""Rsc_PRA3_kits_kitDlg"", _this select 0]; (_this select 0) call PRA3_fnc_kitDlg_onLoad";

	#define __w1 0.5
	#define __w2 0.5

	#define __spaceX 0.01
	#define __spaceY (__spaceX / (4/3))

	#define __mapW (safeZoneW - __w1 - __spaceX * 3)
	#define __mapH (safeZoneH - __spaceY * 2)

	class ControlsBackground : ControlsBackground
	{
		class TitleLeftBackground : TitleLeftBackground {};
		class TitleLeft : TitleLeft {};
		class BackgroundLeft : BackgroundLeft {};

		// Used to detect when the mouse is outside of the kit selection dialog
		class MouseDetector : MouseDetector {};
	};
	class Controls : Controls
	{
		#define __h 0.11
		class KitSelection : KitSelection
		{
			y = safeZoneY + __spaceY + 0.01 + 0.05 + 0.01;
			h = safeZoneH - (__spaceY * 2 + 0.01 + 0.05 + 0.01 + 0.04);

			class Controls : Controls
			{
				class Kit1 : Kit1 {};
				class Kit2 : Kit2 {};
				class Kit3 : Kit3 {};
				class Kit4 : Kit4 {};
				class Kit5 : Kit5 {};
				class Kit6 : Kit6 {};
				class Kit7 : Kit7 {};
				class Kit8 : Kit8 {};
				class Kit9 : Kit9 {};
				class Kit10 : Kit10 {};
				class Kit11 : Kit11 {};
				class Kit12 : Kit12 {};
			};
		};

		#define __h2 0.225
		#define __separatorW 0.01
		class KitDetails : KitDetails {};
	};
};
