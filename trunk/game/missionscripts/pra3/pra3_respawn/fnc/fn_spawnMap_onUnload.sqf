#include "scriptDefines.sqh"

[
	missionNamespace,
	"teamChanged",
	uiNamespace getVariable ["PRA3_spawnMap_teamChangedEvent", -1]
] call BIS_fnc_removeScriptedEventHandler;

uiNamespace setVariable ["PRA3_spawnMap_teamChangedEvent", nil];
