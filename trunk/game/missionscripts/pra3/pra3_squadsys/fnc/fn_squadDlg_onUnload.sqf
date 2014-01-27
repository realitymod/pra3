#include "defines.sqh"
#include "scriptDefines.sqh"
#include "idcs.sqh"

/**
 *	Dialog onUnload handler.
 */

[
	missionNamespace,
	"teamChanged",
	uiNamespace getVariable ["PRA3_squadDlg_teamChangedEvent", -1]
] call BIS_fnc_removeScriptedEventHandler;

uiNamespace setVariable ["PRA3_squadDlg_teamChangedEvent", nil];
