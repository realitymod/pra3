PRA3_mp_playerConnectedHandlers = [];
PRA3_mp_playerConnectedHandlersCounter = 0;

PRA3_mp_playerDisconnectedHandlers = [];
PRA3_mp_playerDisconnectedHandlersCounter = 0;

onPlayerConnected {
	[[_id, _name, _uid], "PRA3_fnc_executePlayerConnected"] call PRA3_fnc_MP;
};

onPlayerDisconnected {
	[[_id, _name, _uid], "PRA3_fnc_executePlayerDisconnected"] call PRA3_fnc_MP;
};
