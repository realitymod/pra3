#include "scriptDefines.sqh"

/**
 * Destroys the given squad.
 * Returns false if the squad doesn't exist.
 *
 *		(in)  <INT> Squad ID
 *		(out) <BOOL> Success
 */

if (isServer) then
{
	var(_squadId) = _this;
	var(_success) = false;

	if (_squadId call PRA3_fnc_squadExists) then
	{
		var(_squad) = PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId];
		if (count (_squad select 0) > 0) then
		{
			{
				[_x select 0, _squadId] call PRA3_fnc_unitLeaveSquad;
			} forEach (_squad select 0);
		}
		else
		{
			// Delete Arma group
			deleteGroup (_squad select 4);

			var(_squads) = PRA3_core getVariable "PRA3_squadSys_squads";
			{
				if (_x == _squadId) exitWith
				{
					[_squads, _forEachIndex] call PRA3_fnc_arrayRemoveAt;
					PRA3_core setVariable [format["PRA3_squadSys_squad_%1", _squadId], nil, true];
					_success = true;
				};

			} forEach _squads;

			_success
		}
	}
	else
	{
		false
	}
}
else
{
	["PRA3_fnc_destroySquad", "Has to be run server-side"] call PRA3_fnc_logError;
	false
}
