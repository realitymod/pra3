PRA3_map_markerCounter = 0;

if (!isDedicated) then
{
	0 spawn
	{
		waitUntil {!isNull player};

		execFSM "pra3\pra3_map\updateVehicleMarkers.fsm";
	};
};
