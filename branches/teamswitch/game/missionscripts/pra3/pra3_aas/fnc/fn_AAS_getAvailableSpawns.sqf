#include "scriptDefines.sqh"
#include "aas_defines.sqh"

var(_unit) = _this;

var(_list) = [];
// Find spawns tied to zones...
var(_side) = _unit call PRA3_fnc_getPlayerSide;
{
	// Make sure all tied zones are owned by this side
	if ({!(_x call PRA3_fnc_AAS_getZoneOwner == _side)} count (_x select 2) == 0) then
	{
		_list set [
			count _list,
			_x
		];
	};
} forEach call PRA3_fnc_AAS_getAllSpawns;

_list
