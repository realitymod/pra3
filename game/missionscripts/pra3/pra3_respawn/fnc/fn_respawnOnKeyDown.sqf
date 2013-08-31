#include "scriptDefines.sqh"

if (!alive player && {_this select 1 == 28}) then
{
	if (dialog) then
	{
		closeDialog 0;
	}
	else
	{
		true call PRA3_fnc_kitDlg_open;
	};
	true
}
else
{
	false
}
