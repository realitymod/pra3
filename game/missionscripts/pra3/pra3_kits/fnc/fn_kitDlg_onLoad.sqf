#include "scriptDefines.sqh"
#include "defines.sqh"

diag_log ["onLoad", _this];
PRA3_kitSys_currentKit call PRA3_fnc_kitDlg_populateKitSelection;
call PRA3_fnc_kitDlg_populateVariants;