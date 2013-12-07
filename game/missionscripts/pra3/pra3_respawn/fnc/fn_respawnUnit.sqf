#include "scriptDefines.sqh"
#include "defines.sqh"

var(_unit)  = _this select 0;
var(_spawn) = _this select 1;

diag_log str _this;

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
	waitUntil {preloadCamera _pos};
	_unit setPosATL _pos;

	true
}
else
{
	false
}
