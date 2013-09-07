#include "scriptDefines.sqh"

if (_this select 1 == 28 &&	{
		!isNull (uiNamespace getVariable ["PRA3_respawn_deadScreen", displayNull]) || {
		!isNull (uiNamespace getVariable ["PRA3_respawn_startScreen", displayNull])}
}) then
{
	if dialog then
	{
		closeDialog 0;
	}
	else
	{
		// Check if we remember what was openend last
		if (isNil "PRA3_respawn_lastOpenTab") then
		{
			// I guess not, decide what to open based on where we are
			if (!isNull (uiNamespace getVariable ["PRA3_respawn_deadScreen", displayNull])) then
			{
				// Opening from dead screen, show kits
				true call PRA3_fnc_kitDlg_open;
			}
			else
			{
				// Opening from mission start screen, show squads
				true call PRA3_fnc_squadDlg_open;
			};
		}
		else
		{
			if (PRA3_respawn_lastOpenTab == "kits") then
			{
				true call PRA3_fnc_kitDlg_open;
			}
			else
			{
				true call PRA3_fnc_squadDlg_open;
			};
		};
	};
	true
}
else
{
	false
}
