#include "scriptDefines.sqh"

/*
 *	Unregisteres the player connected handler.
 *		(in)  <INT> Handler ID
 *		(out) <BOOL> Success
 */

var(_id) = _this;

var(_return) = false;
{
	if ((_x select 1) == _id) exitWith
	{
		[PRA3_mp_playerConnectedHandlers, _forEachIndex] call PRA3_fnc_arrayRemoveAt;
		_return = true;
	};
} forEach PRA3_mp_playerConnectedHandlers;

_return
