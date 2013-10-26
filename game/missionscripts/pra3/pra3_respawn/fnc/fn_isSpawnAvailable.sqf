#include "scriptDefines.sqh"
#include "defines.sqh"

var(_unit)  = _this select 0;
var(_spawn) = _this select 1;

var(_params) = _spawn select 2;

switch (_spawn select 0) do
{
	case SPAWN_RALLYPOINT:
	{
		
	};
	case SPAWN_ZONE:
	{
		var(_side) = _unit call PRA3_fnc_getPlayerSide;
		({!(_x call PRA3_fnc_AAS_getZoneOwner == _side)} count (_params select 1) == 0)
	};
};
