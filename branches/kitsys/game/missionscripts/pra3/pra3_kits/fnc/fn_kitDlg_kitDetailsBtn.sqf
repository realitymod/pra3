#include "scriptDefines.sqh"
#include "defines.sqh"

PRA3_kitSys_currentKit = PRA3_kitSys_curAvailableKits select (_this - 1);
(PRA3_kitSys_curAvailableKits select (_this - 1)) call PRA3_fnc_kitDlg_populateKitSelection;
call PRA3_fnc_kitDlg_populateVariants;
call PRA3_fnc_kitDlg_populateKitDetails;
