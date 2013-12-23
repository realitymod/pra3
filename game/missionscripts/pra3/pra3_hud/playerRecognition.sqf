#include "fnc\defines.sqh"

PRA3_recognize_knownUnits = [];
PRA3_recognize_lastKnownUnits = [];
PRA3_recognize_lastRun = 0;
PRA3_recognize_nextNearCheck = 0;

[
	"PRA3_playerRecognition",
	"onEachFrame",
	"PRA3_fnc_updatePlayerNametags"
] call BIS_fnc_addStackedEventHandler;
