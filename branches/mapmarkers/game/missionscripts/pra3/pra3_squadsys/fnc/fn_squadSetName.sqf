#include "scriptDefines.sqh"

/**
 * Sets the optional name of the squad.
 * Returns false if the squad or the unit does not exist.
 *		(in)  <ARRAY>:
 *			0 <INT> Squad ID
 *			1 <STRING> Squad name
 *		(out) <BOOL> Success
 */

if (isServer) then
{
	var(_squadId) = _this select 0;
	var(_name) = _this select 1;
	if (_squadId call PRA3_fnc_squadExists) then
	{
		var(_arr) = (PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]);
		_arr set [1, _name];
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
	["Has to be run server-side"] call PRA3_fnc_logError;
	false
}
