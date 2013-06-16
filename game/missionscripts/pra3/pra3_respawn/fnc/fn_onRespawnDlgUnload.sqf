#include "scriptDefines.sqh"

// Hide all spawn markers
{
	(_x select 0) setMarkerTypeLocal "EMPTY";
} forEach PRA3_AAS_respawns;

// Delete selection marker
deleteMarkerLocal "PRA3_selectedSpawn";
