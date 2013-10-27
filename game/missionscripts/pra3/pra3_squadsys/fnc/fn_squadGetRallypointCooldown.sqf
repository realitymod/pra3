#include "scriptDefines.sqh"

/**
 * Returns the the time when a new rallypoint becomes available for deployment.
 * Returns -1 if the squad does not exist.
 *		(in)  <INT> Squad ID
 *		(out) <FLOAT> Time when rallypoint becomes available
 */

var(_squadId) = _this;
if (_squadId call PRA3_fnc_squadExists) then
{
	((PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]) select 6)
}
else
{
	-1
}
