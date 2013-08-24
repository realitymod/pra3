#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

lbClear ctrl(IDC_KITDLG_SPAWNMAP_SELECTION);
{
	ctrl(IDC_KITDLG_SPAWNMAP_SELECTION) lbAdd (_x select 1);
} forEach (player call PRA3_fnc_AAS_getAvailableSpawns);
ctrl(IDC_KITDLG_SPAWNMAP_SELECTION) lbSetCurSel 0;