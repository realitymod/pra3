#include "pra3\pra3_aas\fnc\aas_defines.sqh"

PRA3_AAS_teams = ["NATO", "Iran"]; // Opposing teams
PRA3_core setVariable ["PRA3_AAS_tickets", [300, 300]]; // Initial tickets
PRA3_AAS_zones = [
/*    ZONE   | SYNCH | CONNECTS TO   | INITIAL | TICKET BLEED  */
/*    MARKER | TO    |  team1 team2  | OWNER   |  team1  team2 */
	["zone0",  [],     [[1,2],[   ]], "NATO",    [__end, 0    ]],
	["zone1",  [2],    [[3  ],[0  ]], "NATO",    [10,    0    ]],
	["zone2",  [1],    [[3  ],[0  ]], __neutral, [10,    0    ]],
	["zone3",  [],     [[4,5],[1,2]], __neutral, [5,     5    ]],
	["zone4",  [5],    [[6  ],[3  ]], __neutral, [0,     10   ]],
	["zone5",  [4],    [[6  ],[3  ]], __neutral, [0,     10   ]],
	["zone6",  [],     [[   ],[4,5]], "Iran",    [0,     __end]]
];

PRA3_AAS_bases = [[0], [6]]; //Bases for each team, indexes have to match those of PRA3_AAS_sides

PRA3_AAS_respawns = [
/*   SPAWN     TIED */
/*   MARKER    TO   */
	["spawn0", [0  ], [box0, true]],
	["spawn1", [1,2], [box1, false]],
	["spawn2", [4,5], [box2, false]],
	["spawn3", [6  ], [box3, true]]
];

PRA3_AAS_startCamera = [
	[-89965.88,-28833.47,-11838.25], // Camera target
	[3019.15,6001.51,3.38],          // Camera position
	0.7                              // Camera FOV
];

call compile preprocessFileLineNumbers "pra3\init.sqf";
