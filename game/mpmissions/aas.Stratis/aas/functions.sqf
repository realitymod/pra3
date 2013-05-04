#define var(x) private #x; x

#define isClient (!isDedicated)

#define __neutral sideLogic
#define __updateEvery 30

#define __colorFriendly	[0,0.59,0,1]
#define __colorEnemy	[1,1,1,1]
#define __colorNeutral	[0.88,0,0,1]

PRA3_fVar_equals =
{
	var(_var1) = _this select 0;
	var(_var2) = _this select 1;

	if (isNil "_var1" || {isNil "_var2"} || {typeName _var1 != typeName _var2}) then
	{
		false
	}
	else
	{
		switch (toUpper(typeName _var1)) do
		{
			case "ARRAY":
			{
				if (count _var1 != count _var2) then
				{
					false
				}
				else
				{
					var(_equals) = true;
					for "_i" from 0 to ((count _var1) - 1) do
					{
						if (!([_var1 select _i, _var2 select _i] call PRA3_fVar_equals)) exitWith
						{
							_equals = false;
						};
					};

					_equals
				}
			};
			case "BOOL":
			{
				((_var1 && _var2) || (!_var1 && !_var2))
			};
			case "CODE":
			{
				(str _var1 == str _var2)
			};
			default
			{
				(_var1 == _var2)
			};
		};
	}
};

PRA3_fAAS_updateZoneMarkerColor =
{
	var(_side) = _this getVariable "PRA3_AAS_owner";
	var(_color) = (
		if (_side == playerSide) then {
			"ColorGreen"
		} else {
			if (_side == __neutral) then {
				"ColorBlack"
			} else {
				"ColorRed"
			}
		}
	);

	(_this getVariable "PRA3_AAS_marker_1") setMarkerColorLocal _color;
	(_this getVariable "PRA3_AAS_marker_2") setMarkerColorLocal _color;
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
					_pos
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

		if (((PRA3_AAS_zones select _idx) select 0) getVariable "PRA3_AAS_owner" != _team) then
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
			if ({((PRA3_AAS_zones select _x) select 0) getVariable "PRA3_AAS_owner" != _team && !(_x in _connected)} count _synchronized == 0) then
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

				var(_owner) = ((PRA3_AAS_zones select _x) select 0) getVariable "PRA3_AAS_owner";
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
		var(_owner) = (_x select 0) getVariable "PRA3_AAS_owner";
		if (_owner != __neutral) then
		{
			var(_bleed) = _x select 4;
			var(_sync)  = _x select 1;
			// For each team...
			{
				if (_x != _owner &&
					{
						var(_o) = ((PRA3_AAS_zones select _x) select 0) getVariable "PRA3_AAS_owner";
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

PRA3_fAAS_updateZone =
{
	diag_log "PRA3_fAAS_updateZone";
	var(_zone) = _this select 0;
	var(_prevOwner) = _this select 1;
	
	if (isClient) then
	{
		if (_prevOwner == __neutral) then
		{
			player globalChat format["%1 captured %2", _zone getVariable "PRA3_AAS_owner", _zone];
		}
		else
		{
			player globalChat format["%1 lost control of %2", _prevOwner, _zone];
		};
	};
	
	_zone call PRA3_fAAS_updateZoneMarkerColor;
	call PRA3_fAAS_calculateFrontline;
	call PRA3_fAAS_updateAttackDefendMarkers;
	call PRA3_fAAS_calculateTicketBleed;
};
