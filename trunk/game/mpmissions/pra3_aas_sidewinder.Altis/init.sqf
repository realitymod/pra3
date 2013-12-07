#include "pra3\pra3_aas\fnc\aas_defines.sqh"

[
	// Opposing sides
	["NATO", "CSAT"],
	// Initial tickets
	[300, 300],
	// Capture zones
	[
	/*    ZONE   | SYNCH | CONNECTS TO   | INITIAL | TICKET BLEED  */
	/*    MARKER | TO    |  team1 team2  | OWNER   |  team1  team2 */
		["zone0",  [],    [[1  ],[    ]], west,        [0,     0    ]],
		["zone1",  [],    [[2  ],[    ]], __neutral, [__end, 0  ]],
		["zone2",  [],    [[3  ],[1  ]], __neutral, [12,    2    ]],
		["zone3",  [],    [[4  ],[2  ]], __neutral, [10,    4    ]],
		["zone4",  [],    [[5  ],[3  ]], __neutral, [4,     10   ]],
		["zone5",  [],    [[6  ],[4  ]], __neutral, [2,     12   ]],
		["zone6",  [],    [[    ],[5  ]], __neutral, [0,     __end]],
		["zone7",  [],    [[    ],[6  ]], east,        [0,     0    ]]
	],
	// Bases for each team, indexes have to match those of PRA3_AAS_sides
	[[0], [7]],
	// Respawn definitons
	[
	/*   SPAWN   | TIED | SAFE | CHANGE KIT OBJECT       */
	/*   MARKER  | TO   | ZONE | OBJECT | ALLOW REDEPLOY */
		["spawn0", [0  ], true,  [box0,   true]],
		["spawn3", [7  ], true,  [box3,   true]]
	],
	// Restricted areas
	[
	/*   MARKER       |  RESTRICT  | TIME BEFORE | PUNISH WHEN | ALLOW    | DELETE */
	/*   ZONE         |  SIDE      | PUNISHMENT  | OUTSIDE     | AIRCRAFT | MARKER */
		["borderNorth", [west,east], 10,           false,        false,     false],
		["borderEast",  [west,east], 10,           false,        false,     false],
		["borderSouth", [west,east], 10,           false,        false,     false],
		["borderWest",  [west,east], 10,           false,        false,     false],
		["spawn0",  	[east]     , 10,           false,        true,      true],
		["spawn3",  	[west]     , 10,           false,        true,      true]
	],
	// Start camera position
	[
		[3832,11510,0], 	// Camera target 	- x,y,z
		[3659,11094,109],  	// Camera position 	- x,y,z
		0.7				// Camera FOV 		- 0 to 1
	],
	//Random door positions
	["randomDoors1"]
] call compile preprocessFileLineNumbers "pra3\init.sqf";
