#include "scriptDefines.sqh"
#include "defines.sqh"

var(_action) = _this select 0;
var(_id)     = (_this select 1) - 1;

var(_kit) = PRA3_shownKits select _id;

call PRA3_fnc_kitDlg_populateKitSelection;
if (_action == 1) then // Clicked on details button
{
	_id call PRA3_fnc_kitDlg_expandKitDetails;
}
else // Clicked on the kit itself
{
	call PRA3_fnc_kitDlg_hideKitDetails;
};

if (_kit call PRA3_fnc_kitDlg_updateAvailability) then // Only if kit is still available
{
	PRA3_kitSys_currentKit = _kit;
};
