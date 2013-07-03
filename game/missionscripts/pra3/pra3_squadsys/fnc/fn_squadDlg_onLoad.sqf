#include "defines.sqh"
#include "scriptDefines.sqh"

/**
 *	Dialog onLoad handler.
 */

(_this displayCtrl 301) ctrlShow false;
(_this displayCtrl 302) ctrlShow false;
PRAA_squadSys_menuTarget = "";
PRAA_squadSys_dlgOpenedOn = time;
[] call PRA3_fnc_squadDlg_updateSquadsInfo;
