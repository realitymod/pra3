#include "defines.sqh"

PRA3_debugConsole_initialized = true;

if (isNil "PRA3_debugConsole_monitoredValuesCurrent") then
{
	PRA3_debugConsole_monitoredValuesCurrent = 0;
};

if (isNil "PRA3_debugConsole_pinnedValues") then
{
	PRA3_debugConsole_pinnedValues = [];
};

{
	call compile preprocessFile format["\pra3\pra3_debugconsole\scripts\%1", _x];
} forEach [
	"fnc_common.sqf",
	"fnc_execute.sqf",
	"fnc_history.sqf",
	"fnc_favorites.sqf",
	"fnc_monitor.sqf"
];

[
	[compile preprocessFile "\pra3\pra3_debugconsole\scripts\remote.sqf"],
	"BIS_fnc_spawn",
	true,
	true
] call BIS_fnc_MP;
