#include "scriptDefines.sqh"

var(_position)    = _this select 0;
var(_player)      = _this select 1;
var(_maxDistance) = if (count _this > 2) then {_this select 2} else {1e1000};

var(_closestSpawn) = "";
var(_closestDist) = _maxDistance;
{
	if (markerPos (_x select 0) distance _position < _closestDist) then
	{
		_closestSpawn = _x select 0;
		_closestDist = markerPos (_x select 0) distance _position;
	};
} forEach (_player call PRA3_fnc_getAvailableSpawns);

_closestSpawn
