#define var(x) private #x; x

waitUntil {!isNull player};

var(_uid) = player call PRA3_fnc_getPlayerUID;
[PRA3_core, format["PRA3_player_object_%1", _uid], player, __FILE__, __LINE__] call PRA3_fnc_setVarBroadcast;
[PRA3_core, format["PRA3_player_side_%1", _uid], playerside, __FILE__, __LINE__] call PRA3_fnc_setVarBroadcast;

// Update player object on respawn
[
	_uid,
	{
		[
			PRA3_core,
			format["PRA3_player_object_%1", (_this select 0) call PRA3_fnc_getPlayerUID],
			_this select 0,
			__FILE__
		] call PRA3_fnc_setVarBroadcast;
	}
] call PRA3_fnc_registerPlayerRespawnedHandler;
