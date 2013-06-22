#include "scriptDefines.sqh"
#include "aas_defines.sqh"

// TODO: Extend logic for rally points
var(_unit) = _this;

var(_list) = [];
// Find spawns tied to zones...
var(_side) = _unit call PRA3_fnc_getPlayerSide;
{
	// Make sure all tied zones are owned by this side
	if ({_x call PRA3_fnc_AAS_getZoneOwner != _side} count (_x select 1) == 0) then
	{
		var(_name) = markerText (_x select 0);
		if (_name == "") then // Pull the name from the tied zone
		{
			_name = ((_x select 1) select 0) call PRA3_fnc_AAS_getZoneName;
		};
		_list set [count _list, [_x select 0, _name]];
	};
} forEach PRA3_AAS_respawns;

_list
