enableSaving [false, false];

_this call compile preprocessFile "pra3\pra3_aas\loadMissionParams.sqf";

{
	_this call compile preprocessFileLineNumbers format["pra3\pra3_%1\init.sqf", _x];
} forEach [
	"executor",
	"mp",
	"aas",
	"kits",
	"squadsys",
	"map"
];
