#include "defines.sqh"
#include "scriptDefines.sqh"
#include "idcs.sqh"

/**
 *	Dialog onLoad handler.
 */

ctrlSetFocus (_this displayCtrl IDC_KITDLG_SWITCH_SQUADS);

(_this displayCtrl 301) ctrlShow false;
(_this displayCtrl 302) ctrlShow false;
PRA3_squadSys_menuTarget = "";
PRA3_squadSys_dlgOpenedOn = time;

//-->Set team Switching
//Flags
(_this displayCtrl 502) ctrlSetText ((PRA3_AAS_teams select 0) call PRA3_fnc_getTeamFlag);
(_this displayCtrl 503) ctrlSetText ((PRA3_AAS_teams select 1) call PRA3_fnc_getTeamFlag);

//Team names
var(_teamCount) = (PRA3_AAS_teams select 0) call PRA3_fnc_count_PlayersTeam;

(_this displayCtrl 500) ctrlSetText format["%1 [%2]",((PRA3_AAS_teams select 0) call PRA3_fnc_getTeamName),_teamCount select 0];
(_this displayCtrl 501) ctrlSetText format["%1 [%2]",((PRA3_AAS_teams select 1) call PRA3_fnc_getTeamName),_teamCount select 1];

//Disable switching to the team you in
_this call PRA3_fnc_squadDlg_refreshTeamSwitchBtns;

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
