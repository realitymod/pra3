PRA3_mp_playerConnectedHandlers = [];
PRA3_mp_playerConnectedHandlersCounter = 0;

PRA3_mp_playerDisconnectedHandlers = [];
PRA3_mp_playerDisconnectedHandlersCounter = 0;

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
