#include "defines.sqh"
#include "scriptDefines.sqh"

/**
 *	Shows/hides the right-click pop-up menu.
 *
 *		(in)  <BOOL> show?
 *		(out) <VOID>
 */

var(_show) = _this;

if (_show) then
{
	__ctrl(301) ctrlShow true;
	__ctrl(301) ctrlSetPosition PRA3_squadSys_menuPos;
	__ctrl(301) ctrlCommit 0;

	ctrlSetFocus __ctrl(301);
}
else
{
	__ctrl(301) ctrlShow false;
	__ctrl(302) ctrlShow false;
};
