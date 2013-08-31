#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

lbClear ctrl(IDC_KITDLG_SPAWNMAP_SELECTION);
lbClear (ctrlParent (_param select 0) displayCtrl IDC_KITDLG_SPAWNMAP_SELECTION);
ctrl(IDC_KITDLG_SPAWNMAP_SELECTION) lbAdd "< No location selected >";
ctrl(IDC_KITDLG_SPAWNMAP_SELECTION) lbAdd "...";
ctrl(IDC_KITDLG_SPAWNMAP_SELECTION) lbSetCurSel 0;
