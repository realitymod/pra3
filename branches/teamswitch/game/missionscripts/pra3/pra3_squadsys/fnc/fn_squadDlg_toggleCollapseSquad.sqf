#include "defines.sqh"
#include "scriptDefines.sqh"

/**
 *	Toggles the collapse state of the squad with the given squad index.
 */

var(_idx) = _this;

var(_collapse) = !(PRAA_squadSys_collapsedSquads select _idx);
if (_idx == 27) then // Unassigned
{
	_collapse call PRA3_fnc_squadDlg_collapseUnassigned;
}
else
{
	[_idx, _collapse] call PRA3_fnc_squadDlg_collapseSquad;
};

call PRA3_fnc_squadDlg_repositionSquadBoxes;
