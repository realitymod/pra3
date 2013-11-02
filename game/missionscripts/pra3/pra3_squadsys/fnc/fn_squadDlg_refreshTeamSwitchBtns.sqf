#include "defines.sqh"
#include "scriptDefines.sqh"
#include "idcs.sqh"


var(_team1) = player call PRA3_fnc_getPlayerTeam == PRA3_AAS_teams select 0;
diag_log [__FILE__, _this, _team1, _this displayCtrl 500];
_this displayCtrl 500 ctrlEnable !_team1;
_this displayCtrl 501 ctrlEnable _team1;

_this displayCtrl IDC_KITDLG_SPAWNMAP_TEAMFLAG ctrlSetText (player call PRA3_fnc_getPlayerTeam call PRA3_fnc_getTeamFlag);
