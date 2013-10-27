#include "scriptDefines.sqh"

/**
 * Returns the rallypoint of the squad
 * Returns objNull if the squad has no rallypoint or doesn't exist.
 *		(in)  <INT> Squad ID
 *		(out) <OBJECT> Rallypoint
 */

var(_squadId) = _this;
if (_squadId call PRA3_fnc_squadExists) then
{
	((PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]) select 5)
}
else
{
	-1
}
