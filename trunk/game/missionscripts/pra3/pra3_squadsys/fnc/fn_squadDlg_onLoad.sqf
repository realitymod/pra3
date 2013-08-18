#include "defines.sqh"
#include "scriptDefines.sqh"

/**
 *	Dialog onLoad handler.
 */

(_this displayCtrl 301) ctrlShow false;
(_this displayCtrl 302) ctrlShow false;
PRA3_squadSys_menuTarget = "";
PRA3_squadSys_dlgOpenedOn = time;
[] call PRA3_fnc_squadDlg_updateSquadsInfo;
