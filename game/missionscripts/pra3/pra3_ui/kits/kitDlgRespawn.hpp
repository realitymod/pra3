class Rsc_PRA3_kits_kitDlgRespawn
{
	idd      = -1;
	onLoad   = "uiNamespace setVariable ['Rsc_PRA3_kits_kitDlgRespawn', _this select 0]; (_this select 0) call PRA3_fnc_kitDlg_onLoad; (_this select 0) call PRA3_fnc_spawnMap_onLoad";

	#define __w1 0.5
	#define __w2 0.5

	#define __spaceX 0.01
	#define __spaceY (__spaceX / (4/3))

	#define __mapX (safeZoneX + __spaceX + __w1 + __spaceX + __spaceX)
	#define __mapW (safeZoneW - __w1 - __spaceX * 3)
	#define __mapH (safeZoneH - __spaceY * 2)

	class ControlsBackground
	{
		class TitleLeftBackground : RscText
		{
			x = safeZoneX + __spaceX;
			y = safeZoneY + __spaceY;
			w = __EVAL(__w1);
			h = 0.07;
			colorBackground[] = {0.153,0.153,0.153,1.0};
		};
		class TitleLeft : RscText
		{
			x = safeZoneX + __spaceX;
			y = safeZoneY + __spaceY + 0.01;
			w = __EVAL(__w1);
			h = 0.05;
			sizeEx = 0.05;
			text = "KIT SELECTION";
			font = "PuristaBold";
			colorText[] = {0.9,0.9,0.9,1};
			style = ST_CENTER;
			colorBackground[] = {0,0,0,0};
		};
		class BackgroundLeft : TitleLeftBackground
		{
			y = safeZoneY + __spaceY + 0.069;
			w = __EVAL(__w1);
			h = safeZoneH - __spaceY * 2 - 0.069;
			colorBackground[] = {0.1,0.1,0.1,0.8};
		};

		class BackgroundSpawn : TitleLeftBackground
		{
			idc = IDC_KITDLG_SPAWNMAP_BG;
			x = safeZoneX + __spaceX + __w1 + __spaceX;
			y = safeZoneY + __spaceY;
			w = __mapW;
			h = __mapH;
		};
		class MissionName : TitleLeft
		{
			idc = IDC_KITDLG_SPAWNMAP_MISSIONNAME;
			x = safeZoneX + __spaceX + __w1 + __spaceX + 0.03;
			w = 1;
			style = ST_LEFT;
			sizeEx = 0.04;
			text = "Debug_missionName";
		};
		class TitleSpawnTime : TitleLeft
		{
			idc = IDC_KITDLG_SPAWNMAP_SPAWNTIME;
			x = __mapX + (__mapW - __spaceX * 2 - 0.01) / 2 - 0.09;
			w = 0.18;
			style = ST_LEFT;
			text = "01:27.93";
		};
		class PlayerTeamTickets : TitleSpawnTime
		{
			idc = IDC_KITDLG_SPAWNMAP_TICKETS;
			x = __mapX + __mapW - 0.15 - __spaceX - 0.075 - __spaceX - 0.15;
			y = safeZoneY + __spaceY + 0.013;
			w = 0.15;
			style = ST_RIGHT;
			sizeEx = 0.04;
			text = "200 (-10)";
		};
		class PlayerTeamFlag : RscPicture
		{
			idc = IDC_KITDLG_SPAWNMAP_TEAMFLAG;
			x = __mapX + __mapW - 0.15 - __spaceX - 0.075;
			y = safeZoneY + __spaceY + 0.01 + 0.0050;
			// Flags should be 3:2 ratio
			w = 0.06;
			h = 0.04;
			text = "\A3\Data_F\Flags\Flag_nato_CO.paa";
		};
		class MissionTime : PlayerTeamTickets
		{
			idc = IDC_KITDLG_SPAWNMAP_MISSIONTIME;
			x = __mapX + __mapW - 0.15;
			style = ST_LEFT;
			text = "01:34:17";
			w = 0.15;
		};
	};
	class Controls
	{
		// NOTE: This cannot be in a ControlsGroup as Map is completely broken there :X
		class SpawnMap : RscMapControl
		{
			idc = IDC_KITDLG_SPAWNMAP_MAP;
			x = __mapX;
			y = safeZoneY + __spaceY + 0.07;
			w = __mapW - __spaceX * 2;
			h = __mapH - 0.07 - 0.05 - __spaceY;

			onDraw             = "_this call PRA3_fnc_spawnMap_onMapDraw";
			onMouseMoving      = "[0, _this] call PRA3_fnc_spawnMap_mapHandle";
			onMouseButtonClick = "[1, _this] call PRA3_fnc_spawnMap_mapHandle";

			text = "#(argb,8,8,3)color(1,1,1,1)";
			maxSatelliteAlpha = 1;
			alphaFadeStartScale = 100;
			alphaFadeEndScale = 100;
			scaleMin = 0.05;
			scaleMax = 0.5;
			scaleDefault = 0.3;
			colorBackground[] = {1, 1, 1, 1};
			colorSea[] = {0.467, 0.631, 0.851, 0.25};
			colorCountlines[] = {0, 0, 0, 0};
			colorMainCountlines[] = {0, 0, 0, 0};
			colorCountlinesWater[] = {0, 0, 0, 0};
			colorMainCountlinesWater[] = {0, 0, 0, 0};
			colorForest[] = {1, 1, 1, 1};
			colorRocks[] = {0, 0, 0, 0};
			colorGrid[] = {0, 0, 0, 1};
			colorGridMap[] = {0, 0, 0, 0.5};
			colorOutside[] = {
				"uiNamespace getVariable ['PRA3_respawnMapOutside_R', 0]",
				"uiNamespace getVariable ['PRA3_respawnMapOutside_G', 0]",
				"uiNamespace getVariable ['PRA3_respawnMapOutside_B', 0]",
				1
			};
			ptsPerSquareTxt = 20;
			ptsPerSquareRoad = 200;
			ptsPerSquareObj = 200;
			ptsPerSquareCLn = 200;
			ptsPerSquareCost = 200;
			ptsPerSquareFor = 200;
			ptsPerSquareForEdge = 200;
			sizeExLabel = 0;
			sizeExGrid = 0.023;
			sizeExUnits = 0;
			sizeExNames = 0;
			sizeExInfo = 0;
			sizeExLevel = 0;
			moveOnEdges = 1;
			showCountourInterval = 0;
		};
		class SpawnSelection : RscXListBox
		{
			idc = IDC_KITDLG_SPAWNMAP_SELECTION;
			x = __mapX;
			y = safeZoneY + __spaceY + __mapH - __spaceY - 0.045;
			w = __mapW - __spaceX * 2 - 0.15;
			h = 0.045;
			onLBSelChanged = "[2, _this] call PRA3_fnc_spawnMap_mapHandle";
		};
		class SpawnButtonClose : RscButton
		{
			idc = IDC_KITDLG_SPAWNMAP_CLOSE_BTN;
			x = safeZoneX + __spaceX + __w1 + __spaceX + __mapW - __spaceX - 0.15;
			y = safeZoneY + __spaceY + __mapH - __spaceY - 0.045;
			w = 0.15;
			h = 0.045;
			text = "DONE";
			action = "closeDialog 0";
		};

		class SwitchTeam1 : RscButton
		{
			idc = 500;
			x = safeZoneX + __spaceX;
			y = safeZoneY + __spaceY + 0.01 + 0.05 + 0.01;
			w = __w1 / 2 - 0.005;
			h = 0.06;
			action = "player call PRA3_fnc_switchTeam";
			default = false;
		};
		class SwitchTeam2 : SwitchTeam1
		{
			idc = 501;
			x = safeZoneX + __spaceX + __w1 / 2;
			action = "player call PRA3_fnc_switchTeam";
		};

		class SwitchTeam1Pic : RscPicture
		{
			idc = 502;
			x = safeZoneX + __spaceX + 0.005;
			y = safeZoneY + __spaceY + 0.01 + 0.05 + 0.01 + 0.01;
			// Flags should be 3:2 ratio
			w = 0.06;
			h = 0.04;
		};
		class SwitchTeam2Pic : SwitchTeam1Pic
		{
			idc = 503;
			x = safeZoneX + __spaceX + __w1 / 2 + 0.005;
		};

		class SwitchKitsBtn : SwitchTeam1
		{
			idc = IDC_KITDLG_SWITCH_KITS;
			y = safeZoneY + __spaceY + 0.01 + 0.05 + 0.01 + 0.065;
			h = 0.04;
			text = "KITS";
			action = "";
		};
		class SwitchSquadsBtn : SwitchKitsBtn
		{
			idc = IDC_KITDLG_SWITCH_SQUADS;
			x = safeZoneX + __spaceX + __w1 / 2;
			text = "SQUADS";
			action = "0 call PRA3_fnc_spawnMap_toggleTabs";
		};

		#define __h 0.11
		class KitSelection : RscControlsGroup
		{
			x = safeZoneX + __spaceX;
			y = safeZoneY + __spaceY + 0.01 + 0.05 + 0.01 + 0.04 + 0.065;
			w = __EVAL(__w1 + 0.021);
			h = __EVAL("safeZoneH - " + str(__spaceY * 2 + 0.01 + 0.05 + 0.01 + 0.04 + 0.065));

			class Controls
			{
				class Kit1 : RscControlsGroupNoScrollbars
				{
					idc = __EVAL(IDC_KITDLG_SELECTION_KIT + 100);
					x = 0.005;
					y = 0.005 * (4/3);
					w = __EVAL(__w1 - 0.005*2);
					h = __h;

					class Controls
					{
						class Background : RscText
						{
							idc = __EVAL(IDC_KITDLG_SELECTION_KIT + 101);
							x = 0;
							y = 0;
							w = __EVAL(__w1 - (0.005*2));
							h = __h;

							colorBackground[] = {0.35,0.35,0.35,0.9};
							colorBackgroundDim[] = {0.27,0.27,0.27,0.9};
							colorBackgroundHighlight[] = {0.55,0.55,0.55,0.9};
							colorBackgroundDimHighlight[] = {0.45,0.45,0.45,0.9};
						};
						class KitPic : RscPicture
						{
							idc = __EVAL(IDC_KITDLG_SELECTION_KIT + 102);
							x = 0.01;
							y = 0.01 * (4/3);
							w = __EVAL(__h / (4/3) - 0.01*2);
							h = __EVAL(__h - (0.01*2 * (4/3)));
							text = "pra3\pra3_ui\kits\kit_img\rifleman_88.paa";
							colorBackground[] = {0,0,0,0};
							colorText[] = {0.9,0.9,0.9,1.0};
						};
						class Title : RscText
						{
							idc = __EVAL(IDC_KITDLG_SELECTION_KIT + 103);
							x = __EVAL(__h / (4/3));
							y = __EVAL(0.008 * (4/3));
							w = __w1;
							h = 0.042;
							sizeEx = 0.042;
							text = "Rifleman";
							font = "PuristaSemibold";
							colorText[] = {0.9,0.9,0.9,1.0};
						};
						class Availability : Title
						{
							idc = __EVAL(IDC_KITDLG_SELECTION_KIT + 104);
							y = __EVAL(__h - 0.01 * (4/3) - 0.038 - 0.008 * (4/3));
							text = "Unlimited";
							font = "PuristaLight";
							colorText[] = {0.8,0.8,0.8,1.0};
							sizeEx = 0.038;
						};
						class SelectButton : PRA3_RscInvisibleButton
						{
							idc = __EVAL(IDC_KITDLG_SELECTION_KIT + 106);
							x = 0;
							y = 0;
							w = __EVAL(__w1 - 0.005*2 - 0.031);
							h = __h;
							action = "[0, 1] call PRA3_fnc_kitDlg_kitSelectBtn";
						};
						class DetailsButton : RscShortcutButton
						{
							idc = __EVAL(IDC_KITDLG_SELECTION_KIT + 105);
							x = __EVAL(__w1 - 0.005*2 - 0.031);
							y = 0;
							w = 0.031;
							h = __h;
							animTextureNormal	= "pra3\pra3_ui\data\button_tall_88.paa";
							animTextureDisabled	= "pra3\pra3_ui\data\button_tall_88.paa";
							animTextureOver		= "pra3\pra3_ui\data\button_tall_88.paa";
							animTextureFocused	= "pra3\pra3_ui\data\button_tall_88.paa";
							animTexturePressed	= "pra3\pra3_ui\data\button_tall_88.paa";
							animTextureDefault	= "pra3\pra3_ui\data\button_tall_88.paa";
							period = 0;
							periodFocus = 0;
							periodOver = 0;
							colorBackground[] = {1, 1, 1, 1};
							text = "<img size='1' color='#dfdfdf' image='pra3\pra3_ui\data\arrow_right.paa'/>";

							action = "[1, 1] call PRA3_fnc_kitDlg_kitSelectBtn";

							class HitZone
							{
								left = 0;
								top = 0;
								right = 0;
								bottom = 0;
							};
							class TextPos
							{
								left = 0.0;
								top = 0.0;
								right = 0.0;
								bottom = 0.0;
							};
						};
					};
				};

				#define __kit(num) \
				class Kit##num : Kit1 \
				{ \
					idc = IDC_KITDLG_SELECTION_KIT + (100 * num); \
					y = __EVAL(0.005 * (4/3) + (__h + 0.005) * (num - 1)); \
					\
					class Controls : Controls \
					{ \
						class Background : Background \
						{ \
							idc = __EVAL(IDC_KITDLG_SELECTION_KIT + num * 100 + 1); \
						}; \
						class KitPic : KitPic \
						{ \
							idc = __EVAL(IDC_KITDLG_SELECTION_KIT + num * 100 + 2); \
						}; \
						class Title : Title \
						{ \
							idc = __EVAL(IDC_KITDLG_SELECTION_KIT + num * 100 + 3); \
						}; \
						class Availability : Availability \
						{ \
							idc = __EVAL(IDC_KITDLG_SELECTION_KIT + num * 100 + 4); \
						}; \
						class SelectButton : SelectButton \
						{ \
							idc = __EVAL(IDC_KITDLG_SELECTION_KIT + num * 100 + 6); \
							action = [0, num] call PRA3_fnc_kitDlg_kitSelectBtn; \
						}; \
						class DetailsButton : DetailsButton \
						{ \
							idc = __EVAL(IDC_KITDLG_SELECTION_KIT + num * 100 + 5); \
							action = [1, num] call PRA3_fnc_kitDlg_kitSelectBtn; \
						}; \
					}; \
				}

				__kit(2);
				__kit(3);
				__kit(4);
				__kit(5);
				__kit(6);
				__kit(7);
				__kit(8);
				__kit(9);
				__kit(10);
				__kit(11);
				__kit(12);
				__kit(13);
				__kit(14);
				__kit(15);
				__kit(16);
				__kit(17);
				__kit(18);
			};
		};

		#define __h2 0.225
		#define __separatorW 0.01
		class KitDetails : KitSelection
		{
			idc = IDC_KITDLG_DETAILS;
			x = safeZoneX + __spaceX + __w1;
			w = __w2 + __separatorW;

			class Controls : Controls
			{
				class Background : RscText
				{
					idc = IDC_KITDLG_DETAILS_BG;
					x = __separatorW;
					y = 0;
					w = __EVAL(__w2);
					h = "safeZoneH - (0.01 + 0.05 + 0.01)";
					colorBackground[] = {0.1,0.1,0.1,0.8};
				};
				class Separator : Background
				{
					idc = IDC_KITDLG_DETAILS_SEP;
					x = 0;
					w = __separatorW;
					colorBackground[] = {0.153,0.153,0.153,1.0};
				};

				class Variant : RscXListBox
				{
					idc = IDC_KITDLG_DETAILS_VARIANT;
					x = __EVAL(__separatorW + 0.005);
					y = __EVAL(0.005 * (4/3));
					w = __EVAL(__w2 - 0.005*2);
					h = 0.04;
					onLBSelChanged = "_this call PRA3_fnc_kitDlg_loadoutVariantLB";
				};
				class PrimaryWeapon : Kit1
				{
					idc = IDC_KITDLG_DETAILS_PRIMARY;
					x = __EVAL(__separatorW + 0.005);
					y = __EVAL(0.04 + 0.005 * (4/3) * 2);
					w = __EVAL(__w2 - 0.005*2);
					h = __h2;

					class Controls : Controls
					{
						class Background : Background
						{
							w = __EVAL(__w2 - 0.005*2);
							h = __h2;
						};
// #define DEBUG
#ifdef DEBUG
						class WeaponPic : RscText
#else
						class WeaponPic : KitPic
#endif
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_PRIMARY + 1);
							x = __EVAL(__w2 / 2 - ((__h2 * 2) / (4/3) + 0.05) / 2);
							y = -0.03;
							w = __EVAL((__h2 * 2) / (4/3));
							h = __h2;
							text = "\A3\weapons_F\Rifles\MX\data\UI\gear_mx_rifle_X_CA.paa";
							colorText[] = {1,1,1,1};
							colorBackground[] = {1,0,0,0.5};
						};
						class Accessory1 : WeaponPic
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_PRIMARY + 11);
							x = __EVAL(__w2 / 2 - ((__h2 * 2) / (4/3) + 0.05) / 2 + (__h2 * 2) / (4/3));
							y = 0;
							w = 0.05;
							h = __EVAL(0.05 * (4/3));
							text = "\A3\weapons_F\Data\UI\gear_acco_aco_CA.paa";
						};
						class Accessory2 : Accessory1
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_PRIMARY + 12);
							y = __EVAL(0.05 * (4/3));
							text = "\A3\weapons_F\Data\UI\gear_accv_pointer_CA.paa";
						};
						class Accessory3 : Accessory1
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_PRIMARY + 13);
							y = __EVAL(0.05 * (4/3) * 2);
							text = "\A3\weapons_F\Data\UI\gear_acca_snds_h_CA.paa";
						};
						class Magazine1 : RscControlsGroupNoScrollbars
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_PRIMARY + 110);
							x = __EVAL(0.031 + 0.01 + 0.095 * 3);
							y = __EVAL(__h2 - 0.05 * (4/3));
							w = 0.095;
							h = __EVAL(0.05 * (4/3));

							class Controls
							{
								class Picture : WeaponPic
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_PRIMARY + 111);
									x = 0;
									y = 0;
									w = 0.05;
									h = __EVAL(0.05 * (4/3));
									text = "\A3\weapons_f\data\ui\m_30stanag_caseless_CA.paa";
								};
								class X : RscText
								{
									x = 0.044;
									y = __EVAL(0.05 * (4/3) - 0.037);
									h = 0.03;
									font = "PuristaSemibold";
									sizeEx = 0.03;
									colorText[] = {0.9,0.9,0.9,1.0};
									text = "x";
								};
								class Count : X
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_PRIMARY + 112);
									x = 0.054;
									y = __EVAL(0.05 * (4/3) - 0.05);
									h = 0.05;
									text = "11";
									sizeEx = 0.04;
									font = "PuristaMedium";
								};
							};
						};
						class Magazine2 : Magazine1
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_PRIMARY + 120);
							x = __EVAL(0.031 + 0.01 + 0.095 * 2);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_PRIMARY + 121);
									text = "\A3\weapons_f\data\ui\m_30stanag_caseless_red_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_PRIMARY + 122);
									text = "10";
								};
							};
						};

						class Magazine3 : Magazine1
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_PRIMARY + 130);
							x = __EVAL(0.031 + 0.01 + 0.095);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_PRIMARY + 131);
									text = "\A3\Weapons_f\Data\ui\gear_UGL_slug_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_PRIMARY + 132);
									text = "04";
								};
							};
						};
						class Magazine4 : Magazine1
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_PRIMARY + 140);
							x = __EVAL(0.031 + 0.01);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_PRIMARY + 141);
									text = "\A3\Weapons_f\Data\UI\gear_UGL_Smokeshell_red_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_PRIMARY + 142);
									text = "04";
								};
							};
						};
					};
				};
				class SecondaryWeapon : PrimaryWeapon
				{
					idc = IDC_KITDLG_DETAILS_SECONDARY;
					y = __EVAL(0.04 + __h2 + 0.005 * (4/3) * 3);

					class Controls : Controls
					{
						class Background : Background {};
						class WeaponPic : WeaponPic
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_SECONDARY + 1);
							text = "\A3\Weapons_F_Beta\Launchers\Titan\Data\UI\gear_titan_short_CA.paa";
						};
						class Magazine1 : Magazine1
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_SECONDARY + 110);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_SECONDARY + 111);
									text = "\A3\Weapons_F_beta\Launchers\titan\Data\UI\gear_titan_missile_at_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_SECONDARY + 112);
									text = "10";
								};
							};
						};
						class Magazine2 : Magazine2
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_SECONDARY + 120);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_SECONDARY + 121);
									text = "\A3\Weapons_F_beta\Launchers\titan\Data\UI\gear_titan_missile_ap_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_SECONDARY + 122);
									text = "10";
								};
							};
						};
						class Magazine3 : Magazine3
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_SECONDARY + 130);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_SECONDARY + 131);
									text = "\A3\Weapons_F_beta\Launchers\titan\Data\UI\gear_titan_missile_atl_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_SECONDARY + 132);
									text = "10";
								};
							};
						};
						class Magazine4 : Magazine4
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_SECONDARY + 140);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_SECONDARY + 141);
									text = "\A3\Weapons_F_beta\Launchers\titan\Data\UI\gear_titan_missile_atl_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_SECONDARY + 142);
									text = "10";
								};
							};
						};
					};
				};
				class Backpack : SecondaryWeapon
				{
					idc = IDC_KITDLG_DETAILS_BACKPACK;
					y = __EVAL(0.04 + __h2  * 2 + 0.005 * (4/3) * 5);
					class Controls : Controls
					{
						class Background : Background {};
						class BackpackPic : WeaponPic
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_BACKPACK + 1);
							x = __EVAL(0.031 + 0.03);
							y = 0;
							w = __EVAL(__h2 / (4/3));
							h = __h2;
							text = "\A3\Weapons_F\Ammoboxes\Bags\data\ui\backpack_CA.paa";
						};
						class Content1 : Magazine1
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_BACKPACK + 110);
							x = __EVAL(__w2 - 0.005*2 - 0.031 - 0.1 - 0.01 - 0.1);
							y = 0.005;

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_BACKPACK + 111);
									text = "\A3\weapons_f\launchers\nlaw\data\UI\gear_nlaw_rocket_ca.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_BACKPACK + 112);
									text = "01";
								};
							};
						};
						class Content2 : Content1
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_BACKPACK + 120);
							y = __EVAL(0.005 + 0.05 * (4/3) + 0.005);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_BACKPACK + 121);
									text = "\A3\weapons_f\launchers\nlaw\data\UI\gear_nlaw_rocket_ca.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_BACKPACK + 122);
									text = "01";
								};
							};
						};
						class Content3 : Content1
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_BACKPACK + 130);
							y = __EVAL(0.005 + (0.05 * (4/3) + 0.005) * 2);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_BACKPACK + 131);
									text = "\A3\weapons_f\launchers\nlaw\data\UI\gear_nlaw_rocket_ca.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_BACKPACK + 132);
									text = "01";
								};
							};
						};
						class Content4 : Content1
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_BACKPACK + 140);
							x = __EVAL(__w2 - 0.005*2 - 0.031 - 0.1 - 0.01);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_BACKPACK + 141);
									text = "\A3\weapons_f\launchers\nlaw\data\UI\gear_nlaw_rocket_ca.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_BACKPACK + 142);
									text = "01";
								};
							};
						};
						class Content5 : Content2
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_BACKPACK + 150);
							x = __EVAL(__w2 - 0.005*2 - 0.031 - 0.1 - 0.01);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_BACKPACK + 151);
									text = "\A3\weapons_f\launchers\nlaw\data\UI\gear_nlaw_rocket_ca.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_BACKPACK + 152);
									text = "01";
								};
							};
						};
						class Content6 : Content3
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_BACKPACK + 160);
							x = __EVAL(__w2 - 0.005*2 - 0.031 - 0.1 - 0.01);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_BACKPACK + 161);
									text = "\A3\weapons_f\launchers\nlaw\data\UI\gear_nlaw_rocket_ca.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_BACKPACK + 162);
									text = "01";
								};
							};
						};
					};
				};
				class Pistol : Backpack
				{
					idc = IDC_KITDLG_DETAILS_PISTOL;
					y = __EVAL(0.04 + __h2  * 3 + 0.005 * (4/3) * 6);
					h = __h;

					class Controls : Controls
					{
						class Background : Background
						{
							h = __h;
						};
						class WeaponPic : BackpackPic
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_PISTOL + 1);
							h = __h;
							text = "\A3\Weapons_F_Beta\Pistols\ACPC2\Data\UI\gear_Acpc2_X_CA.paa";
						};
						class Magazine1 : Content1
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_PISTOL + 110);
							y = __EVAL((__h / 2) - (0.05 * (4/3)) / 2);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_PISTOL + 111);
									text = "\A3\weapons_f\data\ui\M_30Rnd_9x21_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_PISTOL + 112);
									text = "03";
								};
							};
						};
						class Magazine2 : Content4
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_PISTOL + 120);
							y = __EVAL((__h / 2) - (0.05 * (4/3)) / 2);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_PISTOL + 121);
									text = "\A3\weapons_f\data\ui\M_30Rnd_9x21_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_PISTOL + 122);
									text = "03";
								};
							};
						};
					};
				};
				class Explosives : Pistol
				{
					idc = IDC_KITDLG_DETAILS_EXPLOSIVES;
					y = __EVAL(0.04 + __h2 * 3.5 + 0.005 * (4/3) * 7);

					class Controls : Controls
					{
						class Background : Background {};

						class Item1 : Magazine1
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_EXPLOSIVES + 110);
							x = __EVAL((__w2 - 0.005*2) / 2 - (0.005 / 2) - 0.1 - 0.005 - 0.1);
							y = __EVAL((__h / 2) - (0.05 * (4/3)) / 2);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_EXPLOSIVES + 111);
									text = "\A3\Weapons_F\Data\UI\gear_M67_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_EXPLOSIVES + 112);
									text = "04";
								};
							};
						};
						class Item2 : Item1
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_EXPLOSIVES + 120);
							x = __EVAL((__w2 - 0.005*2) / 2 - (0.005 / 2) - 0.1);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_EXPLOSIVES + 121);
									text = "\A3\Weapons_f\data\ui\gear_smokegrenade_white_ca.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_EXPLOSIVES + 122);
									text = "04";
								};
							};
						};
						class Item3 : Item1
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_EXPLOSIVES + 130);
							x = __EVAL((__w2 - 0.005*2) / 2 + (0.005 / 2));

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_EXPLOSIVES + 131);
									text = "\A3\Weapons_f\data\ui\gear_smokegrenade_blue_ca.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_EXPLOSIVES + 132);
									text = "01";
								};
							};
						};
						class Item4 : Item1
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_EXPLOSIVES + 140);
							x = __EVAL((__w2 - 0.005*2) / 2 + (0.005 / 2) + 0.1 + 0.005);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_EXPLOSIVES + 141);
									text = "\A3\Weapons_f\data\ui\gear_smokegrenade_green_ca.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_EXPLOSIVES + 142);
									text = "01";
								};
							};
						};
					};
				};
				class Items : Explosives
				{
					idc = IDC_KITDLG_DETAILS_ITEMS;
					y = __EVAL(0.04 + __h2 * 4 + 0.005 * (4/3) * 8);

					class Controls : Controls
					{
						class Background : Background {};

						class Item1 : Item1
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_ITEMS + 110);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_ITEMS + 111);
									text = "\A3\Weapons_F\Items\data\UI\gear_FirstAidKit_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_ITEMS + 112);
									text = "04";
								};
							};
						};
						class Item2 : Item2
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_ITEMS + 120);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_ITEMS + 121);
									text = "\A3\Weapons_F\Items\data\UI\gear_Medikit_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_ITEMS + 122);
									text = "04";
								};
							};
						};
						class Item3 : Item3
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_ITEMS + 130);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_ITEMS + 131);
									text = "\A3\Weapons_F\Items\data\UI\gear_Toolkit_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_ITEMS + 132);
									text = "01";
								};
							};
						};
						class Item4 : Item4
						{
							idc = __EVAL(IDC_KITDLG_DETAILS_ITEMS + 140);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_ITEMS + 141);
									text = "\A3\Weapons_F\Items\data\UI\gear_FirstAidKit_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = __EVAL(IDC_KITDLG_DETAILS_ITEMS + 142);
									text = "01";
								};
							};
						};
					};
				};
			};

			// Disable scrollbars
			class VScrollbar : VScrollbar
			{
				width = 0;
			};
			class HScrollbar : HScrollbar
			{
				height = 0;
			};
		};
	};
};
