#include "scriptDefines.sqh"
#include "defines.sqh"

/**
 *	Returns the max number of kits that could be available to the give unit.
 *		(in)  <ARRAY>:
 *			0 <OBJECT> Unit
 *				OR
 *			0 <STRING> Unit UID
 *			1 <STRING> Kit
 *		(out) <INT> Number of possibly available kits
 */

var(_unit) = _this select 0;
var(_kit)  = _this select 1;

var(_kitInfo) = _kit call PRA3_fnc_getKitInfo;
var(_requirements) = _kitInfo select KIT_REQUIREMENTS;

switch (_requirements select 0) do
{
	case LIMIT_NO:
	{
		__inf
	};
	case LIMIT_SQUAD:
	{
		var(_membersNum) = _unit call PRA3_fnc_unitGetSquad call PRA3_fnc_squadGetMembersNum;
		if (
			_unit call PRA3_fnc_isInSquad &&
			{
				_requirements select 2 == 0 ||
				{
					_membersNum >= _requirements select 2
				}
			}
		) then {
			floor(_membersNum / (_requirements select 1)) min (_requirements select 3)
		} else {
			0
		}
	};
	case LIMIT_SL:
	{
		1
	};
};
