#include "scriptDefines.sqh"
#include "defines.sqh"

diag_log ["onLoad", _this];
PRA3_kitSys_currentKit call PRA3_fnc_kitDlg_populateKitSelection;
__getCtrl(100) ctrlShow false;
PRA3_kitSys_kitDetailsExpanded = false;
