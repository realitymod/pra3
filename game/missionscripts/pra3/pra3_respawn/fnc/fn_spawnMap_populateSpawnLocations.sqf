#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

lbClear ctrl(IDC_KITDLG_SPAWNMAP_SELECTION);
{
	ctrl(IDC_KITDLG_SPAWNMAP_SELECTION) lbAdd (_x call PRA3_fnc_getSpawnName);
} forEach (player call PRA3_fnc_getAvailableSpawns);
ctrl(IDC_KITDLG_SPAWNMAP_SELECTION) lbSetCurSel 0;
