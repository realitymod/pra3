#include "pra3\pra3_aas\fnc\aas_defines.sqh"

[
	// Opposing teams
	["NATO", "Iran"],
	// Initial tickets
	[300, 300],
	// Capture zones
	[
	/*   ZONE   | SYNCH |  CONNECTS TO | INITIAL  | TICKET BLEED  */
	/*   MARKER | TO    |  team1 team2 | OWNER    |  team1  team2 */
		["zone0", [],     [[1,2],[   ]], "NATO",    [__end, 0    ]],
		["zone1", [2],    [[3  ],[0  ]], __neutral, [20,    0    ]],
		["zone2", [1],    [[3  ],[0  ]], __neutral, [10,    0    ]],
		["zone3", [],     [[4,5],[1,2]], __neutral, [0,     0    ]],
		["zone4", [5],    [[6  ],[3  ]], __neutral, [0,     10   ]],
		["zone5", [4],    [[6  ],[3  ]], __neutral, [0,     20   ]],
		["zone6", [],     [[   ],[4,5]], "Iran",    [0,     __end]]
	],
	// Bases for each team, indexes have to match those of PRA3_AAS_sides
	[[0], [6]],
	// Respawn definitons
	[
	/*   SPAWN   | TIED | SAFE | CHANGE KIT | ALLOW    */
	/*   MARKER  | TO   | ZONE | OBJECT     | REDEPLOY */
		["spawn0", [0  ], true,  [box0,       true]],
		["spawn1", [1,2], false, [box1,       false]],
		["spawn2", [4,5], false, [box2,       false]],
		["spawn3", [6  ], true,  [box3,       true]]
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
		[-89965.88,-28833.47,-11838.25], // Camera target
		[3019.15,6001.51,3.38],          // Camera position
		0.7                              // Camera FOV
	]
] call compile preprocessFileLineNumbers "pra3\init.sqf";
