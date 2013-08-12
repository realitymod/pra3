PRA3_map_markerCounter = 0;

if (!isDedicated) then
{
	0 spawn
	{
		waitUntil {!isNull player};

		call PRA3_fnc_createMarkers;

		{call PRA3_fnc_createMarkers} call PRA3_fnc_registerPlayerConnectedHandler;

		execFSM "pra3\pra3_map\updateVehicleMarkers.fsm";
	};
};
