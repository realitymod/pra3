#include "scriptDefines.sqh"

/**
 *	Ensures the locally tracked vehicles are in sync with the server list.
 *
 *		(in)  <VOID>
 *		(out) <VOID>
 */

if (isNil "PRA3_player_team" || isNil "PRA3_player_side") exitWith {};
if (isNil "PRA3_map_markedVehicles") then {PRA3_map_markedVehicles = []};

var(_registeredVehs) = PRA3_core getVariable ["PRA3_map_trackedVehicles", []];

var(_toRemove) = [];

{
	var(_vehicle) = _x select 0;
	if (!(_vehicle in _registeredVehs) || _vehicle call PRA3_fnc_getVehicleSide != PRA3_player_side) then
	{
		// Remove the marker for this vehicle
		deleteMarkerLocal (_vehicle getVariable "PRA3_map_marker");
		_vehicle setVariable ["PRA3_map_marker", nil];

		_vehicle removeEventHandler ["getIn",  _vehicle getVariable ["PRA3_map_getInEH", -1]];
		_vehicle removeEventHandler ["getOut", _vehicle getVariable ["PRA3_map_getOutEH", -1]];
		_vehicle removeEventHandler ["killed", _vehicle getVariable ["PRA3_map_killedEH", -1]];

		_toRemove set [count _toRemove, _forEachIndex]; // Remember this vehicle and delete it later
	};
} forEach PRA3_map_markedVehicles;

{
	[PRA3_map_markedVehicles, _x] call PRA3_fnc_arrayRemoveAt;
} forEach _toRemove;

{
	var(_vehicle) = _x;
	if ({_vehicle == _x select 0} count PRA3_map_markedVehicles == 0 && _vehicle call PRA3_fnc_getVehicleSide == PRA3_player_side) then
	{
		// Add marker for this vehicle

		var(_name) = _vehicle call PRA3_fnc_getMarkerForType;
		if (_name == "") then
		{
			_name = "b_unknown";
			[format["Vehicle type %1 has no marker assigned", str (typeOf _vehicle)]] call PRA3_fnc_logWarning;
		};

		var(_marker) = format["PRA3_map_marker_%1", PRA3_map_markerCounter];
		PRA3_map_markerCounter = PRA3_map_markerCounter + 1;

		createMarkerLocal [_marker, getPosATL _vehicle];
		_marker setMarkerDirLocal (getDir _vehicle);
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerTypeLocal _name;
		_marker setMarkerTextLocal "";
		_marker setMarkerColorLocal "ColorBlack";
		_marker setMarkerSizeLocal [1.2, 1.2];

		// Save the vehicle's marker
		_vehicle setVariable ["PRA3_map_marker", _marker];

		PRA3_map_markedVehicles set [count PRA3_map_markedVehicles, [_vehicle, _marker]];

		// Extra handling for mountable vehicles
		if (_vehicle call PRA3_fnc_hasSeats) then
		{
			// Register getIn/getOut event handlers
			var(_handler) =
			{
				{
					_x call PRA3_fnc_updateVehicleMarker //Update markers for...
				} forEach [
					_this select 0, //...the vehicle
					_this select 2  //...the unit who got in/out
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
						"killed",
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
	};
} forEach _registeredVehs;
