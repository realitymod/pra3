#include "defines.sqh"
#include "scriptDefines.sqh"

/**
 *	Locks player's squad.
 */

var(_id) = (player call PRA3_fnc_unitGetSquad);
if (_id > 0) then
{
	false call PRA3_fnc_squadDlg_enableControls;
	[_id, "PRA3_fnc_squadDlg_server_lockSquad", false] call PRA3_fnc_MP;
};
