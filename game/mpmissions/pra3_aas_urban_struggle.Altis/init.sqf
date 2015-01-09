#include "pra3\pra3_aas\fnc\aas_defines.sqh"

PRA3_debug_zoneParticles    = true;
PRA3_debug_skipMissionStart = true;

[
	// Opposing teams
	["CSAT", "AAF"],
	// Initial tickets
	[500, 300],
	// Capture zones
	[
	/*   ZONE    | SYNC WITH              | CONNECTS TO       | INITIAL | TICKET BLEED */
	/*   MARKER  |  team1      team2      |  team1    team2   | OWNER   |  team1 team2 */
		["zone0",  [[        ],[        ]], [[1    ], [     ]], "CSAT",   [0,    0  ]], // CSAT main
		["zone1",  [[        ],[        ]], [[2,3  ], [     ]], "",       [0,    0  ]], // Beachside
		["zone2",  [[3       ],[        ]], [[4    ], [     ]], "AAF",    [6,    0  ]], // Old Church
		["zone3",  [[2       ],[        ]], [[5,6  ], [     ]], "AAF",    [6,    0  ]], // Portside
		["zone4",  [[        ],[        ]], [[8    ], [     ]], "AAF",    [3,    2  ]], // Hospital
		["zone5",  [[        ],[        ]], [[7,8  ], [6    ]], "AAF",    [3,    2  ]], // Kavala Center
		["zone6",  [[        ],[        ]], [[5,7  ], [     ]], "AAF",    [3,    1  ]], // Port
		["zone7",  [[        ],[        ]], [[8    ], [6    ]], "AAF",    [3,    2  ]], // Pier
		["zone8",  [[4,5,6,7 ],[        ]], [[9    ], [4,5,7]], "AAF",    [2,    3  ]], // River South
		["zone9",  [[        ],[        ]], [[10,11], [8    ]], "AAF",    [0,    4  ]], // River North
		["zone10", [[        ],[11,12,13]], [[12   ], [9    ]], "AAF",    [0,    5  ]], // Gas Station
		["zone11", [[        ],[10,12,13]], [[13   ], [9    ]], "AAF",    [0,    5  ]], // Outskirts
		["zone12", [[10,11,13],[        ]], [[14   ], [10   ]], "AAF",    [0,    6  ]], // Warehouses
		["zone13", [[10,11,12],[        ]], [[14   ], [11   ]], "AAF",    [0,    6  ]], // Ancient Ruins
		["zone14", [[        ],[        ]], [[     ], [12,13]], "AAF",    [0,    INF]], // Last Stand
		["zone15", [[        ],[        ]], [[     ], [14   ]], "AAF",    [0,    0  ]]  // AAF main
	],
	// Bases for each team, indexes have to match those of PRA3_AAS_sides
	[[0], [15]],
	// Respawn definitions
	[
	/*   SPAWN              | TIED           | SAFE | CHANGE KIT      | ALLOW    */
	/*   MARKER             | TO             | ZONE | OBJECT          | REDEPLOY */
		["spawnBaseCSAT",     [0],             true,  [boxBaseCSAT,     true ]], // CSAT main
		["spawnGardens",      [0,2,3],         false, [boxGardens,      false]], // CSAT-only, must hold Old Church and Portside
		["spawnHospital",     [2,3,4,5,6,7,8], false, [boxHospital,     false]], // Must hold: Old Churh, Portside, Hospital, Kavala Center, Port, Pier and River South
		["spawnPort",         [2,3,4,5,6,7,8], false, [boxPort,         false]], // - Same as above -
		["spawnGraveyard",    [4,5,7,12,13],   false, [boxGraveyard,    false]], // Must hold: Hospital, Kavala Center, Pier and Warehouses, Ancient Ruins
		["spawnConstruction", [15,10,11],      false, [boxConstruction, false]], // AAF-only, must hold Gas Station and Outskirts
		["spawnBaseAAF",      [15 ],           true,  [boxBaseAAF,      true ]]  // AAF main
	],
	// Restricted areas
	[
	/*   MARKER         | RESTRICT     | TIME BEFORE | PUNISH WHEN | ALLOW    | HIDE   */
	/*   ZONE           | TEAM         | PUNISHMENT  | OUTSIDE     | AIRCRAFT | MARKER */
		["borderNorth",   ["CSAT","AAF"], 10,           false,        false,     false],
		["borderEast",    ["CSAT","AAF"], 10,           false,        false,     false],
		["borderSouth",   ["CSAT","AAF"], 10,           false,        false,     false],
		["borderWest",    ["CSAT","AAF"], 10,           false,        false,     false],
		["spawnBaseCSAT", ["AAF"],        10,           false,        true,      true],
		["spawnBaseAAF",  ["CSAT"],       10,           false,        true,      true]
	],
	// Start camera position
	[
		[-63685.73,85201.39,-15302.82], // Camera target   - x,y,z
		[3762.28,12982.96,17.65],       // Camera position - x,y,z
		0.7                             // Camera FOV      - 0 to 1
	],
	// Markers defining area where doors on buildings should be randomly opened/closed on mission start
	["randomDoors1"]
] call compile preprocessFileLineNumbers "pra3\init.sqf";

