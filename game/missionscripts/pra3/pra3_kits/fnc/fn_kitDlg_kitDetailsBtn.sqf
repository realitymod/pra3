#include "scriptDefines.sqh"
#include "defines.sqh"

(PRA3_shownKits select (_this - 1)) call PRA3_fnc_kitDlg_populateKitSelection;
(_this - 1) call PRA3_fnc_kitDlg_expandKitDetails;
