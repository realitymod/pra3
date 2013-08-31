#include "scriptDefines.sqh"

/**
 * Ensures that the squad has a leader and if not, the highest ranking member is promoted.
 * Returns false if the squad does not exist or no changes have been made.
 *		(in)  <INT> Squad ID
 *		(out) <BOOL> Changes applied
 */

if (isServer) then
{
	var(_squadId) = _this;

	if (_squadId call PRA3_fnc_squadExists) then
	{
		var(_candidate) = 0;
		var(_squad) = (PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]) select 0;
		// Let's try promoting an FT leader
		{
			// The lower the FT ID is, the higher is the "rank"
			if ((_x select 1) >= 10 &&
				( (_x select 1) < ((_squad select _candidate) select 1) ||
				  (_squad select _candidate) select 1 < 10 )
			) then
			{
				_candidate = _forEachIndex;
			};
		} forEach _squad;
		diag_log ["candidate", _candidate];
		if ((_squad select _candidate) select 1 == 10 || count _squad == 0) then //There already is a SL or the squad doesn't exist
		{
			false
		}
		else
		{
			var(_ft) = (_squad select _candidate) select 1;
			if (_ft >= 10) then
			{
				_ft = _ft - 10;
			};

			[_squadId, (_squad select _candidate) select 0] call PRA3_fnc_squadSetLeader;

			diag_log ["FT", _ft];

			if (_ft > 0) then // FT leader promoted to squad leader, FT needs a new leader.
			{
				[_squadId, _ft] call PRA3_fnc_updateFtLeadership;
			};
			true
		}
	}
	else
	{
		false
	}
}
else
{
	["PRA3_fnc_updateSquadLeadership", "Has to be run server-side"] call PRA3_fnc_logError;
	false
}
