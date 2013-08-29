#include "scriptDefines.sqh"

/**
 * Sets the array of members for the given squad.
 * Returns false if the squad or the unit does not exist.
 *		(in)  <ARRAY>:
 *			0 <INT> Squad ID
 *			1 <ARRAY> Squad members
 *		(out) <BOOL> Success
 */

if (isServer) then
{
	var(_squadId) = _this select 0;
	var(_members) = _this select 1;
	if (_squadId call PRA3_fnc_squadExists) then
	{
		var(_arr) = (PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]);
		_arr set [0, _members];
		_squadId call PRA3_fnc_broadcastSquadVariable;
		true
	}
	else
	{
		false
	}
}
else
{
	["PRA3_fnc_squadSetMembers", "Has to be run server-side"] call PRA3_fnc_logError;
	false
}
