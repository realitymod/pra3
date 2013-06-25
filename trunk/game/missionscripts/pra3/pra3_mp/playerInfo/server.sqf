#define var(x) private #x; x

{
	["onPlayerConnected", format ["PLAYER: _id=%1 _name=%2 _uid=%3", _id, str _name, str _uid]] call PRA3_fnc_logInfo;
	if (_name != "__SERVER__") then
	{
		var(_players) = PRA3_core getVariable ["PRA3_connectedPlayers", []];
		_players set [count _players, _uid];
		[PRA3_core, "PRA3_connectedPlayers", _players, "praa_mp\playerInfo\server.sqf OPC"] call PRA3_fnc_setVarBroadcast;
		
		[PRA3_core, format["PRA3_player_name_%1", _uid], _name, "praa_mp\playerInfo\server.sqf OPC"] call PRA3_fnc_setVarBroadcast;
		_uid spawn
		{
			waitUntil {!isNull(_this call PRA3_fnc_getPlayerUnit)};
			PRA3_core setVariable [format["PRA3_player_cid_%1", _this], owner (_this call PRA3_fnc_getPlayerUnit), true];
		};
	};
} call PRA3_fnc_registerPlayerConnectedHandler;

{
	["onPlayerDisconnected", format ["PLAYER: _id=%1 _name=%2 _uid=%3", _id, str _name, str _uid]] call PRA3_fnc_logInfo;
	if (_name != "__SERVER__") then
	{
		var(_players) = PRA3_core getVariable ["PRA3_connectedPlayers", []];
		[_players, _uid] call PRA3_fnc_arrayRemove;
		[PRA3_core, "PRA3_connectedPlayers", _players, "praa_mp\playerInfo\server.sqf OPD"] call PRA3_fnc_setVarBroadcast;
	};
} call PRA3_fnc_registerPlayerDisconnectedHandler;
