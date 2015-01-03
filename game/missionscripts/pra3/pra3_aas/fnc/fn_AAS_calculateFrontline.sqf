#include "scriptDefines.sqh"
#include "aas_defines.sqh"

/**
 *	Traverses the bases in a DFS-like fashion to determine which zones are available to attack.
 */
var(_traverse) =
{
	var(_zones) = _this select 0;
	var(_idx)   = _this select 1;
	var(_team)  = _this select 2;
	var(_open)  = _this select 3;

	_open set [_idx, false]; //Mark this node as closed

	if (_idx call PRA3_fnc_AAS_getZoneOwner != _team) then
	{
		if (!(_idx in _zones)) then
		{
			_zones set [count _zones, _idx];
		};
	}
	else
	{
		var(_connected)    = ((PRA3_AAS_zones select _idx) select 2) select (PRA3_AAS_sides find _team);
		var(_synchronized) = (PRA3_AAS_zones select _idx) select 1;

		// Make sure there are no sync'ed zones that were NOT captured
		if ({_x call PRA3_fnc_AAS_getZoneOwner != _team && !(_x in _connected)} count _synchronized == 0) then
		{
			// For each connected zone...
			{
				// Make sure we're not coming back
				if (_open select _x) then
				{
					[_zones, _x, _team, _open] call _traverse;
				};
			} forEach _connected;
		};
	};
};

// Reset team zones
{
	PRA3_AAS_teamZones set [_forEachIndex, [nil, []]];
} forEach PRA3_AAS_sides;
// Reset active zones
PRA3_AAS_activeZones resize 0;

// For each team...
{
	var(_teamIndex) = _forEachIndex;

	// Build an open/closed array
	var(_open) = [];
	_open resize (count PRA3_AAS_zones);
	for "_i" from 0 to (count _open)-1 do
	{
		_open set [_i, true];
	};
	var(_zones) = [];
	// For each origin...
	{

		[_zones, _x, PRA3_AAS_sides select _teamIndex, _open] call _traverse; //Start DFS

		(PRA3_AAS_teamZones select _teamIndex) set [0, _zones];

		// For each zone the team has to attack...
		{
			if (!(_x in PRA3_AAS_activeZones)) then
			{
				// Add it to active zones
				PRA3_AAS_activeZones set [count PRA3_AAS_activeZones, _x];
			};

			var(_owner) = _x call PRA3_fnc_AAS_getZoneOwner;
			// Unless the zone is neutral somebody has to defend it
			if (_owner != NEUTRAL_SIDE) then
			{
				// Task the owner with defending it
				var(_defend) = (PRA3_AAS_teamZones select (PRA3_AAS_sides find _owner)) select 1;
				_defend set [count _defend, _x];
			};
		} forEach _zones;
	} forEach _x;
} forEach PRA3_AAS_bases;
