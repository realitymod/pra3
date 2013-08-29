/**
 *	Returns name of the unit.
 *	Returns an empty string if the name cannot be determined.
 *
 *		(in)  <OBJECT> Unit
 *				OR
 *		(in)  <STRING> Unit ID
 *		(out) <STRING> Name
 */

#include "scriptDefines.sqh"

var(_unit) = _this;
if (typeName _unit == "OBJECT") then
{
	_unit = _unit call PRA3_fnc_getPlayerUID;
};

PRA3_core getVariable [format["PRA3_player_name_%1", _unit], ""]
