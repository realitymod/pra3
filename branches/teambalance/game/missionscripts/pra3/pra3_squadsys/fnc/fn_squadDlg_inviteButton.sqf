#include "defines.sqh"
#include "scriptDefines.sqh"

/**
 *	Handles activation of the invite button.
 */

// TODO: Implement
var(_squadId) = player call PRA3_fnc_unitGetSquad;

{
	[[(ctrl(998002) lbData _x) call PRA3_fnc_getPlayerUnit, _squadId], "PRA3_fnc_squadDlg_server_joinSquad", false] call PRA3_fnc_MP;
} forEach (lbSelection ctrl(998002));

for "_i" from 0 to (lbSize ctrl(998002))-1 do
{
	ctrl(998002) lbSetSelected [_i, false];
};

[_squadId, 99] call PRA3_fnc_squadDlg_updateSquadsInfo;
