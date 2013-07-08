#include "scriptDefines.sqh"
#include "defines.sqh"

var(_kitInfo) = PRA3_kitSys_currentKit call PRA3_fnc_getKitInfo;

lbClear __getCtrl(20001);
{
	__getCtrl(20001) lbAdd (_x select VARIANT_NAME);
} forEach (_kitInfo select KIT_VARIANTS);

// This will trigger the LB changed event.
// The rest of the dialog will update then.
__getCtrl(20001) lbSetCurSel (_kitInfo select KIT_VARIANT_CURR);
