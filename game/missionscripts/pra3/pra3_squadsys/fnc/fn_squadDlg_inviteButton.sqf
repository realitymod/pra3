#include "defines.sqh"
#include "scriptDefines.sqh"

/**
 *	Handles activation of the invite button.
 */

// TODO: Implement
var(_squadId) = player call PRA3_fnc_unitGetSquad;

{
	[(__ctrl(998002) lbData _x) call PRA3_fnc_getPlayerUnit, _squadId] call PRAA_fSquadSys_server_joinSquad;
} forEach (lbSelection __ctrl(998002));

for "_i" from 0 to (lbSize __ctrl(998002))-1 do
{
	__ctrl(998002) lbSetSelected [_i, false];
};

[_squadId, 99] call PRA3_fnc_squadDlg_updateSquadsInfo;
