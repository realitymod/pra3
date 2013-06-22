#include "idcs.hpp"

class CfgPatches
{
	class PRA3_debugConsole
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_UI_F"};
	};
};

class RscControlsGroupNoScrollbars;
class RscBackground;
class RscText;
class RscEdit;
class RscListBox;
class RscShortcutButton;
class RscButtonMenu : RscShortcutButton
{
	class Attributes;
};
class RscCombo;
class RscStructuredText;

class PRA3_RscDebugConsole : RscControlsGroupNoScrollbars
{
	idc = IDC_DEBUGCONSOLE_MAIN;
	
	#define __spaceX 0.005
	#define __spaceY (__spaceX * (4/3))

	#define __x ((((safezoneW / safezoneH) min 1.2) / 40) + safezoneX + 15 * (((safezoneW / safezoneH) min 1.2) / 40) + __spaceX)
	#define __y (safeZoneY + __spaceY)
	#define __w (safeZoneW - (15 * (((safezoneW / safezoneH) min 1.2) / 40)) - (1 * (((safezoneW / safezoneH) min 1.2) / 40) + (safezoneX) - safeZoneX) - __spaceX * 2)
	#define __h (23 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + (safezoneY + safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2)) - safeZoneY - __spaceY * 2)

	#define __lineH 0.04
	#define __btnW (__lineH / (4/3))

	x = __x;
	y = __y;
	w = __w;
	h = __h;

	class Controls
	{
		class Background : RscBackground
		{
			colorBackground[] = {0,0,0,0.8};

			x = 0;
			y = 0;
			w = __w;
			h = __h;
		};
		class BackgroundTop : Background
		{
			colorBackground[] = {0,0,0,1};

			h = 0.05;
		};
		class TitleText : RscText
		{
			idc = -1;
			x = __spaceX;
			y = 0;
			w = 1;
			h = 0.045;
			text = "DEBUG CONSOLE BY PROJECT REALITY";
			font = "PuristaLight";
			sizeEx = 0.045;
		};

		#define __execX __spaceX
		#define __execY (__spaceY + 0.05)
		#define __execW (__w * 0.5)
		#define __execH (__h - __spaceY*2 - 0.05)
		class ExecGroup : RscControlsGroupNoScrollbars
		{
			idc = -1;
			x = __execX;
			y = __execY;
			w = __execW;
			h = __execH;

			class Controls
			{
				// class Test : RscBackground
				// {
					// x = 0;
					// y = 0;
					// w = __execW;
					// h = __execH;
					// colorBackground[] = {1,0,0,0.5};
				// };

				#define __commandEditH (__execH * 0.4)
				class CommandEdit : RscEdit
				{
					idc = IDC_DEBUGCONSOLE_MAIN_COMMAND_EDIT;
					style = 16;
					x = 0.001;
					y = 0;
					w = __execW - 0.002;
					h = __commandEditH;
					text = "";
					autocomplete = "scripting";
					htmlControl = true;
					font = "EtelkaMonospaceProBold";
					sizeEx = 0.03;
					tooltip = "The code to execute";
				};

				class ParamsText : RscText
				{
					idc = -1;
					x = 0.0;
					y = __commandEditH + __spaceY;
					w = 0.14;
					h = __lineH;
					sizeEx = 0.040;
					text = "Parameter:";
				};
				class ParamsEdit : CommandEdit
				{
					idc = IDC_DEBUGCONSOLE_MAIN_PARAMS_EDIT;
					style = 64;
					x = 0.14;
					y = __commandEditH + __spaceY;
					w = __execW - 0.14 - 0.001;
					h = __lineH;
					tooltip = "Parameter passed to the code as _this. For broadcasted commands it is compiled locally and the resulting value is transmitted alongside the command.";
				};

				class ExecutionText : ParamsText
				{
					y = __commandEditH + __spaceY + __lineH + __spaceY;
					text = "Execution:";
				};
				class ExecutionCB : RscCombo
				{
					idc = IDC_DEBUGCONSOLE_MAIN_EXECUTION_CB;

					x = 0.14;
					y = __commandEditH + __spaceY + __lineH + __spaceY;
					w = 0.15;
					h = __lineH;
					sizeEx = 0.034;
					tooltip = "Execution method; Local - your PC only, Global - everyone, Server - server only, For player - specific player";
					onLBSelChanged = "_this call PRA3_fDebugConsole_executionSelection";
				};
				class PlayerCB : ExecutionCB
				{
					idc = IDC_DEBUGCONSOLE_MAIN_PLAYER_CB;

