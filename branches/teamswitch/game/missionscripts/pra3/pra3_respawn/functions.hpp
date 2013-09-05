class Respawn
{
	file = "pra3\pra3_respawn\fnc";

	class getAllSpawns
	{
		description = "Returns a list of all spawn points in the mission.";
	};
	class getAvailableSpawns
	{
		description = "Returns a list of all spawn points the unit can respawn at.";
	};
	class isSpawnAvailable
	{
		description = "Checks if the unit can spawn at the given spawn point.";
	};
	class respawnUnit
	{
		description = "Respawns the unit at the given spawn point.";
	};
	class refreshRespawnDlg
	{
		description = "Refreshes the spawn points in the spawn selection screen.";
	};

	class onDeath
	{
		description = "Handles player's death.";
	};

	class onRespawnDlgLoad
	{
		description = "Handles opening of the spawn selection dialog.";
	};
	class onRespawnDlgUnload
	{
		description = "Handles closing of the spawn selection dialog.";
	};
	class respawnDlgAction
	{
		description = "Handles actions performed in the spawn selection dialog.";
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
};
