#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

[
	missionNamespace,
	"teamChanged",
	uiNamespace getVariable ["PRA3_kitDlg_teamChangedEvent", -1]
] call BIS_fnc_removeScriptedEventHandler;

uiNamespace setVariable ["PRA3_kitDlg_teamChangedEvent", nil];
