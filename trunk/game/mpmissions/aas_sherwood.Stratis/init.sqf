#include "pra3\pra3_aas\fnc\aas_defines.sqh"

[
	// Opposing sides
	[west, east],
	// Initial tickets
	[500, 500],
	// Capture zones
	[
	/*    ZONE   | SYNCH | CONNECTS TO   | INITIAL | TICKET BLEED  */
	/*    MARKER | TO    |  team1 team2  | OWNER   |  team1  team2 */
		["zone0",  [],     [[1],    [     ]], west,      [0,     0    ]],
		["zone1",  [],     [[2],    [    0]], west,      [__end, 0    ]],
		["zone2",  [],     [[3  ],  [    1]], __neutral, [12,    4    ]],
		["zone3",  [],     [[4],    [    2]], __neutral, [10,    10   ]],
		["zone4",  [],     [[5  ],  [    3]], __neutral, [4,     12   ]],
		["zone5",  [],     [[6  ],  [    4]], east,      [0,     __end]],
		["zone6",  [],     [[   ],  [    5]], east,      [0,     0    ]]
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