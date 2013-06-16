#include "scriptDefines.sqh"

var(_unit)  = _this select 0;
var(_spawn) = _this select 1;

if (_spawn != "") then
{
	// Make sure we can still spawn there
	if ({_spawn == (_x select 0)} count (_unit call PRA3_fnc_AAS_getAvailableRespawns) > 0) then
	{
		// Find some good position to spawn
		var(_pos) = markerPos _spawn findEmptyPosition [0, 20, typeOf _unit];
		_unit setPosATL _pos;

		true
	}
	else
	{
		false
	}
}
else
{
	false
}
