#include "scriptDefines.sqh"
#include "aas_defines.sqh"

{
	_forEachIndex call PRA3_fnc_AAS_updateZoneMarker;
} forEach PRA3_AAS_zones;

call PRA3_fnc_AAS_calculateFrontline;
call PRA3_fnc_AAS_updateAttackDefendMarkers;
call PRA3_fnc_AAS_calculateTicketBleed;
