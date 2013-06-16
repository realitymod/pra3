#include "scriptDefines.sqh"

PRA3_AAS_respawnTime = 20;
setPlayerRespawnTime PRA3_AAS_respawnTime;

if !(alive player) then
{
	PRA3_AAS_spawnAtTime = time + PRA3_AAS_respawnTime;

	sleep 2;
	createDialog "PRA3_dlg_spawnScreen";

	waitUntil {playerRespawnTime < 1 || alive player};
	// If the player has the spawn dialog open do not respawn him
	if (!alive player && {!isNull (uiNamespace getVariable "PRA3_dlg_spawnScreen")}) then
	{
		setPlayerRespawnTime 99999;
	}
	else
	{
		if !([player, PRA3_AAS_selectedSpawn] call PRA3_fnc_respawnUnit) then
		{
			setPlayerRespawnTime 99999;
			// The selected spawn point is no longer avialable, choose again
			createDialog "PRA3_dlg_spawnScreen";
		};
	};
};
