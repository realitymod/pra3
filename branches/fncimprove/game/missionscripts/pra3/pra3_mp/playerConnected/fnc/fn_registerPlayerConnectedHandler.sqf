#define var(x) private #x; x

/*
 *	Registeres a player connected handler.
 *		(in)  <CODE> Handler code
 *		(out) <INT> Handler ID
 */

var(_handler) = _this;

var(_id) = PRA3_mp_playerConnectedHandlersCounter;
PRA3_mp_playerConnectedHandlersCounter = _id + 1;

PRA3_mp_playerConnectedHandlers set [count PRA3_mp_playerConnectedHandlers, [_handler, _id]];

_id
