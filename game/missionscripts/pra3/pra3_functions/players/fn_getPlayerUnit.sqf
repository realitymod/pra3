/**
 *	Returns object player with the given UID is currently controlling.
 *	Returns a null object if the UID is invalid.
 *
 *		(in)  <STRING> Player UID
 *		(out) <OBJECT> Player object
 */

#include "scriptDefines.sqh"

var(_unitID) = _this;

var(_obj) = if (typeName _unitID == "OBJECT") then
{
	_unitID
}
else
{
	PRA3_core getVariable [format["PRA3_player_object_%1", _unitID], objNull]
};

if (isNull _obj) then
{
	[format["object missing for %1 (%2)", str _this, str _unitID]] call PRA3_fnc_logWarning;
};

_obj
