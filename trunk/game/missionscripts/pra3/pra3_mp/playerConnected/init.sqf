PRA3_mp_playerConnectedHandlers = [];
PRA3_mp_playerConnectedHandlersCounter = 0;

PRA3_mp_playerDisconnectedHandlers = [];
PRA3_mp_playerDisconnectedHandlersCounter = 0;

if (isServer) then
{
	onPlayerConnected {
		// A bit of a hackery here since I want to be able to test with two instances.
		// Given they both will have the same UID we have to use some other unique identifier.
		// We'll use the name which is good enough in this case.
		// In live enviromnemnt we still want to use the UID since players can change their names and do dickish things.
		if !isDedicated then
		{
			_uid = _name;
		};
		[[_id, _name, _uid], "PRA3_fnc_executePlayerConnected"] call PRA3_fnc_MP;
	};

	onPlayerDisconnected {
		if !isDedicated then
		{
			_uid = _name;
		};
		[[_id, _name, _uid], "PRA3_fnc_executePlayerDisconnected"] call PRA3_fnc_MP;
	};
};
