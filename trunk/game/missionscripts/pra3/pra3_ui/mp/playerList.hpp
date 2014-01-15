class Rsc_PRA3_AAS_playerList
{
	idd = -1;
	name = "Rsc_PRA3_AAS_playerList";
	onLoad   = "uiNamespace setVariable [""Rsc_PRA3_AAS_playerList"", _this select 0]; (_this select 0) call PRA3_fnc_playerListDlg_onLoad;";
	movingEnable = 0;
	enableSimulation = true;
	
	#define __w1 0.5
	#define __w2 0.5

	#define __spaceX 0.01
	#define __spaceY (__spaceX / (4/3))

	#define __mapX (safeZoneX + __spaceX + __w1 + __spaceX + __spaceX)
	#define __listX (safeZoneX + __w1 + __w1)
	#define __mapW (safeZoneW - __w1 - __spaceX * 3)
	#define __mapH (safeZoneH - __spaceY * 2)

	class ControlsBackground
	{
		class PlayerListTopBackground : RscBackground
		{
			x = __listX - 0.04;
			y = safeZoneY + __spaceY + 0.36;
			w = __EVAL(__w1);
			h = 0.06;
			colorBackground[] = {0.153,0.153,0.153,1.0};
		};
		class PlayerListBottomBackground : PlayerListTopBackground
		{
			x = __listX - 0.04;
			y = safeZoneY + __spaceY + __mapH - __spaceY - 0.045 - __spaceY - 0.524;
			w = __EVAL(__w1);
			h = 0.045;
			colorBackground[] = {0.153,0.153,0.153,1.0};
		};
		class PlayerListMiddleLine : PlayerListBottomBackground
		{
			x = __listX + __w1 / 2 - 0.0025  - 0.04;
			y = safeZoneY + __spaceY + 0.42;
			w = __EVAL(0.005);
			h = 0.8;
		};
	};
	class Controls 
	{
		class PlayerListButtonClose : RscButton
		{
			idc = IDC_MPLISTDLG_OPEN_BTN;
			x = __listX + __w1 / 2 + 0.17 - 0.111;
			y = safeZoneY + __spaceY + __mapH - __spaceY - 0.045 - __spaceY - 0.524;
			w = 0.15;
			h = 0.045;
			text = "DONE";
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
		class NameTeam1 : RscText
		{
			idc = 700;
			x = __listX + 0.01 - 0.04;
			y = safeZoneY + __spaceY + 0.36;
			w = __w1 / 2;
			h = 0.06; 
			sizeEx = 0.035;
		};
		class NameTeam2 : NameTeam1
		{
			idc = 701;
			x = __listX + __w1 / 2 + 0.01 - 0.04;
		};
		class Team1Pic : RscPicture
		{
			idc = 702;
			x = __listX + 0.17 - 0.04;
			y = safeZoneY + __spaceY + 0.37;
			// Flags should be 3:2 ratio
			w = 0.06;
			h = 0.04;
		};
		class Team2Pic : Team1Pic
		{
			idc = 703;
			x = __listX + __w1 / 2 + 0.17 - 0.04;
		};
		class PlayerListBLUFOR : RscListBox 
		{
			idc = 100001;
			x = __listX - 0.04;
			y = safeZoneY + __spaceY + 0.42;
			w = __w1 / 2;
			h = 0.8;
			
			colorBackground[] = {0.1,0.1,0.1,0.5};
		};		
		class PlayerListOPFOR : RscListBox 
		{
			idc = 100002;
			x = __listX + __w1 / 2 - 0.04;
			y = safeZoneY + __spaceY + 0.42;
			w = __w1 / 2;
			h = 0.8;
			
			colorBackground[] = {0.1,0.1,0.1,0.5};
		};
	};
};
