#include "pra3\pra3_aas\fnc\aas_defines.sqh"

PRA3_debug_zoneParticles    = true;
PRA3_debug_skipMissionStart = true;

[
	// Opposing teams
	["CSAT", "AAF"],
	// Initial tickets
	[300, 500],
	// Capture zones
	[
	/*   ZONE         | SYNC WITH             | CONNECTS TO       | INITIAL | TICKET BLEED  */
	/*   MARKER       |   team1       team2   |  team1    team2   | OWNER   |  team1  team2 */
		["zone0",  [[        ],[        ]],  [[1    ], [     ]], "CSAT",   [0, 0  ]],
		["zone1",  [[        ],[        ]],  [[2,3  ], [     ]], "",       [0, 0  ]],
		["zone2",  [[3       ],[        ]],  [[4    ], [     ]], "AAF",    [0, 0  ]],
		["zone3",  [[2       ],[        ]],  [[5,6  ], [     ]], "AAF",    [0, 0  ]],
		["zone4",  [[        ],[        ]],  [[8    ], [     ]], "AAF",    [0, 0  ]],
		["zone5",  [[        ],[        ]],  [[7,8  ], [6    ]], "AAF",    [0, 0  ]],
		["zone6",  [[        ],[        ]],  [[5,7  ], [     ]], "AAF",    [0, 0  ]],
		["zone7",  [[        ],[        ]],  [[8    ], [6    ]], "AAF",    [0, 0  ]],
		["zone8",  [[4,5,6,7 ],[        ]],  [[9    ], [4,5,7]], "AAF",    [0, 0  ]],
		["zone9",  [[        ],[        ]],  [[10,11], [8    ]], "AAF",    [0, 0  ]],
		["zone10", [[        ],[11,12,13]],  [[12   ], [9    ]], "AAF",    [0, 0  ]],
		["zone11", [[        ],[10,12,13]],  [[13   ], [9    ]], "AAF",    [0, 0  ]],
		["zone12", [[10,11,13],[        ]],  [[14   ], [10   ]], "AAF",    [0, 0  ]],
		["zone13", [[10,11,12],[        ]],  [[14   ], [11   ]], "AAF",    [0, 0  ]],
		["zone14", [[        ],[        ]],  [[     ], [12,13]], "AAF",    [0, INF]],
		["zone15", [[        ],[        ]],  [[     ], [14   ]], "AAF",    [0, 0  ]]
	],
	// Bases for each team, indexes have to match those of PRA3_AAS_sides
	[[0], [15]],
	// Respawn definitions
	[
	/*   SPAWN                   | TIED | SAFE | CHANGE KIT    | ALLOW    */
	/*   MARKER                  | TO   | ZONE | OBJECT        | REDEPLOY */
		["spawnBaseCSAT",     [0  ], true,  [boxBaseCSAT,     true ]],
		["spawnGardens",      [15 ], false, [boxGardens,      false]],
		["spawnHospital",     [15 ], false, [boxHospital,     false]],
		["spawnPort",         [15 ], false, [boxPort,         false]],
		["spawnGraveyard",    [15 ], false, [boxGraveyard,    false]],
		["spawnConstruction", [15 ], false, [boxConstruction, false]],
		["spawnBaseAAF",      [15 ], true,  [boxBaseAAF,      true ]]
	],
	// Restricted areas
	[
	/*   MARKER            | RESTRICT       | TIME BEFORE | PUNISH WHEN  | ALLOW     | DELETE */
	/*   ZONE              | TEAM           | PUNISHMENT  | OUTSIDE      | AIRCRAFT  | MARKER */
		["borderNorth",   ["CSAT","AAF"], 10,           false,        false,     false],
		["borderEast",    ["CSAT","AAF"], 10,           false,        false,     false],
		["borderSouth",   ["CSAT","AAF"], 10,           false,        false,     false],
		["borderWest",    ["CSAT","AAF"], 10,           false,        false,     false],
		["spawnBaseCSAT", ["AAF"]       , 10,           false,        true,      true],
		["spawnBaseAAF",  ["CSAT"]      , 10,           false,        true,      true]
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

