#include "defines.sqh"
#include "scriptDefines.sqh"

var(_team1) = player call PRA3_fnc_getPlayerTeam == PRA3_AAS_teams select 0;
__ctrl(500) ctrlEnable !_team1;
__ctrl(501) ctrlEnable _team1;
