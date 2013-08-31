#include "scriptDefines.sqh"

/**
 * Returns ID of the squad the unit is a member of.
 * Returns -1 if the unit is unassigned.
 *		(in)  <OBJECT> Unit
 *			or
 *		(in)  <STRING> Unit UID
 *		(out) <INT> Squad ID
 */

var(_unit) = _this;

if (typeName _unit == "OBJECT") then
{
	_unit = _unit call PRA3_fnc_getPlayerUID;
};

(PRA3_core getVariable [format["PRA3_squadSys_unitSquad_%1", _unit], -1])
