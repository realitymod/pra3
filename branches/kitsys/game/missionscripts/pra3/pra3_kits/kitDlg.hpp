class Rsc_PRA3_kits_kitDlg
{
	idd = -1;
	//onLoad = "uiNamespace setVariable [""PRAA_Rsc_kitSysDlg"", _this select 0]; (_this select 0) call PRAA_fKitSys_dlgOpen";

	#define __w1 0.4
	#define __w2 0.5

	class ControlsBackground
	{
		class TitleBackground : RscText
		{
			x = safeZoneX;
			y = safeZoneY;
			w = __EVAL(__w1 + __w2 + 0.021);
			h = 0.07;
			colorBackground[] = {0.153,0.153,0.153,1.0};
		};
		class Title : RscText
		{
			x = safeZoneX + 0.01 / (4/3);
			y = safeZoneY + 0.01;
			w = __EVAL(__w1 + __w2 + 0.021);
			h = 0.05;
			sizeEx = 0.05;
			text = "KIT SELECTION";
			font = "PuristaBold";
			colorText[] = {0.9,0.9,0.9,1};
			style = ST_CENTER;
			colorBackground[] = {0,0,0,0};
		};
		class Background : TitleBackground
		{
			y = safeZoneY + 0.069;
			w = __EVAL(__w1 + __w2 + 0.021);
			h = safeZoneH - 0.069;
			colorBackground[] = {0.1,0.1,0.1,0.8};
		};

		class SpaceBackground : TitleBackground
		{
			x = safeZoneX + __w1;
			y = safeZoneY + 0.069;
			w = 0.021;
			h = safeZoneH - 0.069;
		};
	};
	class Controls
	{
		#define __h 0.11
		class KitSelection : RscControlsGroup
		{
			x = "safeZoneX";
			y = "safeZoneY + 0.01 + 0.05 + 0.01";
			w = __EVAL(__w1 + 0.021);
			h = "safeZoneH - (0.01 + 0.05 + 0.01)";

			class Controls
			{
				class Kit1 : RscControlsGroupNoScrollbars
				{
					idc = 10100;
					x = 0.005;
					y = 0.005 * (4/3);
					w = __EVAL(__w1 - 0.005*2);
					h = __h;

					class Controls
					{
						class Background : RscText
						{
							idc = 10101;
							x = 0;
							y = 0;
							w = __EVAL(__w1 - (0.005*2));
							h = __h;

							colorBackground[] = {0.35,0.35,0.35,0.9};
							//colorBackgroundDim[] = {0.25,0.25,0.25,0.9};
							colorBackgroundHighlight[] = {0.55,0.55,0.55,0.9};
						};
						class KitPic : RscPicture
						{
							idc = 10102;
							x = 0.01;
							y = 0.01 * (4/3);
							w = __EVAL(__h / (4/3) - 0.01*2);
							h = __EVAL(__h - (0.01*2 * (4/3)));
							text = "pra3\pra3_kits\data\kit_img\rifleman_88.paa";
							colorBackground[] = {1,0,0,1};
							colorText[] = {0.9,0.9,0.9,1.0};
							//colorTextDim[] = {0.5,0.5,0.5,1.0};
							colorTextHighlight[] = {1.0,1.0,1.0,1.0};
						};
						class Title : RscText
						{
							idc = 10103;
							x = __EVAL(__h / (4/3));
							y = __EVAL(0.008 * (4/3));
							w = __w1;
							h = 0.042;
							sizeEx = 0.042;
							text = "Rifleman";
							font = "PuristaSemibold";
							colorText[] = {0.9,0.9,0.9,1.0};
							//colorTextDim[] = {0.5,0.5,0.5,1.0};
							colorTextHighlight[] = {1.0,1.0,1.0,1.0};
						};
						class Availability : Title
						{
							idc = 10104;
							y = __EVAL(__h - 0.01 * (4/3) - 0.038 - 0.008 * (4/3));
							text = "Unlimited";
							font = "PuristaLight";
							colorText[] = {0.8,0.8,0.8,1.0};
							//colorTextDim[] = {0.4,0.4,0.4,1.0};
							colorTextHighlight[] = {0.9,0.9,0.9,1.0};
							sizeEx = 0.038;
						};
						class Button : RscShortcutButton
						{
							idc = 10105;
							x = __EVAL(__w1 - 0.005*2 - 0.031);
							y = 0;
							w = 0.031;
							h = __h;
							animTextureNormal	= "pra3\pra3_kits\data\button_88.paa";
							animTextureDisabled	= "pra3\pra3_kits\data\button_88.paa";
							animTextureOver		= "pra3\pra3_kits\data\button_88.paa";
							animTextureFocused	= "pra3\pra3_kits\data\button_88.paa";
							animTexturePressed	= "pra3\pra3_kits\data\button_88.paa";
							animTextureDefault	= "pra3\pra3_kits\data\button_88.paa";
							period = 0;
							periodFocus = 0;
							periodOver = 0;
							colorBackground[] = {1, 1, 1, 1};
							text = "<img size='1' color='#dfdfdf' image='pra3\pra3_kits\data\arrow_right.paa'/>";

							action = "1 call PRAA_fKitSys_dlgKitButtonAction";

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

				#define __kit(num,name,pic,avail) \
				class Kit##num : Kit1 \
				{ \
					idc = 10000 + (100 * num); \
					y = __EVAL(0.005 * (4/3) + (__h + 0.005) * (num - 1)); \
					\
					class Controls : Controls \
					{ \
						class Background : Background \
						{ \
							idc = __EVAL(10000 + num * 100 + 1); \
						}; \
						class KitPic : KitPic \
						{ \
							idc = __EVAL(10000 + num * 100 + 2); \
							text = pic; \
						}; \
						class Title : Title \
						{ \
							idc = __EVAL(10000 + num * 100 + 3); \
							text = name; \
						}; \
						class Availability : Availability \
						{ \
							idc = __EVAL(10000 + num * 100 + 4); \
							text = avail; \
						}; \
						class Button : Button \
						{ \
							idc = __EVAL(10000 + num * 100 + 5); \
							action = num call PRAA_fKitSys_dlgKitButtonAction; \
						}; \
					}; \
				}

				__kit(2,"Squad Leader","pra3\pra3_kits\data\kit_img\rifleman_88.paa","Must be squad leader");
				__kit(3,"Combat Medic","pra3\pra3_kits\data\kit_img\medic_88.paa","4/10");
				__kit(4,"Automatic Rifleman","pra3\pra3_kits\data\kit_img\rifleman_88.paa","2/10");
				__kit(5,"Grenadier","pra3\pra3_kits\data\kit_img\rifleman_88.paa","3/5");
				__kit(6,"Light Anti-Tank","pra3\pra3_kits\data\kit_img\rifleman_88.paa","0/4");
				__kit(7,"Heavy Anti-Tank","pra3\pra3_kits\data\kit_img\rifleman_88.paa","1/2");
				__kit(8,"Anti-Air","pra3\pra3_kits\data\kit_img\rifleman_88.paa","2/2");
				__kit(9,"Marksman","pra3\pra3_kits\data\kit_img\rifleman_88.paa","3/6");
				__kit(10,"Combat Engineer","pra3\pra3_kits\data\kit_img\rifleman_88.paa","1/5");
				__kit(11,"Sniper","pra3\pra3_kits\data\kit_img\rifleman_88.paa","1/2");
				__kit(12,"Spotter","pra3\pra3_kits\data\kit_img\rifleman_88.paa","1/2");
			};
		};

		#define __h2 0.225
		class KitDetails : KitSelection
		{
			x = safeZoneX + __w1 + 0.021;
			w = __w2;

			class Controls : Controls
			{
				class Variant : RscXListBox
				{
					idc = 20001;
					x = 0.005;
					y = __EVAL(0.005 * (4/3));
					w = __EVAL(__w2 - 0.005*2);
					h = 0.04;
					onLBSelChanged = "_this call PRAA_fKitSys_dlgLoadoutVariantLB";
				};
				class PrimaryWeapon : Kit1
				{
					idc = 21000;
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
							idc = 21001;
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
							idc = 21011;
							x = __EVAL(__w2 / 2 - ((__h2 * 2) / (4/3) + 0.05) / 2 + (__h2 * 2) / (4/3));
							y = 0;
							w = 0.05;
							h = __EVAL(0.05 * (4/3));
							text = "\A3\weapons_F\Data\UI\gear_acco_aco_CA.paa";
						};
						class Accessory2 : Accessory1
						{
							idc = 21012;
							y = __EVAL(0.05 * (4/3));
							text = "\A3\weapons_F\Data\UI\gear_accv_pointer_CA.paa";
						};
						class Accessory3 : Accessory1
						{
							idc = 21013;
							y = __EVAL(0.05 * (4/3) * 2);
							text = "\A3\weapons_F\Data\UI\gear_acca_snds_h_CA.paa";
						};
						class Magazine1 : RscControlsGroupNoScrollbars
						{
							idc = 21110;
							x = __EVAL(0.031 + 0.01 + 0.095 * 3);
							y = __EVAL(__h2 - 0.05 * (4/3));
							w = 0.095;
							h = __EVAL(0.05 * (4/3));

							class Controls
							{
								class Picture : WeaponPic
								{
									idc = 21111;
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
									idc = 21112;
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
							idc = 21120;
							x = __EVAL(0.031 + 0.01 + 0.095 * 2);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 21121;
									text = "\A3\weapons_f\data\ui\m_30stanag_caseless_red_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 21122;
									text = "10";
								};
							};
						};

						class Magazine3 : Magazine1
						{
							idc = 21130;
							x = __EVAL(0.031 + 0.01 + 0.095);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 21131;
									text = "\A3\Weapons_f\Data\ui\gear_UGL_slug_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 21132;
									text = "04";
								};
							};
						};
						class Magazine4 : Magazine1
						{
							idc = 21140;
							x = __EVAL(0.031 + 0.01);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 21141;
									text = "\A3\Weapons_f\Data\UI\gear_UGL_Smokeshell_red_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 21142;
									text = "04";
								};
							};
						};
					};
				};
				class SecondaryWeapon : PrimaryWeapon
				{
					idc = 22000;
					y = __EVAL(0.04 + __h2 + 0.005 * (4/3) * 3);

					class Controls : Controls
					{
						class Background : Background {};
						class WeaponPic : WeaponPic
						{
							idc = 22001;
							text = "\A3\Weapons_F_Beta\Launchers\Titan\Data\UI\gear_titan_short_CA.paa";
						};
						class Magazine1 : Magazine1
						{
							idc = 22110;

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 22111;
									text = "\A3\Weapons_F_beta\Launchers\titan\Data\UI\gear_titan_missile_at_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 22112;
									text = "10";
								};
							};
						};
						class Magazine2 : Magazine2
						{
							idc = 22120;

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 22121;
									text = "\A3\Weapons_F_beta\Launchers\titan\Data\UI\gear_titan_missile_ap_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 22122;
									text = "10";
								};
							};
						};
						class Magazine3 : Magazine3
						{
							idc = 22130;

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 22131;
									text = "\A3\Weapons_F_beta\Launchers\titan\Data\UI\gear_titan_missile_atl_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 22132;
									text = "10";
								};
							};
						};
						class Magazine4 : Magazine4
						{
							idc = 22140;

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 22141;
									text = "\A3\Weapons_F_beta\Launchers\titan\Data\UI\gear_titan_missile_atl_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 22142;
									text = "10";
								};
							};
						};
					};
				};
				class SecondaryBackpack : SecondaryWeapon
				{
					idc = 23000;
					class Controls : Controls
					{
						class Background : Background {};
						class BackpackPic : WeaponPic
						{
							idc = 23001;
							x = __EVAL(0.031 + 0.03);
							y = 0;
							w = __EVAL(__h2 / (4/3));
							h = __h2;
							text = "\A3\Weapons_F\Ammoboxes\Bags\data\ui\backpack_CA.paa";
						};
						class Content1 : Magazine1
						{
							idc = 23110;
							x = __EVAL(__w2 - 0.005*2 - 0.031 - 0.1 - 0.01 - 0.1);
							y = 0.005;

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 23111;
									text = "\A3\weapons_f\launchers\nlaw\data\UI\gear_nlaw_rocket_ca.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 23112;
									text = "01";
								};
							};
						};
						class Content2 : Content1
						{
							idc = 23120;
							y = __EVAL(0.005 + 0.05 * (4/3) + 0.005);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 23121;
									text = "\A3\weapons_f\launchers\nlaw\data\UI\gear_nlaw_rocket_ca.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 23122;
									text = "01";
								};
							};
						};
						class Content3 : Content1
						{
							idc = 23130;
							y = __EVAL(0.005 + (0.05 * (4/3) + 0.005) * 2);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 23131;
									text = "\A3\weapons_f\launchers\nlaw\data\UI\gear_nlaw_rocket_ca.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 23132;
									text = "01";
								};
							};
						};
						class Content4 : Content1
						{
							idc = 23140;
							x = __EVAL(__w2 - 0.005*2 - 0.031 - 0.1 - 0.01);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 23141;
									text = "\A3\weapons_f\launchers\nlaw\data\UI\gear_nlaw_rocket_ca.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 23142;
									text = "01";
								};
							};
						};
						class Content5 : Content2
						{
							idc = 23150;
							x = __EVAL(__w2 - 0.005*2 - 0.031 - 0.1 - 0.01);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 23151;
									text = "\A3\weapons_f\launchers\nlaw\data\UI\gear_nlaw_rocket_ca.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 23152;
									text = "01";
								};
							};
						};
						class Content6 : Content3
						{
							idc = 23160;
							x = __EVAL(__w2 - 0.005*2 - 0.031 - 0.1 - 0.01);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 23161;
									text = "\A3\weapons_f\launchers\nlaw\data\UI\gear_nlaw_rocket_ca.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 23162;
									text = "01";
								};
							};
						};
					};
				};
				class Pistol : SecondaryBackpack
				{
					idc = 24000;
					y = __EVAL(0.04 + __h2  * 2 + 0.005 * (4/3) * 4);
					h = __h;

					class Controls : Controls
					{
						class Background : Background
						{
							h = __h;
						};
						class WeaponPic : BackpackPic
						{
							idc = 24001;
							h = __h;
							text = "\A3\Weapons_F_Beta\Pistols\ACPC2\Data\UI\gear_Acpc2_X_CA.paa";
						};
						class Magazine1 : Content1
						{
							idc = 24110;
							y = __EVAL((__h / 2) - (0.05 * (4/3)) / 2);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 24111;
									text = "\A3\weapons_f\data\ui\M_30Rnd_9x21_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 24112;
									text = "03";
								};
							};
						};
						class Magazine2 : Content4
						{
							idc = 24120;
							y = __EVAL((__h / 2) - (0.05 * (4/3)) / 2);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 24121;
									text = "\A3\weapons_f\data\ui\M_30Rnd_9x21_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 24122;
									text = "03";
								};
							};
						};
					};
				};
				class Explosives : Pistol
				{
					idc = 25000;
					y = __EVAL(0.04 + __h2 * 2.5 + 0.005 * (4/3) * 5);

					class Controls : Controls
					{
						class Background : Background {};

						class Item1 : Magazine1
						{
							idc = 25110;
							x = __EVAL((__w2 - 0.005*2) / 2 - (0.005 / 2) - 0.1 - 0.005 - 0.1);
							y = __EVAL((__h / 2) - (0.05 * (4/3)) / 2);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 25111;
									text = "\A3\Weapons_F\Data\UI\gear_M67_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 25112;
									text = "04";
								};
							};
						};
						class Item2 : Item1
						{
							idc = 25120;
							x = __EVAL((__w2 - 0.005*2) / 2 - (0.005 / 2) - 0.1);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 25121;
									text = "\A3\Weapons_f\data\ui\gear_smokegrenade_white_ca.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 25122;
									text = "04";
								};
							};
						};
						class Item3 : Item1
						{
							idc = 25130;
							x = __EVAL((__w2 - 0.005*2) / 2 + (0.005 / 2));

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 25131;
									text = "\A3\Weapons_f\data\ui\gear_smokegrenade_blue_ca.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 25132;
									text = "01";
								};
							};
						};
						class Item4 : Item1
						{
							idc = 25140;
							x = __EVAL((__w2 - 0.005*2) / 2 + (0.005 / 2) + 0.1 + 0.005);

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 25141;
									text = "\A3\Weapons_f\data\ui\gear_smokegrenade_green_ca.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 25142;
									text = "01";
								};
							};
						};
					};
				};
				class Medical : Explosives
				{
					idc = 26000;
					y = __EVAL(0.04 + __h2 * 3 + 0.005 * (4/3) * 6);

					class Controls : Controls
					{
						class Background : Background {};

						class Item1 : Item1
						{
							idc = 26110;

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 26111;
									text = "\A3\Weapons_F\Items\data\UI\gear_FirstAidKit_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 26112;
									text = "04";
								};
							};
						};
						class Item2 : Item2
						{
							idc = 26120;

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 26121;
									text = "\A3\Weapons_F\Items\data\UI\gear_Medikit_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 26122;
									text = "04";
								};
							};
						};
						class Item3 : Item3
						{
							idc = 26130;

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 26131;
									text = "\A3\Weapons_F\Items\data\UI\gear_Toolkit_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 26132;
									text = "01";
								};
							};
						};
						class Item4 : Item4
						{
							idc = 26140;

							class Controls : Controls
							{
								class Picture : Picture
								{
									idc = 26141;
									text = "\A3\Weapons_F\Items\data\UI\gear_FirstAidKit_CA.paa";
								};
								class X : X {};
								class Count : Count
								{
									idc = 26142;
									text = "01";
								};
							};
						};
					};
				};

				class Button : RscButton
				{
					idc = 27000;
					x = __EVAL(__w2 / 2 - 0.35 / 2);
					y = __EVAL(0.04 + __h2 * 3.5 + 0.005 * (4/3) * 7);
					w = 0.35;
					h = __EVAL(__h / 2);

					font = "PuristaBold";

					action = "call PRAA_fKitSys_dlgRequestButtonAction";

					text = "Request kit";
				};
			};
		};
	};
};
