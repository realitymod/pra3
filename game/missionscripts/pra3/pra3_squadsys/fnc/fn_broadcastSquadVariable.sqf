#include "scriptDefines.sqh"

/**
 * Broadcasts the value of the squad's variable to all clients.
 *		(in)  <INT> Squad ID
 *		(out) <VOID>
 */

var(_squadId) = _this;

if (isServer) then
{
	["PRA3_fnc_broadcastSquadVariable", __FILE__, __LINE__] call PRA3_fnc_logInfo;
	PRA3_core setVariable [
		format["PRA3_squadSys_squad_%1", _squadId],
		PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId],
		true
	];
}
else
{
	["Has to be run server-side"] call PRA3_fnc_logError;
};