					x = 0.14 + 0.15;
					w = __execW - (0.14 + 0.15);
					tooltip = "Player for whom to execute the code.";
				};

				class ExecuteBtn : RscButtonMenu
				{
					idc = -1;// IDC_DEBUGCONSOLE_MAIN_EXECUTE_BTN;
					x = __execW / 2 - (__execW * 0.4);
					y = __commandEditH + (__spaceY + __lineH) * 2 + __spaceY;
					w = __execW * 0.8;
					h = __lineH;
					text = "Execute!";
					tooltip = "Executes the code and retrieves its return value. Works for broadcasted commands too!";
					//shortcuts[] = {512 + 0x12};

					onButtonClick = "";
					action = "false call PRA3_fDebugConsole_execute";

					class Attributes : Attributes
					{
						align = "center";
					};
				};

				class ReturnText : ExecutionText
				{
					text = "Return value:";
					y = __commandEditH + (__spaceY + __lineH) * 3;
				};
				class ReturnTypeText : ReturnText
				{
					idc = IDC_DEBUGCONSOLE_MAIN_RETURN_TYPE;
					x = 0.17;
					colorText[] = {0.4, 0.4, 0.4, 1.0};
					text = "<nil>";
				};

				#define __returnH ((__execH - __commandEditH - (__spaceY + __lineH) * 3) * 0.3)
				class ReturnEdit : CommandEdit
				{
					idc = IDC_DEBUGCONSOLE_MAIN_RETURN_EDIT;
					y = __commandEditH + (__spaceY + __lineH) * 4;
					h = __returnH;
					canModify = 0;
					tooltip = "Value returned by the executed code.";
				};

				class HistoryText : ExecutionText
				{
					text = "History:";
					y = __commandEditH + (__spaceY + __lineH) * 4 + __returnH + __spaceY;
				};
				class HistoryLB : RscListBox
				{
					idc = IDC_DEBUGCONSOLE_MAIN_HISTORY_LB;
					x = 0.0;
					y = __commandEditH + (__spaceY + __lineH) * 5 + __returnH;
					w = __execW;
					h = __execH - (__commandEditH + (__spaceY + __lineH) * 5 + __returnH);
					font = "EtelkaMonospaceProBold";
					sizeEx = 0.032;
					tooltip = "History of previously executed code with the most recent one at the top. Double-click to select the entry.";
					onLBDblClick = "_this call PRA3_fDebugConsole_historySelect";
				};
				class HistoryClear : ExecuteBtn
				{
					idc = -1;
					x = __execW - 0.1;
					y = __commandEditH + (__spaceY + __lineH) * 5 + __returnH - __lineH;
					w = 0.1;
					h = __lineH;
					text = "Clear";
					tooltip = "Clears the entire history.";

					class TextPos
					{
						left = 0.0;
						top = 0.0;
						right = 0.0;
						bottom = 0.0;
					};

					action = "call PRA3_fDebugConsole_historyClear";
				};
			};
		};

		#define __favX (__execX + __execW + __spaceX)
		#define __favY __execY
		#define __favW (__w * 0.2)
		#define __favH __execH
		class FavoritesGroup : ExecGroup
		{
			x = __favX;
			w = __favW;

			class Controls : Controls
			{
				// class Test : Test
				// {
					// w = __favW;
					// colorBackground[] = {0,1,0,0.5};
				// };

				class FavoritesText : ExecutionText
				{
					x = 0;
					y = 0;
					w = __favW;
					text = "Favorites";
				};
				class FavoritesLB : HistoryLB
				{
					idc = IDC_DEBUGCONSOLE_MAIN_FAVORITES_LB;
					x = 0;
					y = 0.04;
					w = __favW;
					h = __favH - __lineH * 2 - __spaceY;
					tooltip = "Persistenly stored favorite commands. Double-click to select the entry.";
					font = "PuristaLight";
					sizeEx = 0.032;
					onLBDblClick = "_this call PRA3_fDebugConsole_favoritesSelect";
				};
				class FavoritesAdd : ExecuteBtn
				{
					idc = -1;
					x = (__favW * 0.1);
					y = __favH - __lineH;
					w = __btnW;
					h = __lineH;
					text = "A";
					action = "0 spawn PRA3_fDebugConsole_showAddFavorite";
					tooltip = "Add a new favorite entry";

