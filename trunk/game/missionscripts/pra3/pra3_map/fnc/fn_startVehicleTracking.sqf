#include "scriptDefines.sqh"

/**
 *	Starts tracking the vehicle by the map marker system.
 *	Returns false if the vehicle is already being tracked.
 *
 *		(in)  <OBJECT> Vehicle to track
 *		(out) <BOOL> Success
 */

var(_vehicle) = _this;

var(_vehicles) = PRA3_core getVariable ["PRA3_map_trackedVehicles", []];

if (_vehicle in _vehicles) then
{
	false
}
else
{
	_vehicles set [count _vehicles, _vehicle];
	PRA3_core setVariable ["PRA3_map_trackedVehicles", _vehicles, true];

	[nil, "PRA3_fnc_refreshVehicleMarkers"] call PRA3_fnc_MP;

	true
}
