#include "scriptDefines.sqh"
#include "defines.sqh"

var(_spawns) = [];

{
	var(_name) = markerText (_x select 0);
	if (_name == "") then // Pull the name from the tied zone
	{
		_name = (_x select 1) select 0 call PRA3_fnc_AAS_getZoneName;
	};

	_spawns set [
		count _spawns,
		[
			SPAWN_ZONE,
			_name,
			[
				_x select 0,
				_x select 1,
				{var(_base) = _x; {_base in _x} count PRA3_AAS_bases > 0} count (_x select 1) > 0
			]
		]
	];
} forEach PRA3_AAS_respawns;

{
	_spawns set [
		count _spawns,
		[
			SPAWN_RALLYPOINT,
			"Squad rallypoint",
			[
				_x
			]
		]
	]
} forEach call PRA3_fnc_getRallyPoints;

_spawns
