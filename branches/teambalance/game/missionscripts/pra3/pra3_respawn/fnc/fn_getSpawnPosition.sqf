#include "scriptDefines.sqh"
#include "defines.sqh"

switch (_this select 0) do
{
	case SPAWN_RALLYPOINT:
	{
		getPosATL (_this select 2 select 0)
	};
	case SPAWN_ZONE:
	{
		markerPos (_this select 2 select 0)
	};
};
