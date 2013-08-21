#include "pra3\pra3_aas\fnc\aas_defines.sqh"

[
	// Opposing sides
	[west, east],
	// Initial tickets
	[400, 400],
	// Capture zones
	[
	/*    ZONE   | SYNCH | CONNECTS TO   | INITIAL | TICKET BLEED  */
	/*    MARKER | TO    |  team1 team2  | OWNER   |  team1  team2 */
		["zone0",  [],     [[1],    [     ]], west,      [0,      0   ]],
		["zone1",  [],     [[2,3,4],[    0]], west,      [__end,  0   ]],
		["zone2",  [3,4],  [[5  ],  [    1]], __neutral, [10,    10   ]],
		["zone3",  [2,4],  [[5],    [    1]], __neutral, [10,    10   ]],
		["zone4",  [2,3],  [[5],    [    1]], __neutral, [10,    10   ]],
		["zone5",  [],     [[6  ],  [2,3,4]], east,      [0,     __end]],
		["zone6",  [],     [[   ],  [    5]], east,      [0,      0   ]]
	],
	// Bases for each team, indexes have to match those of PRA3_AAS_sides
	[[0], [6]],
	// Respawn definitons
	[
	/*   SPAWN     TIED */
	/*   MARKER    TO   */
		["spawn0", [0  ]],
		["spawn1", [2,3,4]],
		["spawn2", [2,3,4]],
		["spawn3", [6  ]]
	]
] call compile preprocessFileLineNumbers "pra3\init.sqf";
