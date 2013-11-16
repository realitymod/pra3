/**
 *	Returns UID for the given unit.
 *	Returns empty string if UID cannot be determined.
 *
 *		(in)  <OBJECT> Unit
 *		(out) <STRING> UID
 */

#include "scriptDefines.sqh"

var(_unit) = _this;

var(_uid) = if (typeName _unit == "STRING") then //Already UID
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
};

if (_uid == "") then
{
	[format["UID missing for %1 (%2)", str _this, str _unit]] call PRA3_fnc_logWarning;
};
_uid