					class TextPos
					{
						left = 0.0;
						top = 0.0;
						right = 0.0;
						bottom = 0.0;
					};
				};
				class FavoritesEdit : FavoritesAdd
				{
					x = (__favW * 0.1 + __btnW + __spaceX);
					text = "E";
					action = "0 spawn PRA3_fDebugConsole_showEditFavorite";
					tooltip = "Edit the selected favorite entry";
				};
				class FavoritesDelete : FavoritesAdd
				{
					x = (__favW * 0.1 + (__btnW + __spaceX) * 2);
					text = "D";
					action = "call PRA3_fDebugConsole_deleteFavorite";
					tooltip = "Deletes the selected favorite entry";
				};
			};
		};

		#define __monitorX (__execX + __execW + __spaceX + __favW + __spaceX)
		#define __monitorY __execY
		#define __monitorW (__w - __execW - __favW - __spaceX*4)
		#define __monitorH __execH
		class MonitorGroup : FavoritesGroup
		{
			x = __monitorX;
			w = __monitorW;

			class Controls : Controls
			{
				// class Test : Test
				// {
					// w = __monitorW;
					// colorBackground[] = {0,0,1,0.5};
				// };

				class MonitorText : FavoritesText
				{
					w = __monitorW;
					text = "Value Monitor";
				};
				class MonitorCatCB : ExecutionCB
				{
					idc = IDC_DEBUGCONSOLE_MAIN_MONITOR_CAT_CB;

					x = 0;
					y = __lineH;
					w = __monitorW;
					onLBSelChanged = "_this call PRA3_fDebugConsole_monitoredCategoryChange";
					tooltip = "Categories of monitored values";
				};
				class MonitorListLB : FavoritesLB
				{
					idc = IDC_DEBUGCONSOLE_MAIN_MONITOR_LIST_LB;
					x = 0;
					y = __lineH * 2;
					w = __monitorW;
					h = __monitorH - __lineH * 3 - __spaceY;
					style = 16 + 32;
					onLBDblClick = "_this call PRA3_fDebugConsole_monitorSelect";
					tooltip = "Monitored values. Double-click to load the expression and its value.";
				};
				class MonitorAdd : FavoritesAdd
				{
					action = "0 spawn PRA3_fDebugConsole_showAddMonitored";
					tooltip = "Add a new value monitor entry";
				};
				class MonitorEdit : FavoritesEdit
				{
					action = "0 spawn PRA3_fDebugConsole_showEditMonitored";
					tooltip = "Edit the selected value monitor entry";
				};
				class MonitorDelete : FavoritesDelete
				{
					action = "call PRA3_fDebugConsole_deleteMonitor";
					tooltip = "Deletes the selected value monitor entry";
				};
				class MonitorPin : MonitorDelete
				{
					idc = IDC_DEBUGCONSOLE_MAIN_MONITOR_PIN;
					x = __monitorW - __favW * 0.1 - 0.08;
					w = 0.08;
					text = "Pin";
					action = "call PRA3_fDebugConsole_pinMonitor";
					tooltip = "Pins/unpins the selected entries to/from the in-game HUD.";
				};
			};
		};

		#define __externalBtnW 0.08
		#define __buttonsW ((__externalBtnW + __spaceX) * 6)
		class ButtonsGroup : MonitorGroup
		{
			x = __w - __buttonsW;
			y = 0.005;
			w = (__externalBtnW + __spaceX) * 6;
			h = __lineH;

