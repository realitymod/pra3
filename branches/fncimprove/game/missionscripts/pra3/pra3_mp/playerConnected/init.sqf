PRA3_mp_playerConnectedHandlers = [];
PRA3_mp_playerConnectedHandlersCounter = 0;

PRA3_mp_playerDisconnectedHandlers = [];
PRA3_mp_playerDisconnectedHandlersCounter = 0;

{
	missionNamespace setVariable [
		_x,
		compileFinal preprocessFileLineNumbers format["pra3\pra3_mp\playerConnected\fnc\%1.sqf", _x]
	];
} forEach [
	"PRA3_fMp_registerPlayerConnectedHandler",
	"PRA3_fMp_registerPlayerDisconnectedHandler",
	"PRA3_fMp_unregisterPlayerConnectedHandler",
	"PRA3_fMp_unregisterPlayerDisconnectedHandler"
];

onPlayerConnected {
	{
		call (_x select 0);
	} forEach PRA3_mp_playerConnectedHandlers;
};

onPlayerDisconnected {
	{
		call (_x select 0);
	} forEach PRA3_mp_playerDisconnectedHandlers;
};
