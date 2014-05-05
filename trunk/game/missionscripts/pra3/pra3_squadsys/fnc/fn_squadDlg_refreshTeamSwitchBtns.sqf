#include "defines.sqh"
#include "scriptDefines.sqh"
#include "idcs.sqh"

var(_team1) = PRA3_player_team == PRA3_AAS_teams select 0;

if (isNil "PRA3_blockTeamSwitch") then
{
	_this displayCtrl 500 ctrlEnable !_team1;
	_this displayCtrl 501 ctrlEnable _team1;
}
else
{
	_this displayCtrl 500 ctrlEnable false;
	_this displayCtrl 501 ctrlEnable false;
};

//Team names
var(_teamCount) = (PRA3_AAS_teams select 0) call PRA3_fnc_count_PlayersTeam;

_this displayCtrl 500 ctrlSetText format["%1 [%2]",((PRA3_AAS_teams select 0) call PRA3_fnc_getTeamName),_teamCount select 0];
_this displayCtrl 501 ctrlSetText format["%1 [%2]",((PRA3_AAS_teams select 1) call PRA3_fnc_getTeamName),_teamCount select 1];

_this displayCtrl 502 ctrlSetText ((PRA3_AAS_teams select 0) call PRA3_fnc_getTeamFlag);
_this displayCtrl 503 ctrlSetText ((PRA3_AAS_teams select 1) call PRA3_fnc_getTeamFlag);

// Only run this for the lite dialog, work around for the missing flags
if (!isNull (uiNamespace getVariable ["Rsc_PRA3_squadSys_manageDlg", displayNull])) then
{
	ctrlSetFocus ctrl(990000 + 7002);
};
_this displayCtrl IDC_KITDLG_SPAWNMAP_TEAMFLAG ctrlSetText (PRA3_player_team call PRA3_fnc_getTeamFlag);
