class AAS
{
	file = "pra3\pra3_aas\fnc";
	
	class AAS_calculateFrontline
	{
		description = "Determies which zones need to be attacked and defended and updates the UI accordingly.";
	};
	class AAS_calculateTicketBleed
	{
		description = "Calculates the ticket bleed each side should have based on the ownership of zones.";
	};
	class AAS_getAutoUncapRate
	{
		description = "Returns the automatic uncapture rate for the given zone.";
	};
	class AAS_getCaptureRate
	{
		description = "Returns the speed of capture for the given zone based on the number of attacking players.";
	};
	class AAS_getAvailableSpawns
	{
		description = "Returns an array of places the given unit can respawn at.";
	};
	class AAS_getAllSpawns
	{
		description = "Returns an array of all respawn points.";
	};
	class AAS_getZoneName
	{
		description = "Returns the name of the zone.";
	};
	class AAS_getZoneOwner
	{
		description = "Returns which side that owns the zone.";
	};
	class AAS_updateAttackDefendMarkers
	{
		description = "Updates the display of attack and defend markers.";
	};
	class AAS_captureZone
	{
		description = "Performs all necessary updates upon capturing the zone.";
	};
	class AAS_updateZoneMarker
	{
		description = "Updates the zone's marker.";
	};
	
	class AAS_removeTickets
	{
		description = "Removes a certain amount of tickets from the team.";
	};
};
