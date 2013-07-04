#include "scriptDefines.sqh"

/**
 * Returns the side the squad is on.
 *		(in)  <INT> Squad ID
 *		(out) <SIDE> Squad's side
 */

var(_squadId) = floor(_this / 1000);

var(_side) = civilian;
{
	var(_base) = (_x call PRA3_fnc_getSideID) / 1000;
	if (_squadId == _base) exitWith
	{
		_side = _x;
	};
} forEach [west, east, resistance, civilian];

_side
