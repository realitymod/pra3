#include "scriptDefines.sqh"

/**
 * Returns ID of the fireteam the unit is assigned to.
 * Returns -1 if the unit does not belong to the squad, 0 if the unit has no FT assigned.
 *		(in)  <ARRAY>:
 *			0 <INT> Squad ID
 *			1 <OBJECT> Unit
 *				OR
 *			1 <STRING> Unit UID
 *		(out) <INT> Fireteam ID
 */

var(_squadId) = _this select 0;
var(_unit) = _this select 1;

var(_ft) = -1;

if (_squadId call PRA3_fnc_squadExists) then
{
	var(_squad) = (PRA3_core getVariable format["PRA3_squadSys_squad_%1", _squadId]) select 0;
	{
		if ((_x select 0) == _unit) exitWith
		{
			_ft = _x select 1;
			if (_ft > 9) then
			{
				_ft = _ft - 10;
			};
		};
	} forEach _squad;
};

_ft
