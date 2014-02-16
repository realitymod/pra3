#include "scriptDefines.sqh"
#include "defines.sqh"

if (isNull (uiNamespace getVariable ["Rsc_PRA3_score_playersDlg", displayNull])) then
{
	createDialog "Rsc_PRA3_score_playersDlg";
	true
}
else
{
	false
}
