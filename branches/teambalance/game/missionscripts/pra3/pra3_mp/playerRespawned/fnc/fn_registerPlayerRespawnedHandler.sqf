#define var(x) private #x; x

/*
 *	Registeres a player respawned handler.
 *		(in) <ARRAY>:
 *			0 <STRING> Player UID
 *				or
 *			0 <OBJECT> Player
 *			1 <CODE> Handler code
 *		(out) <INT> Handler ID
 */

var(_uid)     = if (typeName (_this select 0) == "STRING") then {_this select 0} else {(_this select 0) call PRA3_fnc_getPlayerUID};
var(_handler) = _this select 1;

var(_id) = (PRA3_core getVariable [format["PRA3_mp_playerRespawnedHandlersCounter_%1", _uid], 0]);
PRA3_core setVariable [format["PRA3_mp_playerRespawnedHandlersCounter_%1", _uid], _id + 1];

var(_handlers) = PRA3_core getVariable [format["PRA3_mp_playerRespawnedHandlers_%1", _uid], []];
_handlers set [count _handlers, [_handler, _id]];
PRA3_core setVariable [format["PRA3_mp_playerRespawnedHandlers_%1", _uid], _handlers];


_id
