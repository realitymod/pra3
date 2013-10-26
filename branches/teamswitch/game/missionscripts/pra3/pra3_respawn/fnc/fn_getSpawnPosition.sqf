#include "scriptDefines.sqh"
#include "defines.sqh"

switch (_this select 0) do
{
	case SPAWN_RALLYPOINT:
	{
		[0,0,0]
	};
	case SPAWN_ZONE:
	{
		markerPos (_this select 2 select 0)
	};
};
