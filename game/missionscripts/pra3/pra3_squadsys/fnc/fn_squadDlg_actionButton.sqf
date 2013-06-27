#include "defines.sqh"
#include "scriptDefines.sqh"

/**
 *	Handles buttons.
 */

var(_id) = _this;
false call PRA3_fnc_squadDlg_enableControls;
if (_id == 0) then // Leaving own squad
{
	["call", "PRAA_fSquadSys_server_joinSquad", [player, -1]] call PRAA_fMp_execServer;
}
else
{
	if (_id == 99) then // Creating new squad
	{
		["call", "PRAA_fSquadSys_server_createSquad", player] call PRAA_fMp_execServer;
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
			["call", "PRAA_fSquadSys_server_joinSquad", [player, _id]] call PRAA_fMp_execServer;
		};
	};
};
