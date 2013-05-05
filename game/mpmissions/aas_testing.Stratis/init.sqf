#include "aas\defines.sqh"

PRA3_AAS_sides = [west, east]; // Opposing sides
PRA3_core setVariable ["PRA3_AAS_tickets", [300, 300]]; // Initial tickets
PRA3_AAS_zones = [
/*    ZONE   | SYNCH | CONNECTS TO   | INITIAL | TICKET BLEED  */
/*    MARKER | TO    |  team1 team2  | OWNER   |  team1  team2 */
	["zone0",  [],     [[1  ],[   ]],  west,     [__end, 0    ]],
	["zone1",  [],     [[2,3],[0  ]], __neutral, [10,    0    ]],
	["zone2",  [3],    [[4  ],[1  ]], __neutral, [5,     5    ]],
	["zone3",  [2],    [[4  ],[1  ]], __neutral, [5,     5    ]],
	["zone4",  [],     [[5  ],[2,3]], __neutral, [0,     10   ]],
	["zone5",  [],     [[   ],[4  ]], east,      [0,     __end]],
	["zone6",  [],     [[   ],[4  ]], east,      [0,     __end]]
];

PRA3_AAS_bases = [[0], [5,6]]; //Bases for each team, indexes have to match those of PRA3_AAS_sides

PRA3_AAS_respawns = [
/*   SPAWN     TIED */
/*   MARKER    TO   */
	["spawn0", [0  ]],
	["spawn5", [5,6]],
	["spawn6", [6  ]]
];

call compile preprocessFileLineNumbers "aas\init.sqf";
