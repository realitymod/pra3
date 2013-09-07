class Rsc_PRA3_kits_kitDlg : Rsc_PRA3_kits_kitDlgRespawn
{
	idd = -1;
	onLoad = "uiNamespace setVariable [""Rsc_PRA3_kits_kitDlg"", _this select 0]; (_this select 0) call PRA3_fnc_kitDlg_onLoad";

	#define __w1 0.5

	#define __spaceX 0.01
	#define __spaceY (__spaceX / (4/3))

	#define __mapW (safeZoneW - __w1 - __spaceX * 3)
	#define __mapH (safeZoneH - __spaceY * 2)

	class ControlsBackground : ControlsBackground
	{
		class TitleLeftBackground : TitleLeftBackground {};
		class TitleLeft : TitleLeft {};
		class BackgroundLeft : BackgroundLeft {};
		class ButtonsBackground : TitleLeftBackground
		{
			y = safeZoneY + safeZoneH - __spaceY - 0.05;
			h = 0.05;
		};

		// Used to detect when the mouse is outside of the kit selection dialog
		class MouseDetector : MouseDetector {};
	};
	class Controls : Controls
	{
		#define __h 0.11
		class KitSelection : KitSelection
		{
			y = safeZoneY + __spaceY + 0.01 + 0.05 + 0.01;
			h = safeZoneH - (__spaceY * 2 + 0.01 + 0.05 + 0.01 + 0.04 + 0.05);

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
		
		class ConfirmButton : RscShortcutButton
		{
			idc = IDC_KITDLG_CHANGEKIT_BTN;
			x = safeZoneX + __spaceX + __spaceX;
			y = safeZoneY + safeZoneH - __spaceY - 0.045;
			w = __EVAL((__w1 - __spaceX*3) / 2);
			h = 0.04;
			text = "Change kit";
			action = "closeDialog 0";
			sizeEx = 0.035;
			size = 0.035;

			class TextPos
			{
				left = 0;
				top = 0;
				right = 0;
				bottom = 0;
			};
			class Attributes : Attributes
			{
				align = "center";
			};
		};
		class CancelButton : ConfirmButton
		{
			idc = -1;
			x = safeZoneX + __spaceX + (__w1 + __spaceX) / 2;
			text = "Cancel";
			action = "PRA3_kitSys_currentKit = ''; closeDialog 0";
		};
	};
};
