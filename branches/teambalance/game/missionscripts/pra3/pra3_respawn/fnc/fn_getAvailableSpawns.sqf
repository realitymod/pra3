#include "scriptDefines.sqh"
#include "defines.sqh"

var(_spawns) = [];

{
	if ([_this, _x] call PRA3_fnc_isSpawnAvailable) then
	{
		_spawns set [count _spawns, _x];
	};
} forEach call PRA3_fnc_getSpawnPoints;

_spawns
