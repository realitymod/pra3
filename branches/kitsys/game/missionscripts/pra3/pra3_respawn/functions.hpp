class Respawn
{
	file = "pra3\pra3_respawn\fnc";

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
};