			class Controls : Controls
			{
				class ConfigBrowser : FavoritesAdd
				{
					x = 0;
					y = 0;
					w = __externalBtnW;
					text = "CFG";
					tooltip = "Opens Splendid Config Viewer";
					onButtonClick = "[ctrlparent (_this select 0)] spawn (uinamespace getvariable 'bis_fnc_configViewer');";
					action = "";
				};
				class FunctionsBrowser : ConfigBrowser
				{
					x = __externalBtnW + __spaceX;
					text = "FNC";
					tooltip = "Opens Functions Viewer";
					onButtonClick = "[ctrlparent (_this select 0)] spawn (uinamespace getvariable 'bis_fnc_help');";
				};
				class AnimBrowser : ConfigBrowser
				{
					x = (__externalBtnW + __spaceX) * 2;
					text = "ANIM";
					tooltip = "Opens Splendid Animaiton Viewer";
					onButtonClick = "[] spawn (uinamespace getvariable 'bis_fnc_animViewer');";
				};
				class GuiEditor : ConfigBrowser
				{
					x = (__externalBtnW + __spaceX) * 3;
					text = "GUI";
					tooltip = "Opens the GUI editor";
					onButtonClick = "[] spawn bis_fnc_guiEditor;";
				};
				class Spectator : ConfigBrowser
				{
					x = (__externalBtnW + __spaceX) * 4;
					text = "SPEC";
					tooltip = "Starts spectator script";
					onButtonClick = "if (isnil {RscSpectator_camera}) then {RscSpectator_allowFreeCam = true; cutrsc ['RscSpectator','plain'];} else {cuttext ['','plain']};";
				};
				class Camera : ConfigBrowser
				{
					x = (__externalBtnW + __spaceX) * 5;
					text = "CAM";
					tooltip = "Opens Splendid Camera";
					onButtonClick = "[] spawn (uinamespace getvariable 'bis_fnc_camera');";
				};
			};
		};
	};
};

class PRA3_DisplayDebugConsole_yesNo
{
	idd = -1;
	movingEnable = true;
	enableSimulation = false;

	onLoad = "uiNamespace setVariable [""PRA3_DisplayDebugConsole_yesNo"", _this select 0];";

	#define __w 0.5
	#define __h 0.3
	#define __x (0.5 - (__w  / 2))
	#define __y (0.5 - (__h  / 2))
	class ControlsBackground
	{
		class Background : RscBackground
		{
			moving = 0;

			colorBackground[] = {0,0,0,0.8};

			x = __x;
			y = __y;
			w = __w;
			h = __h;
		};
		class BackgroundTop : Background
		{
			moving = 1;

			colorBackground[] = {0,0,0,1};

			h = 0.05;
		};
		class BackgroundButtons : BackgroundTop
		{
			moving = 0;
			y = __y + __h - 0.05;
		};
		class TitleText : RscText
		{
			idc = 1;
			x = __x + 0.05 / (4/3);
			y = __y;
			w = 1;
			text = "CONFIRM";
			font = "PuristaLight";
			sizeEx = 0.045;
		};

		class Message : RscStructuredText
		{
			idc = 2;
			x = __x;
			y = __y + 0.05;
			w = __w;
			h = __h - 0.05 * 2;
			size = 0.035;
			text = "";
		};
	};
	class Controls
	{
		class ButtonYes : RscButtonMenu
		{
			idc = 101;
			x = __x;
			y = __y + __h - 0.05;
			w = __w / 2;
			h = 0.05;
			text = "Yes";

			action = "uiNamespace getVariable ""PRA3_DisplayDebugConsole_yesNo"" closeDisplay 1; call PRA3_debugConsole_executeOnYes";

			class Attributes : Attributes
			{
				align = "center";
			};
		};
		class ButtonNo : ButtonYes
		{
			default = 1;
			idc = 102;
			x = __x + __w / 2;
			text = "No";
			action = "uiNamespace getVariable ""PRA3_DisplayDebugConsole_yesNo"" closeDisplay 0";
		};
	};
};
class PRA3_DisplayDebugConsole_addFavorite : PRA3_DisplayDebugConsole_yesNo
{
	onLoad = "uiNamespace setVariable [""PRA3_DisplayDebugConsole_addFavorite"", _this select 0];";

	#define __w 0.55
	#define __h (0.05 * 2 + 0.35 + 0.05 + 0.005 + 0.05 * 2)
	#define __x (0.5 - (__w  / 2))
	#define __y (0.5 - (__h  / 2))

	class ControlsBackground : ControlsBackground
	{
		class Background : Background
		{
			x = __x;
			y = __y;
			w = __w;
			h = __h;
		};
		class BackgroundTop : BackgroundTop
		{
			x = __x;
			y = __y;
			w = __w;
		};
		class BackgroundButtons : BackgroundButtons
		{
			x = __x;
			w = __w;
			y = __y + __h - 0.05;
		};
		class TitleText : TitleText
		{
			idc = IDC_DEBUGCONSOLE_FAVORITE_TITLE;
			x = __x + 0.05 / (4/3);
			y = __y;
			text = "ADD FAVORITE ENTRY";
			font = "PuristaLight";
			sizeEx = 0.045;
		};
	};
	class Controls : Controls
	{
		class NameText : RscText
		{
			default = 1;
			idc = -1;
			x = __x;
			y = __y + 0.05;
			h = 0.040;
			sizeEx = 0.040;
			text = "Name:";
		};
		class NameEdit : RscEdit
		{
			idc = IDC_DEBUGCONSOLE_FAVORITE_NAME;
			style = 64;
			x = __x + 0.14;
			y = __y + 0.05 + 0.005;
			w = __w - 0.14;
			h = 0.04;
			tooltip = "Name of the favorite entry.";
			autocomplete = "";
		};

