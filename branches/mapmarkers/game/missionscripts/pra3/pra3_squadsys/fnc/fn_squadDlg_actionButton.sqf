#include "defines.sqh"
#include "scriptDefines.sqh"

/**
 *	Handles buttons.
 */

var(_id) = _this;
false call PRA3_fnc_squadDlg_enableControls;
if (_id == 0) then // Leaving own squad
{
	[[player, -1], "PRA3_fnc_squadDlg_server_joinSquad", false] call BIS_fnc_MP;
}
else
{
	if (_id == 99) then // Creating new squad
	{
		[player, "PRA3_fnc_squadDlg_server_createSquad", false] call BIS_fnc_MP;
	}
	else // Joining a squad
	{
		_id = _id + (playerSide call PRA3_fnc_getSideID);
		if (_id call PRA3_fnc_squadIsLocked) then // Send request
		{
			// TODO: Implement
			hint "TODO: send request";
		}
		else
		{
			[[player, _id], "PRA3_fnc_squadDlg_server_joinSquad", false] call BIS_fnc_MP;
		};
	};
};
