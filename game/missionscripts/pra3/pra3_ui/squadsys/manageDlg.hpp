class Rsc_PRA3_squadSys_manageDlg : Rsc_PRA3_squadSys_manageDlgRespawn
{
	idd = -1;
	movingEnable = false;
	enableSimulation = true;
	onLoad = "uiNamespace setVariable [""Rsc_PRA3_squadSys_manageDlg"", _this select 0]; (_this select 0) call PRA3_fnc_squadDlg_onLoad; (_this select 0) call PRA3_fnc_spawnMap_onLoad";

	#define __w 0.5
	#define __spaceX 0.01
	#define __spaceY (__spaceX / (4/3))

	class ControlsBackground : ControlsBackground
	{
		class TitleLeftBackground : TitleLeftBackground {};
		class TitleLeft : TitleLeft {};
		class BackgroundLeft : BackgroundLeft {};
		class CreateBackground : TitleLeftBackground {};
	};
	class Controls : Controls
	{
		class Group : Group
		{
			y = safeZoneY + __spaceY + 0.01 + 0.05 + 0.01;
			h = safeZoneH - (__spaceY * 2 + 0.01 + 0.05 + 0.01 + 0.05);

			class Controls : Controls {};
		};
		class DummyGroup : DummyGroup {}; //Invisible dummy object for EHs to work outside the squad dialog
		class RightclickMenuLevel1 : RightclickMenuLevel1 {};
		class RightclickMenuLevel2 : RightclickMenuLevel2 {};
		class CreateSquadButton : CreateSquadButton {};
	};

	#undef __w
};
