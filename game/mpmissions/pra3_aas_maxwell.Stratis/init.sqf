#include "pra3\pra3_aas\fnc\aas_defines.sqh"

// PRA3_debug_zoneParticles    = true;
// PRA3_debug_skipMissionStart = true;

[
	// Opposing sides
	["NATO", "CSAT"],
	// Initial tickets
	[300, 300],
	// Capture zones
	[
	/*    ZONE   | SYNCH | CONNECTS TO   | INITIAL | TICKET BLEED  */
	/*    MARKER | TO    |  team1 team2  | OWNER   |  team1  team2 */
		["zone0",  [],     [[1,2],[   ]], "NATO",  [0,     0    ]],
		["zone1",  [2],    [[3  ],[0  ]], "",          [INF, 0    ]],
		["zone2",  [1],    [[3  ],[0  ]], "",          [12,    4    ]],
		["zone3",  [],     [[4,5],[1,2]], "",          [10,    10  ]],
		["zone4",  [5],    [[6  ],[3  ]], "",          [4,     12   ]],
		["zone5",  [4],    [[6  ],[3  ]], "",          [0,     INF]],
		["zone6",  [],     [[   ],[4,5]], "CSAT",  [0,     0    ]]
	],
	// Bases for each team, indexes have to match those of PRA3_AAS_sides
	[[0], [6]],
	// Respawn definitons
	[
	/*   SPAWN   | TIED | SAFE | CHANGE KIT OBJECT       */
	/*   MARKER  | TO   | ZONE | OBJECT | ALLOW REDEPLOY */
		["spawn0", [0  ], true,  [box0,   true]],
		["spawn3", [6  ], true,  [box3,   true]]
	],
	// Restricted areas
	[
	/*   MARKER       |  RESTRICT  | TIME BEFORE | PUNISH WHEN | ALLOW    | DELETE */
	/*   ZONE         |  SIDE      | PUNISHMENT  | OUTSIDE     | AIRCRAFT | MARKER */
		["borderNorth", ["NATO","CSAT"], 10,           false,        false,     false],
		["borderEast",  ["NATO","CSAT"], 10,           false,        false,     false],
		["borderSouth", ["NATO","CSAT"], 10,           false,        false,     false],
		["borderWest",  ["NATO","CSAT"], 10,           false,        false,     false],
		["spawn0",        ["CSAT"]     , 10,           false,        true,      true],
		["spawn3",        ["NATO"]     , 10,           false,        true,      true]
	],
	// Start camera position
	[
		[3120,2817,0],      // Camera target  - x,y,z
		[3390,3123,130],  // Camera position - x,y,z
		0.7                      // Camera FOV      - 0 to 1
	],
	// Markers defining area where doors on buildings should be randomly opened/closed on mission start
	["randomDoors1"]
] call compile preprocessFileLineNumbers "pra3\init.sqf";
