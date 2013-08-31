#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

var(_kitInfo) = _this call PRA3_fnc_getKitInfo;

lbClear __getCtrl(IDC_KITDLG_DETAILS_VARIANT);
{
	__getCtrl(IDC_KITDLG_DETAILS_VARIANT) lbAdd (_x select VARIANT_NAME);
} forEach (_kitInfo select KIT_VARIANTS);

__getCtrl(IDC_KITDLG_DETAILS_VARIANT) lbSetCurSel (_kitInfo select KIT_VARIANT_CURR);
