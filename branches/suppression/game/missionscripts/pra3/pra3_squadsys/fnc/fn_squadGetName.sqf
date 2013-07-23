#include "scriptDefines.sqh"

/**
 * Returns the optional name of the squad's leader.
 * Returns an empty string if the squad does not exist (or no name is assigned).
 *		(in)  <INT> Squad ID
 *		(out) <STRING> Optional name
 */

var(_squadId) = _this;
if (_squadId call PRA3_fnc_squadExists) then
{
	((PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]) select 1)
}
else
{
	""
}
