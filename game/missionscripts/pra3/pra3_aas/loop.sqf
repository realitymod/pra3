#include "fnc\aas_defines.sqh"

var(_syncArray) = [];
_syncArray resize (count PRA3_AAS_zones);
{
	_syncArray set [_forEachIndex, -1];
} forEach PRA3_AAS_zones;

var(_hudLayer) = ["PRA3_AAS_captureIndicator"] call BIS_fnc_rscLayer;
var(_time) = time;
var(_sinceUpdate) = 0; //Number of iterations since the last public update
while {true} do
{
	sleep 1;
	var(_debug) = "<t align='left'>";
	var(_playerZone) = -1;

	// For each zone...
	{
		var(_zone) = _forEachIndex;

		if (isClient) then
		{
			var(_serverCap) = PRA3_core getVariable [format["PRA3_AAS_%1_capture_sync", _zone], 0]; // Capture percentage, synchronized from the server
			if (_serverCap != (_syncArray select _forEachIndex)) then
			{
				diag_log text format["Synchronizing zone %1 with server: %2 => %3 (diff %4)",
					_zone,
					PRA3_core getVariable format["PRA3_AAS_%1_capture_local", _zone],
					_serverCap,
					_serverCap - (PRA3_core getVariable format["PRA3_AAS_%1_capture_local", _zone])
				];
				PRA3_core setVariable [format["PRA3_AAS_%1_capture_local", _zone], _serverCap];
				_syncArray set [_forEachIndex, _serverCap];
			};
		};

		var(_owner)    = PRA3_core getVariable format["PRA3_AAS_%1_owner", _zone]; // Owner side
		var(_attacker) = PRA3_core getVariable format["PRA3_AAS_%1_attacker", _zone]; // Side that is currently capturing
		var(_capture)  = PRA3_core getVariable format["PRA3_AAS_%1_capture_local", _zone]; // Capture percentage, local to the machine

		// ---------- HANDLE CAPTURING ----------

		var(_attackersNum) = 0;
		var(_attackersIndex) = -1;
		var(_attackersSide) = _owner;
		var(_playersPresent) = [];
		_playersPresent resize (count PRA3_AAS_sides);
		{
			_playersPresent set [_forEachIndex, []];
		} forEach PRA3_AAS_sides;

		// Zone can acutally be captured
		if (_zone in PRA3_AAS_activeZones) then
		{
			// Let's categorize each present player according to his side
			var(_marker) = _x select 0;
			var(_markerSize) = markerSize _marker;
			var(_dist) = (
				if (markerShape _marker == "RECTANGLE") then
				{
					sqrt((_markerSize select 0)^2 + (_markerSize select 1)^2)
				}
				else
				{
					(_markerSize select 0) max (_markerSize select 1)
				}
			);
			// For each nearby player...
			{
				if ([getPosATL _x, _marker] call PRA3_fnc_isPointInMarker) then
				{
					var(_sideIndex) = PRA3_AAS_sides find (_x call PRA3_fnc_getPlayerSide);
					if (_sideIndex != -1) then
					{
						// Make sure the player's side can attack or defend this zone
						if (_zone in ((PRA3_AAS_teamZones select _sideIndex) select 0) ||
							_zone in ((PRA3_AAS_teamZones select _sideIndex) select 1)) then
						{
							var(_arr) = _playersPresent select _sideIndex;
							_arr set [count _arr, _x];
							if (isClient) then
							{
								if (player == _x) then
								{
									_playerZone = _zone;
								};
							};
						};
					};
				};
			} forEach ((getMarkerPos _marker) nearEntities ["Man", _dist]);

			// Determine which side is attacking
			{
				if (count(_x) > _attackersNum) then
				{
					_attackersNum = count(_x);
					_attackersIndex = _forEachIndex;
					_attackersSide = PRA3_AAS_sides select _attackersIndex;
				};
			} forEach _playersPresent;
		};

		if (_attackersNum > 0) then //Somebody is capturing
		{
			// Determine number of defending players
			var(_defendersNum) = 0;
			for "_i" from 0 to (count PRA3_AAS_sides)-1 do
			{
				if (_i != _attackersIndex) then
				{
					_defendersNum = _defendersNum + count(_playersPresent select _i);
				};
			};

			var(_capPerSecond) = [_zone, _attackersNum - _defendersNum] call PRA3_fnc_AAS_getCaptureRate;
			var(_cap) = _capPerSecond * (time - _time);

			if (_attackersSide == _attacker) then
			{
				if (_capture < 100) then
				{
					_capture = _capture + _cap;
				};
			}
			else
			{
				if (_capture > 0) then
				{
					_capture = _capture - _cap;
				};
			};

			if (_capture <= 0) then
			{
				var(_prevOwner) = _owner;

				PRA3_core setVariable [format["PRA3_AAS_%1_attacker", _zone], _attackersSide];
				_owner = __neutral;
				_capture = 0;
			}
			else
			{
				if (_capture >= 100) then
				{
					_owner = _attackersSide;
					_capture = 100;
				};
			};
		}
		else //No one present, slowly neutralize/recapture on its own
		{
			if (_owner == __neutral) then
			{
				if (_capture > 0) then
				{
					_capture = _capture - (_zone call PRA3_fnc_AAS_getAutoUncapRate);
				}
				else
				{
					_capture = 0; //Clamp the value
				};
			}
			else
			{
				if (_capture < 100) then
				{
					_capture = _capture + (_zone call PRA3_fnc_AAS_getAutoUncapRate);
				}
				else
				{
					_capture = 100; //Clamp the value
				};
			};
		};

		PRA3_core setVariable [format["PRA3_AAS_%1_capture_local", _zone], _capture];

		// Server side synchronization
		if (isServer) then
		{
			// Only if things have changed
			if (_capture != (PRA3_core getVariable format["PRA3_AAS_%1_capture_sync", _zone])) then
			{
				// Update owner if needed
				var(_prevOwner) = _zone call PRA3_fnc_AAS_getZoneOwner;
				if (_prevOwner != _owner) then
				{
					PRA3_core setVariable [format["PRA3_AAS_%1_owner", _zone], _owner, true];

					[[_zone, _prevOwner], "PRA3_fnc_AAS_captureZone", true] call PRA3_fnc_MP;

					_sinceUpdate = __updateEvery; //Enforce update if the zone owner changes
				};

				// Periodically update clients too
				PRA3_core setVariable [
					format["PRA3_AAS_%1_capture_sync", _zone],
					_capture,
					_sinceUpdate >= __updateEvery
				];
			};
		};

		_debug = format["%1%2: %3 %4/%5<br/>",
			_debug,
			_zone,
			PRA3_core getVariable format["PRA3_AAS_%1_capture_local", _zone],
			PRA3_core getVariable format["PRA3_AAS_%1_owner", _zone],
			PRA3_core getVariable format["PRA3_AAS_%1_attacker", _zone]
		];
	} forEach PRA3_AAS_zones;

	// ---------- HANDLE DISPLAYING OF CAPTURE BAR ----------
	if (isClient) then
	{
		// Check if player is capturing himself
		if (_playerZone == -1) then
		{
			_hudLayer cutText ["", "PLAIN"];
		}
		else
		{
			var(_smooth) = true;
			if (isNull(uiNamespace getVariable ["PRA3_AAS_captureIndicator", displayNull])) then
			{
				_hudLayer cutRsc ["PRA3_AAS_captureIndicator", "PLAIN"];
				_smooth = false;
			};

			#define ctrl(x) ((uiNamespace getVariable "PRA3_AAS_captureIndicator") displayCtrl x)

			var(_capture) = PRA3_core getVariable format["PRA3_AAS_%1_capture_local", _playerZone];
			var(_side)    = PRA3_core getVariable format["PRA3_AAS_%1_attacker", _playerZone];

			var(_pos) = ctrlPosition ctrl(1);
			_pos set [2, (0.39 * _capture / 100)];
			ctrl(1) ctrlSetPosition _pos;
			ctrl(1) ctrlSetBackgroundColor (
				if (_side == playerSide) then {
					__colorFriendly
				} else {
					if (_side == __neutral) then {
						__colorNeutral
					} else {
						__colorEnemy
					}
				}
			);
			ctrl(1) ctrlCommit (if (_smooth) then {1} else {0});
		};
	};

	// ---------- HANDLE TICKET BLEED ----------
	
	var(_tickets) = PRA3_core getVariable "PRA3_AAS_tickets";
	
	// Check for game over...
	var(_gameOver) = false;
	{
		if (_x < 0) exitWith
		{
			_gameOver = true;
		};
	} forEach _tickets;

	if (!_gameOver) then // Only if the game hasn't ended yet
	{
		{ // For each team's ticket bleed...
			var(_bleed) = (_x / 60) * (time - _time);
			var(_newVal) = (_tickets select _forEachIndex) - _bleed;
			// Only server can have < 0 tickets because < 0 marks game over
			if (_newVal < 0 && !isServer) then
			{
				_newVal = 0;
			};
			_tickets set [
				_forEachIndex,
				_newVal
			];
		} forEach PRA3_AAS_ticketBleed;
	};

	if (isServer) then
	{
		if ( (_sinceUpdate >= __updateEvery &&
			!([_tickets, PRA3_core getVariable "PRA3_AAS_tickets"] call BIS_fnc_areEqual) ) ||
			_gameOver
			) then
		{
			PRA3_core setVariable ["PRA3_AAS_tickets", _tickets, true];
		};

		_sinceUpdate = _sinceUpdate + 1;
		// Reset the update counter if needed
		if (_sinceUpdate > __updateEvery) then
		{
			_sinceUpdate = 0;
		};
	};
	
	if (_gameOver) exitWith // End the game
	{
		if (!isNull player) then
		{
			vehicle player enableSimulation false;
		};
		
		//NOTE: This part does not support >2 teams correctly
		var(_winner) = 0;
		var(_maxTickets) = _tickets select 0;
		for "_i" from 1 to (count _tickets)-1 do
		{
			// Check for draw
			if (round (_tickets select _i) == round _maxTickets) exitWith
			{
				_winner = -1;
			};
			if ((_tickets select _i) > _maxTickets) then
			{
				_maxTickets = _tickets select _i;
				_winner = _i;
			};
		};
		
		if (_winner == -1) then
		{
			["draw", false, true] call BIS_fnc_endMission;
		}
		else
		{
			[format["end%1", _winner + 1], isClient && {PRA3_AAS_sides select _winner == playerSide}, true] call BIS_fnc_endMission;
		};
	};

	hintSilent parseText format["%1<br/>Tickets: %2<br/>Bleed: %3</t>", _debug, PRA3_core getVariable "PRA3_AAS_tickets", PRA3_AAS_ticketBleed];

	_time = time;
};
