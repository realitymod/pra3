#include "scriptDefines.sqh"
#include "defines.sqh"

uiNamespace setVariable [
	"PRA3_playersDlg_teamChangedEvent",
	[
		missionNamespace,
		"teamChanged",
		{
			call PRA3_fnc_playersDlg_update
		}
	] call BIS_fnc_addScriptedEventHandler
];

call PRA3_fnc_playersDlg_update;
