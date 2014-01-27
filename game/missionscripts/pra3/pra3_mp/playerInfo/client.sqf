#define var(x) private #x; x

waitUntil {!isNull player};

// Update player object on respawn
[
	player call PRA3_fnc_getPlayerUID,
	{
		[
			PRA3_core,
			format["PRA3_player_object_%1", (_this select 0) call PRA3_fnc_getPlayerUID],
			_this select 0,
			__FILE__
		] call PRA3_fnc_setVarBroadcast;
	}
] call PRA3_fnc_registerPlayerRespawnedHandler;
