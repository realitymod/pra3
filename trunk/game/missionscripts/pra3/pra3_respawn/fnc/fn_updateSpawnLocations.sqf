#include "scriptDefines.sqh"
#include "defines.sqh"
#include "idcs.sqh"

if (count PRA3_selectedSpawn == 0) then
{
	call PRA3_fnc_spawnMap_selectNoSpawn;
}
else
{
	var(_selectedIndex) = -1;
	{
		if ([_x, PRA3_selectedSpawn] call BIS_fnc_areEqual) exitWith
		{
			_selectedIndex = _forEachIndex;
		};
	} forEach (player call PRA3_fnc_getAvailableSpawns);
	
	if (_selectedIndex == -1) then // Previous spawn is no longer available
	{
		PRA3_selectedSpawn = [];
		call PRA3_fnc_spawnMap_selectNoSpawn;
	}
	else // Re-select previous spawn
	{
		call PRA3_fnc_spawnMap_populateSpawnLocations;
		ctrl(IDC_KITDLG_SPAWNMAP_SELECTION) lbSetCurSel _selectedIndex;
	};
};
