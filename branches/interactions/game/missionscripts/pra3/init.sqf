enablesaving [false,false];

{
	call compile preprocessFileLineNumbers format["pra3\pra3_%1\init.sqf", _x];
} forEach [
	"aas",
	"executor",
	"mp",
	"kits",
	"squadsys",
	"interactions",
	"hud",
	"wpnswitch"
];