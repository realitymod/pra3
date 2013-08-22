#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

lbClear __getCtrl(IDC_KITDLG_SPAWNMAP_SELECTION);
{
	__getCtrl(IDC_KITDLG_SPAWNMAP_SELECTION) lbAdd (_x select 1);
} forEach (player call PRA3_fnc_AAS_getAvailableSpawns);
__getCtrl(IDC_KITDLG_SPAWNMAP_SELECTION) lbSetCurSel 0;