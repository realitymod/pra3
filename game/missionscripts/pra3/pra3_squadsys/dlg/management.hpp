#define ST_POS					0x0F
#define ST_HPOS					0x03
#define ST_VPOS					0x0C
#define ST_LEFT					0x00
#define ST_RIGHT				0x01
#define ST_CENTER				0x02
#define ST_DOWN					0x04
#define ST_UP					0x08
#define ST_VCENTER				0x0c

#define ST_TYPE					0xF0
#define ST_SINGLE				0
#define ST_MULTI				16
#define ST_TITLE_BAR			32
#define ST_PICTURE				48
#define ST_FRAME				64
#define ST_BACKGROUND			80
#define ST_GROUP_BOX			96
#define ST_GROUP_BOX2			112
#define ST_HUD_BACKGROUND		128
#define ST_TILE_PICTURE			144
#define ST_WITH_RECT			160
#define ST_LINE					176

#define ST_SHADOW				0x100
#define ST_NO_RECT				0x200 // this style works for CT_STATIC in conjunction with ST_MULTI
#define ST_KEEP_ASPECT_RATIO	0x800

#define ST_TITLE				ST_TITLE_BAR + ST_CENTER

// Slider styles
#define SL_DIR					0x400
#define SL_VERT					0
#define SL_HORZ					0x400

#define SL_TEXTURES				0x10

// Listbox styles
#define LB_TEXTURES				0x10
#define LB_MULTI				0x20

#define FontM					"Zeppelin32"


#define __colorText {0.85, 0.85, 0.85, 1.0} //Replaces {0.4, 0.6745, 0.2784, 1.0}
#define __colorSilverTransp {0.75, 0.75, 0.75, 0.75}

#include "\a3\ui_f\hpp\defineCommonColors.inc"

// ----------------------------------------------------------------------------------------------------------------------- //

class PRA3_RscPopupMenu : RscControlsGroupNoScrollbars
{
	x = 0;
	y = 0;
	w = 0.22;
	h = 0.4;

	class Controls
	{
		class Item1 : RscButton
		{
			idc = __EVAL(100 + 1);
			x = 0;
			y = 0;
			w = 0.22;
			h = 0.036;
			style = ST_LEFT;
			text = "Item1";
		};
		#define __item(num) \
		class Item##num : Item1 \
		{ \
			idc = __EVAL(100 + 1*num); \
			y = 0.04 * (num-1); \
			text = Item##num; \
		};
		__item(2);
		__item(3);
		__item(4);
		__item(5);
		__item(6);
		__item(7);
		__item(8);
		__item(9);
		__item(10);
		#undef __item
	};
};

class Rsc_PRA3_squadSys_manageDlg
{
	idd = -1;
	movingEnable = false;
	enableSimulation = true;
	onLoad = "uiNamespace setVariable [""Rsc_PRA3_squadSys_manageDlg"", _this select 0]; (_this select 0) call PRA3_fnc_squadDlg_onLoad";

	#define __w 0.5

