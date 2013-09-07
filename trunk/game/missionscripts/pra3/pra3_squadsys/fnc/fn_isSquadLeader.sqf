#include "scriptDefines.sqh"

/**
 *	Returns whether the unit is a squad leader.
 *	Unassigned units aren't considered squad leaders and return false.
 *		(in)  <OBJECT> Unit
 *			or
 *		(in)  <STRING> Unit UID
 *		(out) <BOOL> Is squad leader
 */

var(_unit) = _this;
if (typeName _unit == "OBJECT") then
{
	_unit = _unit call PRA3_fnc_getPlayerUID;
};

var(_squadId) = _unit call PRA3_fnc_unitGetSquad;

(_unit == (_squadId call PRA3_fnc_squadGetLeader))
