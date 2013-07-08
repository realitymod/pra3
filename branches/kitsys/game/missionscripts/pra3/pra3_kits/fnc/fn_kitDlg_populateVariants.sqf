#include "scriptDefines.sqh"
#include "defines.sqh"

var(_kit)     = PRA3_kitSys_currentKit;
var(_variant) = _kit call PRA3_fnc_getSelectedKitVariant;

lbClear __getCtrl(20001);
{
	__getCtrl(20001) lbAdd getText(_x >> "name");
	if (configName _x == _variant) then
	{
		// This will trigger the LB changed event.
		// The rest of the dialog will update then.
		__getCtrl(20001) lbSetCurSel _forEachIndex;
	};
} forEach (_kit call PRA3_fnc_getKitVariants);
