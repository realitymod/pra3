#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

var(_kitID) = _this;
var(_kit) = PRA3_shownKits select _kitID;

// Check if we've clicked on the same details button twice
// If so, hide the details instead
if (_kit == PRA3_kitSys_currentKit && PRA3_kitSys_kitDetailsExpanded) then
{
	call PRA3_fnc_kitDlg_hideKitDetails;
}
else
{
	PRA3_kitSys_currentKit = _kit;

	__getCtrl(IDC_KITDLG_DETAILS) ctrlShow true;
	PRA3_kitSys_kitDetailsExpanded = true;

	call PRA3_fnc_kitDlg_populateVariants;
	call PRA3_fnc_kitDlg_populateKitDetails;

	var(_w) = getNumber(__kitDetails >> "w");
	var(_pos) = ctrlPosition __getCtrl(IDC_KITDLG_DETAILS);

	var(_y) = getNumber(__kitLine(_kitID + 1) >> "y") + getNumber(__kits >> "y");
	// Have to make sure we don't go below the screen...
	_y = _y min (safeZoneY + safeZoneH - (_pos select 3));

	_pos set [1, _y];
	_pos set [2, 0];
	__getCtrl(IDC_KITDLG_DETAILS) ctrlSetPosition _pos;
	__getCtrl(IDC_KITDLG_DETAILS) ctrlCommit 0;
	_pos set [2, _w];
	__getCtrl(IDC_KITDLG_DETAILS) ctrlSetPosition _pos;
	__getCtrl(IDC_KITDLG_DETAILS) ctrlCommit DETAILS_ANIMATE_SPEED;
};