		class CommandEdit : NameEdit
		{
			idc = IDC_DEBUGCONSOLE_FAVORITE_COMMAND;
			style = 16;
			x = __x + 0.001;
			y = __y + 0.05 * 2;
			w = __w - 0.002;
			h = 0.35;
			text = "";
			autocomplete = "scripting";
			htmlControl = true;
			font = "EtelkaMonospaceProBold";
			sizeEx = 0.03;
			tooltip = "";
		};

		class ParamsText : NameText
		{
			y = __y + 0.05 * 2 + 0.35;
			text = "Parameter:";
		};
		class ParamsEdit : CommandEdit
		{
			idc = IDC_DEBUGCONSOLE_FAVORITE_PARAM;
			style = 64;
			x = __x + 0.14;
			y = __y + 0.05 * 2 + 0.35 + 0.005;
			w = __w - 0.14;
			h = 0.04;
			tooltip = "";
		};

		class ExecutionText : ParamsText
		{
			y = __y + 0.05 * 2 + 0.35 + 0.05;
			text = "Execution:";
		};
		class ExecutionCB : RscCombo
		{
			idc = IDC_DEBUGCONSOLE_FAVORITE_EXECUTION;
			x = __x + 0.14;
			y = __y + 0.05 * 2 + 0.35 + 0.05 + 0.005;
			w = 0.15;
			h = 0.04;
			sizeEx = 0.034;
		};

		class ButtonYes : ButtonYes
		{
			idc = IDC_DEBUGCONSOLE_FAVORITE_CONFIRM;
			x = __x;
			y = __y + __h - 0.05;
			w = __w / 2;
			action = "call PRA3_fDebugConsole_addFavorite";
			text = "Add";
		};
		class ButtonNo : ButtonNo
		{
			idc = IDC_DEBUGCONSOLE_FAVORITE_CANCEL;
			default = 0;
			x = __x + __w / 2;
			y = __y + __h - 0.05;
			w = __w / 2;
			text = "Cancel";
			action = "uiNamespace getVariable ""PRA3_DisplayDebugConsole_addFavorite"" closeDisplay 0";
		};
	};
};
class PRA3_DisplayDebugConsole_addMonitoredValue : PRA3_DisplayDebugConsole_addFavorite
{
	onLoad = "uiNamespace setVariable [""PRA3_DisplayDebugConsole_addMonitoredValue"", _this select 0];";

	#define __w 0.55
	#define __h (0.05 + 0.05 + 0.05 + 0.04 + 0.1 + 0.05)
	#define __x (0.5 - (__w  / 2))
	#define __y (0.5 - (__h  / 2))

	class ControlsBackground : ControlsBackground
	{
		class Background : Background
		{
			x = __x;
			y = __y;
			w = __w;
			h = __h;
		};
		class BackgroundTop : BackgroundTop
		{
			x = __x;
			y = __y;
			w = __w;
		};
		class BackgroundButtons : BackgroundButtons
		{
			x = __x;
			w = __w;
			y = __y + __h - 0.05;
		};
		class TitleText : TitleText
		{
			idc = IDC_DEBUGCONSOLE_MONITOR_TITLE;
			x = __x + 0.05 / (4/3);
			y = __y;
			text = "ADD MONITORED VALUE ENTRY";
			font = "PuristaLight";
			sizeEx = 0.045;
		};
	};
	class Controls : Controls
	{
		class NameText : NameText
		{
			y = __y + 0.05;
		};
		class NameEdit : NameEdit
		{
			idc = IDC_DEBUGCONSOLE_MONITOR_NAME;
			y = __y + 0.05 + 0.005;
			tooltip = "Name of the monitored value.";
		};

