#include "pra3\pra3_aas\fnc\aas_defines.sqh"

[
	// Opposing teams
	["NATO", "CSAT"],
	// Initial tickets
	[300, 300],
	// Capture zones
	[
	/*   ZONE   | SYNCH |  CONNECTS TO | INITIAL  | TICKET BLEED  */
	/*   MARKER | TO    |  team1 team2 | OWNER    |  team1  team2 */
		["zone0", [],     [[1,2],[   ]], west,        [0    , 0     ]],
		["zone1", [2],    [[3  ],[0  ]], __neutral, [__end, 0  ]],
		["zone2", [1],    [[3  ],[0  ]], __neutral, [20,    0    ]],
		["zone3", [],     [[4,5],[1,2]], __neutral, [5,     5    ]],
		["zone4", [5],    [[6  ],[3  ]], __neutral, [0,     20   ]],
		["zone5", [4],    [[6  ],[3  ]], __neutral, [0,     __end]],
		["zone6", [],     [[   ],[4,5]], east,    	[0,    0    ]]
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
		["spawn0",      [east]     , 10,           false,        true,      true],
		["spawn3",      [west]     , 10,           false,        true,      true]
	],
	// Start camera position
	[
		[3283,5794,0], 		// Camera target 	- x,y,z
		[2630,6163,59],  	// Camera position 	- x,y,z
		0.7				// Camera FOV 		- 0 to 1
	],
	//Random door positions
	["randomDoors1"]
] call compile preprocessFileLineNumbers "pra3\init.sqf";

