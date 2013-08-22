#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

lbClear __getCtrl(IDC_KITDLG_SPAWNMAP_SELECTION);
lbClear (ctrlParent (_param select 0) displayCtrl IDC_KITDLG_SPAWNMAP_SELECTION);
__getCtrl(IDC_KITDLG_SPAWNMAP_SELECTION) lbAdd "< No location selected >";
__getCtrl(IDC_KITDLG_SPAWNMAP_SELECTION) lbAdd "...";
__getCtrl(IDC_KITDLG_SPAWNMAP_SELECTION) lbSetCurSel 0;
