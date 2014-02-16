#include "scriptDefines.sqh"
#include "defines.sqh"

[
	missionNamespace,
	"teamChanged",
	uiNamespace getVariable ["PRA3_playersDlg_teamChangedEvent", -1]
] call BIS_fnc_removeScriptedEventHandler;

uiNamespace setVariable ["PRA3_playersDlg_teamChangedEvent", nil];
