#include "scriptDefines.sqh"
#include "defines.sqh"

if (PRA3_kitSys_kitDetailsExpanded && ctrlCommitted __getCtrl(100)) then
{
	var(_pos) = ctrlPosition __getCtrl(100);
	_pos set [2, 0];
	__getCtrl(100) ctrlSetPosition _pos;
	__getCtrl(100) ctrlCommit DETAILS_ANIMATE_SPEED;
	0 spawn
	{
		sleep DETAILS_ANIMATE_SPEED;
		__getCtrl(100) ctrlShow false;
	};
	PRA3_kitSys_kitDetailsExpanded = false;
};
