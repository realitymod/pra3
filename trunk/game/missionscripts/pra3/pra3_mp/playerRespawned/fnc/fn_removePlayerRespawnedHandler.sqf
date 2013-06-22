#define var(x) private #x; x

/*
 *	Unregisteres the player spawned handler.
 *		(in) <ARRAY>:
 *			0 <STRING> Player UID
 *				or
 *			0 <OBJECT> Player
 *			1 <INT> Handler ID
 *		(out) <BOOL> Success
 */

var(_uid) = if (typeName _uid == "STRING") then {_this select 0} else {(_this select 0) call PRA3_fnc_getPlayerUID};
var(_id)  = _this select 1;

var(_return) = false;
var(_handlers) = PRA3_core getVariable [format["PRA3_mp_playerRespawnedHandlers_%1", _uid], []];
{
	if ((_x select 1) == _id) exitWith
	{
		[_handlers, _forEachIndex] call PRA3_fArray_removeIndex;
		_return = true;
	};
} forEach _handlers;

_return
