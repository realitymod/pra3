enableSaving [false, false];

_this call compile preprocessFile "pra3\pra3_aas\loadMissionParams.sqf";

{
	_this call compile preprocessFileLineNumbers format["pra3\pra3_%1\init.sqf", _x];
} forEach [
	"executor",
	"map",
	"mp",
	"aas",
	"squadsys",
	"kits",
	"hud"
];

if !isDedicated then
{
	_debug = createTrigger["EmptyDetector",getPos player];
	_debug setTriggerActivation ["ALPHA", "PRESENT", true];
	_debug setTriggerStatements ["this", "0 = createDialog 'Rsc_PRA3_debugMenu'", ""];
	_debug setTriggerText "Show debug options";
};
