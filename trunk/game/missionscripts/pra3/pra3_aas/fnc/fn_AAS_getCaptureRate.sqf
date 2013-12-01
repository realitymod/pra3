#include "scriptDefines.sqh"
#include "aas_defines.sqh"

/**
 *	Returns the speed of capture for the given zone based on the number of attacking players.
 *
 *		(in)  <ARRAY>:
 *			0 <INT> Zone ID
 *			1 <INT> Number of capturing players
 *		(out) <FLOAT> Capture rate
 */

var(_zone)      = _this select 0;
var(_attackers) = _this select 1;

if (PRA3_core getVariable ["PRA3_debug_AAS_fastCap", false]) then
{
	_attackers * 10
}
else
{
	_attackers
};
