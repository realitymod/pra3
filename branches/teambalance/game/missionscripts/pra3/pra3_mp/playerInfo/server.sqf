#define var(x) private #x; x

{
	var(_id)   = _this select 0;
	var(_name) = _this select 1;
	var(_uid)  = _this select 2;

	[format ["PLAYER: _id=%1 _name=%2 _uid=%3", _id, str _name, str _uid], "onPlayerConnected"] call PRA3_fnc_logInfo;
	if (_name != "__SERVER__") then
	{
		var(_players) = PRA3_core getVariable ["PRA3_connectedPlayers", []];
		_players set [count _players, _uid];
		[PRA3_core, "PRA3_connectedPlayers", _players, "praa_mp\playerInfo\server.sqf OPC"] call PRA3_fnc_setVarBroadcast;

		[PRA3_core, format["PRA3_player_name_%1", _uid], _name, "praa_mp\playerInfo\server.sqf OPC"] call PRA3_fnc_setVarBroadcast;

		_uid spawn
		{
			waitUntil {!isNull (_this call PRA3_fnc_getPlayerUnit)};

			var(_unit) = _this call PRA3_fnc_getPlayerUnit;

			var(_balance) = 1 call PRA3_fnc_getUnbalancedSide;
			if (count _balance == 0) then
			{
				[[_unit, side _unit], "PRA3_fnc_switchTeam", _unit] call PRA3_fnc_MP;
			}
			else
			{
				diag_log "Switch side";
				[[_unit, _balance select 1], "PRA3_fnc_switchTeam", _unit] call PRA3_fnc_MP;
			};

			[
				PRA3_core,
				format["PRA3_player_cid_%1", _this],
				owner _unit,
				"praa_mp\playerInfo\server.sqf OPC"
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
		[PRA3_core, "PRA3_connectedPlayers", _players, "praa_mp\playerInfo\server.sqf OPD"] call PRA3_fnc_setVarBroadcast;
	};
} call PRA3_fnc_registerPlayerDisconnectedHandler;
