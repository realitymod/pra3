#include "fnc\scriptDefines.sqh"

var(_box) = _this select 0;

var(_closestSpawn) = [getPosATL _box, player, 25] call PRA3_fnc_findNearestSpawn;
if (count _closestSpawn == 0) then
{
	PRA3_core globalChat "Unavailable. Attached spawn must belong to your team.";
}
else
{
	PRA3_selectedSpawn = _closestSpawn;

	false call PRA3_fnc_kitDlg_open;

	_closestSpawn spawn
	{
		waitUntil {
			isNull (uiNamespace getVariable ["Rsc_PRA3_kits_kitDlg", displayNull])
		};

		if (PRA3_kitSys_currentKit != "") then
		{
			[player, PRA3_kitSys_currentKit] call PRA3_fnc_equipWithKit;
		};
	};
};