		class CategoryText : NameText
		{
			y = __y + 0.05 + 0.05;
			text = "Category:";
		};
		class CategoryCB : RscCombo
		{
			idc = IDC_DEBUGCONSOLE_MONITOR_CATEGORY;
			x = __x + 0.14;
			y = __y + 0.05 + 0.05;
			w = __w - 0.14;
			h = 0.04;
			sizeEx = 0.034;
		};

		class ExpressionText : NameText
		{
			y = __y + 0.05 + 0.05 + 0.05;
			text = "Monitored expression:";
		};
		class ExpressionEdit : NameEdit
		{
			idc = IDC_DEBUGCONSOLE_MONITOR_COMMAND;
			style = 16;
			x = __x + 0.001;
			y = __y + 0.05 + 0.05 + 0.05 + 0.04;
			w = __w - 0.002;
			h = 0.1;
			text = "";
			autocomplete = "scripting";
			htmlControl = true;
			font = "EtelkaMonospaceProBold";
			sizeEx = 0.03;
			tooltip = "Enter the expression of which you want to monitor the value.";
		};

		class ButtonYes : ButtonYes
		{
			idc = IDC_DEBUGCONSOLE_MONITOR_CONFIRM;
			x = __x;
			y = __y + __h - 0.05;
			w = __w / 2;
			action = "call PRA3_fDebugConsole_addMonitored";
			text = "Add";
		};
		class ButtonNo : ButtonNo
		{
			idc = IDC_DEBUGCONSOLE_MONITOR_CANCEL;
			default = 0;
			x = __x + __w / 2;
			y = __y + __h - 0.05;
			w = __w / 2;
			text = "Cancel";
			action = "uiNamespace getVariable ""PRA3_DisplayDebugConsole_addMonitoredValue"" closeDisplay 0";
		};
	};
};

class RscStandardDisplay;
class RscDisplayInterrupt : RscStandardDisplay
{
	onLoad = "uiNamespace setVariable [""PRA3_RscDebugConsole"", _this select 0]; call compile preprocessFileLineNumbers ""\pra3\pra3_debugconsole\scripts\onLoad.sqf""; [""onLoad"",_this,""RscDisplayInterrupt"",'GUI'] call compile preprocessfilelinenumbers ""A3\ui_f\scripts\initDisplay.sqf""";

	class Controls
	{
		delete DebugConsole; // Remove BIS debug console

		class PRA3_RscDebugConsole : PRA3_RscDebugConsole {};
	};
};

class RscDisplayMPInterrupt : RscStandardDisplay
{
	class Controls
	{
		delete DebugConsole; // Remove BIS debug console

		class PRA3_RscDebugConsole : PRA3_RscDebugConsole {};
	};
};

class RscTitles
{
	class PRA3_RscDebugConsole_pinnedValues
	{
		idd = -1;
        duration = 1e+1000;
        fadeIn = 0;
        fadeOut = 0;
        name = "";
        onLoad = "uiNamespace setVariable [""PRA3_RscDebugConsole_pinnedValues"", _this select 0]";

		class ControlsBackground
		{
			class Name1 : RscText
			{
				idc = 101;
				x = "safeZoneXAbs";
				y = "safeZoneY";
				w = 0.2;
				h = 0.033;
				sizeEx = 0.033;
				text = "Name";
			};
			class Value1 : Name1
			{
				idc = 102;
				x = "safeZoneXAbs + 0.2";
				w = "(safeZoneWAbs - 0.2) * 0.8";
				font = EtelkaMonospaceProBold;
				text = "Value";
				sizeEx = 0.03;
			};

			#define __line(num) \
			class Name##num : Name1 \
			{ \
				idc = __EVAL(100 * num + 1); \
				y = safeZoneY + 0.033 * (num - 1); \
			}; \
			class Value##num : Value1 \
			{ \
				idc = __EVAL(100 * num + 2); \
				y = safeZoneY + 0.033 * (num - 1); \
			}

			__line(2);
			__line(3);
			__line(4);
			__line(5);
			__line(6);
			__line(7);
			__line(8);
			__line(9);
			__line(10);
			__line(11);
			__line(12);
			__line(13);
			__line(14);
			__line(15);
			__line(16);
			__line(17);
			__line(18);
			__line(19);
			__line(20);
			__line(21);
			__line(22);
			__line(23);
			__line(24);
			__line(25);
			__line(26);
			__line(27);
			__line(28);
			__line(29);
			__line(30);
		};
	};
};
