#define var(x) private #x; x

#define isClient (!isDedicated)

#define __neutral sideLogic
#define __updateEvery 30

#define __colorFriendly	[0,0.59,0,1]
#define __colorEnemy	[1,1,1,1]
#define __colorNeutral	[0.88,0,0,1]


PRA3_AAS_sides = [west, east]; // Opposing sides
PRA3_core setVariable ["PRA3_AAS_tickets", [300, 300]]; // Initial tickets
PRA3_AAS_zones = [
/*   FLAG   | SYNCH | NEXT FLAG      | INITIAL  |  TICKET BLEED     */
/*   OBJECT | TO    | team1   team2  | OWNER    |   team1    team2  */
	[flag0,   [],     [[1],   []   ],   west,     [1000000, 0      ]],
	[flag1,   [],     [[2,3], [0]  ],  __neutral, [10,      0      ]],
	[flag2,   [3],    [[4],   [1]  ],  __neutral, [5,       5      ]],
	[flag3,   [2],    [[4],   [1]  ],  __neutral, [5,       5      ]],
	[flag4,   [],     [[5],   [2,3]],  __neutral, [0,       10     ]],
	[flag5,   [],     [[],    [4]  ],  east,      [0,       1000000]],
	[flag6,   [],     [[],    [4]  ],  east,      [0,       1000000]]
];

PRA3_AAS_bases = [[0], [5,6]]; //Bases for each team, indexes have to match those of PRA3_AAS_sides

call compile preprocessFileLineNumbers "aas\init.sqf";
