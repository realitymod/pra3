class Map
{
	file = "pra3\pra3_map\fnc";

	class getMarkerForType
	{
		description = "Returns name of the marker used for the vehicle type. """" is returned if the vehicle has no marker assigned.";
	};
	class startVehicleTracking
	{
		description = "Starts tracking the vehicle by the map marker system. Returns false if the vehicle is of the wrong side or it is already being tracked. Client-only function.";
	};
	class stopVehicleTracking
	{
		description = "Stops tracking of the vehicle via map markers. Returns false if the vehicle wasn't being tracked. Client-only function.";
	};
	class updateVehicleMarker
	{
	};
	class createMarkers
	{
		description = "Creates markers for all vehicles.";
	};
};
