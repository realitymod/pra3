#include "scriptDefines.sqh"

if (!alive player && {_this select 1 == 28}) then
{
	if (dialog) then
	{
		closeDialog 0;
	}
	else
	{
		createDialog "PRA3_dlg_spawnScreen";
	};
	true
}
else
{
	false
}
