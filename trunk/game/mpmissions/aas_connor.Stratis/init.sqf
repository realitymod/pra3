#include "pra3\pra3_aas\fnc\aas_defines.sqh"

PRA3_AAS_sides = [west, east]; // Opposing sides
PRA3_core setVariable ["PRA3_AAS_tickets", [400, 400]]; // Initial tickets
PRA3_AAS_zones = [
/*    ZONE   | SYNCH | CONNECTS TO   | INITIAL | TICKET BLEED  */
/*    MARKER | TO    |  team1   team2  | OWNER   |  team1  team2 */
	["zone0",  [],     [[1],    [     ]], west,      [0,      0   ]],
	["zone1",  [],     [[2,3],  [    0]], west,      [__end,  0   ]],
	["zone2",  [3],    [[4  ],  [    1]], __neutral, [10,    10   ]],
	["zone3",  [2],    [[4],    [    1]], __neutral, [10,    10   ]],
	["zone4",  [],     [[5  ],  [  2,3]], east,      [0,     __end]],
	["zone5",  [],     [[   ],  [    4]], east,      [0,      0   ]]
];

PRA3_AAS_bases = [[0], [5]]; //Bases for each team, indexes have to match those of PRA3_AAS_sides

PRA3_AAS_respawns = [
/*   SPAWN     TIED */
/*   MARKER    TO   */
	["spawn0", [0  ]],
	["spawn1", [2,3]],
	["spawn2", [2,3]],
	["spawn3", [5  ]]
];

call compile preprocessFileLineNumbers "pra3\init.sqf";
