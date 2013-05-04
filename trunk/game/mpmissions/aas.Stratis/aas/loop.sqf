#define var(x) private #x; x

#define isClient (!isDedicated)

#define __neutral sideLogic
#define __updateEvery 30

#define __colorFriendly	[0,0.59,0,1]
#define __colorEnemy	[1,1,1,1]
#define __colorNeutral	[0.88,0,0,1]


var(_syncArray) = [];
_syncArray resize (count PRA3_AAS_zones);
{
	_syncArray set [_forEachIndex, -1];
} forEach PRA3_AAS_zones;

var(_time) = time;
var(_sinceUpdate) = 0; //Number of iterations since the last public update
while {true} do
{
	sleep 1;
	var(_debug) = "<t align='left'>";
	var(_playerZone) = objNull;

	// For each zone...
	{
		var(_zone) = _x select 0;

		if (isClient) then
		{
			var(_serverCap) = _zone getVariable ["PRA3_AAS_capture_sync", 0]; // Capture percentage, synchronized from the server
			if (_serverCap != (_syncArray select _forEachIndex)) then
			{
				diag_log text format["Synchronizing zone %1 with server: %2 => %3 (diff %4)",
					_zone,
					_zone getVariable "PRA3_AAS_capture_local",
					_serverCap,
					_serverCap - (_zone getVariable "PRA3_AAS_capture_local")
				];
				_zone setVariable ["PRA3_AAS_capture_local", _serverCap];
				_syncArray set [_forEachIndex, _serverCap];
			};
		};

		var(_id)       = _zone getVariable "PRA3_AAS_id"; // Zone ID
		var(_owner)    = _zone getVariable "PRA3_AAS_owner"; // Owner side
		var(_attacker) = _zone getVariable "PRA3_AAS_attacker"; // Side that is currently capturing
		var(_capture)  = _zone getVariable "PRA3_AAS_capture_local"; // Capture percentage, local to the machine

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
		if (_id in PRA3_AAS_activeZones) then
		{
			// Let's categorize each present player according to his side
			// For each nearby player...
			{
				var(_sideIndex) = PRA3_AAS_sides find (side _x);
				if (_sideIndex != -1) then
				{
					// Make sure the player's side can attack of defend this zone
					if (_id in ((PRA3_AAS_teamZones select _sideIndex) select 0) ||
						_id in ((PRA3_AAS_teamZones select _sideIndex) select 1)) then
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
			} forEach ((getPosATL _zone) nearEntities ["Man", 2]);

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

			var(_capPerSecond) = (_attackersNum - _defendersNum) call PRA3_fAAS_calculateCaptureRate;
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

				_zone setVariable ["PRA3_AAS_attacker", _attackersSide];
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
					_capture = _capture - (call PRA3_fAAS_calculateAutoDecapRate);
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
					_capture = _capture + (call PRA3_fAAS_calculateAutoDecapRate);
				}
				else
				{
					_capture = 100; //Clamp the value
				};
			};
		};

		_zone setVariable ["PRA3_AAS_capture_local", _capture];
		
		// Server side synchronization
		if (isServer) then
		{
			// Only if things have changed
			if (_capture != (_zone getVariable "PRA3_AAS_capture_sync")) then
			{
				// Update owner if needed
				var(_prevOwner) = _zone getVariable "PRA3_AAS_owner";
				if (_prevOwner != _owner) then
				{
					_zone setVariable ["PRA3_AAS_owner", _owner, true];

					[[_zone, _prevOwner], "PRA3_fAAS_updateZone", true] call BIS_fnc_MP;

					_sinceUpdate = __updateEvery; //Enforce update if the zone owner changes
				};

				// Periodically update clients too
				_zone setVariable [
					"PRA3_AAS_capture_sync",
					_capture,
					_sinceUpdate >= __updateEvery
				];
			};
		};

		_debug = format["%1%2: %3 %4/%5<br/>",
			_debug,
			_zone,
			_zone getVariable "PRA3_AAS_capture_local",
			_zone getVariable "PRA3_AAS_owner",
			_zone getVariable "PRA3_AAS_attacker"
		];
	} forEach PRA3_AAS_zones;

	// ---------- HANDLE DISPLAYING OF CAPTURE BAR ----------
	if (isClient) then
	{
		// Check if player is capturing himself
		if (isNull _playerZone) then
		{
			55 cutText ["", "PLAIN"];
		}
		else
		{
			var(_smooth) = true;
			if (isNull(uiNamespace getVariable ["PRA3_AAS_captureIndicator", displayNull])) then
			{
				55 cutRsc ["PRA3_AAS_captureIndicator", "PLAIN"];
				_smooth = false;
			};

			#define ctrl(x) ((uiNamespace getVariable "PRA3_AAS_captureIndicator") displayCtrl x)

			var(_capture) = _playerZone getVariable "PRA3_AAS_capture_local";
			var(_side) = _playerZone getVariable "PRA3_AAS_attacker";

			var(_pos) = ctrlPosition ctrl(1);
			_pos set [2, (0.39 * _capture / 100)];
			ctrl(1) ctrlSetPosition _pos;
			ctrl(1) ctrlSetBackgroundColor (
				if (_side == playerSide) then {
					[0,0.59,0,1]
				} else {
					if (_side == __neutral) then {
						[1,1,1,1]
					} else {
						[0.88,0,0,1]
					}
				}
			);
			ctrl(1) ctrlCommit (if (_smooth) then {1} else {0});
		};
	};

	// ---------- HANDLE TICKET BLEED ----------
	var(_tickets) = PRA3_core getVariable "PRA3_AAS_tickets";
	{
		var(_bleed) = (_x / 60) * (time - _time);
		_tickets set [
			_forEachIndex,
			(_tickets select _forEachIndex) - _bleed
		];
	} forEach PRA3_AAS_ticketBleed;

	if (isServer) then
	{
		if (_sinceUpdate >= __updateEvery &&
			!([_tickets, PRA3_core getVariable "PRA3_AAS_tickets"] call PRA3_fVar_equals)) then
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

	hintSilent parseText format["%1<br/>Tickets: %2<br/>Bleed: %3</t>", _debug, PRA3_core getVariable "PRA3_AAS_tickets", PRA3_AAS_ticketBleed];

	_time = time;
};
