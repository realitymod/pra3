#include "scriptDefines.sqh"
#include "defines.sqh"

/**
 *	Returns the unit's kit icon.
 *	Returns an empty string if the unit had no kit assigned.
 *		(in)  <OBJECT> Unit
 *			or
 *		(in)  <STRING> Unit UID
 *		(out) <STRING> Path to kit icon
 */

var(_unit) = _this;

if (typeName _unit == "OBJECT") then
{
	_unit = _unit call PRA3_fnc_getPlayerUID;
};

(PRA3_core getVariable [format["PRA3_kits_unitKitIcon_%1", _unit], ""])
