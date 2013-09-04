#include "pra3\pra3_aas\fnc\aas_defines.sqh"

PRA3_AAS_teams = ["NATO", "Iran"]; // Opposing teams
PRA3_AAS_sides = [west, east]; // Opposing sides 
PRA3_core setVariable ["PRA3_AAS_tickets", [300, 300]]; // Initial tickets
PRA3_AAS_zones = [
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
];

PRA3_AAS_bases = [[0], [11]]; //Bases for each team, indexes have to match those of PRA3_AAS_sides

PRA3_AAS_respawns = [
/*   SPAWN     TIED */
/*   MARKER    TO   */
	["spawn0", [ 0, 1]],
	["spawn1", [10,11]]
];

call compile preprocessFileLineNumbers "pra3\init.sqf";
