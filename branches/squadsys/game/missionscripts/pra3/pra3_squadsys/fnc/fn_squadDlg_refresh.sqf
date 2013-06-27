#include "defines.sqh"
#include "scriptDefines.sqh"

/**
 *	Refreshes the dialog if it is open and re-enables all controls.
 */

var(_refreshSquads) = _this;

player sideChat "refresh";
if (!isNull(uiNamespace getVariable "Rsc_PRA3_squadSys_manageDlg")) then // Squad dialog open
{
	true call PRA3_fnc_squadDlg_enableControls;
	_refreshSquads call PRA3_fnc_squadDlg_updateSquadsInfo;
};
