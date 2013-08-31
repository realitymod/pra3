#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

var(_kit) = _this;

{
	var(_i) = _forEachIndex + 1;
	var(_availability) = [player, _x] call PRA3_fnc_getKitAvailableInfo;

	__getCtrl(IDC_KITDLG_SELECTION_KIT + 100*_i + 4) ctrlSetText (_availability select 1);

	// Highlight selected, dim unavailable
	__getCtrl(IDC_KITDLG_SELECTION_KIT + 100*_i + 1) ctrlSetBackgroundColor
		getArray(__kitLineCtrl(_i,"Background") >> (if (_x == PRA3_kitSys_currentKit) then {
			if (_availability select 0) then {
				"colorBackgroundHighlight"
			} else {
				"colorBackgroundDimHighlight"
			}
		} else {
			if (_availability select 0) then {
				"colorBackground"
			} else {
				"colorBackgroundDim"
			}
		}));

	__getCtrl(IDC_KITDLG_SELECTION_KIT + 100*_i + 6) ctrlEnable (_availability select 0);
} forEach PRA3_shownKits;
