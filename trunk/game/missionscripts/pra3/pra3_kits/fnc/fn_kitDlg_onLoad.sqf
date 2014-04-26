#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

if (PRA3_kitSys_currentKit != "" && {
	[player, PRA3_kitSys_currentKit] call PRA3_fnc_getKitAvailableInfo select 0}
	) then // If the current kit is no longer available
{
	PRA3_kitSys_currentKit = "";
};

// Team switch buttons
_this call PRA3_fnc_squadDlg_refreshTeamSwitchBtns;

uiNamespace setVariable [
	"PRA3_kitDlg_teamChangedEvent",
	[
		missionNamespace,
		"teamChanged",
		{
			disableSerialization;

			uiNamespace getVariable [
				if (isNull (uiNamespace getVariable ["Rsc_PRA3_kits_kitDlg", displayNull])) then {
					"Rsc_PRA3_kits_kitDlgRespawn"
				} else {
					"Rsc_PRA3_kits_kitDlg"
				},
				displayNull
			] call PRA3_fnc_squadDlg_refreshTeamSwitchBtns;

			PRA3_kitSys_currentKit = "";
			"" call PRA3_fnc_kitDlg_updateAvailability;
			"" call PRA3_fnc_kitDlg_populateKitSelection;
		}
	] call BIS_fnc_addScriptedEventHandler
];

PRA3_kitSys_currentKit call PRA3_fnc_kitDlg_populateKitSelection;
__getCtrl(IDC_KITDLG_DETAILS) ctrlShow false;
PRA3_kitSys_kitDetailsExpanded = "";

ctrlSetFocus __getCtrl(IDC_KITDLG_SWITCH_KITS);
__getCtrl(IDC_KITDLG_CHANGEKIT_BTN) ctrlEnable (PRA3_kitSys_currentKit != "");
