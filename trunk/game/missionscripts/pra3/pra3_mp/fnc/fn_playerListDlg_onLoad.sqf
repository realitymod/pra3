#include "defines.sqh"
#include "scriptDefines.sqh"
#include "idcs.sqh"

/**
 *	Dialog onLoad handler.
 */

//-->Set team Switching
//Flags
(_this displayCtrl 702) ctrlSetText ((PRA3_AAS_teams select 0) call PRA3_fnc_getTeamFlag);
(_this displayCtrl 703) ctrlSetText ((PRA3_AAS_teams select 1) call PRA3_fnc_getTeamFlag);

//Team names
_teamCount = (PRA3_AAS_teams select 0) call PRA3_fnc_count_PlayersTeam;

(_this displayCtrl 700) ctrlSetText format["%1 [%2]",((PRA3_AAS_teams select 0) call PRA3_fnc_getTeamName),_teamCount select 0];
(_this displayCtrl 701) ctrlSetText format["%1 [%2]",((PRA3_AAS_teams select 1) call PRA3_fnc_getTeamName),_teamCount select 1];
