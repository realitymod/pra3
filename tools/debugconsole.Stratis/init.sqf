player addAction ["Open Debug Console", "open.sqf"];

#include "defines.sqh"

PRA3_debugConsole_favorites = profileNamespace getVariable ["PRA3_debugConsole_favorites", []];
if (isNil {profileNamespace getVariable "PRA3_debugConsole_favorites"}) then
{
	profileNamespace setVariable ["PRA3_debugConsole_favorites", PRA3_debugConsole_favorites];
};

PRA3_debugConsole_monitoredValues = profileNamespace getVariable ["PRA3_debugConsole_monitoredValues", []];
if (isNil {profileNamespace getVariable "PRA3_debugConsole_monitoredValues"}) then
{
	profileNamespace setVariable ["PRA3_debugConsole_monitoredValues", PRA3_debugConsole_monitoredValues];
};
if (isNil "PRA3_debugConsole_monitoredValuesCurrent") then
{
	PRA3_debugConsole_monitoredValuesCurrent = 0;
};

if (isNil "PRA3_debugConsole_pinnedValues") then
{
	PRA3_debugConsole_pinnedValues = [];
};

{
	call compile preprocessFile _x;
} forEach [
	"commonFnc.sqf",
	"executeFnc.sqf",
	"historyFnc.sqf",
	"favoritesFnc.sqf",
	"monitorFnc.sqf"
];

[
	[compile preprocessFile "remote.sqf"],
	"BIS_fnc_spawn",
	true,
	true
] call BIS_fnc_MP;
