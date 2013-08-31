#include "scriptDefines.sqh"

/**
 * Returns whether the squad is locked.
 *		(in)  <INT> Squad ID
 *		(out) <BOOR> Squad locked
 */

var(_squadId) = _this;
if (_squadId call PRA3_fnc_squadExists) then
{
	((PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]) select 3)
}
else
{
	false
}
