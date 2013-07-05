PRA3_map_markerCounter = 0;

if (!isDedicated) then
{
	0 spawn
	{
		waitUntil {!isNull player};
		{
			_x call PRA3_fnc_startVehicleTracking;
		} forEach allUnits;

		execFSM "pra3\pra3_map\updateVehicleMarkers.fsm";
	};
};
