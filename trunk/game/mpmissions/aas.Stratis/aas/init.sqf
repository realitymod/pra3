#define var(x) private #x; x

#define isClient (!isDedicated)

#define __neutral sideLogic
#define __updateEvery 30

#define __colorFriendly	[0,0.59,0,1]
#define __colorEnemy	[1,1,1,1]
#define __colorNeutral	[0.88,0,0,1]

call compile preprocessFileLineNumbers "aas\functions.sqf";

PRA3_AAS_ticketBleed = [0,0];
PRA3_AAS_activeZones = []; //Zones that are currently on the frontlines (active) and can be captured by somebody
PRA3_AAS_teamZones = []; //Zones that each team has to capture/defend, indexes have to match those of PRA3_AAS_sides
PRA3_AAS_teamZones resize (count PRA3_AAS_sides);

// Initialize each zone and create markers for it
{
	var(_zone) = _x select 0;
	if (isServer) then
	{
		var(_owner) = _x select 3;
		_zone setVariable ["PRA3_AAS_id", _forEachIndex, true];
		_zone setVariable ["PRA3_AAS_owner", _owner, true];
		_zone setVariable ["PRA3_AAS_attacker", _owner, true];
		_zone setVariable ["PRA3_AAS_capture_local", if (_owner == __neutral) then {0} else {100}, true];
		_zone setVariable ["PRA3_AAS_capture_sync", if (_owner == __neutral) then {0} else {100}, true];
	};

	if (isClient) then
	{
		var(_marker) = createMarkerLocal [format["%1_circle_1", _zone], getPosATL _zone];
		_marker setMarkerShapeLocal "Ellipse";
		_marker setMarkerBrushLocal "SolidBorder";
		_marker setMarkerSizeLocal [0.3,0.3];
		_zone setVariable ["PRA3_AAS_marker_1", _marker];

		_marker = createMarkerLocal [format["%1_circle_2", _zone], getPosATL _zone];
		_marker setMarkerShapeLocal "Ellipse";
		_marker setMarkerBrushLocal "Border";
		_marker setMarkerSizeLocal [5,5];
		_zone setVariable ["PRA3_AAS_marker_2", _marker];

		_zone call PRA3_fAAS_updateZoneMarkerColor;
	};
} forEach PRA3_AAS_zones;

call PRA3_fAAS_calculateFrontline;
call PRA3_fAAS_updateAttackDefendMarkers;

// Now that everything is initialized, start the loop
execVM "aas\loop.sqf";
