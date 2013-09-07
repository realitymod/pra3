/**
 *	Returns client ID for the given unit.
 *	Returns -1 if CID cannot be determined.
 *
 *		(in)  <OBJECT> Unit
 *				OR
 *		(in)  <STRING> Unit ID
 *		(out) <INT> Client ID
 */

#include "scriptDefines.sqh"

var(_unit) = _this;
if (typeName _unit == "OBJECT") then
{
	_unit = _unit call PRA3_fnc_getPlayerUID;
};

var(_cid) = PRA3_core getVariable [format["PRA3_player_cid_%1", _unit], -1];

if (_cid == -1) then
{
	[format["CID missing for %1 (%2)", str _this, str _unit]] call PRA3_fnc_logWarning;
};

_cid
