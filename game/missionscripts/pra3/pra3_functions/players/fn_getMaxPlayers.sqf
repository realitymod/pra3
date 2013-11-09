/**
 *	Return the maximum ammount of players for this mission
 *
 *		(in)  nothing
 *		(out) <integer> Max Players
 */

#include "scriptDefines.sqh"

getNumber(missionConfigFile >> "Header" >> "maxPlayers");
