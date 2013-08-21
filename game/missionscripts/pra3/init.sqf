_this call compile "pra3\pra3_aas\init.sqf";

{
	call compile preprocessFileLineNumbers format["pra3\pra3_%1\init.sqf", _x];
} forEach [
	"executor",
	"map",
	"mp",
	"kits",
	"squadsys"
];
