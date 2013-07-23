/**
 *	Returns UID for the given unit.
 *	Returns empty string if UID cannot be determined.
 *
 *		(in)  <OBJECT> Unit
 *		(out) <STRING> UID
 */

#include "scriptDefines.sqh"

var(_unit) = _this;

if (typeName _unit == "STRING") then //Already UID
{
	_unit
}
else
{
	if (isMultiplayer) then
	{
		getPlayerUID _unit
	}
	else
	{
		_unit getVariable ["PRA3_UID", ""]
	}
}
