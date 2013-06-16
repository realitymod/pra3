#include "scriptDefines.sqh"
/*
if (time >= PRA3_AAS_spawnAtTime) then
{
	0 spawn
	{
		setPlayerRespawnTime -1;
		if !([player, PRA3_AAS_selectedSpawn] call PRA3_fnc_respawnUnit) then
		{
			// The selected spawn point is no longer avialable, choose again
			createDialog "PRA3_dlg_spawnScreen";
		};
	};
};
*/