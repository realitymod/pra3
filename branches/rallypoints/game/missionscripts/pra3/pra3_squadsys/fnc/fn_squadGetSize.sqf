#include "scriptDefines.sqh"

/**
 * Returns the max size the squad allows.
 * Returns -1 if the squad does not exist.
 *		(in)  <INT> Squad ID
 *		(out) <INT> Max size
 */

var(_squadId) = _this;
if (_squadId call PRA3_fnc_squadExists) then
{
	((PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]) select 2)
}
else
{
	-1
}
