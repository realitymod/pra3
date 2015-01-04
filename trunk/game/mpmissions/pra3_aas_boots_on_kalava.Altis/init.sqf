#include "pra3\pra3_aas\fnc\aas_defines.sqh"

// PRA3_debug_zoneParticles    = true;
// PRA3_debug_skipMissionStart = true;

[
	// Opposing teams
	["NATO", "CSAT"],
	// Initial tickets
	[300, 300],
	// Capture zones
	[
	/*   ZONE       | SYNC WITH             | CONNECTS TO   | INITIAL      | TICKET BLEED  */
	/*   MARKER  |   team1        team2   |  team1    team2   | OWNER   |  team1  team2    */
		["zone0", [[        ],[        ]],        [[1  ], [   ]], "NATO",  [0,   0  ]],
		["zone1", [[        ],[        ]],        [[2  ], [   ]], "",      [INF, 0  ]],
		["zone2", [[        ],[        ]],        [[3  ], [1  ]], "",      [20,  0  ]],
		["zone3", [[        ],[        ]],        [[4  ], [2  ]], "",      [0,   20 ]],
		["zone4", [[        ],[        ]],        [[   ], [3  ]], "",      [0,   INF]],
		["zone5", [[        ],[        ]],        [[   ], [4  ]], "CSAT",  [0,   0  ]]
	],
	// Bases for each team, indexes have to match those of PRA3_AAS_sides
	[[0], [5]],
	// Respawn definitions
	[
		/*   SPAWN   | TIED | SAFE | CHANGE KIT | ALLOW    */
		/*   MARKER  | TO   | ZONE | OBJECT     | REDEPLOY */
		["spawn0",   [0  ], true,  [box0,       true]],
		["spawn3",   [5  ], true,  [box3,       true]]
	],
	// Restricted areas
	[
	/*   MARKER       |  RESTRICT  | TIME BEFORE | PUNISH WHEN | ALLOW    | DELETE */
	/*   ZONE         |  SIDE      | PUNISHMENT  | OUTSIDE     | AIRCRAFT | MARKER */
		["borderNorth", ["NATO", "CSAT"], 10,      false,        false,     false],
		["borderEast",  ["NATO", "CSAT"], 10,      false,        false,     false],
		["borderSouth", ["NATO", "CSAT"], 10,      false,        false,     false],
		["borderWest",  ["NATO", "CSAT"], 10,      false,        false,     false],
		["spawn0",      ["CSAT"],         10,      false,        true,      true],
		["spawn3",      ["NATO"],         10,      false,        true,      true]
	],
	// Start camera position
	[
		[3520,13073,0],   // Camera target   - x,y,z
		[2928,13377,152], // Camera position - x,y,z
		0.7                      // Camera FOV      - 0 to 1
	],
	// Markers defining area where doors on buildings should be randomly opened/closed on mission start
	["randomDoors1"]
] call compile preprocessFileLineNumbers "pra3\init.sqf";
