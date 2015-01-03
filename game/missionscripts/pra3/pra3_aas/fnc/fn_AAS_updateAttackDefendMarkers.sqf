#include "scriptDefines.sqh"
#include "aas_defines.sqh"

// Server doesn't need markers
if (!isDedicated) then
{
	{
		deleteMarkerLocal _x;
	} forEach PRA3_AAS_attackDefendMarkers;
	PRA3_AAS_attackDefendMarkers resize 0;

	{
		player removeSimpleTask _x;
	} forEach PRA3_AAS_attackDefendTasks;
	PRA3_AAS_attackDefendTasks resize 0;

	var(_side)  = PRA3_player_side;
	_side       = PRA3_AAS_sides find _side;
	var(_index) = if (_side == -1) then {0} else {_side};

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
			_marker setMarkerSizeLocal [0.75,0.75];
			_marker setMarkerColorLocal (if (_attack) then {"ColorOrange"} else {"ColorCIV"});

			var(_task) = player createSimpleTask [""];
			var(_zoneName) = _x call PRA3_fnc_AAS_getZoneName;
			if _attack then
			{
				_task setSimpleTaskDescription [
					format ["Eliminate the enemy at %1 and capture the zone.", _zoneName],
					format ["Capture %1", _zoneName],
					"Capture"
				];
			}
			else
			{
				_task setSimpleTaskDescription [
					format ["Defend %1 and prevent the enemy from capturing it.", _zoneName],
					format ["Defend %1", _zoneName],
					"Defend"
				];
			};
			_task setSimpleTaskDestination getMarkerPos _pos;

			PRA3_AAS_attackDefendMarkers set [count PRA3_AAS_attackDefendMarkers, _marker];
			PRA3_AAS_attackDefendTasks set [count PRA3_AAS_attackDefendTasks, _task];
		} forEach _x;
	} forEach (PRA3_AAS_teamZones select _index);
};
