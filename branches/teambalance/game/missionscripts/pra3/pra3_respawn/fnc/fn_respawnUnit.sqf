#include "scriptDefines.sqh"

var(_unit)  = _this select 0;
var(_spawn) = _this select 1;

diag_log str _this;

if (count _spawn > 0) then
{
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
