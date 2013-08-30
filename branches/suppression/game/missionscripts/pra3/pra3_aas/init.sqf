#include "fnc\aas_defines.sqh"

// Add respawn EH to player to delete bodies
// TODO: Have the server do this otherwise the body will not get deleted if player disconnects
if (isClient) then
{
	player addEventHandler ["respawn", {[time + 30, {deleteVehicle _this}, _this select 1] call PRA3_fnc_scheduleToExecute}];
};

PRA3_AAS_ticketBleed = [0,0];
PRA3_AAS_activeZones = []; //Zones that are currently on the frontlines (active) and can be captured by somebody
PRA3_AAS_teamZones = []; //Zones that each team has to capture/defend, indexes have to match those of PRA3_AAS_sides
PRA3_AAS_teamZones resize (count PRA3_AAS_sides);

PRA3_AAS_respawnTime = 30;

var(_init) =
{
	// Initialize each zone and create markers for it
	{
		if (isServer) then
		{
			var(_owner) = _x select 3;
			PRA3_core setVariable [format["PRA3_AAS_%1_owner", _forEachIndex], _owner, true];
			PRA3_core setVariable [format["PRA3_AAS_%1_attacker", _forEachIndex], _owner, true];
			PRA3_core setVariable [format["PRA3_AAS_%1_capture_local", _forEachIndex], if (_owner == __neutral) then {0} else {100}, true];
			PRA3_core setVariable [format["PRA3_AAS_%1_capture_sync", _forEachIndex], if (_owner == __neutral) then {0} else {100}, true];
		};

		if (isClient) then
		{
			var(_mainMarker) = _x select 0;
			_mainMarker setMarkerBrushLocal "SolidBorder";
			PRA3_core setVariable [format["PRA3_AAS_%1_marker_1", _forEachIndex], _mainMarker];

			var(_pos) = getMarkerPos _mainMarker;
			var(_smallMarker) = createMarkerLocal [format["%1_circle_1", _forEachIndex], _pos];
			_smallMarker setMarkerShapeLocal "Ellipse";
			_smallMarker setMarkerBrushLocal "SolidBorder";
			_smallMarker setMarkerSizeLocal [0.3,0.3];
			_smallMarker setMarkerTextLocal "Hello";
			PRA3_core setVariable [format["PRA3_AAS_%1_marker_2", _forEachIndex], _smallMarker];

			var(_location) = createLocation ["NameVillage", _pos, 0, 0];
			_location setText format[" %1", _forEachIndex call PRA3_fnc_AAS_getZoneName];
			PRA3_core setVariable [format["PRA3_AAS_%1_location", _forEachIndex], _location];

			_forEachIndex call PRA3_fnc_AAS_updateZoneMarker;
		};
	} forEach PRA3_AAS_zones;

	PRA3_AAS_attackDefendMarkers = [];

	call PRA3_fnc_AAS_calculateFrontline;
	call PRA3_fnc_AAS_updateAttackDefendMarkers;

	// Now that everything is initialized, start the loop
	execVM "pra3\pra3_aas\loop.sqf";
};

// Client might need to wait so he'll need a scheduled thread
if (isServer) then
{
	call _init;
}
else
{
	_init spawn
	{
		// playerSide will return garbage for JIP players without this wait, causing zone markers to have the wrong colors
		waitUntil {!isNull player};
		
		// We need to make sure the server has initialzed all the zones
		{
			waitUntil {!isNil {PRA3_core getVariable format["PRA3_AAS_%1_owner", _forEachIndex]}};
		} forEach PRA3_AAS_zones;

		call _this;
	};
};