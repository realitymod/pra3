class Rsc_PRA3_score_playersDlg
{
	idd              = -1;
	onLoad           = "uiNamespace setVariable [""Rsc_PRA3_score_playersDlg"", _this select 0]; _this select 0 call PRA3_fnc_playersDlg_onLoad;";
	onUnload           = "_this select 0 call PRA3_fnc_playersDlg_onUnload;";
	movingEnable     = false;
	enableSimulation = true;

	#define __w      (GUI_GRID_W * 16)
	#define __h      (GUI_GRID_H * 20)
	#define __x      (0.5 - __w*0.5)
	#define __y      (0.5 - __h*0.5)
	#define __midW   (GUI_GRID_W * 0.25)
	#define __titleH (GUI_GRID_H * 1.5)

	class ControlsBackground
	{
		class MainBackground : RscBackground
		{
			x = __x;
			y = __y;
			w = __w;
			h = __h;
			colorBackground[] = {0.1,0.1,0.1,0.5};
		};
		class PlayerListTopBackground : MainBackground
		{
			x = __x;
			y = __y;
			w = __w;
			h = __titleH;
			colorBackground[] = {0.153,0.153,0.153,1.0};
		};
		class PlayerListBottomBackground : PlayerListTopBackground
		{
			y = __y + __h - GUI_GRID_H;
			h = GUI_GRID_H;
		};

		class NameTeam1 : RscText
		{
			idc = 51;
			x = __x + GUI_GRID_W * 0.5;
			y = __y;
			w = __w * 0.5;
			h = __titleH;
			sizeEx = GUI_GRID_H;
		};
		class NameTeam2 : NameTeam1
		{
			idc = 52;
			x = __x + (__w + __midW) * 0.5 + GUI_GRID_W * 0.5;
		};
		class Team1Pic : RscPicture
		{
			idc = 61;
			x = __x + (__w + __midW) * 0.5 - 0.06 - GUI_GRID_W * 0.5;
			y = __y + __titleH * 0.5 - GUI_GRID_H * 0.5;
			// Flags should be 3:2 ratio
			w = GUI_GRID_H / 2 * 3; // 0.06
			h = GUI_GRID_H; // 0.04
		};
		class Team2Pic : Team1Pic
		{
			idc = 62;
			x = __x + __w - 0.06 - GUI_GRID_W * 0.5;
		};
	};
	class Controls
	{
		class PlayerListButtonClose : RscButton
		{
			idc = IDC_MPLISTDLG_OPEN_BTN;
			x = __x + __w - GUI_GRID_W * 4;
			y = __y + __h - GUI_GRID_H;
			w = GUI_GRID_W * 4;
			h = GUI_GRID_H;
			text = "CLOSE";
			action = "closeDialog 0";

			shadow = 0;

			offsetX = 0.000;
			offsetY = 0.000;

			colorFocused[] = {0.3, 0.3, 0.3, 1};
			colorShadow[] = {0, 0, 0, 0};
			colorBorder[] = {0, 0, 0, 1};

			colorText[] = {1, 1, 1, 1.0};
			colorDisabled[] = {0.4, 0.4, 0.4, 1};
			colorBackground[] = {0.2, 0.2, 0.2, 1};
			colorBackgroundActive[] = {0.3, 0.3, 0.3, 1};
			colorBackgroundDisabled[] = {0.1, 0.1, 0.1, 1};
		};
		class PlayerListTeam1 : RscControlsGroup
		{
			x   = __x;
			y   = __y + __titleH;
			w   = __w;
			h   = __h - __titleH - GUI_GRID_H;

			class Controls
			{
				#define __column2 (__w * 0.5 + __midW * 0.5)

				class Line1 : RscText
				{
					idc = 100;
					x   = 0;
					y   = 0;
					w   = __w;
					h   = GUI_GRID_H;
					colorBackground[] = {0.1,0.1,0.1,0.5};
				};
				class PlayerName1A : RscText
				{
					idc = 101;
					x   = GUI_GRID_W * 0.25;
					y   = 0;
					w   = __w * 0.5 - GUI_GRID_W * 0.25 - __midW * 0.5;
					h   = GUI_GRID_H;
					sizeEx = GUI_GRID_H * 0.75;
				};
				class PlayerName1B : PlayerName1A
				{
					idc = 102;
					x   = __column2 + GUI_GRID_W * 0.25;
				};
				class Line2 : Line1
				{
					idc = 200;
					y   = GUI_GRID_H;
					colorBackground[] = {0.3,0.3,0.3,0.5};
				};
				class PlayerName2A : PlayerName1A
				{
					idc = 201;
					y   = GUI_GRID_H;
				};
				class PlayerName2B : PlayerName1B
				{
					idc = 202;
					y   = GUI_GRID_H;
				};

				#define MAKE_LINE(num1,num2)             \
				class Line##num1 : Line1                 \
				{                                        \
					idc = __EVAL(100*num1 + 0);          \
					y   = GUI_GRID_H * (num1 - 1);       \
				};                                       \
				class PlayerName##num1##A : PlayerName1A \
				{                                        \
					idc = __EVAL(100*num1 + 1);          \
					y   = GUI_GRID_H * (num1 - 1);       \
				};                                       \
				class PlayerName##num1##B : PlayerName1B \
				{                                        \
					idc = __EVAL(100*num1 + 2);          \
					y   = GUI_GRID_H * (num1 - 1);       \
				};                                       \
				class Line##num2 : Line2                 \
				{                                        \
					idc = __EVAL(100*num2 + 0);          \
					y   = GUI_GRID_H * (num2 - 1);       \
				};                                       \
				class PlayerName##num2##A : PlayerName2A \
				{                                        \
					idc = __EVAL(100*num2 + 1);          \
					y   = GUI_GRID_H * (num2 - 1);       \
				};                                       \
				class PlayerName##num2##B : PlayerName2B \
				{                                        \
					idc = __EVAL(100*num2 + 2);          \
					y   = GUI_GRID_H * (num2 - 1);       \
				}

				MAKE_LINE(3,4);
				MAKE_LINE(5,6);
				MAKE_LINE(7,8);
				MAKE_LINE(9,10);
				MAKE_LINE(11,12);
				MAKE_LINE(13,14);
				MAKE_LINE(15,16);
				MAKE_LINE(17,18);
				MAKE_LINE(19,20);
				MAKE_LINE(21,22);
				MAKE_LINE(23,24);
				MAKE_LINE(25,26);
				MAKE_LINE(27,28);
				MAKE_LINE(29,30);
				MAKE_LINE(31,32);
				MAKE_LINE(33,34);
				MAKE_LINE(35,36);
				MAKE_LINE(37,38);
				MAKE_LINE(39,40);
				MAKE_LINE(41,42);
				MAKE_LINE(43,44);
				MAKE_LINE(45,46);
				MAKE_LINE(47,48);
				MAKE_LINE(49,50);

				class PlayerListMiddleLine : Line1
				{
					idc = 99;
					x   = (__w + __midW) * 0.5;
					w   = __midW;
					h   = GUI_GRID_H * 50;
					colorBackground[] = {0.153,0.153,0.153,1.0};
				};
			};
		};
	};
};
