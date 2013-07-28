#include "scriptDefines.sqh"
#include "defines.sqh"

/**
 *	Returns the number of kits the given unit has available.
 *		(in)  <OBJECT> Unit
 *			or
 *		(in)  <STRING> Unit UID
 *		(out) <INT> Number of available kits
 */

var(_unit) = _this select 0;
var(_kit)  = _this select 1;

var(_kitInfo) = _kit call PRA3_fnc_getKitInfo;
var(_requirements) = _kitInfo select KIT_REQUIREMENTS;

switch (_requirements select 0) do
{
	case LIMIT_NO:
	{
		1e10
	};
	case LIMIT_SQUAD:
	{
		var(_max) = [_unit, _kit] call PRA3_fnc_getMaxKitAvailableNum;
		if (_max > 0) then
		{
			var(_members) = _unit call PRA3_fnc_unitGetSquad call PRA3_fnc_squadGetMembers;
			var(_curr) = {_x select 0 call PRA3_fnc_unitGetKit == _kit} count _members;

			(_max - _curr)
		}
		else
		{
			0
		}
	};
	case LIMIT_SL:
	{
		if (
			_unit call PRA3_fnc_isSquadLeader &&
			{
				_requirements select 1 == 0 ||
				{
					(_unit call PRA3_fnc_unitGetSquad call PRA3_fnc_squadGetMembersNum) >= _requirements select 1
				}
			}
		) then {
			1
		} else {
			0
		}
	};
};
