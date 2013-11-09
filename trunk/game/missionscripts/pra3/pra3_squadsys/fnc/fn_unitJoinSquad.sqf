#include "scriptDefines.sqh"
#include "defines.sqh"

/**
 * Assigns the given unit to the squad.
 * Returns false if the squad does not exist.
 *		 (in)  <ARRAY>:
 *			0 <OBJECT> Unit
 *				or
 *			0 <STRING> Unit UID
 *			1 <INT> Squad ID
 *		(out) <BOOL> Success
 */

if (isServer) then
{
	var(_unit)    = _this select 0;
	var(_squadId) = _this select 1;

	var(_unitID) = "";
	if (typeName _unit == "OBJECT") then
	{
		_unitID = _unit call PRA3_fnc_getPlayerUID;
	}
	else
	{
		_unitID = _unit;
		_unit = _unitID call PRA3_fnc_getPlayerUnit;
	};

	if (_squadId call PRA3_fnc_squadExists) then
	{
		var(_squad) = PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId];
		var(_prevSquad) = _unitId call PRA3_fnc_unitGetSquad;

		var(_prevGroup) = group _unit;

		if (_prevSquad != -1) then // Already in a squad
		{
			// Leave the current squad
			[_unit, _prevSquad] call PRA3_fnc_unitLeaveSquad;
		};

		var(_members) = _squad select 0;
		_members set [count _members, [_unitID, 0]];
		PRA3_core setVariable [format["PRA3_squadSys_unitSquad_%1", _unitID], _squadId, true];

		//Refresh to clients
		_squadId call PRA3_fnc_broadcastSquadVariable;

		[_unit] joinSilent (_squad select 4);
		diag_log ["JOIN", _unit, _squad select 4];

		if (_prevSquad == -1) then // Previously unassigned
		{
			// Delete the lone (now empty) unassigned group.
			// Due to locality issues that has to be done on the client.
			// Also, there is a problem delay, hence the waitUntil.
			[[_prevGroup, {waitUntil {count units _this == 0}; deleteGroup _this}], "BIS_fnc_spawn", _unit] call PRA3_fnc_MP;
		};

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
