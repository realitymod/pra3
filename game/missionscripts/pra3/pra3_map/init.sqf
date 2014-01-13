PRA3_map_markerCounter = 0;
PRA3_map_markedVehicles = [];

if (!isDedicated) then
{
	0 spawn
	{
		waitUntil {!isNull player};

		execFSM "pra3\pra3_map\updateVehicleMarkers.fsm";
	};
};
