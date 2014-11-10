class Respawn
{
	file = "pra3\pra3_respawn\fnc";

	class getSpawnPoints
	{
		description = "Returns a list of all spawn points in the mission.";
	};
	class getRallyPoints
	{
		description = "Returns a list of all rally points that are currently deployed.";
	};
	class getAvailableSpawns
	{
		description = "Returns a list of all spawn points the unit can respawn at.";
	};
	class isSpawnAvailable
	{
		description = "Checks if the unit can spawn at the given spawn point.";
	};
	class findNearestSpawn
	{
		description = "Returns the nearest spawn point available to the unit from given position with optional distance limit. If no spawn is available, empty string is returned.";
	};
	class getSpawnName
	{
		description = "Returns the name of the spawn";
	};
	class getSpawnPosition
	{
		description = "Returns the position of the spawn";
	};
	class getSpawnDirection
	{
		description = "Returns the direction of the spawn";
	};
	class updateSpawnLocations
	{
		description = "Updates spawn locations if the spawn map is open.";
	};

	class initUnit
	{
		description = "Performs the necessary initialization on the unit after mission start or respawn.";
	};
	class respawnUnit
	{
		description = "Respawns the unit at the given spawn point.";
	};

	class onDeath
	{
		description = "Handles player's death.";
	};

	class respawnOnKeyDown
	{
		description = "Handles onKeyDown.";
	};
	class switchTeamCheck
	{
		description = "Check if the unit switched team and make the switch";
	};

	class spawnMap_onLoad
	{
		description = "";
	};
	class spawnMap_onUnload
	{
		description = "";
	};
	class spawnMap_onMapDraw
	{
		description = "";
	};
	class spawnMap_mapHandle
	{
		description = "";
	};
	class spawnMap_selectNoSpawn
	{
		description = "";
	};
	class spawnMap_populateSpawnLocations
	{
		description = "";
	};
	class spawnMap_toggleTabs
	{
		description = "";
	};
};
