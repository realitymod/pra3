#include "scriptDefines.sqh"
#include "defines.sqh"

/**
 * Creates a new rallypoint object at the given position and registers it with the squad.
 * Existing rallypoint is deleted should the squad already have one.
 * Rallypoint cooldown is updated as well.
 *
 *		(in)  <ARRAY>:
 *			0: <INT> Squad ID
 *			1: <POSITION ATL> Position to place rallypoint at
 *			2: <NUMBER> Direction
 *			3: <NUMBER> Rallypoint type
 *		(out) <BOOL> Success
 */

if (isServer) then
{
	var(_squadId) = _this select 0;
	var(_pos)     = _this select 1;
	var(_dir)     = _this select 2;
	var(_type)    = _this select 3;
	if (_squadId call PRA3_fnc_squadExists) then
	{
		var(_arr) = (PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]);

		// Delete the old rally point if needed
		deleteVehicle (_arr select 5);

		var(_rally) = _type createVehicle _pos;
		_rally setDir _dir;
		_rally setPosATL _pos;

		_rally setVariable ["PRA3_rally_deployTime", time, true];
		_rally setVariable ["PRA3_rally_squad", _squadId, true];
		_rally setVariable ["PRA3_rally_tickets", count (_squadId call PRA3_fnc_squadGetMembers), true];

		_arr set [5, _rally];

		if (PRA3_core getVariable ["PRA3_debug_squadSys_noRPCooldown", false]) then
		{
			_arr set [6, time + 0];
		}
		else
		{
			_arr set [6, time + RALLYPOINT_COOLDOWN];
		};

		_squadId call PRA3_fnc_broadcastSquadVariable;

		_rally addEventHandler [
			"killed",
			{deleteVehicle (_this select 0)}
		];
		_rally addEventHandler [
			"hit",
			{
				if (damage (_this select 0) > 0.1) then
				{
					deleteVehicle (_this select 0);
				};
			}
		];

		true
	}
	else
	{
		false
	}
}
else
{
	["PRA3_fnc_squadCreateRallypoint", "Has to be run server-side"] call PRA3_fnc_logError;
	false
}
