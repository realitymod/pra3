#include "pra3\pra3_aas\fnc\aas_defines.sqh"

[
	// Opposing teams
	["NATO", "Iran"],
	// Initial tickets
	[300, 300],
	// Capture zones
	[
	/*    ZONE   | SYNCH | CONNECTS TO       | INITIAL  | TICKET BLEED  */
	/*    MARKER | TO    |   team1   team2  | OWNER    |  team1  team2 */
		["zone0",  [    ], [[1    ],[     ]], west,      [__end, 0    ]],
		["zone1",  [    ], [[2,3  ],[     ]], __neutral, [__end, 0    ]],
		["zone2",  [3   ], [[4,5,6],[1    ]], __neutral, [5,     0    ]],
		["zone3",  [2   ], [[4,5,6],[1    ]], __neutral, [5,     0    ]],
		["zone4",  [5,6 ], [[7    ],[2,3  ]], __neutral, [5,     5    ]],
		["zone5",  [4,6 ], [[7    ],[2,3  ]], __neutral, [5,     5    ]],
		["zone6",  [4,5 ], [[7    ],[2,3  ]], __neutral, [5,     5    ]],
		["zone7",  [    ], [[8,9  ],[4,5,6]], __neutral, [0,     2    ]],
		["zone8",  [9   ], [[10   ],[7    ]], __neutral, [0,     4    ]],
		["zone9",  [8   ], [[10   ],[7    ]], east,      [0,     4    ]],
		["zone10", [    ], [[     ],[8,9  ]], east,      [0,     __end]],
		["zone11", [    ], [[     ],[10   ]], east,      [0,     __end]]
	],
	// Bases for each team, indexes have to match those of PRA3_AAS_sides
	[[0], [11]],
	// Respawn definitons
	[
	/*   SPAWN   | TIED   | SAFE | CHANGE KIT OBJECT       */
	/*   MARKER  | TO     | ZONE | OBJECT | ALLOW REDEPLOY */
		["spawn0", [ 0, 1], true,  [box0,   true]],
		["spawn1", [10,11], true,  [box1,   true]]
	],
	// Restricted areas
	[
	/*   MARKER       |  RESTRICT  | TIME BEFORE | PUNISH WHEN | ALLOW    | DELETE */
	/*   ZONE         |  SIDE      | PUNISHMENT  | OUTSIDE     | AIRCRAFT | MARKER */
		["borderNorth", [west,east], 10,           false,        false,     false],
		["borderEast",  [west,east], 10,           false,        false,     false],
		["borderSouth", [west,east], 10,           false,        false,     false],
		["borderWest",  [west,east], 10,           false,        false,     false],
		["west_spawn",  [east]     , 10,           false,        true,      true],
		["east_spawn",  [west]     , 10,           false,        true,      true]
	],
	// Start camera position
	[
		[-35446.70,97156.86,-13761.08], // Camera target
		[2202.67,5545.74,12.78],        // Camera position
		0.7                             // Camera FOV
	]
] call compile preprocessFileLineNumbers "pra3\init.sqf";
