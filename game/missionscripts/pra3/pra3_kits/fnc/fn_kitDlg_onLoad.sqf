#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

if (PRA3_kitSys_currentKit != "" && {
	[player, PRA3_kitSys_currentKit] call PRA3_fnc_getKitAvailableInfo select 0}
	) then // If the current kit is no longer available
{
	PRA3_kitSys_currentKit = "";
};

PRA3_kitSys_currentKit call PRA3_fnc_kitDlg_populateKitSelection;
__getCtrl(IDC_KITDLG_DETAILS) ctrlShow false;
PRA3_kitSys_kitDetailsExpanded = "";

__getCtrl(IDC_KITDLG_SWITCH_KITS) ctrlEnable false;