	class ControlsBackground
	{
		class Background : RscText
		{
			x = "safeZoneX";
			y = "safeZoneY";
			w = __w;
			h = "safeZoneH";
			colorBackground[] = {0.1,0.1,0.1,0.8};
		};
		class TitleBackground : Background
		{
			colorBackground[] = {0.1,0.1,0.1,0.8};
			h = 0.07;
		};
		class Title : RscText
		{
			x = "safeZoneX";
			y = "safeZoneY + 0.01";
			w = __w;
			h = 0.05;
			sizeEx = 0.05;
			text = "Squad management";
			font = "PuristaSemibold";
			colorText[] = {1,1,1,1};
			style = ST_CENTER;
		};
		class CreateSquadBackground : TitleBackground
		{
			y = safeZoneY + safeZoneH - 0.05;
			h = 0.05;
		};
	};
	class Controls
	{
		class Group : RscControlsGroup
		{
			idc = 1;
			x = "safeZoneX";
			y = "safeZoneY + 0.01 + 0.05 + 0.01";
			w = __w;
			h = "safeZoneH - (0.01 + 0.05 + 0.01 + 0.05)";
			onMouseButtonDown = "["""", _this] call PRA3_fnc_squadDlg_onMouseClick";
			onMouseMoving = "-1 call PRA3_fnc_squadDlg_onMouseMoving";

			class Controls
			{
				#define __lbItems 8
				#define __lbH 0.032
				#define __grpW 0.47
				#define __grpH (__lbH*__lbItems + 0.05)

				class ItemSquad01 : RscControlsGroupNoScrollbars
				{
					idc = 10000;
					x = 0.005;
					y = __grpH;
					w = __grpW;
					h = __grpH;

					class Controls
					{
						class Background : RscText
						{
							idc = __EVAL(10000 + 1000);
							x = 0;
							y = 0;
							w = __grpW;
							h = __grpH;
							colorBackground[] = {0.3,0.3,0.3,0.8};
						};
						class HeaderBackground : Background
						{
							h = 0.05;
							colorBackground[] = {0.1,0.1,0.1,1};
						};
						class Name : RscText
						{
							x = 0;
							y = 0.002;
							w = 0.11;
							h = 0.05;
							sizeEx = 0.034;
							colorText[] = {1,1,1,1};
							text = "Alpha";
						};
						class NameCustom : Name
						{
							idc = __EVAL(10000 + 3001);
							x = 0.10;
							y = 0.0025;
							w = __EVAL(( __grpW - (0.04+0.005)/(4/3) - 0.09 - 0.005 - (0.04)/(4/3) - 0.005 - 0.05) - 0.10 + 0.005);
							colorText[] = __colorText;
							sizeEx = 0.032;
							text = "AAAAAAAAAAAAAAA";
							style = ST_RIGHT;
						};

						class Size : Name
						{
							idc = __EVAL(10000 + 4000);
							x = __EVAL(__grpW - (0.04+0.005)/(4/3) - 0.09 - 0.005 - (0.04)/(4/3) - 0.005 - 0.05);
							y = 0.002;
							w = 0.05;
							style = ST_CENTER;
							sizeEx = 0.034;
							text = "15/16";
						};

						class LockPicture : RscPicture
						{
							idc = __EVAL(10000 + 5001);
							x = __EVAL(__grpW - (0.04+0.005)/(4/3) - 0.09 - 0.005 - (0.04)/(4/3) - 0.005);
							y = 0.005;
							w = __EVAL(0.04/(4/3));
							h = 0.04;
							text = "pra3\pra3_squadsys\dlg\img\unlocked_88.paa";
						};

						class ActionButton : RscShortcutButton
						{
							idc = __EVAL(10000 + 6000);
							x = __EVAL(__grpW - (0.04+0.005)/(4/3) - 0.09 - 0.005);
							y = 0.005;
							w = 0.09;
							h = 0.04;
							text = "Request";
							colorText[] = __colorText;
							action = "1 call PRA3_fnc_squadDlg_actionButton";
							sizeEx = 0.034;
							size = 0.034;

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

						class CollapserPicture : LockPicture
						{
							idc = __EVAL(10000 + 7001);
							x = __EVAL(__grpW - (0.04+0.005)/(4/3));
							text = "pra3\pra3_squadsys\dlg\img\arrow_down_88.paa";
						};
						class CollapserButton : RscButton
						{
							idc = __EVAL(10000 + 7002);
							x = __EVAL(__grpW - (0.04+0.005)/(4/3));
							y = 0.005;
							w = __EVAL(0.04/(4/3));
							h = 0.04;
							action = "1 call PRA3_fnc_squadDlg_toggleCollapseSquad";

							colorDisabled[] = {0,0,0,0};
							colorBackground[] = {0,0,0,0};
							colorBackgroundActive[] = {0,0,0,0};
							colorBackgroundDisabled[] = {0,0,0,0};
							colorFocused[] = {0,0,0,0};
							colorShadow[] = {0,0,0,0};
							colorBorder[] = {0,0,0,0};
						};

						class MembersList : RscControlsGroupNoScrollbars
						{
							idc = __EVAL(10000 + 8000);
							x = 0;
							y = 0.05;
							w = __grpW;
							h = __EVAL(__lbH * __lbItems);

							class Controls
							{
								class Line01 : RscControlsGroup
								{
									idc = __EVAL(10000 + 8000 + 10);
									x = 0;
									y = 0;
									w = __grpW;
									h = __lbH;

									class Controls
									{
										class Background : RscText
										{
											idc = __EVAL(10000 + 8000 + 10 + 6);
											x = 0;
											y = 0;
											w = __grpW;
											h = __lbH;
											colorBackground[] = {0.8, 0.8, 0.8, 0};
											colorBackgroundHighlight[] = {0.8, 0.8, 0.8, 0.3};
										};
										class VehiclePic : RscPicture
										{
											idc = __EVAL(10000 + 8000 + 10 + 1);
											x = 0;
											y = 0;
											w = __EVAL((__lbH - 0.002) / (4/3));
											h = __EVAL(__lbH - 0.002);
											text = "";
										};
										class KitPic : VehiclePic
										{
											idc = __EVAL(10000 + 8000 + 10 + 2);
											x = 0.02;
											text = "";
										};
										class Name : RscText
										{
											idc = __EVAL(10000 + 8000 + 10 + 3);
											x = 0.04;
											y = 0;
											w = __EVAL(__grpW - 2*0.02);
											h = __EVAL(__lbH);
											sizeEx = __EVAL(__lbH);
											text = "Nameless Mook";
											colorTextHighlighted[] = {1,1,1,1};
											font = "PuristaMedium";
											fontHighlighted = "PuristaSemibold";
										};
										class RoleText : Name
										{
											style = ST_CENTER;
											x = __EVAL(__grpW - (__lbH - 0.002) / (4/3) - 0.005);
											idc = __EVAL(10000 + 8000 + 10 + 5);
											w = __EVAL((__lbH - 0.002) / (4/3));
											h = __EVAL(__lbH - 0.002);
											colorBackground[] = {0.6,0.6,0.6,1};
											sizeEx = (__lbH - 0.002);
											font = "PuristaBold";
											text = "A";
										};
									};
								};
								#define __line(num) \
								class Line##num : Line01 \
								{ \
									idc = __EVAL(10000 + 8000 + 10*num); \
									y = __EVAL(__lbH*(num-1)); \
									class Controls : Controls \
									{ \
										class Background : Background \
										{ \
											idc = __EVAL(10000 + 8000 + 10*num + 6); \
										}; \
										class VehiclePic : VehiclePic \
										{ \
											idc = __EVAL(10000 + 8000 + 10*num + 1); \
										}; \
										class KitPic : KitPic \
										{ \
											idc = __EVAL(10000 + 8000 + 10*num + 2); \
										}; \
										class Name : Name \
										{ \
											idc = __EVAL(10000 + 8000 + 10*num + 3); \
										}; \
										class RoleText : RoleText \
										{ \
											idc = __EVAL(10000 + 8000 + 10*num + 5); \
										}; \
									}; \
								}
								__line(02);
								__line(03);
								__line(04);
								__line(05);
								__line(06);
								__line(07);
								__line(08);
								__line(09);
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
							};
						};
					};
				};

				/* Used by the define below to inherit individual lines and change their IDCs */
								#define __lineUpdate(num1,num2) \
								class Line##num2 : Line##num2 \
								{ \
									idc = __EVAL(10000*num1 + 8000 + 10*num2); \
									onMouseButtonDown = ""; \
									onMouseMoving = ""; \
									class Controls : Controls \
									{ \
										class VehiclePic : VehiclePic \
										{ \
											idc = __EVAL(10000*num1 + 8000 + 10*num2 + 1); \
										}; \
										class KitPic : KitPic \
										{ \
											idc = __EVAL(10000*num1 + 8000 + 10*num2 + 2); \
										}; \
										class Name : Name \
										{ \
											idc = __EVAL(10000*num1 + 8000 + 10*num2 + 3); \
										}; \
										class RoleText : RoleText \
										{ \
											idc = __EVAL(10000*num1 + 8000 + 10*num2 + 5); \
										}; \
									}; \
								}

				#define __itemSquad(num,phonetic) \
				class ItemSquad##num : ItemSquad01 \
				{ \
					idc = __EVAL(10000*num); \
					y = __EVAL(num * __grpH); \
					class Controls : Controls \
					{ \
						class Background : Background \
						{ \
							idc = __EVAL(10000*num + 1000); \
						}; \
						class HeaderBackground : HeaderBackground \
						{ \
						}; \
						class Name : Name \
						{ \
							text = phonetic; \
						}; \
						class NameCustom : NameCustom \
						{ \
							idc = __EVAL(10000*num + 3001); \
						}; \
						class Size : Size \
						{ \
							idc = __EVAL(10000*num + 4000); \
						}; \
						class LockPicture : LockPicture \
						{ \
							idc = __EVAL(10000*num + 5001); \
						}; \
						class ActionButton : ActionButton \
						{ \
							idc = __EVAL(10000*num + 6000); \
							action = #(##num call PRA3_fnc_squadDlg_actionButton); \
						}; \
						class CollapserPicture : CollapserPicture \
						{ \
							idc = __EVAL(10000*num + 7001); \
						}; \
						class CollapserButton : CollapserButton \
						{ \
							idc = __EVAL(10000*num + 7002); \
							action = #(##num call PRA3_fnc_squadDlg_toggleCollapseSquad); \
						}; \
						class MembersList : MembersList \
						{ \
							idc = __EVAL(10000*num + 8000); \
							class Controls : Controls \
							{ \
								__lineUpdate(num,01); \
								__lineUpdate(num,02); \
								__lineUpdate(num,03); \
								__lineUpdate(num,04); \
								__lineUpdate(num,05); \
								__lineUpdate(num,06); \
								__lineUpdate(num,07); \
								__lineUpdate(num,08); \
								__lineUpdate(num,09); \
								__lineUpdate(num,10); \
								__lineUpdate(num,11); \
								__lineUpdate(num,12); \
								__lineUpdate(num,13); \
								__lineUpdate(num,14); \
								__lineUpdate(num,15); \
								__lineUpdate(num,16); \
								__lineUpdate(num,17); \
								__lineUpdate(num,18); \
								__lineUpdate(num,19); \
								__lineUpdate(num,20); \
							}; \
						}; \
					}; \
				}

				__itemSquad(02, "Bravo");
				__itemSquad(03, "Charlie");
				__itemSquad(04, "Delta");
				__itemSquad(05, "Echo");
				__itemSquad(06, "Foxtrot");
				__itemSquad(07, "Golf");
				__itemSquad(08, "Hotel");
				__itemSquad(09, "India");

				__itemSquad(10, "Juliet");
				__itemSquad(11, "Kilo");
				__itemSquad(12, "Lima");
				__itemSquad(13, "Mike");
				__itemSquad(14, "November");
				__itemSquad(15, "Oscar");
				__itemSquad(16, "Papa");
				__itemSquad(17, "Quebec");
				__itemSquad(18, "Romeo");
				__itemSquad(19, "Sierra");

				__itemSquad(20, "Tango");
				__itemSquad(21, "Uniform");
				__itemSquad(22, "Victor");
				__itemSquad(23, "Whiskey");
				__itemSquad(24, "X-ray");
				__itemSquad(25, "Yankee");
				__itemSquad(26, "Zulu");

				class ItemSquadPlayer : ItemSquad01
				{
					idc = 500000;
					y = 0.0;

					class Controls : Controls
					{
						class Background : Background
						{
							idc = __EVAL(500000 + 1000);
						};
						class HeaderBackground : HeaderBackground
						{
						};
						class Name : Name
						{
							idc = __EVAL(500000 + 2000);
						};
						class NameCustom : NameCustom
						{
							idc = __EVAL(500000 + 3001);
						};
						class NameCustomAction : RscActiveText
						{
							idc = __EVAL(500000 + 3002);
							x = 0.10;
							y = 0.00;
							w = __EVAL((__grpW - (0.04+0.005)/(4/3) - 0.09 - 0.005 - (0.04)/(4/3) - 0.005 - 0.05) - 0.10 + 0.005);
							h = 0.05;
							sizeEx = 0.032;
							style = ST_RIGHT;
							text = "Infantry ENG";
							action = "[0] call PRA3_fnc_squadDlg_customName";
						};
						class NameCustomEdit : RscEdit
						{
							idc = __EVAL(500000 + 3003);
							x = 0.10;
							y = 0.001;
							w = __EVAL(( __grpW - (0.04+0.005)/(4/3) - 0.09 - 0.005 - (0.04)/(4/3) - 0.005 - 0.05) - 0.10 + 0.005);
							h = 0.048;
							sizeEx = 0.032;
							style = ST_RIGHT + ST_FRAME;
							text = "Infantry ENG";
							onChar = "[1, _this] call PRA3_fnc_squadDlg_customName";
							onKeyDown = "[2, _this] call PRA3_fnc_squadDlg_customName";
						};

						class Size : Size
						{
							idc = __EVAL(500000 + 4000);
						};

						class LockPicture : LockPicture
						{
							idc = __EVAL(500000 + 5001);
						};
						class LockButton : CollapserButton
						{
							idc = __EVAL(500000 + 5002);
							x = __EVAL(__grpW - (0.04+0.005)/(4/3) - 0.09 - 0.005 - (0.04)/(4/3) - 0.005);
							action = "call PRA3_fnc_squadDlg_lockSquad";
						};

						class ActionButton : ActionButton
						{
							idc = __EVAL(500000 + 6000);
							action = "0 call PRA3_fnc_squadDlg_actionButton";
						};

						class CollapserPicture : CollapserPicture
						{
							idc = __EVAL(500000 + 7001);
						};
						class CollapserButton : CollapserButton
						{
							idc = __EVAL(500000 + 7002);
							action = "0 call PRA3_fnc_squadDlg_toggleCollapseSquad";
						};

						class MembersList : MembersList
						{
							idc = __EVAL(500000 + 8000);

							class Controls : Controls
							{
								#define __lineUpdate(num) \
								class Line##num : Line##num \
								{ \
									idc = __EVAL(500000 + 8000 + 10*num); \
									onMouseMoving = (( num - 1) call PRA3_fnc_squadDlg_onMouseMoving); \
									\
									class Controls : Controls \
									{ \
										class Background : Background \
										{ \
											idc = __EVAL(500000 + 8000 + 10*num + 6); \
										}; \
										class VehiclePic : VehiclePic \
										{ \
											idc = __EVAL(500000 + 8000 + 10*num + 1); \
										}; \
										class KitPic : KitPic \
										{ \
											idc = __EVAL(500000 + 8000 + 10*num + 2); \
										}; \
										class Name : Name \
										{ \
											idc = __EVAL(500000 + 8000 + 10*num + 3); \
										}; \
										class RoleText : RoleText \
										{ \
											idc = __EVAL(500000 + 8000 + 10*num + 5); \
										}; \
									}; \
								}

								__lineUpdate(01);
								__lineUpdate(02);
								__lineUpdate(03);
								__lineUpdate(04);
								__lineUpdate(05);
								__lineUpdate(06);
								__lineUpdate(07);
								__lineUpdate(08);
								__lineUpdate(09);
								__lineUpdate(10);
								__lineUpdate(11);
								__lineUpdate(12);
								__lineUpdate(13);
								__lineUpdate(14);
								__lineUpdate(15);
								__lineUpdate(16);
								__lineUpdate(17);
								__lineUpdate(18);
								__lineUpdate(19);
								__lineUpdate(20);
							};
						};

						class NameCustomEditOK : ActionButton
						{
							idc = __EVAL(500000 + 3004);
							x = 0.10;
							y = 0.05;
							w = __EVAL(((__grpW - (0.04+0.005)/(4/3) - 0.09 - 0.005 - (0.04)/(4/3) - 0.005 - 0.05) - 0.10 + 0.005)/2 - 0.003);
							text = "OK";
							action = "[3] call PRA3_fnc_squadDlg_customName";
						};
						class NameCustomEditCancel : NameCustomEditOK
						{
							idc = __EVAL(500000 + 3005);
							x = __EVAL(0.10 + ((__grpW - (0.04+0.005)/(4/3) - 0.09 - 0.005 - (0.04)/(4/3) - 0.005 - 0.05) - 0.10 + 0.005)/2);
							text = "Cancel";
							action = "[4] call PRA3_fnc_squadDlg_customName";
						};
					};
				};

				#undef __itemSquad
				#undef __lineUpdate

				class ItemSquadUnassigned : ItemSquad01
				{
					idc = 990000;
					x = 0.005;
					y = __EVAL(__grpH * 27);
					w = __grpW;
					h = __EVAL(__grpH + 0.04);
					hNoButton = __EVAL(__grpH);

					class Controls : Controls
					{
						class Background : Background
						{
							idc = __EVAL(990000 + 1000);
						};
						class HeaderBackground : HeaderBackground
						{
						};

						class Name : RscText
						{
							idc = __EVAL(990000 + 2000);
							x = 0;
							y = 0.002;
							w = 0.2;
							h = 0.05;
							sizeEx = 0.034;
							colorText[] = {1,1,1,1};
							text = "Unassigned";
						};

						class Size : Size
						{
							idc = __EVAL(990000 + 4000);
							x = __EVAL(__grpW - (0.04+0.005)/(4/3) - 0.05 - 0.007);
							style = ST_RIGHT;
							text = "31";
						};

						class CollapserPicture : CollapserPicture
						{
							idc = __EVAL(990000 + 7001);
						};
						class CollapserButton : CollapserButton
						{
							idc = __EVAL(990000 + 7002);
							action = "27 call PRA3_fnc_squadDlg_toggleCollapseSquad";
						};

						class MembersList : RscListBox
						{
							idc = __EVAL(990000 + 8001);
							x = 0;
							y = 0.05;
							w = __grpW;
							h = __EVAL(__lbH * __lbItems);
							sizeEx = __EVAL(__lbH);
						};
						class MembersListMulti : MembersList
						{
							idc = __EVAL(990000 + 8002);
							style = LB_MULTI;
							colorSelectBackground[] = {0.4, 0.4, 0.4, 1.0};
							colorSelectBackground2[] = {0.5, 0.5, 0.5, 1.0};
						};

						class InviteButton : ActionButton
						{
							idc = __EVAL(990000 + 9000);
							x = __EVAL(( __grpW - 0.25) / 2);
							y = __EVAL(0.05 + __lbH * __lbItems);
							w = 0.25;

							text = "Invite selected";
							action = "call PRA3_fnc_squadDlg_inviteButton";
						};
					};
				};
				#undef __lbItems
				#undef __lbH
				#undef __grpW
				#undef __grpH
			};
		};
		class DummyGroup : Group //Invisible dummy object for EHs to work outside the squad dialog
		{
			x = safeZoneX + __w;
			w = safeZoneW - __w;

			class Controls
			{
			};
		};
		class RightclickMenuLevel1 : PRA3_RscPopupMenu
		{
			idc = 301;
			h = 0.12;

			class Controls : Controls
			{
				class Item1 : Item1
				{
					idc = 30101;
					text = "Fireteam         >";
					action = "[0,0] call PRA3_fnc_squadDlg_menuButton";
				};
				class Item2 : Item2
				{
					idc = 30102;
					text = "Set squad leader >";
					action = "[0,1] call PRA3_fnc_squadDlg_menuButton";
				};
				class Item3 : Item3
				{
					idc = 30103;
					text = "Kick out         >";
					action = "[0,2] call PRA3_fnc_squadDlg_menuButton";
				};
			};
		};
		class RightclickMenuLevel2 : RightclickMenuLevel1
		{
			idc = 302;
			h = 0.08;

			class Controls : Controls
			{
				class Item1 : Item1
				{
					idc = 30201;
					text = "Assign to Charlie";
					action = "[1,0] call PRA3_fnc_squadDlg_menuButton";
				};
				class Item2 : Item2
				{
					idc = 30202;
					text = "Assign to Delta";
					action = "[1,1] call PRA3_fnc_squadDlg_menuButton";
				};
				class Item3 : Item3
				{
					idc = 30203;
					text = "";
					action = "[1,2] call PRA3_fnc_squadDlg_menuButton";
				};
			};
		};
		class CreateSquadButton : RscShortcutButton
		{
			idc = 999901;
			x = safeZoneX + __w/2 - 0.15;
			y = safeZoneY + safeZoneH - 0.045;
			w = 0.30;
			h = 0.04;
			text = "Create squad";
			action = "99 call PRA3_fnc_squadDlg_actionButton";
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
	};

	#undef __w
};
