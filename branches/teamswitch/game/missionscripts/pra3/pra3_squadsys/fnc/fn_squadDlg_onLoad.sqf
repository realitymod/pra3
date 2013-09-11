#include "defines.sqh"
#include "scriptDefines.sqh"
#include "idcs.sqh"

/**
 *	Dialog onLoad handler.
 */

(_this displayCtrl IDC_KITDLG_SWITCH_SQUADS) ctrlEnable false;
 
(_this displayCtrl 301) ctrlShow false;
(_this displayCtrl 302) ctrlShow false;
PRAA_squadSys_menuTarget = "";
PRAA_squadSys_dlgOpenedOn = time;

//-->Set team Switching
//Flags
(_this displayCtrl 502) ctrlSetText ((PRA3_AAS_teams select 0) call PRA3_fnc_getTeamFlag);
(_this displayCtrl 503) ctrlSetText ((PRA3_AAS_teams select 1) call PRA3_fnc_getTeamFlag);

//Team names
(_this displayCtrl 500) ctrlSetText ((PRA3_AAS_teams select 0) call PRA3_fnc_getTeamName);
(_this displayCtrl 501) ctrlSetText ((PRA3_AAS_teams select 1) call PRA3_fnc_getTeamName);

//Disable switching to the team you in
call PRA3_fnc_squadDlg_refreshTeamSwitchBtns;
	
[] call PRA3_fnc_squadDlg_updateSquadsInfo;
