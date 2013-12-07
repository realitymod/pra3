#define var(x) private #x; x

var(_uid) = (_this select 0) call PRA3_fnc_getPlayerUID;
var(_handlers) = PRA3_core getVariable [format["PRA3_mp_playerRespawnedHandlers_%1", _uid], []];
[format ["PLAYER RESPAWNED: %1", str _this], "PRA3_fMp_playerRespawnedHandler"] call PRA3_fnc_logInfo;

{
	_this call (_x select 0);
} forEach _handlers;
