#include "defines.sqh"
#include "scriptDefines.sqh"

// Restrict ability to switch team only once per death
// Does not apply if the mission hasn't started yet
if (!isNil "PRA3_joinedGame") then
{
	PRA3_blockTeamSwitch = true;
};

player call PRA3_fnc_switchTeam;
