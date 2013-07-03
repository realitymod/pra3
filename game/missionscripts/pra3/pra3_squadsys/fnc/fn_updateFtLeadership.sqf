#include "scriptDefines.sqh"

/**
 * Ensures that the squad's fireteam has a leader and if not, the highest ranking member of the fireteam is promoted.
 * Returns false if the squad does not exist or no changes have been made.
 *		(in)  <ARRAY>:
 *			0 <INT> Squad ID
 *			1 <INT> Fireteam ID
 *		(out) <BOOL> Changes applied
 */

if (isServer) then
{
	var(_squadId) = _this select 0;
	var(_ft) = _this select 1;

	if (_squadId call PRA3_fnc_squadExists) then
	{
		var(_candidate) = -1;
		var(_members) = (PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]) select 0;
		for "_i" from (count _members)-1 to 0 step -1 do
		{
			var(_x) = _members select _i;
			if (_x select 1 == (_ft + 10)) exitWith //FT already has a leader
			{
				_candidate = -1;
			};
			if (_x select 1 == _ft) then
			{
				_candidate = _i;
			};
		};
		if (_candidate == -1) then
		{
			false
		}
		else
		{
			[_squadId, _ft, (_members select _candidate) select 0] call PRA3_fnc_squadSetFtLeader;
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
	["PRA3_fnc_updateFtLeadership", "Has to be run server-side"] call PRA3_fnc_logError;
	false
}
