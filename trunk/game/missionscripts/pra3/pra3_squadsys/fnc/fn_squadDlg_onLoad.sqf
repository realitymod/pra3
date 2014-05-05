#include "defines.sqh"
#include "scriptDefines.sqh"
#include "idcs.sqh"

/**
 *	Dialog onLoad handler.
 */

// Disable the Squads button
(_this displayCtrl IDC_KITDLG_SWITCH_SQUADS) ctrlEnable false;

(_this displayCtrl 301) ctrlShow false;
(_this displayCtrl 302) ctrlShow false;
PRA3_squadSys_menuTarget = "";
PRA3_squadSys_dlgOpenedOn = time;

// Team switch buttons
_this call PRA3_fnc_squadDlg_refreshTeamSwitchBtns;

uiNamespace setVariable [
	"PRA3_squadDlg_teamChangedEvent",
	[
		missionNamespace,
		"teamChanged",
		{
			disableSerialization;

			uiNamespace getVariable [
				if (isNull (uiNamespace getVariable ["Rsc_PRA3_squadSys_manageDlg", displayNull])) then {
					"Rsc_PRA3_squadSys_manageDlgRespawn"
				} else {
					"Rsc_PRA3_squadSys_manageDlg"
				},
				displayNull
			] call PRA3_fnc_squadDlg_refreshTeamSwitchBtns;

			// Also update squads if the guy is of the same team
			if (PRA3_player_team == _this select 1) then
			{
				[] call PRA3_fnc_squadDlg_updateSquadsInfo;
			};
		}
	] call BIS_fnc_addScriptedEventHandler
];

[] call PRA3_fnc_squadDlg_updateSquadsInfo;

// Only run this for the lite dialog, the full one will handle the update elsewhere
if (isNull (uiNamespace getVariable ["Rsc_PRA3_squadSys_manageDlgRespawn", displayNull])) then
{
	ctrl(IDC_KITDLG_SPAWNMAP_TEAMFLAG) ctrlSetText (PRA3_player_team call PRA3_fnc_getTeamFlag);
	ctrl(IDC_KITDLG_SPAWNMAP_MISSIONNAME) ctrlSetText call PRA3_fnc_missionName; //Mission name

	var(_updateControls) =
	{
		var(_time) = time - PRA3_AAS_prepareTime;
		if (_time < 0) then
		{
			_time = 0;
		};
		ctrl(IDC_KITDLG_SPAWNMAP_MISSIONTIME) ctrlSetText ([_time, "HH:MM:SS"] call BIS_fnc_secondsToString);

		var(_team) = PRA3_AAS_teams find PRA3_player_team;
		ctrl(IDC_KITDLG_SPAWNMAP_TICKETS) ctrlSetText format [
			"%1 (%2)",
			round (PRA3_core getVariable "PRA3_AAS_tickets" select _team),
			- round (PRA3_AAS_ticketBleed select _team)
		];
	};

	call _updateControls;

	_updateControls spawn
	{
		while {!isNull ctrl(IDC_KITDLG_SPAWNMAP_TEAMFLAG)} do
		{
			sleep 0.01;
			call _this;
		};
	};
};
