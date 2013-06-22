class Array
{
	file = "pra3\pra3_functions\array";
	
	class arrayFind
	{
		description = "Searches the array and returns the index of the first match or -1 if no match is found. String comparison is case insensitive. Does not perform deep search for nested arrays.";
	};
	class arrayInsert
	{
		description = "Inserts the element at the specified index of the array.";
	};
	class arrayRemove
	{
		description = "Removes the first element that matches the value from the array. The array is modified directly. Returns true if the element was found and removed.";
	};
	class arrayRemoveAt
	{
		description = "Removes the element at the specified index of the input array. The array is modified directly. Returns false if the index is out of bounds.";
	};
};

class Debug
{
	file = "pra3\pra3_functions\debug";
	
	class logError
	{
		description = "Logs the error message and alerts the user via hint.";
	};
	class logWarning
	{
		description = "Logs the warning message.";
	};
	class logInfo
	{
		description = "Logs the message.";
	};
};

class Math
{
	file = "pra3\pra3_functions\math";
	
	class isPointInPolygon
	{
		description = "Checks if the point is inside of the polygon.";
	};
	class isPointInMarker
	{
		description = "Checks if the point is inside of the marker.";
	};
};

class Net
{
	file = "pra3\pra3_functions\net";
	
	class setVarBroadcast
	{
		description = "Sets a variable on the object and broadcasts it across the multiplayer clients. Logs the event if PRA3_net_debug is enabled.";
	};
};

class Players
{
	file = "pra3\pra3_functions\players";
	
	class getConnectedPlayers
	{
		description = "Returns an array of UIDs of all connected players.";
	};
	class getPlayerCID
	{
		description = "Returns client ID for the given unit. Returns -1 if CID cannot be determined.";
	};
	class getPlayerName
	{
		description = "Returns name of the unit. Returns an empty string if the name cannot be determined.";
	};
	class getPlayerSide
	{
		description = "Returns the side the player unit is on (even when dead). Returs sideLogic if side cannot be determined.";
	};
	class getPlayerUID
	{
		description = "Returns UID for the given unit. Returns empty string if UID cannot be determined.";
	};
	class getPlayerUnit
	{
		description = "Returns object player with the given UID is currently controlling. Returns a null object if the UID is invalid.";
	};
};
