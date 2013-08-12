#include "scriptDefines.sqh"

/**
 *	Stops tracking of the vehicle via map markers.
 *	Returns false if the vehicle wasn't being tracked.
 *	Client-only function.
 *
 *		(in)  <OBJECT> Vehicle to stop tracking
 *		(out) <BOOL> Success
 */

var(_vehicle) = _this;

if (!isDedicated) then
{
	var(_removed) = false;
	// Find the vehicle and remove it
	var(_vehicles) = PRA3_core getVariable ["PRA3_map_trackedVehicles", []];
	{
		if ((_x select 0) == _vehicle) exitWith
		{
			[_vehicles, _forEachIndex] call PRA3_fnc_arrayRemoveAt;
			_removed = true;
		};
	} forEach _vehicles;

	if (_removed) then
	{
		[format["Unregistering %1 [%2]", _vehicle, typeOf _vehicle]] call PRA3_fnc_logInfo;

		PRA3_core setVariable ["PRA3_map_trackedVehicles", _vehicles];

		var(_marker) = _vehicle getVariable ["PRA3_map_marker", ""];
		if (_marker != "") then
		{
			deleteMarker _marker;

			_vehicle setVariable ["PRA3_map_marker", nil];
			PRA3_core setVariable [_marker, nil];

			if (_vehicle call PRA3_fnc_hasSeats) then
			{
				// Unregister getIn/getOut EHs
				_vehicle removeEventHandler ["getIn", _vehicle getVariable "PRA3_map_getInEH"];
				_vehicle setVariable ["PRA3_map_getInEH", nil];
				_vehicle removeEventHandler ["getOut", _vehicle getVariable "PRA3_map_getOutEH"];
				_vehicle setVariable ["PRA3_map_getOutEH", nil];
			};

			true
		}
		else
		{
			false
		}
	}
	else
	{
		false
	}
}
else
{
	["Cannot run on dedicated server"] call PRA3_fnc_logError;
	false
}
