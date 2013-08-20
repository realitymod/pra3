#include "scriptDefines.sqh"
#include "defines.sqh"

var(_kitID) = _this;
var(_kit) = PRA3_kitSys_curAvailableKits select _kitID;

// Check if we've clicked on the same details button twice
// If so, hide the details instead
if (_kit == PRA3_kitSys_currentKit && PRA3_kitSys_kitDetailsExpanded) then
{
	call PRA3_fnc_kitDlg_hideKitDetails;
}
else
{
	PRA3_kitSys_currentKit = _kit;

	__getCtrl(100) ctrlShow true;
	PRA3_kitSys_kitDetailsExpanded = true;

	call PRA3_fnc_kitDlg_populateVariants;
	call PRA3_fnc_kitDlg_populateKitDetails;

	var(_w) = getNumber(__kitDetails >> "w");
	var(_pos) = ctrlPosition __getCtrl(100);

	var(_y) = getNumber(__kitLine(_kitID + 1) >> "y") + getNumber(__kits >> "y");
	// Have to make sure we don't go below the screen...
	_y = _y min (safeZoneY + safeZoneH - (_pos select 3));

	_pos set [1, _y];
	_pos set [2, 0];
	__getCtrl(100) ctrlSetPosition _pos;
	__getCtrl(100) ctrlCommit 0;
	_pos set [2, _w];
	__getCtrl(100) ctrlSetPosition _pos;
	__getCtrl(100) ctrlCommit DETAILS_ANIMATE_SPEED;
};
