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
	ctrl(301) ctrlShow true;
	ctrl(301) ctrlSetPosition PRA3_squadSys_menuPos;
	ctrl(301) ctrlCommit 0;

	ctrlSetFocus ctrl(301);
}
else
{
	ctrl(301) ctrlShow false;
	ctrl(302) ctrlShow false;
};
