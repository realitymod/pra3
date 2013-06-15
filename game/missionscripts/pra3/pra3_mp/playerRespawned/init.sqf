#define var(x) private #x; x

PRA3_fMp_playerRespawnedHandler =
{
	var(_uid) = (_this select 0) call PRA3_fnc_getPlayerUID;
	var(_handlers) = PRA3_core getVariable [format["PRA3_mp_playerRespawnedHandlers_%1", _uid], []];
	["PRA3_fMp_playerRespawnedHandler", format ["PLAYER RESPAWNED: %1", str _this]] call PRA3_fDebug_logInfo;

	{
		_this call (_x select 0);
	} forEach _handlers;
};

if (!isDedicated) then
{
	//Add the MP EH to the player unit
	0 spawn
	{
		waitUntil {!isNull player};
		// NOTE: We cannot use MPRespawn because that doesn't actually work properly as of 1.62 - it doesn't execute for other clients!
		player addEventHandler ["Respawn", {[_this, "PRA3_fMp_playerRespawnedHandler"] call BIS_fnc_MP}];
	};
};
