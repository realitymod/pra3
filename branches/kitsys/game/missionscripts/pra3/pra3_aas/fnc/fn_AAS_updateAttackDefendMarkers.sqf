#include "scriptDefines.sqh"
#include "aas_defines.sqh"

// Server doesn't need markers
if (!isDedicated) then
{
	{
		deleteMarkerLocal _x;
	} forEach PRA3_AAS_attackDefendMarkers;
	PRA3_AAS_attackDefendMarkers resize 0;

	// For attack and defend...
	{
		var(_attack) = _forEachIndex == 0;
		// For each zone...
		{
			var(_pos) = (PRA3_AAS_zones select _x) select 0;
			var(_marker) = createMarkerLocal [
				format["PRA3_AAS_marker_attackDefend_%1", count PRA3_AAS_attackDefendMarkers],
				getMarkerPos _pos
			];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerTypeLocal "mil_objective";
			_marker setMarkerColorLocal (if (_attack) then {"ColorRed"} else {"ColorBlue"});
			PRA3_AAS_attackDefendMarkers set [count PRA3_AAS_attackDefendMarkers, _marker];
		} forEach _x;
	} forEach (PRA3_AAS_teamZones select (PRA3_AAS_sides find playerSide));
};
