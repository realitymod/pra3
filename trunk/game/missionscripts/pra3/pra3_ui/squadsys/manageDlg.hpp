class Rsc_PRA3_squadSys_manageDlg : Rsc_PRA3_squadSys_manageDlgRespawn
{
	idd = -1;
	movingEnable = false;
	enableSimulation = true;
	onLoad = "uiNamespace setVariable [""Rsc_PRA3_squadSys_manageDlg"", _this select 0]; (_this select 0) call PRA3_fnc_squadDlg_onLoad";

	#define __w 0.5
	#define __spaceX 0.01
	#define __spaceY (__spaceX / (4/3))

	class ControlsBackground : ControlsBackground
	{
		class TitleLeftBackground : TitleLeftBackground {};
		class TitleLeft : TitleLeft {};
		class BackgroundLeft : BackgroundLeft {};
		class CreateBackground : CreateBackground {};

		class BackgroundMissionInfo : TitleLeftBackground
		{
			x = safeZoneX + safeZoneW - __spaceX - 0.34 - __spaceX - 0.075 - __spaceX - 0.15;
			w = 0.15 + __spaceX + 0.075 + __spaceX + 0.342;
		};

		class PlayerTeamTickets : PlayerTeamTickets {};
		class PlayerTeamFlag : PlayerTeamFlag {};
		class MissionTime : MissionTime {};
	};
	class Controls : Controls
	{
		class SwitchTeam1 : SwitchTeam1 {};
		class SwitchTeam2 : SwitchTeam2 {};
		class SwitchTeam1Pic : SwitchTeam1Pic {};
		class SwitchTeam2Pic : SwitchTeam2Pic {};
		
		class PlayerListButtonOpen : PlayerListButtonOpen {};

		class Group : Group
		{
			y = safeZoneY + __spaceY + 0.01 + 0.05 + 0.01 + 0.06;
			h = safeZoneH - (__spaceY * 2 + 0.01 + 0.05 + 0.01 + 0.05 + 0.06);

			class Controls : Controls
			{
				class ItemSquad01 : ItemSquad01 {};
				class ItemSquad02 : ItemSquad02 {};
				class ItemSquad03 : ItemSquad03 {};
				class ItemSquad04 : ItemSquad04 {};
				class ItemSquad05 : ItemSquad05 {};
				class ItemSquad06 : ItemSquad06 {};
				class ItemSquad07 : ItemSquad07 {};
				class ItemSquad08 : ItemSquad08 {};
				class ItemSquad09 : ItemSquad09 {};
				class ItemSquad10 : ItemSquad10 {};
				class ItemSquad11 : ItemSquad11 {};
				class ItemSquad12 : ItemSquad12 {};
				class ItemSquad13 : ItemSquad13 {};
				class ItemSquad14 : ItemSquad14 {};
				class ItemSquad15 : ItemSquad15 {};
				class ItemSquad16 : ItemSquad16 {};
				class ItemSquad17 : ItemSquad17 {};
				class ItemSquad18 : ItemSquad18 {};
				class ItemSquad19 : ItemSquad19 {};
				class ItemSquad20 : ItemSquad20 {};
				class ItemSquad21 : ItemSquad21 {};
				class ItemSquad22 : ItemSquad22 {};
				class ItemSquad23 : ItemSquad23 {};
				class ItemSquad24 : ItemSquad24 {};
				class ItemSquad25 : ItemSquad25 {};
				class ItemSquad26 : ItemSquad26 {};
				class ItemSquadPlayer : ItemSquadPlayer {};
				class ItemSquadUnassigned : ItemSquadUnassigned {};
			};
		};
		class DummyGroup : DummyGroup {}; //Invisible dummy object for EHs to work outside the squad dialog
		class RightclickMenuLevel1 : RightclickMenuLevel1 {};
		class RightclickMenuLevel2 : RightclickMenuLevel2 {};
		class CreateSquadButton : CreateSquadButton {};
	};

	#undef __w
};
