#include "defines.sqh"
#include "scriptDefines.sqh"

/**
 *	Refreshes the dialog if it is open and re-enables all controls.
 */

var(_refreshSquads) = _this;

if (
	!isNull(uiNamespace getVariable ["Rsc_PRA3_squadSys_manageDlg", displayNull]) ||
	{!isNull(uiNamespace getVariable ["Rsc_PRA3_squadSys_manageDlgRespawn", displayNull])}
) then // Squad dialog open
{
	_refreshSquads call PRA3_fnc_squadDlg_updateSquadsInfo;
	true call PRA3_fnc_squadDlg_enableControls;
};
