#include "scriptDefines.sqh"

/**
 * Assigns fireteam to the unit.
 * Setting FT ID to 0 will unassign the unit from its current FT.
 * Returns false if the squad does not exist or the unit is not the squad's memeber.
 *		(in)  <ARRAY>:
 *			0 <INT> Squad ID
 *			1 <OBJECT> Unit
 *				OR
 *			1 <STRING> Unit UID
 *			2 <INT> Fireteam ID
 *		(out) <BOOL> Success
 */

if (isServer) then
{
	var(_squadId) = _this select 0;
	var(_unit) = _this select 1;
	var(_ft) = _this select 2;

	if (typeName _unit == "OBJECT") then
	{
		_unit = _unit call PRA3_fnc_getPlayerUID;
	};

	if (_squadId call PRA3_fnc_squadExists) then
	{
		var(_idx) = -1;
		var(_squad) = (PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]) select 0;
		{
			if (_x select 0 == _unit) exitWith
			{
				_idx = _forEachIndex;
			};
		} forEach _squad;

		if (_idx != -1) then
		{
			var(_prev) = (_squad select _idx) select 1;
			(_squad select _idx) set [1, _ft];
			[_squadId, _ft] call PRA3_fnc_updateFtLeadership;
			if (_prev > 10) then
			{
				[_squadId, _prev - 10] call PRA3_fnc_updateFtLeadership;
			};

			_squadId call PRA3_fnc_broadcastSquadVariable;
			true
		}
		else //Unit not in the squad
		{
			false
		}
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
