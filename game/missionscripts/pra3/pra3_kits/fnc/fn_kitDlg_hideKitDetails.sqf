#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

if (PRA3_kitSys_kitDetailsExpanded && ctrlCommitted __getCtrl(IDC_KITDLG_DETAILS)) then
{
	var(_pos) = ctrlPosition __getCtrl(IDC_KITDLG_DETAILS);
	_pos set [2, 0];
	__getCtrl(IDC_KITDLG_DETAILS) ctrlSetPosition _pos;
	__getCtrl(IDC_KITDLG_DETAILS) ctrlCommit DETAILS_ANIMATE_SPEED;
	0 spawn
	{
		sleep DETAILS_ANIMATE_SPEED;
		__getCtrl(IDC_KITDLG_DETAILS) ctrlShow false;
	};
	PRA3_kitSys_kitDetailsExpanded = false;
};
