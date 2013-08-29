#include "scriptDefines.sqh"

/**
 * Sets the max size of the squad.
 * Returns false if the squad or the unit does not exist.
 *		(in)  <ARRAY>:
 *			0 <INT> Squad ID
 *			1 <INT> Max size
 *		(out) <BOOL> Success
 */

if (isServer) then
{
	var(_squadId) = _this select 0;
	var(_size) = _this select 1;
	if (_squadId call PRA3_fnc_squadExists) then
	{
		var(_arr) = (PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]);
		_arr set [2, _size];
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
	["PRA3_fnc_squadSetSize", "Has to be run server-side"] call PRA3_fnc_logError;
	false
}
