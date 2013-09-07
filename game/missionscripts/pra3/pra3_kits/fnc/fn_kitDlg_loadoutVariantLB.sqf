#include "scriptDefines.sqh"
#include "defines.sqh"

var(_index) = _this select 1;

// Remember the currently selected variant
var(_kitInfo) = PRA3_kitSys_kitDetailsExpanded call PRA3_fnc_getKitInfo;
_kitInfo set [KIT_VARIANT_CURR, _index];

PRA3_kitSys_kitDetailsExpanded call PRA3_fnc_kitDlg_populateKitDetails;
