#include "defines.sqh"
#include "scriptDefines.sqh"
#include "idcs.sqh"

//Flags
ctrl(702) ctrlSetText ((PRA3_AAS_teams select 0) call PRA3_fnc_getTeamFlag);
ctrl(703) ctrlSetText ((PRA3_AAS_teams select 1) call PRA3_fnc_getTeamFlag);

//Team names
_teamCount = (PRA3_AAS_teams select 0) call PRA3_fnc_count_PlayersTeam;

ctrl(700) ctrlSetText format["%1 [%2]",((PRA3_AAS_teams select 0) call PRA3_fnc_getTeamName),_teamCount select 0];
ctrl(701) ctrlSetText format["%1 [%2]",((PRA3_AAS_teams select 1) call PRA3_fnc_getTeamName),_teamCount select 1];
