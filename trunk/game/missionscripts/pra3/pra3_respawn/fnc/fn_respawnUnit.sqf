#include "scriptDefines.sqh"
#include "defines.sqh"

#define RANDOM_DIR 40

var(_unit)  = _this select 0;
var(_spawn) = _this select 1;

if (count _spawn > 0) then
{
	if (_spawn select 0 == SPAWN_RALLYPOINT) then
	{
		// Decrease RP tickets
		var(_rally) = _spawn select 2 select 0;
		var(_tickets) = (_rally getVariable "PRA3_rally_tickets") - 1;
		if (_tickets > 0) then
		{
			_rally setVariable ["PRA3_rally_tickets", _tickets, true];
		}
		else
		{
			// Delete it
			deleteVehicle _rally;
		};
	};

	// Find some good position to spawn
	var(_pos) = _spawn call PRA3_fnc_getSpawnPosition findEmptyPosition [0, 20, typeOf _unit];

	// Get direction and randomize it a bit
	var(_dir) = (_spawn call PRA3_fnc_getSpawnDirection) + RANDOM_DIR * 0.5 - random RANDOM_DIR;

	// Wait for the position to be loaded
	waitUntil {preloadCamera _pos};

	// Move the unit there
	_unit setDir _dir;
	_unit setPosATL _pos;

	true
}
else
{
	false
}
