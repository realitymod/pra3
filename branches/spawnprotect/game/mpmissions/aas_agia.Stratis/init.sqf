#include "pra3\pra3_aas\fnc\aas_defines.sqh"
enablesaving [false,false];

PRA3_AAS_sides = [west, east]; // Opposing sides
PRA3_core setVariable ["PRA3_AAS_tickets", [300, 300]]; // Initial tickets
PRA3_AAS_zones = [
/*    ZONE   	| SYNCH | CONNECTS TO   | INITIAL | TICKET BLEED  	*/
/*    MARKER 	| TO        |  team1 team2 	    | OWNER   |  team1  team2 		*/
	["zone0",  [],     [[1,2],[   ]], west,      [__end, 0    ]],
	["zone1",  [2],    [[3  ],[0  ]], west,      [10,    0    ]],
	["zone2",  [1],    [[3  ],[0  ]], __neutral, [10,    0    ]],
	["zone3",  [],     [[4,5],[1,2]], __neutral, [5,     5    ]],
	["zone4",  [5],    [[6  ],[3  ]], __neutral, [0,     10   ]],
	["zone5",  [4],    [[6  ],[3  ]], __neutral, [0,     10   ]],
	["zone6",  [],     [[   ],[4,5]], east,      [0,     __end]]
];

PRA3_AAS_bases = [[0], [6]]; //Bases for each team, indexes have to match those of PRA3_AAS_sides

PRA3_AAS_respawns = [
/*   SPAWN     TIED	Safe */
/*   MARKER    TO   		Zone*/
	["spawn0", [0  ],true],
	["spawn1", [1,2],false],
	["spawn2", [4,5],false],
	["spawn3", [6  ],true]
];

PRA3_AAS_restrictionZones = [
/*   MARKER     Side		Need to be 		*/
/*   Name		restrcit   		Inside the zone	*/
	["fighting_Zone", [west,east],true],
	["west_spawn", [east],false],
	["east_spawn", [west],false]
];

call compile preprocessFileLineNumbers "pra3\init.sqf";
