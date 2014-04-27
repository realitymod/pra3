#include "fnc\aas_defines.sqh"

PRA3_AAS_ticketBleed = [0,0];
PRA3_AAS_activeZones = []; //Zones that are currently on the frontlines (active) and can be captured by somebody
PRA3_AAS_teamZones = []; //Zones that each team has to capture/defend, indexes have to match those of PRA3_AAS_sides
PRA3_AAS_teamZones resize (count PRA3_AAS_sides);

PRA3_AAS_prepareTime = 15;
PRA3_AAS_respawnTime = 30;
PRA3_AAS_spawnAtTime = PRA3_AAS_prepareTime;

var(_init) =
{
	// Initialize each zone and create markers for it
	{
		if isServer then
		{
			var(_owner) = (_x select 3) call PRA3_fnc_getTeamSide;
			PRA3_core setVariable [format["PRA3_AAS_%1_owner", _forEachIndex], _owner, true];
			PRA3_core setVariable [format["PRA3_AAS_%1_attacker", _forEachIndex], _owner, true];
			PRA3_core setVariable [format["PRA3_AAS_%1_capture_local", _forEachIndex], if (_owner == __neutral) then {0} else {100}, true];
			PRA3_core setVariable [format["PRA3_AAS_%1_capture_sync", _forEachIndex], if (_owner == __neutral) then {0} else {100}, true];
		};

		if isClient then
		{
			var(_mainMarker) = _x select 0;
			_mainMarker setMarkerBrushLocal "SolidBorder";
			PRA3_core setVariable [format["PRA3_AAS_%1_marker_1", _forEachIndex], _mainMarker];

			var(_pos) = getMarkerPos _mainMarker;
			var(_smallMarker) = createMarkerLocal [format["%1_circle_1", _forEachIndex], _pos];
			_smallMarker setMarkerShapeLocal "Ellipse";
			_smallMarker setMarkerBrushLocal "SolidBorder";
			_smallMarker setMarkerSizeLocal [0.3,0.3];
			_smallMarker setMarkerTextLocal "";
			PRA3_core setVariable [format["PRA3_AAS_%1_marker_2", _forEachIndex], _smallMarker];

			var(_location) = createLocation ["NameVillage", _pos, 0, 0];
			_location setText format[" %1", _forEachIndex call PRA3_fnc_AAS_getZoneName];
			PRA3_core setVariable [format["PRA3_AAS_%1_location", _forEachIndex], _location];

			_forEachIndex call PRA3_fnc_AAS_updateZoneMarker;

			if (!isNil "PRA3_debug_zoneParticles") then
			{
				var(_createSource) =
				{
					var(_owner) = _forEachIndex call PRA3_fnc_AAS_getZoneOwner;
					_source = "#particlesource" createVehicleLocal (_this select 0);
					_source setParticleParams [
						["\A3\data_f\ParticleEffects\Universal\Universal.p3d",16, 12, 13, 0],
						"",
						"Billboard",
						1,
						25,
						[0,0,0],
						[0,0,_this select 2],
						0,
						1.275,
						1,
						0,
						_this select 1,
						[
							if (_owner == sideLogic) then {
								[0,0,0,1]
							} else {
								if (_owner == playerSide) then {
									[0,0,1,1]
								} else {
									[1,0,0,1]
								}
							}
						],
						[1000],
						1,
						0,
						"",
						"",
						""
					];
					_source setDropInterval (_this select 3);
				};
				[markerPos _mainMarker, [5,5], 3, 1] call _createSource;
				if (markerShape _mainMarker == "RECTANGLE") then
				{
					var(_size) = markerSize _mainMarker;
					var(_dir)  = markerDir _mainMarker;
					var(_b) = +(_size select 1);
					for "_a" from -(_size select 0) to (_size select 0) step 1.5 do
					{
						[
							[
								(markerPos _mainMarker select 0) - (_a * cos _dir) + (_b * sin _dir),
								(markerPos _mainMarker select 1) + (_a * sin _dir) + (_b * cos _dir),
								-1
							],
							[3,3],
							0.3,
							4
						] call _createSource;
					};
					var(_b) = -(_size select 1);
					for "_a" from -(_size select 0) to (_size select 0) step 1.5 do
					{
						[
							[
								(markerPos _mainMarker select 0) - (_a * cos _dir) + (_b * sin _dir),
								(markerPos _mainMarker select 1) + (_a * sin _dir) + (_b * cos _dir),
								-1
							],
							[3,3],
							0.3,
							4
						] call _createSource;
					};
					var(_a) = -(_size select 0);
					for "_b" from -(_size select 1) to (_size select 1) step 1.5 do
					{
						[
							[
								(markerPos _mainMarker select 0) - (_a * cos _dir) + (_b * sin _dir),
								(markerPos _mainMarker select 1) + (_a * sin _dir) + (_b * cos _dir),
								-1
							],
							[3,3],
							0.3,
							4
						] call _createSource;
					};
					var(_a) = +(_size select 0);
					for "_b" from -(_size select 1) to (_size select 1) step 1.5 do
					{
						[
							[
								(markerPos _mainMarker select 0) - (_a * cos _dir) + (_b * sin _dir),
								(markerPos _mainMarker select 1) + (_a * sin _dir) + (_b * cos _dir),
								-1
							],
							[3,3],
							0.3,
							4
						] call _createSource;
					};
				}
				else
				{
					var(_a) = markerSize _mainMarker select 0;
					var(_b) = markerSize _mainMarker select 1;
					var(_dir) = markerDir _mainMarker;
					for "_i" from 0 to 360 step 2 do
					{
						var(_x) = _a * _b / sqrt(_b^2 + _a^2 * ((tan _i)^2));
						if (_i >= 180) then {_x = -_x};
						var(_y) = tan _i * _x;
						[
							[
								(markerPos _mainMarker select 0) - (_x * cos _dir) + (_y * sin _dir),
								(markerPos _mainMarker select 1) + (_x * sin _dir) + (_y * cos _dir),
								-1
							],
							[3,3],
							0.3,
							4
						] call _createSource;
					};
				};
			};
		};
	} forEach PRA3_AAS_zones;

	{
		var(_box)           = _x select 3 select 0;
		var(_allowRedeploy) = _x select 3 select 1;

		_box allowDamage false;
		if (local _box) then
		{
			// For whatever reason the local commands don't actually work despite running on all clients...
			clearBackpackCargoGlobal _box;
			clearMagazineCargoGlobal _box;
			clearWeaponCargoGlobal _box;
		};

		if _allowRedeploy then
		{
			_box addAction ["<t color=""#99FF00"">REDEPLOY / KIT SELECTION</t>", "pra3\pra3_respawn\redeploy.sqf"];
		}
		else
		{
			_box addAction ["<t color=""#99FF00"">KIT SELECTION</t>", "pra3\pra3_respawn\changeKit.sqf"];
		};
	} forEach PRA3_AAS_respawns;

	PRA3_AAS_attackDefendMarkers = [];

	call PRA3_fnc_AAS_createRestrictedZones; //Build restriction zones
	call PRA3_fnc_AAS_createRandomDoor; //Create random door positions
	call PRA3_fnc_AAS_calculateFrontline;
	call PRA3_fnc_AAS_updateAttackDefendMarkers;

	// Apply spawn protection (invincibility in main bases)
	player addEventHandler [
		"handleDamage",
		{
			_this call PRA3_fnc_unitHit
		}
	];

	// Now that everything is initialized, start the loop
	execVM "pra3\pra3_aas\loop.sqf";
};

// Client might need to wait so he'll need a scheduled thread
if isDedicated then
{
	call _init;
}
else
{
	_init spawn
	{
		// playerSide will return garbage for JIP players without this wait, causing zone markers to have the wrong colors
		waitUntil {!isNull player};

		// Wait for server to assign side and team
		waitUntil {!isNil "PRA3_player_side"};

		if !isServer then
		{
			// We need to make sure the server has initialized all the zones
			{
				waitUntil {!isNil {PRA3_core getVariable format["PRA3_AAS_%1_owner", _forEachIndex]}};
			} forEach PRA3_AAS_zones;
		};

		diag_log "AAS client start init";
		call _this;
	};
};

if isClient then
{
	execVM "pra3\pra3_respawn\missionStart.sqf";
};
