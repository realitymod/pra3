#include "pra3\pra3_aas\fnc\aas_defines.sqh"

PRA3_AAS_sides = [west, east]; // Opposing sides
PRA3_core setVariable ["PRA3_AAS_tickets", [300, 300]]; // Initial tickets
PRA3_AAS_zones = [
/*    ZONE   | SYNCH | CONNECTS TO   | INITIAL | TICKET BLEED  */
/*    MARKER | TO    |  team1 team2  | OWNER   |  team1  team2 */
	["zone0",  [],     [[1,2],[   ]], west,      [0,     0    ]],
	["zone1",  [2],    [[3  ],[0  ]], __neutral, [__end, 0    ]],
	["zone2",  [1],    [[3  ],[0  ]], __neutral, [12,    4    ]],
	["zone3",  [],     [[4,5],[1,2]], __neutral, [10,    10   ]],
	["zone4",  [5],    [[6  ],[3  ]], __neutral, [4,     12   ]],
	["zone5",  [4],    [[6  ],[3  ]], __neutral, [0,     __end]],
	["zone6",  [],     [[   ],[4,5]], east,      [0,     0    ]]
];

PRA3_AAS_bases = [[0], [6]]; //Bases for each team, indexes have to match those of PRA3_AAS_sides

PRA3_AAS_respawns = [
/*   SPAWN     TIED */
/*   MARKER    TO   */
	["spawn0", [0  ]],
	["spawn1", [1,2]],
	["spawn2", [4,5]],
	["spawn3", [6  ]]
];

call compile preprocessFileLineNumbers "pra3\init.sqf";
