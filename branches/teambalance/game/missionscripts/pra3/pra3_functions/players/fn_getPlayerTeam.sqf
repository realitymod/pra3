/**
 *	Returns the player's team.
 *	Returns an empty string if the team cannot be determined.
 *
 *		(in)  <OBJECT> Unit
 *			OR
 *		(in)  <STRING> Unit ID
 *		(out) <SIDE> Player's side
 */

#include "scriptDefines.sqh"

var(_unit) = _this;
if (typeName _unit == "OBJECT") then
{
	_unit = _unit call PRA3_fnc_getPlayerUID;
};

PRA3_core getVariable [format["PRA3_player_team_%1", _unit], ""]
