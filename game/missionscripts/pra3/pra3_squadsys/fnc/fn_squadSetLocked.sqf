#include "scriptDefines.sqh"

/**
 * Sets whether the squad is locked.
 * Returns false if the squad or the unit does not exist.
 *		(in)  <ARRAY>:
 *			0 <INT> Squad ID
 *			1 <BOOL> Squad locked
 *		(out) <BOOL> Success
 */

if (isServer) then
{
	var(_squadId) = _this select 0;
	var(_locked) = _this select 1;
	if (_squadId call PRA3_fnc_squadExists) then
	{
		var(_arr) = (PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]);
		_arr set [3, _locked];
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
	["PRA3_fnc_squadSetLocked", "Has to be run server-side"] call PRA3_fnc_logError;
	false
}
