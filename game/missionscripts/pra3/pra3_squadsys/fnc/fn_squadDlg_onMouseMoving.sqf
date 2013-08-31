#include "defines.sqh"
#include "scriptDefines.sqh"

/**
 *	Handles mouse moving event.
 */

PRAA_squadSys_currentLine = _this + 1;

if (PRAA_squadSys_menuTarget == "") then // Only if not in pop-up menu
{
	call PRA3_fnc_squadDlg_highlightLines;
};
