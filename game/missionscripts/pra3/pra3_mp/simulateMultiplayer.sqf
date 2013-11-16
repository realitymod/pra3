#define var(x) private #x; x

/**
 * Simulates multiplayer conditions in singleplayer
 * by assigning each unit a unique identifier (UID)
 * and triggering the onPlayerConnected events.
 */

var(_unit) = _this;

if (isNil "PRA3_mp_playerInfoSpUID") then
{
	PRA3_mp_playerInfoSpUID = 0;
};

// Assign the UID
_unit setVariable ["PRA3_UID", str PRA3_mp_playerInfoSpUID];

// Stop them from shooting each other
_unit setBehaviour "CARELESS";

// Trigger onPlayerConnected
[PRA3_mp_playerInfoSpUID, _unit] spawn
{
	waitUntil {!isNil "PRA3_core"};
	[_this select 0, name (_this select 1), str (_this select 0)] call PRA3_fnc_executePlayerConnected;
};

PRA3_mp_playerInfoSpUID = PRA3_mp_playerInfoSpUID + 1;

[
	PRA3_core,
	format["PRA3_player_object_%1", _unit call PRA3_fnc_getPlayerUID],
	_unit,
	__FILE__,
	__LINE__
] call PRA3_fnc_setVarBroadcast;
[
	PRA3_core,
	format["PRA3_player_side_%1", _unit call PRA3_fnc_getPlayerUID],
	side _unit,
	__FILE__,
	__LINE__
] call PRA3_fnc_setVarBroadcast;
[
	PRA3_core,
	format["PRA3_player_team_%1", _unit call PRA3_fnc_getPlayerUID],
	{if (_x call PRA3_fnc_getTeamSide == side _unit) exitWith {_x}} forEach PRA3_AAS_teams,
	__FILE__,
	__LINE__
] call PRA3_fnc_setVarBroadcast;
