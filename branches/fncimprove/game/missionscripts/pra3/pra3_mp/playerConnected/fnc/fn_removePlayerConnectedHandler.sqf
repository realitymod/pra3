#define var(x) private #x; x

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
		[PRA3_mp_playerConnectedHandlers, _forEachIndex] call PRA3_fArray_removeIndex;
		_return = true;
	};
} forEach PRA3_mp_playerConnectedHandlers;

_return
