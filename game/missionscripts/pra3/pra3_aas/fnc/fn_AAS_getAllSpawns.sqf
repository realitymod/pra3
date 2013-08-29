#include "scriptDefines.sqh"
#include "aas_defines.sqh"

var(_list) = [];
// Find spawns tied to zones...
{
	var(_isMain) = {var(_base) = _x; {_base in _x} count PRA3_AAS_bases == 0} count (_x select 1) == 0;
	var(_name) = markerText (_x select 0);
	if (_name == "") then // Pull the name from the tied zone
	{
		_name = ((_x select 1) select 0) call PRA3_fnc_AAS_getZoneName;
	};
	_list set [
		count _list,
		[
			_x select 0,
			_name,
			_x select 1,
			if _isMain then {0} else {1}
		]
	];
} forEach PRA3_AAS_respawns;

_list
