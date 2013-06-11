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
	var(_uid) = getPlayerUID _unit;

	if (_uid == "") then
	{
		_uid = (_unit getVariable ["PRA3_UID", ""]);
	};

	_uid
}
