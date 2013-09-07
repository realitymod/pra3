enableSaving [false, false];

{
	call compile preprocessFileLineNumbers format["pra3\pra3_%1\init.sqf", _x];
} forEach [
	"executor",
	"mp",
	"kits",
	"squadsys",
	"map"
];

_this call compile preprocessFile "pra3\pra3_aas\init.sqf";
