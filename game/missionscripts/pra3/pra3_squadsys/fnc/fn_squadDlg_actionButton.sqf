#include "defines.sqh"
#include "scriptDefines.sqh"

/**
 *	Handles buttons.
 */

var(_id) = _this;
false call PRA3_fnc_squadDlg_enableControls;
if (_id == 0) then // Leaving own squad
{
	[[player, -1], "PRA3_fnc_squadDlg_server_joinSquad", false] call PRA3_fnc_MP;
}
else
{
	if (_id == 99) then // Creating new squad or placing a rally point
	{
		if (player call PRA3_fnc_unitGetSquad == -1) then
		{
			[player, "PRA3_fnc_squadDlg_server_createSquad", false] call PRA3_fnc_MP;
		}
		else
		{
			if (player call compile preprocessFileLineNumbers "pra3\pra3_respawn\deployRallyPoint.sqf") then
			{
				closeDialog 0;
			};
		};
	}
	else // Joining a squad
	{
		_id = _id + ((player call PRA3_fnc_getPlayerSide) call PRA3_fnc_getSideID);
		if (_id call PRA3_fnc_squadIsLocked) then // Send request
		{
			// TODO: Implement
			hint "TODO: send request";
		}
		else
		{
			[[player, _id], "PRA3_fnc_squadDlg_server_joinSquad", false] call PRA3_fnc_MP;
		};
	};
};
