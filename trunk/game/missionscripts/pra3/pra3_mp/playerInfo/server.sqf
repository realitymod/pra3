#define var(x) private #x; x

{
	var(_id)   = _this select 0;
	var(_name) = _this select 1;
	var(_uid)  = _this select 2;

	[format ["PLAYER: _id=%1 _name=%2 _uid=%3", _id, str _name, str _uid], "onPlayerConnected"] call PRA3_fnc_logInfo;
	if (_name != "__SERVER__") then
	{
		// Figure out which side the player should be put on
		var(_balance) = 1 call PRA3_fnc_getUnbalancedSide;
		var(_targetSide) = if (count _balance == 0) then {
			PRA3_AAS_sides select 0
		} else {
			_balance select 1
		};

		// Register the player as connected
		var(_players) = PRA3_core getVariable ["PRA3_connectedPlayers", []];
		_players set [count _players, _uid];
		[PRA3_core, "PRA3_connectedPlayers", _players, "pra3_mp\playerInfo\server.sqf OPC"] call PRA3_fnc_setVarBroadcast;

		// And remember his name
		[PRA3_core, format["PRA3_player_name_%1", _uid], _name, "pra3_mp\playerInfo\server.sqf OPC"] call PRA3_fnc_setVarBroadcast;

		// ...his side
		[PRA3_core, format["PRA3_player_side_%1", _uid], _targetSide, "pra3_mp\playerInfo\server.sqf OPC"] call PRA3_fnc_setVarBroadcast;

		// ...and the unit he's playing as
		var(_unit) = objNull;
		{
			if (name _x == _name) exitWith
			{
				_unit = _x;

				[PRA3_core, format["PRA3_player_object_%1", _uid], _x, "pra3_mp\playerInfo\server.sqf OPC"] call PRA3_fnc_setVarBroadcast;

				if !isDedicated then
				{
					[_x, "PRA3_UID", _name, "pra3_mp\playerInfo\server.sqf OPC"] call PRA3_fnc_setVarBroadcast;
				};
			};
		} forEach allUnits;

		// Switch him to the correct team and save his client ID, we'll have to wait for his unit to exist for this...
		[_uid, _targetSide, _unit, _name] spawn
		{
			var(_uid)        = _this select 0;
			var(_targetSide) = _this select 1;
			var(_unit)       = _this select 2;
			var(_name)       = _this select 3;

			// In case of JIP we may not have found the unit. Try again.
			waitUntil
			{
				{
					if (name _x == _name) exitWith
					{
						_unit = _x;
					};
				} forEach allUnits;

				!isNull _unit
			};

			diag_log [__FILE__, "PLAYER CONNECTED", _uid, _targetSide, _unit];

			_unit call PRA3_fnc_startVehicleTracking;

			[[_unit, _targetSide], "PRA3_fnc_switchTeam", _unit] call PRA3_fnc_MP;

			[
				PRA3_core,
				format["PRA3_player_cid_%1", _uid],
				owner _unit,
				"pra3_mp\playerInfo\server.sqf OPC"
			] call PRA3_fnc_setVarBroadcast;
		};
	};
} call PRA3_fnc_registerPlayerConnectedHandler;

{
	var(_id)   = _this select 0;
	var(_name) = _this select 1;
	var(_uid)  = _this select 2;

	[format ["PLAYER: _id=%1 _name=%2 _uid=%3", _id, str _name, str _uid], "onPlayerDisconnected"] call PRA3_fnc_logInfo;
	if (_name != "__SERVER__") then
	{
		var(_players) = PRA3_core getVariable ["PRA3_connectedPlayers", []];
		[_players, _uid] call PRA3_fnc_arrayRemove;
		[PRA3_core, "PRA3_connectedPlayers", _players, "pra3_mp\playerInfo\server.sqf OPD"] call PRA3_fnc_setVarBroadcast;
	};
} call PRA3_fnc_registerPlayerDisconnectedHandler;
