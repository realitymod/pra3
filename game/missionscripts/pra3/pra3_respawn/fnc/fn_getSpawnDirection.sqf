#include "scriptDefines.sqh"
#include "defines.sqh"

switch (_this select 0) do
{
	case SPAWN_RALLYPOINT:
	{
		getDir (_this select 2 select 0)
	};
	case SPAWN_ZONE:
	{
		markerDir (_this select 2 select 0)
	};
};
