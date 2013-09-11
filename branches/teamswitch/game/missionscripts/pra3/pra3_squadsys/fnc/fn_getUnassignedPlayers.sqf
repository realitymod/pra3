#include "scriptDefines.sqh"

/**
 * Returns an array of unassigned players for the given side.
 *
 *		(in)  <SIDE> Side
 *		(out) <ARRAY> Unnasigned players' UIDs
 */

var(_units) = call PRA3_fnc_getConnectedPlayers;

var(_unassigned) = [];
{
	if (_x call PRA3_fnc_getPlayerSide == _this && (_x call PRA3_fnc_unitGetSquad) == -1) then
	{
		_unassigned set [count _unassigned, _x];
	};
} forEach _units;

_unassigned
