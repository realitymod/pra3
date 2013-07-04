#include "scriptDefines.sqh"

/**
 * Returns an array of unassigned players for the given side.
 *
 *		(in)  <SIDE> Side
 *		(out) <ARRAY> Unnasigned players' UIDs
 */

var(_units) = if (isMultiplayer) then
	{
		playableUnits
	}
	else
	{
		allUnits
	};
var(_unassigned) = [];
{
	if (side _x == _this && (_x call PRA3_fnc_unitGetSquad) == -1) then
	{
		_unassigned set [count _unassigned, _x call PRA3_fnc_getPlayerUID];
	};
} forEach _units;

_unassigned
