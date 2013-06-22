/**
 *	Returns the side the player unit is on (even when dead).
 *	Returns sideLogic if side cannot be determined.
 *
 *		(in)  <OBJECT> Unit
 *			OR
 *		(in)  <STRING> Unit ID
 *		(out) <INT> Client ID
 */

#include "scriptDefines.sqh"

var(_unit) = _this;
if (typeName _unit == "OBJECT") then
{
	_unit = _unit call PRA3_fnc_getPlayerUID;
};

PRA3_core getVariable [format["PRA3_player_side_%1", _unit], sideLogic]
