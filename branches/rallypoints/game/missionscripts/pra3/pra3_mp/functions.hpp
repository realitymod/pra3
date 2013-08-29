class PlayerConnected
{
	file = "pra3\pra3_mp\playerConnected\fnc";
	
	class registerPlayerConnectedHandler
	{
		description = "Registers an onPlayerConnected handler.";
	};
	class removePlayerConnectedHandler
	{
		description = "Removes a previously registered onPlayerConnected handler.";
	};
	class registerPlayerDisconnectedHandler
	{
		description = "Registers an onPlayerDisconnected handler.";
	};
	class removePlayerDisconnectedHandler
	{
		description = "Removes a previously registered onPlayerDisconnected handler.";
	};
};

class PlayerRespawned
{
	file = "pra3\pra3_mp\playerRespawned\fnc";

	class registerPlayerRespawnedHandler
	{
		description = "Registers a handler triggered upon player's respawn. The event is triggered publically and each machine can have a different set of handlers.";
	};
	class removePlayerRespawnedHandler
	{
		description = "Removes a previously registered player respawn handler.";
	};
};

class MP
{
	file = "pra3\pra3_mp\fnc";
	
	class MP
	{
		description = "Wrapper for BIS_fnc_MP_packet to make everything call by default.";
	};
};
