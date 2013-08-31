#include "scriptDefines.sqh"

/*
 * Returns UID of the squad's fireteam leader.
 * Returns an empty string if the squad or FT does not exist, or the FT has no leader.
 *		(in)  <ARRAY>:
 *			0 <INT> Squad ID
 *			1 <INT> Fireteam ID
 *		(out) <STRING> Leader UID
 */

var(_squadId) = _this select 0;
var(_ft) = _this select 1;

var(_leader) = "";
if (_squadId call PRA3_fnc_squadExists) then
{
	var(_squad) = (PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]) select 0;
	{
		if (((_x select 1) - _ft) == 10) exitWith
		{
			_leader = _x select 0;
		};
	} forEach _squad;
};

_leader
