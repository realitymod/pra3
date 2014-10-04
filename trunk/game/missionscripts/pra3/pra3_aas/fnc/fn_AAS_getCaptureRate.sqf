#include "scriptDefines.sqh"
#include "aas_defines.sqh"

/**
 *	Returns the speed of capture for the given zone based on the number of attacking players.
 *
 *		(in)  <ARRAY>:
 *			0 <INT> Zone ID
 *			1 <INT> Number of attackers
 *			2 <INT> Number of defenders
 *		(out) <FLOAT> Capture rate - capture points per second
 */

// Defines the number of connected players from where at least two attackers are required to capture
#define TWO_CAP_THRESHOLD 8

var(_zone)      = _this select 0;
var(_attackers) = _this select 1;
var(_defenders) = _this select 2;

if (PRA3_core getVariable ["PRA3_debug_AAS_fastCap", false]) then
{
	(_attackers - _defenders) * 10
}
else
{
	if (_attackers < 2 && isMultiplayer && call PRA3_fnc_getConnectedPlayers >= TWO_CAP_THRESHOLD) then
	{
		_defenders
	}
	else
	{
		(_attackers - _defenders)
	}
}
