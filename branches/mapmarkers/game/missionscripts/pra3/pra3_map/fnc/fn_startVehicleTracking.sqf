#include "scriptDefines.sqh"

/**
 *	Starts tracking the vehicle by the map marker system.
 *	Returns false if the vehicle is of the wrong side or it is already being tracked.
 *	Client-only function.
 *
 *		(in)  <OBJECT> Vehicle to track
 *		(out) <BOOL> Success
 */

var(_vehicle) = _this;

if (!isDedicated) then
{
	// Only track friendly vehicles
	if (((_vehicle call PRA3_fnc_getVehicleSide) == playerSide) ||
		{_vehicle getVariable ["PRA3_map_marker", ""] != ""}) then
	{
		[__FILE__, format["Registering %1 [%2]", _vehicle, typeOf _vehicle]] call PRA3_fnc_logInfo;

		var(_marker) = format["PRA3_map_marker_%1", PRA3_map_markerCounter];
		PRA3_map_markerCounter = PRA3_map_markerCounter + 1;

		// Save to the tracked vehicles array
		var(_vehicles) = PRA3_core getVariable ["PRA3_map_trackedVehicles", []];
		_vehicles set [count _vehicles, [_vehicle, _marker]];
		PRA3_core setVariable ["PRA3_map_trackedVehicles", _vehicles];

		var(_name) = _vehicle call PRA3_fnc_getMarkerForType;
		if (_name == "") then
		{
			_name = "b_unknown";
			[__FILE__, format["Vehicle type %1 has no marker assigned", str (typeOf _vehicle)]] call PRA3_fnc_logWarning;
		};

		createMarkerLocal [_marker, getPosATL _vehicle];
		_marker setMarkerDirLocal (getDir _vehicle);
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerTypeLocal _name;
		_marker setMarkerTextLocal "";
		_marker setMarkerColorLocal "ColorBlack";
		_marker setMarkerSizeLocal [1.2, 1.2];

		// Save the vehicle's marker
		_vehicle setVariable ["PRA3_map_marker", _marker];
		// Save the marker's vehicle
		PRA3_core setVariable [_marker, _vehicle];

		// Extra handling for mountable vehicles
		if (_vehicle call PRA3_fnc_hasSeats) then
		{
			// Register getIn/getOut event handlers
			var(_handler) =
			{
				{
					_x call PRA3_fnc_updateVehicleMarker //Update markers for...
				} forEach [
					_this select 0,	//...the vehicle
					_this select 2	//...the unit who got in/out
				]
			};

			_vehicle setVariable [
				"PRA3_map_getInEH",
				_vehicle addEventHandler [
					"getIn",
					_handler
				]
			];
			_vehicle setVariable [
				"PRA3_map_getOutEH",
				_vehicle addEventHandler [
					"getOut",
					_handler
				]
			];
			if (local _vehicle) then
			{
				_handler =
				{
					_this select 0 call PRA3_fnc_stopVehicleTracking;
				};
				_vehicle setVariable [
					"PRA3_map_killedEH",
					_vehicle addEventHandler [
						"MPKilled",
						_handler
					]
				];
			};

			// Manually trigger getIn for units that are already inside the vehicle
			{
				_vehicle call PRA3_fnc_updateVehicleMarker;
			} forEach (crew _vehicle);
		}
		else
		{
			_vehicle call PRA3_fnc_updateVehicleMarker;
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
	[__FILE__, "Cannot run on dedicated server"] call PRA3_fnc_logError;
	false
}

