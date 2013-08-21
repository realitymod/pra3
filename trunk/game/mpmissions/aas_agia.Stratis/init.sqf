#include "pra3\pra3_aas\fnc\aas_defines.sqh"

[
	// Opposing sides
	[west, east],
	// Initial tickets
	[300, 300],
	// Capture zones
	[
	/*    ZONE   | SYNCH | CONNECTS TO   | INITIAL | TICKET BLEED  */
	/*    MARKER | TO    |  team1 team2  | OWNER   |  team1  team2 */
		["zone0",  [],     [[1,2],[   ]], west,      [__end, 0    ]],
		["zone1",  [2],    [[3  ],[0  ]], west,      [10,    0    ]],
		["zone2",  [1],    [[3  ],[0  ]], __neutral, [10,    0    ]],
		["zone3",  [],     [[4,5],[1,2]], __neutral, [5,     5    ]],
		["zone4",  [5],    [[6  ],[3  ]], __neutral, [0,     10   ]],
		["zone5",  [4],    [[6  ],[3  ]], __neutral, [0,     10   ]],
		["zone6",  [],     [[   ],[4,5]], east,      [0,     __end]]
	],
	// Bases for each team, indexes have to match those of PRA3_AAS_sides
	[[0], [6]],
	// Respawn definitons
	[
	/*   SPAWN     TIED */
	/*   MARKER    TO   */
		["spawn0", [0  ]],
		["spawn1", [1,2]],
		["spawn2", [4,5]],
		["spawn3", [6  ]]
	]
] call compile preprocessFileLineNumbers "pra3\init.sqf";
