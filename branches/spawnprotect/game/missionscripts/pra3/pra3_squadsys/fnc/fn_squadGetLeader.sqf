#include "scriptDefines.sqh"

/**
 * Returns UID of the squad's leader.
 * Returns an empty string if the squad does not exist.
 *		(in)  <INT> Squad ID
 *		(out) <STRING> Leader UID
 */

var(_squadId) = _this;

var(_leader) = "";
if (_squadId call PRA3_fnc_squadExists) then
{
	var(_squad) = (PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId] select 0);
	{
		if ((_x select 1) == 10) exitWith //Find squad leader
		{
			_leader = _x select 0;
		};
	} forEach _squad;
};

_leader
