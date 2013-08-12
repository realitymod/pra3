#include "scriptDefines.sqh"

/*
 *	Executes all registered player connected event handlers.
 *		(in)  <ARRAY> [name, id, uid]
 *		(out) <VOID>
 */

if !isDedicated then
{
	{
		_this call (_x select 0);
	} forEach PRA3_mp_playerConnectedHandlers;
};
