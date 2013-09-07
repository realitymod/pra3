#include "fnc\scriptDefines.sqh"

var(_box) = _this select 0;

var(_closestSpawn) = [getPosATL _box, player, 25] call PRA3_fnc_findNearestSpawn;
if (_closestSpawn == "") then
{
	PRA3_core globalChat "Unavailable. Attached spawn must belong to your team.";
}
else
{
	PRA3_selectedSpawn = _closestSpawn;

	true call PRA3_fnc_kitDlg_open;

	_closestSpawn spawn
	{
		waitUntil {
			isNull (uiNamespace getVariable ["Rsc_PRA3_squadSys_manageDlgRespawn", displayNull]) && {
			isNull (uiNamespace getVariable ["Rsc_PRA3_kits_kitDlgRespawn", displayNull])}
		};

		if (PRA3_selectedSpawn != "") then
		{
			if (PRA3_selectedSpawn != _this) then
			{
				[player, PRA3_selectedSpawn] call PRA3_fnc_respawnUnit;
			};
			if (PRA3_kitSys_currentKit != "") then
			{
				[player, PRA3_kitSys_currentKit] call PRA3_fnc_equipWithKit;
			};
		};
	};
};
