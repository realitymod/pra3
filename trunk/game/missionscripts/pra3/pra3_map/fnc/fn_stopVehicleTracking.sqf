#include "scriptDefines.sqh"

/**
 *	Stops tracking of the vehicle via map markers.
 *	Returns false if the vehicle wasn't being tracked.
 *
 *		(in)  <OBJECT> Vehicle to stop tracking
 *		(out) <BOOL> Success
 */

var(_vehicle) = _this;

var(_vehicles) = PRA3_core getVariable ["PRA3_map_trackedVehicles", []];

if (_vehicle in _vehicles) then
{
	[_vehicles, _vehicle] call PRA3_fnc_arrayRemove;
	PRA3_core setVariable ["PRA3_map_trackedVehicles", _vehicles, true];

	[nil, "PRA3_fnc_refreshVehicleMarkers"] call PRA3_fnc_MP;

	true
}
else
{
	false
}
