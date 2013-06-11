#include "defines.sqh"

PRA3_fAAS_updateZoneMarkerColor =
{
	var(_side) = _this call PRA3_fAAS_getOwner;
	var(_color) = (
		if (_side == playerSide) then {
			"ColorBLUFOR"
		} else {
			if (_side == __neutral) then {
				"ColorBlack"
			} else {
				"ColorOPFOR"
			}
		}
	);

	(PRA3_core getVariable format["PRA3_AAS_%1_marker_1", _this]) setMarkerColorLocal _color;
	(PRA3_core getVariable format["PRA3_AAS_%1_marker_2", _this]) setMarkerColorLocal _color;
};

PRA3_AAS_attackDefendMarkers = [];

PRA3_fAAS_updateAttackDefendMarkers =
{
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
};

PRA3_fAAS_calculateFrontline =
{
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

		if (_idx call PRA3_fAAS_getOwner != _team) then
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
			if ({_x call PRA3_fAAS_getOwner != _team && !(_x in _connected)} count _synchronized == 0) then
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

				var(_owner) = _x call PRA3_fAAS_getOwner;
				// Unless the zone is neutral somebody has to defend it
				if (_owner != __neutral) then
				{
					// Task the owner with defending it
					var(_defend) = (PRA3_AAS_teamZones select (PRA3_AAS_sides find _owner)) select 1;
					_defend set [count _defend, _x];
				};
			} forEach _zones;
		} forEach _x;
	} forEach PRA3_AAS_bases;
};

PRA3_fAAS_calculateTicketBleed =
{
	// Reset to 0
	{
		PRA3_AAS_ticketBleed set [_forEachIndex, 0];
	} forEach PRA3_AAS_sides;

	// Now add up the bleed for each zone
	// For each zone...
	{
		var(_owner) = _forEachIndex call PRA3_fAAS_getOwner;
		if (_owner != __neutral) then
		{
			var(_bleed) = _x select 4;
			var(_sync)  = _x select 1;
			// For each team...
			{
				if (_x != _owner &&
					{
						var(_o) = _x call PRA3_fAAS_getOwner;
						_o == __neutral || _o != _owner
					} count _sync == 0
					&& (_bleed select _forEachIndex) > 0) then
				{
					PRA3_AAS_ticketBleed set [
						_forEachIndex,
						(PRA3_AAS_ticketBleed select _forEachIndex) + (_bleed select _forEachIndex)
					];
				};
			} forEach PRA3_AAS_sides;
		};
	} forEach PRA3_AAS_zones;
};

/**
 *	Calculates speed of capture for human players.
 *
 *		(in) <INT> Number of capturing players
 */
PRA3_fAAS_calculateCaptureRate =
{
	(_this * 10)
};

/**
 *	Calculates speed of automatic decapture if no human players are present.
 */
PRA3_fAAS_calculateAutoDecapRate =
{
	1
};

PRA3_fAAS_getZoneName =
{
	var(_marker) = (PRA3_AAS_zones select _this) select 0;

	markerText _marker
};

PRA3_fAAS_updateZone =
{
	diag_log "PRA3_fAAS_updateZone";
	var(_zone) = _this select 0;
	var(_prevOwner) = _this select 1;

	if (isClient) then
	{
		if (_prevOwner == __neutral) then
		{
			player globalChat format["%1 captured %2", _zone call PRA3_fAAS_getOwner, _zone call PRA3_fAAS_getZoneName];
		}
		else
		{
			player globalChat format["%1 lost control of %2", _prevOwner, _zone call PRA3_fAAS_getZoneName];
		};
	};

	_zone call PRA3_fAAS_updateZoneMarkerColor;
	call PRA3_fAAS_calculateFrontline;
	call PRA3_fAAS_updateAttackDefendMarkers;
	call PRA3_fAAS_calculateTicketBleed;
};

PRA3_fAAS_getOwner =
{
	PRA3_core getVariable format["PRA3_AAS_%1_owner", _this]
};

PRA3_fAAS_getAvailableRespawns =
{
	var(_side) = _this;

	var(_list) = [];
	{
		// Make sure all tied zones are owned by this side
		if ({_x call PRA3_fAAS_getOwner != _side} count (_x select 1) == 0) then
		{
			var(_name) = markerText (_x select 0);
			if (_name == "") then // Pull the name from the tied zone
			{
				_name = ((_x select 1) select 0) call PRA3_fAAS_getZoneName;
			};
			_list set [count _list, [_x select 0, _name]];
		};
	} forEach PRA3_AAS_respawns;

	_list
};
