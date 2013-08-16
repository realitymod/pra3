#include "pra3\pra3_aas\fnc\aas_defines.sqh"

PRA3_AAS_sides = [west, east]; // Opposing sides
PRA3_core setVariable ["PRA3_AAS_tickets", [500, 500]]; // Initial tickets
PRA3_AAS_zones = [
/*    ZONE   | SYNCH | CONNECTS TO   | INITIAL | TICKET BLEED  */
/*    MARKER | TO    |  team1   team2  | OWNER   |  team1  team2 */
	["zone0",  [],     [[1],    [     ]], west,      [0,     0   ]],
	["zone1",  [],     [[2,3],  [    0]], west,      [__end, 0   ]],
	["zone2",  [3],    [[4,5,6],[    1]], west,      [5,     5   ]],
	["zone3",  [2],    [[4,5,6],[    1]], west,      [5,     5   ]],
	["zone4",  [5,6],  [[7,8],  [  2,3]], __neutral, [5,     5   ]],
	["zone5",  [4,6],  [[7,8],  [  2,3]], __neutral, [5,     5   ]],
	["zone6",  [5,6],  [[7,8],  [  2,3]], __neutral, [5,     5   ]],
	["zone7",  [8],    [[9],    [4,5,6]], east,      [5,     5   ]],
	["zone8",  [7],    [[9  ],  [4,5,6]], east,      [5,     5   ]],
	["zone9",  [],     [[10],     [7,8]], east,      [0,    __end]],
	["zone10", [],     [[   ],  [    9]], east,      [0,     0   ]]
];

PRA3_AAS_bases = [[0], [6]]; //Bases for each team, indexes have to match those of PRA3_AAS_sides

PRA3_AAS_respawns = [
/*   SPAWN     TIED */
/*   MARKER    TO   */
	["spawn0", [0   ]],
	["spawn1", [2,3 ]],
	["spawn2", [7,8 ]],
	["spawn3", [10  ]]
];

call compile preprocessFileLineNumbers "pra3\init.sqf";
