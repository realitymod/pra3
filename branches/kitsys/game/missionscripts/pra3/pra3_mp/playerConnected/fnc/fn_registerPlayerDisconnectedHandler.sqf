#include "scriptDefines.sqh"

/*
 *	Registeres a player disconnected handler.
 *		(in)  <CODE> Handler code
 *		(out) <INT> Handler ID
 */

var(_handler) = _this;

var(_id) = PRA3_mp_playerDisconnectedHandlersCounter;
PRA3_mp_playerDisconnectedHandlersCounter = _id + 1;

PRA3_mp_playerDisconnectedHandlers set [count PRA3_mp_playerDisconnectedHandlers, [_handler, _id]];

_id
