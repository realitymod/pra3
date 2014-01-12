#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

var(_action) = _this select 0;
var(_id)     = (_this select 1) - 1;

var(_kit) = PRA3_shownKits select _id;

if (_action == 1) then // Clicked on details button
{
	_id call PRA3_fnc_kitDlg_expandKitDetails;
}
else // Clicked on the kit itself
{
	call PRA3_fnc_kitDlg_hideKitDetails;
};

if ([player, _kit] call PRA3_fnc_getKitAvailableInfo select 0) then // Only if kit is still available
{
	PRA3_kitSys_currentKit = _kit;
	[[player, _kit], "PRA3_fnc_unitSetKit", false] call PRA3_fnc_MP;
};

call PRA3_fnc_kitDlg_populateKitSelection;

__getCtrl(IDC_KITDLG_CHANGEKIT_BTN) ctrlEnable (PRA3_kitSys_currentKit != "");
