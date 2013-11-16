#include "scriptDefines.sqh"
#include "defines.sqh"

/**
 *	Sets the unit's kit.
 *	Has to be run server-side.
 *		(in)  <ARRAY>:
 *			0 <OBJECT> Unit
 *				OR
 *			0 <STRING> Unit UID
 *			1 <STRING> Kit
 *		(out) <BOOL> Success
 */

var(_unit) = _this select 0;
var(_kit)  = _this select 1;

if (isServer) then
{
	if (typeName _unit == "OBJECT") then
	{
		_unit = _unit call PRA3_fnc_getPlayerUID;
	};

	if (_unit != "") then
	{
		PRA3_core setVariable [format["PRA3_kits_unitKit_%1", _unit], _kit, true];
		PRA3_core setVariable [format["PRA3_kits_unitKitIcon_%1", _unit], _kit call PRA3_fnc_getKitInfo select KIT_ICON, true];
		true
	}
	else
	{
		false
	}
}
else
{
	["PRA3_fnc_unitSetKit", "Has to be run server-side"] call PRA3_fnc_logError;
	false
}
