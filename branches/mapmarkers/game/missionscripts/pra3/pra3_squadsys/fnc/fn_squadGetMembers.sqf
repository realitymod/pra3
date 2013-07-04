#include "scriptDefines.sqh"

/**
 * Returns a POINTER to an array of squads members
 * Returns an empty string if the squad does not exist.
 *		(in)  <INT> Squad ID
 *		(out) <ARRAY> Squad members (pointer)
 */

var(_squadId) = _this;
if (_squadId call PRA3_fnc_squadExists) then
{
	((PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]) select 0)
}
else
{
	[]
}
