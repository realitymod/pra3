#include "scriptDefines.sqh"
#include "defines.sqh"

/**
 * Registers a rallypoint object as the new rallypoint of the squad. Rallypoint cooldown time is updated too.
 *		(in)  <ARRAY>:
 *			0: <INT> Squad ID
 *			1: <OBJECT> New rallypoint
 *		(out) <BOOL> Success
 */

if (isServer) then
{
	var(_squadId) = _this select 0;
	var(_rally)   = _this select 1;
	if (_squadId call PRA3_fnc_squadExists) then
	{
		var(_arr) = (PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]);
		_arr set [5, _rally];
		_arr set [6, time + RALLYPOINT_COOLDOWN];

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
	["PRA3_fnc_squadSetName", "Has to be run server-side"] call PRA3_fnc_logError;
	false
}
