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
_unit setVariable ["PRA3_UID", name _unit];

// Stop them from shooting each other
_unit setBehaviour "CARELESS";
_unit disableAI "MOVE";
_unit disableAI "TARGET";
_unit disableAI "AUTOTARGET";

// Trigger onPlayerConnected
[PRA3_mp_playerInfoSpUID, name _unit, name _unit] call PRA3_fnc_executePlayerConnected;
